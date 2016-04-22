//
//  RecipeListTableViewModel.m
//  Cooker
//
//  Created by 叶旺 on 16/4/22.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "RecipeListTableViewModel.h"

@implementation RecipeListTableViewModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        self.Description = value;
    }
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
}

@end
