//
//  HomeRecipeModelCell.h
//  Cooker
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface HomeRecipeModelCell : BaseCollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageidView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *Description;
@property (strong, nonatomic) IBOutlet UILabel *collectionCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *likeCountLabel;

@end
