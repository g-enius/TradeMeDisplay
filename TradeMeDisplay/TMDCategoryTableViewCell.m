//
//  TMDCategoryTableViewCell.m
//  TradeMeDisplay
//
//  Created by Charles on 5/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import "TMDCategoryTableViewCell.h"

@implementation TMDCategoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillDataWithCategory:(TMDCategory *)category
{
    self.textLabel.text = category.name;
    self.detailTextLabel.text = category.number;
}

@end
