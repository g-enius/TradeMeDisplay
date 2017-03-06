//
//  TMDListingTableViewCell.m
//  TradeMeDisplay
//
//  Created by Charles on 6/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import "TMDListingTableViewCell.h"
#import "TMDListing.h"
#import "UIImageView+WebCache.h"

@implementation TMDListingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillDataWithListing:(TMDListing *)listing {
    [self.thumbnail sd_setImageWithURL:[NSURL URLWithString:listing.picURL]];
    self.nameLabel.text = listing.title;
    self.listingIdLabel.text = [NSString stringWithFormat:@"%ld", listing.listingId];
}

@end
