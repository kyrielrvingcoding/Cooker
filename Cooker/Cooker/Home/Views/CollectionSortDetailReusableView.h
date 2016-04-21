//
//  CollectionSortDetailReusableView.h
//  Cooker
//
//  Created by 叶旺 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionSortDetailReusableView : UICollectionReusableView

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *authorImageView;
@property (strong, nonatomic) IBOutlet UILabel *authorNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *recipeCountLabel;

@end
