//
//  CommentTableViewModel.m
//  Cooker
//
//  Created by 叶旺 on 16/4/20.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "CommentTableViewModel.h"

@implementation CommentTableViewModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
}

@end
