//
//  TMDListingViewController.h
//  TradeMeDisplay
//
//  Created by Charles on 5/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMDListing;

@interface TMDListingViewController : UITableViewController

@property (strong, nonatomic, readonly) NSArray<TMDListing *> *dataSource;

@property (copy, nonatomic) NSString *categoryNumber;


@end
