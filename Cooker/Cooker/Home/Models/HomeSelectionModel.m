//
//  HomeSelectionModel.m
//  Cooker
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "HomeSelectionModel.h"

@implementation HomeSelectionModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
    if ([key isEqualToString:@"description"]) {
        _Description = value;
    }
}

@end
