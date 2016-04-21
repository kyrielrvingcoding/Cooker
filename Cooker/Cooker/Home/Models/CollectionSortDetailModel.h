//
//  CollectionSortDetailModel.h
//  Cooker
//
//  Created by 叶旺 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"

@interface CollectionSortDetailModel : BaseModel

@property (nonatomic, copy) NSString *name; //菜谱名称
@property (nonatomic, copy) NSString *authorname; //作者名称
@property (nonatomic, copy) NSString *imageid; //菜谱图片
@property (nonatomic, copy) NSString *authorid; //作者id
@property (nonatomic, copy) NSString *authorimageid; //作者头像
@property (nonatomic, copy) NSString *collectCount; //收藏数量
@property (nonatomic, copy) NSString *Description; //简介
@property (nonatomic, copy) NSString *ID;

@end
