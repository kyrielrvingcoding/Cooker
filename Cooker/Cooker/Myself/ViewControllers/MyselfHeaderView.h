//
//  MyselfHeaderView.h
//  Cooker
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 class17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyselfHeaderView : UIView
@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *genderImageView;
@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sayingLabel;


@end
