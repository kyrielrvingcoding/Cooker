//
//  CommentTableViewCell.m
//  Cooker
//
//  Created by 叶旺 on 16/4/20.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "CommentTableViewModel.h"

@implementation CommentTableViewCell

- (void)setDataWithModel:(CommentTableViewModel *)model {
    _nicknameLabel.text = model.usernickname;
    _timeLabel.text = model.displaytime;
    _userTextLabel.text = model.text;
    [_imageIDView sd_setImageWithURL:[NSURL stringAppendingToURLWithString:model.userimageid]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
