//
//  RecipeListTableViewModel.h
//  Cooker
//
//  Created by 叶旺 on 16/4/22.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"

@interface RecipeListTableViewModel : BaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *Description;
@property (nonatomic, copy) NSString *imageid;
@property (nonatomic, copy) NSString *likeCount;
@property (nonatomic, copy) NSString *recipeCount;
@property (nonatomic, copy) NSString *ID;

@end
