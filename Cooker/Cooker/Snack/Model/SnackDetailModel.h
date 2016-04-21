//
//  SnackDetailModel.h
//  Cooker
//
//  Created by lanou on 16/4/21.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseModel.h"

@interface SnackDetailModel : BaseModel

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *titlepic;
@property (nonatomic, copy) NSString *gongyi;
@property (nonatomic, copy) NSString *kouwei;
@property (nonatomic, copy) NSString *md;
@property (nonatomic, copy) NSString *mt;
@property (nonatomic, copy) NSString *step;
@property (nonatomic, copy) NSString *smalltext;
@property (nonatomic, copy) NSString *is_recipep;
@property (nonatomic, copy) NSString *item_type;
@property (nonatomic, copy) NSString *rate;


@end
