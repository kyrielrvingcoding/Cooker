//
//  CollectionSortListModelCell.m
//  Cooker
//
//  Created by 叶旺 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "CollectionSortListModelCell.h"
#import "CollectionSortListModel.h"

@implementation CollectionSortListModelCell

- (void)setDataWithModel:(CollectionSortListModel *)model {
    [_imageIDView sd_setImageWithURL:[NSURL stringAppendingToURLWithString:model.imageid]];
    _nameLabel.text = model.name;
    _descriptionLabel.text = model.Description;
    _likeCountLabel.text = model.likeCount;
    _recipeCountLabel.text = model.recipeCount;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
