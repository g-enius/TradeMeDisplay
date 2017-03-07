//
//  TMDListingDetailTitleCell.m
//  TradeMeDisplay
//
//  Created by Charles on 6/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import "TMDListingDetailTitleCell.h"

@implementation TMDListingDetailTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
