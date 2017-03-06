//
//  TMDListingViewController.m
//  TradeMeDisplay
//
//  Created by Charles on 5/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import "TMDListingViewController.h"
#import "TMDListing.h"
#import "TMDDataStore.h"
#import "TMDListingTableViewCell.h"
#import "MBProgressHUD.h"

@interface TMDListingViewController ()

@property (strong, nonatomic, readwrite) NSArray<TMDListing *> *dataSource;

@end

@implementation TMDListingViewController

#pragma mark - Life cycles

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self searchListings];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Search listings accourding to category number

- (void)searchListings {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [TMDDataStore searchListsWithBuy:@"All"
                            category:self.categoryNumber
                           clearance:@"All"
                           condition:@"All"
                             expired:NO
                           listed_as:@"All"
                      member_listing:0 page:1
                                 pay:@"All"
                          photo_size:@"Thumbnail"
                 return_did_you_mean:NO
                       return_metada:NO
                     shipping_method:@"All"
                          sort_order:@"Default"
                          completion:^(BOOL success, NSArray<TMDListing *> *listings, NSError *error) {
                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                              
                              if (success) {
                                  self.dataSource = listings;
                                  [self.tableView reloadData];
                              } else {
                                  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network error"
                                                                                                 message:error.description
                                                                                          preferredStyle:UIAlertControllerStyleAlert];
                                  UIAlertAction *action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
