//
//  CollectionSortDetailModel.m
//  Cooker
//
//  Created by 叶旺 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "CollectionSortDetailModel.h"

@implementation CollectionSortDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
    if ([key isEqualToString:@"description"]) {
        _Description = value;
    }
}

@end
