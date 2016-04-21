//
//  HomeSelectionModel.h
//  Cooker
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"

@interface HomeSelectionModel : BaseModel
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *imageid;//图片
@property (nonatomic, copy) NSString *Description;//描述
@property (nonatomic, copy) NSString *name;//标题
@property (nonatomic, copy) NSString *type;//类型
@property (nonatomic, copy) NSString *likeCount;//点赞的次数
@property (nonatomic, copy) NSString *recipeCount;//收藏的次数



@end
