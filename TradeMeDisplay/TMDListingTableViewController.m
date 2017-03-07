//
//  TMDListingTableViewController.m
//  TradeMeDisplay
//
//  Created by Charles on 5/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import "TMDListingTableViewController.h"
#import "TMDListing.h"
#import "TMDDataStore.h"
#import "TMDListingTableViewCell.h"
#import "TMDListingDetailTableViewController.h"

#define LISTING_CELL_NAME NSStringFromClass([TMDListingTableViewCell class])

static NSString * const ShowListingDetailIdentifier = @"ShowListingDetailIdentifier";

@interface TMDListingTableViewController ()


@end

@implementation TMDListingTableViewController

#pragma mark - Life cycles

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Listings";

    [self.tableView registerNib:[UINib nibWithNibName:LISTING_CELL_NAME bundle:nil] forCellReuseIdentifier:LISTING_CELL_NAME];
    
    if (self.categoryNumber.length > 0) {
        [self searchListings];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Search listings accourding to category number

- (void)searchListings {
    [self.activityIndicator startAnimating];

    [TMDDataStore searchListsWithCategory:self.categoryNumber
                               completion:^(BOOL success, NSArray<TMDListing *> *listings, NSError *error) {
                                   [self.activityIndicator stopAnimating];
                                   
                                   if (success) {
                                      self.dataSource = listings;
                                      [self.tableView reloadData];
                                   } else {
                                      UIAlertController *alert =
                                      [UIAlertController alertControllerWithTitle:@"Network error"
                                                                          message:error.localizedDescription
                                                                   preferredStyle:UIAlertControllerStyleAlert];
                                      
                                      UIAlertAction *action =
                                      [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
                                      
                                      [alert addAction:action];
                                      [self presentViewController:alert animated:YES completion:nil];
                                   }
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TMDListingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LISTING_CELL_NAME forIndexPath:indexPath];
    if (self.dataSource.count > indexPath.row) {
        [cell fillDataWithListing:self.dataSource[indexPath.row]];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource.count > indexPath.row) {
        TMDListingDetailTableViewController *detailViewController = [TMDListingDetailTableViewController new];
        detailViewController.listingId = ((TMDListing *)self.dataSource[indexPath.row]).listingId;
        detailViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        detailViewController.navigationItem.leftItemsSupplementBackButton = YES;
        
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
