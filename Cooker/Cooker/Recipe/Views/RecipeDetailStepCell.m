//
//  RecipeDetailStepCell.m
//  Cooker
//
//  Created by 诸超杰 on 16/4/20.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "RecipeDetailStepCell.h"

#define describeLabelWidth 250
@implementation RecipeDetailStepCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 40, 40)];
        self.stepLabel.font = [UIFont systemFontOfSize:28];
        [self.contentView addSubview:self.stepLabel];
        
        self.picImage = [[UIImageView alloc] init];
        self.describeLabel = [[UILabel alloc] init];
        self.describeLabel.font = [UIFont systemFontOfSize:15];
        self.describeLabel.numberOfLines = 0;
    }
    return self;
}

//返回每个分区高度的方法
+ (CGFloat)getHeightWith:(RecipeDetailModel *)model andIndexpath:(NSIndexPath *)indexPath {
    StepListModel *stepModel = model.stepListModelArray[indexPath.row];
   
    CGFloat height = [RecipeDetailStepCell getHeigntWith:stepModel.details];
    if (![stepModel.imageid isEqualToString:@""]) {
        //给出图片宽度
        height += 230;
    }
    //上下各空15
    height += 30;
    return height;
}


- (void)setModel:(RecipeDetailModel *)model andIndexPath:(NSIndexPath *)indexPath{
    StepListModel *stepModel = model.stepListModelArray[indexPath.row];
    self.describeLabel.text = stepModel.details;
    if (![stepModel.imageid isEqualToString:@""]) {
        [self.picImage sd_setImageWithURL:[NSURL stringAppendingToURLWithString:stepModel.imageid]];
        self.picImage.frame = CGRectMake(70, 15, describeLabelWidth, 200);
#pragma mark  =========这个步骤最好用扣死二第做，减少渲染，提高性能
        self.picImage.layer.masksToBounds = YES;
        self.picImage.layer.cornerRadius = 20;
        [self.contentView addSubview:self.picImage];
        self.describeLabel.frame = CGRectMake(70, 230, describeLabelWidth + 50, [RecipeDetailStepCell getHeigntWith:self.describeLabel.text]);
        [self.contentView addSubview:self.describeLabel];
    } else {
        [self.contentView addSubview:self.describeLabel];
        self.describeLabel.frame = CGRectMake(70, 15, describeLabelWidth + 50, [RecipeDetailStepCell getHeigntWith:self.describeLabel.text]);
    }
    
    self.stepLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
}


//根据字符多少返会高度
+ (CGFloat)getHeigntWith:(NSString *)string {
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil];
    CGRect rect = [string boundingRectWithSize:CGSizeMake(describeLabelWidth + 50, 1000) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    CGFloat height = rect.size.height;
    
    return height;
}


- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
