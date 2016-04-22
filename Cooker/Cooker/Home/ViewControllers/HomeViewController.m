//
//  HomeViewController.m
//  Cooker
//
//  Created by 诸超杰 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "HomeViewController.h"
#import "CollectionSortListViewController.h"
#import "HomeSelectionDetailViewController.h"
#import "CycleScrollView.h"
#import "HomeCarouselModel.h"
#import "HomeRecipeModel.h"
#import "HomeRecipeModelCell.h"
#import "HomeSelectionModel.h"
#import "CollectionSortListModelCell.h"
#import "RecipeDetailViewController.h"
#import "CollectionSortDetailViewController.h"
#define kColletionViewHeight (SCREENWIDTH / 2 + 40)
#define kTotalCollectionViewHeight ((_everydayRecipeArray.count + 1)/2 * kColletionViewHeight )
#define kTotalTableViewHeight (350 * _selectionArray.count)

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) CycleScrollView *cycleScrollView;//轮播图
@property (nonatomic, strong) NSMutableArray *carouselArray;//轮播图数据源
@property (nonatomic, strong) UICollectionView *collectionView;//每日菜单
@property (nonatomic, strong) NSMutableArray *everydayRecipeArray;//每日菜单数据源
@property (nonatomic, strong) NSMutableArray *selectionArray;//精选数据源
@property (nonatomic, strong) UITableView *tableView;//精选

@property (nonatomic, strong) UIScrollView *rootScrollView;

@end

@implementation HomeViewController

#pragma mark--------懒加载--------

- (NSMutableArray *)everydayRecipeArray {
    if (!_everydayRecipeArray) {
        self.everydayRecipeArray = [NSMutableArray array];
    }
    return _everydayRecipeArray;
}

- (NSMutableArray *)selectionArray {
    if (!_selectionArray) {
        self.selectionArray = [NSMutableArray array];
    }
    return _selectionArray;
}

- (NSMutableArray *)carouselArray {
    if (!_carouselArray) {
        self.carouselArray = [NSMutableArray array];
    }
    return _carouselArray;
}


//请求数据
- (void)requestData {
 
    NSDictionary *parameter = @{@"version":@"12.2.1.0",@"machine":@"O382baa3c128b3de78ff6bbcd395b2a27194b01ad",@"device":@"iPhone8%2C1"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:HOMEDATA_URL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"---%@---", responseObject);
        
        //轮播图
        NSArray *array = responseObject[@"banner"];
        for (NSDictionary *dic in array) {
            HomeCarouselModel *carouselModel = [[HomeCarouselModel alloc] init];
            [carouselModel setValuesForKeysWithDictionary:dic];
       
            if ([carouselModel.uri hasPrefix:@"http://www.ecook.cn/ecook/viewContent.shtml"]) {
                [self.carouselArray addObject:carouselModel];
            }
  
        }
        
        //每日菜单
        NSDictionary *recipedic = responseObject[@"recipe"];
        NSArray *recipeArray = recipedic[@"list"];
        for (NSDictionary *dic in recipeArray) {
            HomeRecipeModel *recipeModel = [[HomeRecipeModel alloc] init];
            [recipeModel setValuesForKeysWithDictionary:dic];
            [self.everydayRecipeArray addObject:recipeModel];
            
        }
        
        //精选推荐
        NSDictionary *selectionDic = responseObject[@"collectionsort"];
        NSArray *selectionArray = selectionDic[@"list"];
        for (NSDictionary *dic in selectionArray) {
            HomeSelectionModel *selectionModel = [[HomeSelectionModel alloc] init];
            [selectionModel setValuesForKeysWithDictionary:dic];
            [self.selectionArray addObject:selectionModel];
            
        }
        
        //轮播图
        [self createCycleScrollView];
        _collectionView.frame = CGRectMake(0, _cycleScrollView.frame.size.height + 40, SCREENWIDTH, kTotalCollectionViewHeight + 60);
        _tableView.frame = CGRectMake(0, _cycleScrollView.frame.size.height  + kTotalCollectionViewHeight + 70, SCREENWIDTH, kTotalTableViewHeight );
        _rootScrollView.contentSize = CGSizeMake(SCREENWIDTH,  280 + kTotalCollectionViewHeight + kTotalTableViewHeight);
        
        [self.tableView reloadData];
        [self.collectionView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error = %@",error);
    }];
    
}


//创建RootScrollView
- (void)createRootScrollView {
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 49)];
    _rootScrollView.delegate = self;
    _rootScrollView.contentSize = CGSizeZero;
    _rootScrollView.contentOffset = CGPointMake(0, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_rootScrollView];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    //创建滚动视图
    [self createRootScrollView];

    //创建每日菜单
    [self createEverydayListLayoutView];
    //创建CollectionView头视图
    [self createCollectionHeaderView];
    
    
    //创建精选菜单
    [self createSelectionList];
    //创建TableView头视图
    [self creatTableViewHeaderView];
    
    //请求数据
    [self requestData];
    
    self.navigationController.navigationBar.translucent = NO;
    
}


//头视图
- (UIView *)headerViewWithLabeltext:(NSString *)labeltext Titletext:(NSString *)titletext frameY:(CGFloat)frameY action:(SEL)action {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, frameY, SCREENWIDTH, 40)];
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 10, view.frame.size.height-5)];
    leftImageView.backgroundColor = [UIColor orangeColor];
    leftImageView.layer.cornerRadius = 5;
    leftImageView.layer.masksToBounds = YES;
    [view addSubview:leftImageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 100, view.frame.size.height - 5)];
    label.text = labeltext;
    [view addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(SCREENWIDTH - 100, 0, 100, view.frame.size.height - 5);
    [button addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:titletext forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.titleLabel.textColor = [UIColor lightGrayColor];
    [view addSubview:button];
    
    return view;
    
}
//创建CollectionView头视图
- (void)createCollectionHeaderView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 210, SCREENWIDTH, 40)];
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 10, view.frame.size.height-5)];
    leftImageView.backgroundColor = [UIColor orangeColor];
    leftImageView.layer.cornerRadius = 5;
    leftImageView.layer.masksToBounds = YES;
    [view addSubview:leftImageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 100, view.frame.size.height - 5)];
    label.text = @"每日菜单";
    [view addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(SCREENWIDTH - 100, 0, 100, view.frame.size.height - 5);
    [button addTarget:self action:@selector(nextRecipeDetailVC:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"更多菜谱" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.titleLabel.textColor = [UIColor lightGrayColor];
    [view addSubview:button];
    [_rootScrollView addSubview:view];

  
}

- (void)nextRecipeDetailVC:(id)sender {
    
    HomeSelectionDetailViewController *homeSelectionDetailVC = [[HomeSelectionDetailViewController alloc] init];
    homeSelectionDetailVC.title = @"精选菜谱";
    [self.navigationController pushViewController:homeSelectionDetailVC animated:YES];
    
    
}

//创建TableView头视图
- (void)creatTableViewHeaderView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 10, view.frame.size.height-5)];
    leftImageView.backgroundColor = [UIColor orangeColor];
    leftImageView.layer.cornerRadius = 5;
    leftImageView.layer.masksToBounds = YES;
    [view addSubview:leftImageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 100, view.frame.size.height - 5)];
    label.text = @"精选专辑" ;
    [view addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(SCREENWIDTH - 100, 0, 100, view.frame.size.height - 5);
    [button addTarget:self action:@selector(nextcollectionSortListVC:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"更多专辑" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.titleLabel.textColor = [UIColor lightGrayColor];
    [view addSubview:button];
    
    _tableView.tableHeaderView = view;
    
}

- (void)nextcollectionSortListVC:(id)sender {
    
    CollectionSortListViewController *collectionSoertVC = [[CollectionSortListViewController alloc] init];
    
    [self.navigationController pushViewController:collectionSoertVC animated:YES];
    
}

//创建轮播图
- (void)createCycleScrollView {
    
    _cycleScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 200) animationDuration:2];
    NSMutableArray *viewsArray = [@[] mutableCopy];
    
    for (int i = 0; i < _carouselArray.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:_cycleScrollView.bounds];
        
        HomeCarouselModel *model = _carouselArray[i];
        
        [imageView sd_setImageWithURL:[NSURL stringAppendingToURLWithString:model.imageid]];
        [viewsArray addObject:imageView];
    }
    if(viewsArray.count < 2) {
    
        [_rootScrollView addSubview:viewsArray.lastObject];
    
    } else {
    
    [_rootScrollView addSubview:_cycleScrollView];
    
    _cycleScrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex) {
        return viewsArray[pageIndex];
    };
    _cycleScrollView.totalPagesCount = viewsArray.count;
    
    //  跳转到详情
    __weak NSArray *cycelArray = _carouselArray;
    __weak typeof(self)homeVC = self;
    
    _cycleScrollView.TapActionBlock = ^(NSInteger pageIndex) {
        HomeCarouselModel * model = [cycelArray objectAtIndex:pageIndex];
        NSArray *urlArray = [model.uri componentsSeparatedByString:@"?"];
        NSString *idString = urlArray.lastObject;
        NSString *ID = [idString componentsSeparatedByString:@"="].lastObject;
                RecipeDetailViewController *recipeDetailVC = [[RecipeDetailViewController alloc] init];
                recipeDetailVC.ID = ID;
                [homeVC.navigationController pushViewController:recipeDetailVC animated:YES];
    };
    }

}

//创建每日菜单
- (void)createEverydayListLayoutView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //最小行间距
    layout.minimumLineSpacing = 0;
    //最小列间距
    layout.minimumInteritemSpacing = 10;
    //滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //item的大小
    layout.itemSize = CGSizeMake(SCREENWIDTH / 2 - 15, kColletionViewHeight);
    //边距
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 0);
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    _collectionView.backgroundColor = [UIColor clearColor];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.bounces = NO;
    _collectionView.scrollEnabled = NO;
    
    //防止偏移的
    self.automaticallyAdjustsScrollViewInsets = NO;

    [_collectionView registerNib:[UINib nibWithNibName:@"HomeRecipeModelCell" bundle:nil] forCellWithReuseIdentifier:@"RecipeCell"];
    
    [_rootScrollView addSubview:_collectionView];

}

//创建精选菜单
- (void)createSelectionList{
    //防止偏移的
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces = NO;
    _tableView.scrollEnabled = NO;
    
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 600;
    
    [_rootScrollView addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"CollectionSortListModelCell" bundle:nil] forCellReuseIdentifier:@"SelectionCell"];
    
}

#pragma mark ---TableView协议方法----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.selectionArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeSelectionModel *model = self.selectionArray[indexPath.row];
    CollectionSortListModelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectionCell"];
    [cell setDataWithModel:model];
    return cell;
}

//点击cell跳转到详情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectionSortDetailViewController *collectionDetailVC = [[CollectionSortDetailViewController alloc] init];
    HomeSelectionModel *model = self.selectionArray[indexPath.row];
    collectionDetailVC.ID = model.ID;
    [self.navigationController pushViewController:collectionDetailVC animated:YES];
    
}

#pragma mark ------CollectionView协议方法--------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.everydayRecipeArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeRecipeModel *model= self.everydayRecipeArray[indexPath.row];
    
    HomeRecipeModelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecipeCell" forIndexPath:indexPath];
    
    [cell setDataWithModel:model];
    
    return cell;
    
}

//点击跳转到详情
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RecipeDetailViewController *recipeDetailVC = [[RecipeDetailViewController alloc] init];
    HomeRecipeModel *model = self.everydayRecipeArray[indexPath.row];
    recipeDetailVC.ID = model.ID;

    [self.navigationController pushViewController:recipeDetailVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
