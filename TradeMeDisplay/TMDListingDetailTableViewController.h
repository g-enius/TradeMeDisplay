//
//  TMDListingDetailTableViewController.h
//  TradeMeDisplay
//
//  Created by Charles on 6/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TMDListedItemDetail;

@interface TMDListingDetailTableViewController : UITableViewController

@property (assign, nonatomic) NSInteger listingId;
@property (strong, nonatomic) TMDListedItemDetail *detail;

@end
