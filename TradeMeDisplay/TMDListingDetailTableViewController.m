//
//  TMDListingDetailTableViewController.m
//  TradeMeDisplay
//
//  Created by Charles on 6/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import "TMDListingDetailTableViewController.h"
#import "TMDDataStore.h"
#import "TMDListingDetailImageCell.h"
#import "TMDListedItemDetail.h"
#import "TMDListingDetailTitleCell.h"

#define LISTING_DETAIL_IMAGE_CELL_NAME NSStringFromClass([TMDListingDetailImageCell class])
#define LISTING_DETAIL_TITLE_CELL_NAME NSStringFromClass([TMDListingDetailTitleCell class])


@interface TMDListingDetailTableViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end

@implementation TMDListingDetailTableViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ListingDetails";
    
    [self.tableView registerNib:[UINib nibWithNibName:LISTING_DETAIL_IMAGE_CELL_NAME bundle:nil]
         forCellReuseIdentifier:LISTING_DETAIL_IMAGE_CELL_NAME];
    [self.tableView registerNib:[UINib nibWithNibName:LISTING_DETAIL_TITLE_CELL_NAME bundle:nil]
         forCellReuseIdentifier:LISTING_DETAIL_TITLE_CELL_NAME];

    
    [self retrieveListingDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Retrieve listing details

- (void)retrieveListingDetails {

    [self.activityIndicator startAnimating];

    [TMDDataStore retrieveListingDetailsWithLisingId:self.listingId
                                          completion:^(BOOL success, TMDListedItemDetail *detail, NSError *error) {
                                              [self.activityIndicator stopAnimating];

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
        [tableView dequeueReusableCellWithIdentifier:LISTING_DETAIL_IMAGE_CELL_NAME
                                        forIndexPath:indexPath];
        [cell setImageWithURLString:self.detail.photoURLString];
        return cell;
    } else if (indexPath.section == 1) {
        TMDListingDetailTitleCell *cell =
        [tableView dequeueReusableCellWithIdentifier:LISTING_DETAIL_TITLE_CELL_NAME
                                        forIndexPath:indexPath];
        cell.titleLabel.text = self.detail.title;
        cell.detailLabel.text = [NSString stringWithFormat:@"%ld", self.detail.listingId];
        return cell;

    } else if (indexPath.section == 2) {
        TMDListingDetailTitleCell *cell =
        [tableView dequeueReusableCellWithIdentifier:LISTING_DETAIL_TITLE_CELL_NAME
                                        forIndexPath:indexPath];
        cell.titleLabel.text = [NSString stringWithFormat:@"%ld$", self.detail.startPrice];
        cell.detailLabel.text = [NSString stringWithFormat:@"%ld$", self.detail.buyNowPrice];
        return cell;

    } else if (indexPath.section == 3) {
        TMDListingDetailTitleCell *cell =
        [tableView dequeueReusableCellWithIdentifier:LISTING_DETAIL_TITLE_CELL_NAME
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
        cell.titleLabel.text = [formatter stringFromDate:startDate];
        cell.detailLabel.text = [formatter stringFromDate:endDate];
        
        return cell;
    } else if (indexPath.section == 4) {
        TMDListingDetailTitleCell *cell =
        [tableView dequeueReusableCellWithIdentifier:LISTING_DETAIL_TITLE_CELL_NAME
                                        forIndexPath:indexPath];
        cell.titleLabel.text = self.detail.body;
        cell.titleLabel.numberOfLines = 0;
        cell.detailLabel.text = @"";
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
            //TODO AUTO CALCULATION
            return 400;
            
        default:
            return CGFLOAT_MIN;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
