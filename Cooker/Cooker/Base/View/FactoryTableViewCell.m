//
//  FactoryTableViewCell.m
//  Cooker
//
//  Created by 叶旺 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "FactoryTableViewCell.h"

@implementation FactoryTableViewCell

+ (BaseTableViewCell *)createTableViewCellWithModel:(BaseModel *)model {
    //1.将model类名转化为字符串
    NSString *modelName = NSStringFromClass([model class]);
    //2.获取需要创建cell的类名
    Class cellClass = NSClassFromString([NSString stringWithFormat:@"%@Cell", modelName]);
    //3.创建cell对象
    BaseTableViewCell *cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:modelName];
    return cell;
}

+ (BaseTableViewCell *)createTableViewCellWithModel:(BaseModel *)model tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    NSString *modelName = NSStringFromClass([model class]);
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:modelName forIndexPath:indexPath];
    return cell;
}

@end
