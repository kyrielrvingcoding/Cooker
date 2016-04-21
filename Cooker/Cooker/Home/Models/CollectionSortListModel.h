//
//  CollectionSortListModel.h
//  Cooker
//
//  Created by 叶旺 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"

@interface CollectionSortListModel : BaseModel

@property (nonatomic, copy) NSString *name;//标题
@property (nonatomic, copy) NSString *Description;//副标题
@property (nonatomic, copy) NSString *commentCount;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *imageid;//图片id
@property (nonatomic, copy) NSString *likeCount;//喜欢人数
@property (nonatomic, copy) NSString *recipeCount;//菜谱个数

@end
