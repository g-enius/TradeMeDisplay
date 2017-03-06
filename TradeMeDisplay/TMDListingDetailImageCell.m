//
//  TMDListingDetailImageCell.m
//  TradeMeDisplay
//
//  Created by Charles on 6/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import "TMDListingDetailImageCell.h"
#import "UIImageView+WebCache.h"

@implementation TMDListingDetailImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImageWithURLString:(NSString *)urlString {
    if (urlString) {
        [self.detailImageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    }
}

@end
