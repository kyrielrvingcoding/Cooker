//
//  CommentTableViewModel.h
//  Cooker
//
//  Created by 叶旺 on 16/4/20.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"

@interface CommentTableViewModel : BaseModel

@property (nonatomic, copy) NSString *displaytime; //发布时间
@property (nonatomic, copy) NSString *userimageid; //用户头像
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *text; //评论内容
@property (nonatomic, copy) NSString *userid; //用户id
@property (nonatomic, copy) NSString *usernickname; //用户名称

@end
