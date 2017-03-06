//
//  TMDLisingDetailTableViewController.m
//  TradeMeDisplay
//
//  Created by Charles on 6/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import "TMDLisingDetailTableViewController.h"
#import "TMDDataStore.h"
#import "TMDListingDetailImageCell.h"
#import "TMDListedItemDetail.h"
#import "MBProgressHUD.h"

@interface TMDLisingDetailTableViewController ()

@property (strong, nonatomic) TMDListedItemDetail *detail;

@end

@implementation TMDLisingDetailTableViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ListingDetails";
    [self retrieveListingDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Retrieve listing details

- (void)retrieveListingDetails {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [TMDDataStore retrieveListingDetailsWithLisingId:self.listingId
                                          completion:^(BOOL success, TMDListedItemDetail *detail, NSError *error) {
                                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                                              if (success) {
                                                  self.detail = detail;
                                                  [self.tableView reloadData];
                                              } else { \
                                                  UIAlertController *alert =
                                                  [UIAlertController alertControllerWithTitle:@"Network error"
                                                                                      message:error.localizedDescription
                                                                               preferredStyle:UIAlertControllerStyleAlert];
                                                  
                                                  UIAlertAction *action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
                                                  [alert addAction:action];
                                                  [self presentViewController:alert animated:YES completion:nil];
                                              }
                                          }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.detail ? 1 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        TMDListingDetailImageCell * cell =
        [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TMDListingDetailImageCell class])
                                                                           forIndexPath:indexPath];
        [cell setImageWithURLString:self.detail.photoURLString];
        return cell;
    } else {
        return [UITableViewCell new];
    }
    
}

@end
