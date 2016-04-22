//
//  LatestAndHotestListViewController.m
//  Cooker
//
//  Created by 叶旺 on 16/4/22.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "LatestAndHotestListViewController.h"
#import "HomeRecipeModelCell.h"
#import "HomeRecipeModel.h"
#import "RecipeListTableViewCell.h"
#import "RecipeListTableViewModel.h"
#import "CollectionSortDetailViewController.h"
#import "RecipeDetailViewController.h"

@interface LatestAndHotestListViewController () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableDataArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *collectionDataArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, copy) NSString *urlString; //url类型

@end

@implementation LatestAndHotestListViewController

- (NSMutableArray *)tableDataArray {
    if (!_tableDataArray) {
        self.tableDataArray = [NSMutableArray array];
    }
    return _tableDataArray;
}

- (NSMutableArray *)collectionDataArray {
    if (!_collectionDataArray) {
        self.collectionDataArray = [NSMutableArray array];
    }
    return _collectionDataArray;
}

- (void)requestData {
    NSDictionary *parameter = @{@"type":_type, @"version":@"12.2.1.0"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:_urlString parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"---%@---", responseObject);
        NSArray *recipeArray = responseObject[@"list"];
        
        if ([_urlString isEqualToString:RECIPELIST_URL]) {
            [self.collectionDataArray removeAllObjects];
            for (NSDictionary *dic in recipeArray) {
                HomeRecipeModel *recipeModel = [[HomeRecipeModel alloc] init];
                [recipeModel setValuesForKeysWithDictionary:dic];
                [self.collectionDataArray addObject:recipeModel];
            }
            [self.collectionView reloadData];
        } else {
            [self.tableDataArray removeAllObjects];
            for (NSDictionary *dic in recipeArray) {
                RecipeListTableViewModel *tableViewModel = [[RecipeListTableViewModel alloc] init];
                [tableViewModel setValuesForKeysWithDictionary:dic];
                [self.tableDataArray addObject:tableViewModel];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _urlString = RECIPELIST_URL;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createSegmentedControl];
    [self createScrollView];
    [self createCollectionView];
    [self createTableView];
    [self requestData];
    // Do any additional setup after loading the view.
}

- (void)createScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64)];
    _scrollView.contentSize = CGSizeMake(2 * SCREENWIDTH, SCREENHEIGHT - 64);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, SCREENHEIGHT - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 150;
    [_tableView registerNib:[UINib nibWithNibName:@"RecipeListTableViewCell" bundle:nil] forCellReuseIdentifier:@"RecipeListTableViewModel"];
    [_scrollView addSubview:_tableView];
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(SCREENWIDTH / 2 - 15, SCREENWIDTH / 2 + 40);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    //注册cell
    [_collectionView registerNib:[UINib nibWithNibName:@"HomeRecipeModelCell" bundle:nil] forCellWithReuseIdentifier:@"ListRecipeCellModel"];
    [_scrollView addSubview:_collectionView];
}

- (void)createSegmentedControl {
    NSArray *array = nil;
    if ([_type isEqualToString:@"latest"]) {
        array = @[@"最新菜谱", @"最新专辑"];
    } else {
        array = @[@"最热菜谱", @"最热专辑"];
    }
    UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:array];
    [control addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = control;
}

//SegmentedControl的点击方法
- (void)changeView:(UISegmentedControl *)segmented {
    switch (segmented.selectedSegmentIndex) {
        case 0:
            _urlString = RECIPELIST_URL;
            [self requestData];
            _scrollView.contentOffset = CGPointMake(0, 0);
            break;
        case 1:
            _scrollView.contentOffset = CGPointMake(SCREENWIDTH, 0);
            _urlString = COLLECTIONSORTLIST_URL;
            [self requestData];
            break;
        default:
            break;
    }
}

#pragma mark ------scrollView的代理方法------
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == 0) {
        _urlString = COLLECTIONSORTLIST_URL;
        [self requestData];
    } else if (scrollView.contentOffset.x == SCREENWIDTH) {
        _urlString = RECIPELIST_URL;
        [self requestData];
    }
}

#pragma mark  -------tableView代理方法-------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeListTableViewModel" forIndexPath:indexPath];
    [cell setDataWithModel:self.tableDataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectionSortDetailViewController *collectVC = [[CollectionSortDetailViewController alloc] init];
    collectVC.ID = [self.tableDataArray[indexPath.row] ID];
    [self.navigationController pushViewController:collectVC animated:YES];
}

#pragma mark  -------collectionView代理方法-------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeRecipeModelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ListRecipeCellModel" forIndexPath:indexPath];
    [cell setDataWithModel:self.collectionDataArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    RecipeDetailViewController *recipeVC = [[RecipeDetailViewController alloc] init];
    recipeVC.ID = [self.collectionDataArray[indexPath.row] ID];
    [self.navigationController pushViewController:recipeVC animated:YES];
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
