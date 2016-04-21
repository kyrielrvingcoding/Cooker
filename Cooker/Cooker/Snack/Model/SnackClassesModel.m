//
//  SnackClassesModel.m
//  Cooker
//
//  Created by lanou on 16/4/21.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "SnackClassesModel.h"

@implementation SnackClassesModel

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key {
    if ([@"id" isEqualToString:key]) {
        self.ID = value;
    }
}

@end
