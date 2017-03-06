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
#import "TMDListingDatalTitleCell.h"

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.detail ? 5 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        TMDListingDetailImageCell * cell =
        [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TMDListingDetailImageCell class])
                                                                           forIndexPath:indexPath];
        [cell setImageWithURLString:self.detail.photoURLString];
        return cell;
    } else if (indexPath.section == 1) {
        TMDListingDatalTitleCell *cell =
        [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TMDListingDatalTitleCell class])
                                        forIndexPath:indexPath];
        cell.textLabel.text = self.detail.title;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", self.detail.listingId];
        return cell;

    } else if (indexPath.section == 2) {
        TMDListingDatalTitleCell *cell =
        [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TMDListingDatalTitleCell class])
                                        forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld$", self.detail.startPrice];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld$", self.detail.buyNowPrice];
        return cell;

    } else if (indexPath.section == 3) {
        TMDListingDatalTitleCell *cell =
        [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TMDListingDatalTitleCell class])
                                        forIndexPath:indexPath];
        NSString *startDateString = [self.detail.startDate substringWithRange:NSMakeRange(6, self.detail.startDate.length - 2 - 6)];
        NSString *endDateString = [self.detail.endDate substringWithRange:NSMakeRange(6, self.detail.endDate.length - 2 - 6)];
        NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:startDateString.doubleValue];
        NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:endDateString.doubleValue];
        
        static NSDateFormatter *formatter;
        if (!formatter) {
            formatter = [NSDateFormatter new];
            formatter.dateFormat = @"dd/MM/yyyy";
        }
        cell.textLabel.text = [formatter stringFromDate:startDate];
        cell.detailTextLabel.text = [formatter stringFromDate:endDate];
        
        return cell;
    } else if (indexPath.section == 4) {
        TMDListingDatalTitleCell *cell =
        [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TMDListingDatalTitleCell class])
                                        forIndexPath:indexPath];
        cell.textLabel.text = self.detail.body;
        cell.textLabel.numberOfLines = 0;
        cell.detailTextLabel.text = @"";
        return cell;
    }
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Photo";
    } else if (section == 1) {
        return @"Title & ListingId";
    } else if (section == 2) {
        return @"Start price & Buy now price";
    } else if (section == 3) {
        return @"Start date & End date";
    } else if (section == 4) {
        return @"Body";
    }
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 264;
        case 1:
            return 100;
        case 2:
            return 100;
        case 3:
            return 100;
        case 4:
            return 300;
            
        default:
            return CGFLOAT_MIN;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
