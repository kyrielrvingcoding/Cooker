//
//  RecipeViewController.h
//  Cooker
//
//  Created by 诸超杰 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseViewController.h"
#import "TYCircleCollectionView.h"

@interface RecipeViewController : BaseViewController

@property (nonatomic, strong) TYCircleCollectionView *collectionView;

@property (nonatomic, copy) NSArray *items;

@end
