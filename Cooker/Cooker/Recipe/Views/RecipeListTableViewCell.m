//
//  RecipeListTableViewCell.m
//  Cooker
//
//  Created by 叶旺 on 16/4/22.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "RecipeListTableViewCell.h"
#import "RecipeListTableViewModel.h"

@implementation RecipeListTableViewCell

- (void)setDataWithModel:(RecipeListTableViewModel *)model {
    [_imageIDview sd_setImageWithURL:[NSURL stringAppendingToURLWithString:model.imageid]];
    _nameLabel.text = model.name;
    _descriptionLabel.text = model.Description;
    _countLabel.text = [NSString stringWithFormat:@"菜谱 %@", model.recipeCount];
}

- (void)setDataWithOtherModel:(BaseModel *)model {
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
