//
//  CollectionSortDetailViewController.m
//  Cooker
//
//  Created by 叶旺 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "CollectionSortDetailViewController.h"
#import "CollectionSortDetailModel.h"
#import "CollectionSortDetailModelCell.h"
#import "CollectionSortDetailReusableView.h"
#import "CommentTableViewModel.h"
#import "CollectionSortDrtailFooterView.h"

@interface CollectionSortDetailViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSMutableArray *listArray; // 菜谱显示数据数组
@property (nonatomic) NSInteger count;  //listArray的增量
@property (nonatomic, strong) NSMutableArray *collectionListArray; //菜谱数据数组
@property (nonatomic, strong) NSMutableArray *commentListArray; //评论数据数组
@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

@implementation CollectionSortDetailViewController

//数组懒加载
- (NSMutableArray *)collectionListArray {
    if (!_collectionListArray) {
        self.collectionListArray = [NSMutableArray array];
    }
    return _collectionListArray;
}
- (NSMutableArray *)commentListArray {
    if (!_commentListArray) {
        self.commentListArray = [NSMutableArray array];
    }
    return _commentListArray;
}

- (NSMutableArray *)listArray {
    if (!_listArray) {
        self.listArray = [NSMutableArray array];
    }
    return _listArray;
}

- (void)requestData {
    NSDictionary *parameter = @{@"version":@"12.2.1.0", @"id":_ID};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:COLLECTIONSORTDETAIL_URL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@", responseObject);
        _dataDic = [NSMutableDictionary dictionary];
        _dataDic = responseObject[@"details"];
        NSArray *commentArr = _dataDic[@"commentList"];
        for (NSDictionary *dic in commentArr) {
            CommentTableViewModel *commentModel = [[CommentTableViewModel alloc] init];
            [commentModel setValuesForKeysWithDictionary:dic];
            [self.commentListArray addObject:commentModel];
        }
        NSArray *collectionArr = _dataDic[@"recipeList"];
        for (NSDictionary *dic in collectionArr) {
            CollectionSortDetailModel *listModel = [[CollectionSortDetailModel alloc] init];
            [listModel setValuesForKeysWithDictionary:dic];
            [self.collectionListArray addObject:listModel];
        }
        _count = 9;
        for (NSInteger i = 0; i < _count; i ++) {
            [self.listArray addObject:_collectionListArray[i]];
        }
        _layout.footerReferenceSize = CGSizeMake(SCREENWIDTH, 100 * (self.commentListArray.count + 1));
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self createTableView];
    self.navigationController.navigationBar.translucent = NO;
    [self createCollectionView];
    
    [self requestData];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark ------collectionView------

- (void)createCollectionView {
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.minimumLineSpacing = 10;
    _layout.minimumInteritemSpacing = 10;
    _layout.itemSize =  CGSizeMake((SCREENWIDTH - 45) / 3, (SCREENWIDTH - 45) / 3 + 25);
    _layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _layout.itemSize = CGSizeMake((SCREENWIDTH - 45) / 3, (SCREENWIDTH - 45) / 3 + 25);
    _layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _collectionView = [[UICollectionView alloc] initWithFrame:SCREENBOUNDS collectionViewLayout:_layout];

    _collectionView.backgroundColor = [UIColor redColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[CollectionSortDetailModelCell class] forCellWithReuseIdentifier:NSStringFromClass([CollectionSortDetailModel class])];
    //指定增广视图大小
    _layout.headerReferenceSize = CGSizeMake(SCREENWIDTH, 230);
    
    //
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionSortDetailReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionSortDetailReusable"];
    //
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionSortDrtailFooterView" bundle:nil]  forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CommentTableViewModel"];
    [self.view addSubview:_collectionView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickMoreData:) name:@"clickAddMoreCollectionData" object:nil];
}

//计算collectionView的数据源个数
- (void)clickMoreData:(NSNotification *)noti {
    if (_count <= _collectionListArray.count) {
        _count += 6;
    }
    if (_count <= _collectionListArray.count) {
        for (NSInteger i = _count - 6; i < _count; i ++) {
            [self.listArray addObject:_collectionListArray[i]];
        }
        [self.collectionView reloadData];
    } else {
        UIButton *button = (UIButton *)noti.object;
        [button setTitle:@"加载完毕" forState:UIControlStateNormal];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionSortDetailModelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CollectionSortDetailModel class]) forIndexPath:indexPath];
    [cell setDataWithModel:self.listArray[indexPath.row]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CollectionSortDetailReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionSortDetailReusable" forIndexPath:indexPath];
        reusableView.nameLabel.text = _dataDic[@"name"];
        reusableView.authorNameLabel.text = _dataDic[@"usernickname"];
        reusableView.timeLabel.text = _dataDic[@"time"];
        reusableView.descriptionLabel.text = _dataDic[@"description"];
        [reusableView.authorImageView sd_setImageWithURL:[NSURL stringAppendingToURLWithString:_dataDic[@"userimageid"]]];
        reusableView.recipeCountLabel.text = [NSString stringWithFormat:@"菜谱(%ld)", _collectionListArray.count];
        
        return reusableView;
    } else {
        CollectionSortDrtailFooterView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CommentTableViewModel" forIndexPath:indexPath];
        if (_commentListArray.count) {
            reusableView.dataArray = _commentListArray;
        }
        return reusableView;
    }
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
