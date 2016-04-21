//
//  HomeRecipeModelCell.m
//  Cooker
//
//  Created by lanou on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "HomeRecipeModelCell.h"
#import "HomeRecipeModel.h"

@implementation HomeRecipeModelCell

- (void)setDataWithModel:(HomeRecipeModel *)model {

    [_imageidView sd_setImageWithURL:[NSURL stringAppendingToURLWithString:model.imageid]];
    _titleLabel.text = model.name;
    _Description.text = model.authorname;
    _collectionCountLabel.text = model.collectCount;
    _likeCountLabel.text = model.likeCount;
}

@end
