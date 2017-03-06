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
#import "TMDLisingDetailTableViewController.h"
#import "MBProgressHUD.h"

static NSString * const ShowListingDetailIdentifier = @"ShowListingDetailIdentifier";

@interface TMDListingTableViewController ()

@property (strong, nonatomic, readwrite) NSArray<TMDListing *> *dataSource;

@end

@implementation TMDListingTableViewController

#pragma mark - Life cycles

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Listings";
    [self searchListings];
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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [TMDDataStore searchListsWithCategory:self.categoryNumber
                               completion:^(BOOL success, NSArray<TMDListing *> *listings, NSError *error) {
                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                              
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
    TMDListingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TMDListingTableViewCell class]) forIndexPath:indexPath];
    if (self.dataSource.count > indexPath.row) {
        [cell fillDataWithListing:self.dataSource[indexPath.row]];
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:ShowListingDetailIdentifier]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        if (self.dataSource.count > indexPath.row) {
            TMDLisingDetailTableViewController *detailViewController =
            (TMDLisingDetailTableViewController *)segue.destinationViewController;
            detailViewController.listingId = ((TMDListing *)self.dataSource[indexPath.row]).listingId;
            
            detailViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
            detailViewController.navigationItem.leftItemsSupplementBackButton = YES;
        }
    }
}

@end
