//
//  RecipeDetailHeaderView.m
//  Cooker
//
//  Created by 诸超杰 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "RecipeDetailHeaderView.h"
#import "RecipeMaterialCell.h"
#import "RecipeDetailModel.h"
static NSString *RecipeMaterialCellReuseIdentifier = @"RecipeMaterialCellReuseIdentifier";
@interface RecipeDetailHeaderView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) RecipeDetailModel *recipeDetailModel;
@end

@implementation RecipeDetailHeaderView

- (void)awakeFromNib {
}
- (void)setModel:(BaseModel *)model {
    
    if (model == nil) {
        return;
    }
    RecipeDetailModel *detailModel = (RecipeDetailModel *)model;
    self.materialTabelView.dataSource = self;
    self.materialTabelView.delegate = self;
    self.materialTabelView.bounces = NO;
    self.materialTabelView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.materialTabelView.height = self.recipeDetailModel.materialListModelArray.count;
    [self.materialTabelView registerNib:[UINib nibWithNibName:@"RecipeMaterialCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RecipeMaterialCellReuseIdentifier];


    self.titleLabel.text = detailModel.name;
    
    self.iconName.text = detailModel.authorname;
    self.dateLabel.text = detailModel.gettime;
    self.describeLabel.text = detailModel.Description;

    self.iconImage.layer.masksToBounds = YES;
    self.iconImage.layer.cornerRadius = 20;
#pragma mark   ========扣死二第切图
    
    NSDictionary *parameter = @{@"version":@"12.2.1.0",@"machine":@"O382baa3c128b3de78ff6bbcd395b2a27194b01ad",@"device":@"iPhone8%2C1",@"frienduid":detailModel.authorid};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:SELECTUSER_URL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *pic = responseObject[@"pic"];
        if (pic) {
            [self.iconImage sd_setImageWithURL:[NSURL stringAppendingToURLWithString:pic] placeholderImage:[UIImage imageNamed:@"头像"]];
        } else {
            self.iconImage.image = [UIImage imageNamed:@"头像"];
        }
        [self.iconImage sd_setImageWithURL:[NSURL stringAppendingToURLWithString:pic] placeholderImage:[UIImage imageNamed:@"头像"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"用户头像请求失败");
    }];
    
}

- (CGFloat)returnHeightByModel:(BaseModel *)model {
    if (model == nil) {
        return 0;
    }
    self.recipeDetailModel = (RecipeDetailModel *)model;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, nil];
    NSString *description =  nil;
    if (model.description) {
        description = model.description;
    } else {
        description = @"   ";
    }
   
    CGRect rect = [description boundingRectWithSize:CGSizeMake(SCREENWIDTH - 30, 3000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    CGFloat strHeight = rect.size.height;
    CGFloat stepHeight = 0;
    if (self.recipeDetailModel.materialListModelArray.count) {
        stepHeight = (self.recipeDetailModel.materialListModelArray.count ) * 30;
    }
    CGFloat height = strHeight + stepHeight + 550 - 232 - 29;
    return height;
}

#pragma mark tableView的代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recipeDetailModel.materialListModelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeMaterialCell *cell = [tableView dequeueReusableCellWithIdentifier:RecipeMaterialCellReuseIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ((int)(indexPath.row % 2) == 1) {
        cell.contentView.backgroundColor = [UIColor colorWithRed:208 / 255.0 green:208 / 255.0 blue:208 / 255.0 alpha:1];
    }
    materialListModel *model = self.recipeDetailModel.materialListModelArray[indexPath.row];
    if (model.name) {
        cell.name.text = model.name;
    }
    if (model.dosage) {
        cell.number.text = model.dosage;
    } else {
        cell.number.text = @"";
    }
    return cell;
}
@end
