//
//  RecipeDetailModel.h
//  Cooker
//
//  Created by 诸超杰 on 16/4/20.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"
#import "StepListModel.h"
#import "materialListModel.h"

@interface RecipeDetailModel : BaseModel
@property (nonatomic, copy) NSString *imageid;//头视图图片
@property (nonatomic, copy) NSString *authorid;//用于提取用户信息
@property (nonatomic, copy) NSString *url;//跳转到网页的
@property (nonatomic, copy) NSString *tags;//菜别
@property (nonatomic, copy) NSString *gettime;//制作时间
@property (nonatomic, copy) NSString *authorname;//
@property (nonatomic, strong) NSMutableArray  *stepListModelArray;//制作步骤
@property (nonatomic, strong) NSMutableArray *materialListModelArray;//材料
@property (nonatomic, copy) NSString *Description;//描述
@property (nonatomic, copy) NSString *ID;//菜的id
@property (nonatomic, copy) NSString *name;//菜名
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *tipList;//小贴士
@end
