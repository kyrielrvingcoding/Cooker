//
//  CollectionSortDetailModelCell.m
//  Cooker
//
//  Created by 叶旺 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "CollectionSortDetailModelCell.h"
#import "CollectionSortDetailModel.h"

@implementation CollectionSortDetailModelCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _imageIDView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_nameLabel];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_imageIDView];
    }
    return self;
}

- (void)setDataWithModel:(CollectionSortDetailModel *)model {
    [_imageIDView sd_setImageWithURL:[NSURL stringAppendingToURLWithString:model.imageid]];
    _nameLabel.text = model.name;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = self.bounds;
    _imageIDView.frame = CGRectMake(0, 0, frame.size.width, frame.size.width);
    _nameLabel.frame = CGRectMake(0, frame.size.width + 5, frame.size.width, 20);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
