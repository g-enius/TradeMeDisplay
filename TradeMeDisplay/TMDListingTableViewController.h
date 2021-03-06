//
//  TMDListingTableViewController.h
//  TradeMeDisplay
//
//  Created by Charles on 5/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMDListing;

@interface TMDListingTableViewController : UITableViewController

@property (strong, nonatomic) NSArray<TMDListing *> *dataSource;

@property (copy, nonatomic) NSString *categoryNumber;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
