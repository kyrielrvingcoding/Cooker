//
//  CollectionSortDrtailFooterView.m
//  Cooker
//
//  Created by 叶旺 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "CollectionSortDrtailFooterView.h"
#import "CommentTableViewCell.h"
#import "CommentTableViewModel.h"

@interface CollectionSortDrtailFooterView ()

@property (nonatomic, strong) UITableView *footTableView;
@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation CollectionSortDrtailFooterView

- (void)clickAddMoreData:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clickAddMoreCollectionData" object:sender];
}


- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self.footTableView reloadData];
    _countLabel.text = [NSString stringWithFormat:@"评论(%ld)", (unsigned long)self.dataArray.count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentTableViewModel *model = self.dataArray[indexPath.row];
    CommentTableViewCell *cell = (CommentTableViewCell *)[FactoryTableViewCell createTableViewCellWithModel:model tableView:tableView indexPath:indexPath];
    [cell setDataWithModel:model];
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100;
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.footTableView = [[UITableView alloc] initWithFrame:SCREENBOUNDS style:UITableViewStylePlain];
    self.footTableView.delegate = self;
    self.footTableView.dataSource = self;
    self.footTableView.tableHeaderView = [self createTableHeaderView];
    self.backgroundColor = [UIColor blueColor];
    [self.footTableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommentTableViewModel"];
    self.footTableView.rowHeight = UITableViewAutomaticDimension;
    self.footTableView.estimatedRowHeight = 150;
    [self addSubview:_footTableView];
     
    // Initialization code
}

- (UIView *)createTableHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 90)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake((SCREENWIDTH / 2 - 40), 0, 80, 40);
    [button setTitle:@"加载更多" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickAddMoreData:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:button];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 50, SCREENWIDTH - 10, 5)];
    imageView.image = [UIImage imageNamed:@"line"];
    [headerView addSubview:imageView];
    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 65, 100, 25)];
    
    [headerView addSubview:_countLabel];
    return headerView;
}

@end
