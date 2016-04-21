//
//  HomeRecipeModel.h
//  Cooker
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"

@interface HomeRecipeModel : BaseModel

@property (nonatomic, copy) NSString *imageid;
@property (nonatomic, copy) NSString *Description;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *likeCount;
@property (nonatomic, copy) NSString *collectCount;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *authorname;
@end
