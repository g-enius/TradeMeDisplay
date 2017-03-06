//
//  TMDListingDetailImageCell.h
//  TradeMeDisplay
//
//  Created by Charles on 6/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMDListingDetailImageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;

- (void)setImageWithURLString:(NSString *)urlString;

@end
