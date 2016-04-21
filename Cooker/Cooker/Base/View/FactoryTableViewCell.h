//
//  FactoryTableViewCell.h
//  Cooker
//
//  Created by 叶旺 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "BaseTableViewCell.h"

@interface FactoryTableViewCell : NSObject

+ (BaseTableViewCell *)createTableViewCellWithModel:(BaseModel *)model;

+ (BaseTableViewCell *)createTableViewCellWithModel:(BaseModel *)model tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
