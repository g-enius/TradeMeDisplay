//
//  TMDCategoryTableViewController.m
//  TradeMeDisplay
//
//  Created by Charles on 5/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import "TMDCategoryTableViewController.h"
#import "TMDCategory.h"
#import "TMDCategoryTableViewCell.h"
#import "TMDDataStore.h"
#import "MBProgressHUD.h"

static NSString * const ShowListingsIdentifier = @"ShowListingsIdentifier";

@interface TMDCategoryTableViewController ()

@property (strong, nonatomic) NSArray <TMDCategory *> *dataSource;

@end

@implementation TMDCategoryTableViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Categories";
    [self fetchCategories];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Fetch data from server

- (void)fetchCategories
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [TMDDataStore fetchCategoriesWithCompletion:^(BOOL success, NSArray *categoriesArray, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (success) {
            self.dataSource = categoriesArray;
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
    TMDCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TMDCategoryTableViewCell class])
                                                                     forIndexPath:indexPath];
    if (self.dataSource.count > indexPath.row) {
        [cell fillDataWithCategory:self.dataSource[indexPath.row]];
    }
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:ShowListingsIdentifier]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        if (self.dataSource.count > indexPath.row && self.dataSource[indexPath.row]) {
            TMDCategory *category = self.dataSource[indexPath.row];
            TMDListingTableViewController *listingViewController = (TMDListingTableViewController *)((UINavigationController *)segue.destinationViewController).topViewController;
            listingViewController.categoryNumber = category.number;
            
            listingViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
            listingViewController.navigationItem.leftItemsSupplementBackButton = YES;

        }
    }
    
}

@end
