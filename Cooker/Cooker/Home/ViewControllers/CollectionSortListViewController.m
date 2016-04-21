//
//  CollectionSortListViewController.m
//  Cooker
//
//  Created by 叶旺 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "CollectionSortListViewController.h"
#import "CollectionSortListModel.h"
#import "CollectionSortListModelCell.h"
#import "CollectionSortDetailViewController.h"

@interface CollectionSortListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArray;//存储列表数据
@property (nonatomic, copy) NSString *ID;

@end

@implementation CollectionSortListViewController

- (NSMutableArray *)listArray {
    if (!_listArray) {
        self.listArray = [NSMutableArray array];
    }
    return _listArray;
}

//请求数据
- (void)requestData {
    NSDictionary *parameter = nil;
    if (!_ID) {
        parameter = @{@"version":@"12.2.1.0", @"type":@"collectionsort"};
    } else {
        parameter = @{@"version":@"12.2.1.0", @"type":@"collectionsort", @"id":_ID};
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:RECOMMENDLIST_URL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"---%@---", responseObject);
        NSArray *array = responseObject[@"list"];
        for (NSDictionary *dic in array) {
            CollectionSortListModel *listModel = [[CollectionSortListModel alloc] init];
            [listModel setValuesForKeysWithDictionary:dic];
            [self.listArray addObject:listModel];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)requestMoreData {
    _ID = [[self.listArray lastObject] ID];
    [self requestData];
    [self.tableView.mj_footer endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _ID = nil;
    [self requestData];
    


    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CollectionSortListModelCell" bundle:nil] forCellReuseIdentifier:@"CollectionSortListModel"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 600;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectionSortListModel *listModel = self.listArray[indexPath.row];
    CollectionSortListModelCell *cell = (CollectionSortListModelCell *)[FactoryTableViewCell createTableViewCellWithModel:listModel tableView:tableView indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setDataWithModel:listModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectionSortDetailViewController *collectVC = [[CollectionSortDetailViewController alloc] init];
    collectVC.ID = [self.listArray[indexPath.row] ID];
    [self.navigationController pushViewController:collectVC animated:YES];
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
