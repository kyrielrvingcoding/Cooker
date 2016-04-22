//
//  HomeSelectionDetailViewController.m
//  Cooker
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "HomeSelectionDetailViewController.h"
#import "HomeRecipeModel.h"
#import "HomeRecipeModelCell.h"
#import "RecipeDetailViewController.h"

@interface HomeSelectionDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;//每日菜单
@property (nonatomic, strong) NSMutableArray *everydayRecipeArray;//每日菜单数据源

@property (nonatomic, copy) NSString *ID;

@end

@implementation HomeSelectionDetailViewController

#pragma mark--------懒加载--------
- (NSMutableArray *)everydayRecipeArray {
    if (!_everydayRecipeArray) {
        self.everydayRecipeArray = [NSMutableArray array];
    }
    return _everydayRecipeArray;
}

- (void)requestData {
    NSDictionary *parameter = nil;
    
    if (!_ID) {
        parameter = @{@"version":@"12.2.1.0",@"type":@"recipe"};
    } else {
    parameter = @{@"version":@"12.2.1.0", @"type":@"recipe", @"id":_ID};
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:RECOMMENDLIST_URL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"---%@---", responseObject);
        
        NSArray *listArray = responseObject[@"list"];
        //每日菜单
        for (NSDictionary *dic in listArray) {
            HomeRecipeModel *model = [[HomeRecipeModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.everydayRecipeArray addObject:model];
        }
        
        [_collectionView reloadData];
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        NSLog(@"error = %@",error);
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //请求数据
    [self requestData];
    //创建每日菜单
    [self createEverydayListLayoutView];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    _ID = nil;
    [self requestData];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
    
}
- (void)requestMoreData {
    _ID = [[self.everydayRecipeArray lastObject] ID];
    [self requestData];
    [self.collectionView.mj_footer endRefreshing];
}

//创建每日菜单
- (void)createEverydayListLayoutView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //最小行间距
    layout.minimumLineSpacing = 20;
    //最小列间距
    layout.minimumInteritemSpacing = 10;
    //滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //item的大小
    layout.itemSize = CGSizeMake(SCREENWIDTH / 2 - 15, SCREENWIDTH / 2 + 40);
    //边距
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBARHEIGHT + 20, SCREENWIDTH, SCREENHEIGHT - 109) collectionViewLayout:layout];
    
    _collectionView.backgroundColor = [UIColor clearColor];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.bounces = NO;
    //防止偏移的
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    //跳转到详情的界面
    [_collectionView registerNib:[UINib nibWithNibName:@"HomeRecipeModelCell" bundle:nil] forCellWithReuseIdentifier:@"RecipeCell"];
    
    [self.view addSubview:_collectionView];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
