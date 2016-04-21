//
//  CollectionSortListModelCell.h
//  Cooker
//
//  Created by 叶旺 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface CollectionSortListModelCell : BaseTableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageIDView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *recipeCountLabel;

@end
