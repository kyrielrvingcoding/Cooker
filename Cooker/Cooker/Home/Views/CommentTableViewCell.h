//
//  CommentTableViewCell.h
//  Cooker
//
//  Created by 叶旺 on 16/4/20.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface CommentTableViewCell : BaseTableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageIDView;
@property (strong, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *userTextLabel;


@end
