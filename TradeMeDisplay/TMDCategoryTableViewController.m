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
#import "TMDListingDetailTableViewController.h"
#import "TMDListing.h"

static NSString * const ShowListingsIdentifier = @"ShowListingsIdentifier";

@interface TMDCategoryTableViewController () <UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate>

@property (strong, nonatomic) NSArray <TMDCategory *> *dataSource;

@property (strong, nonatomic) TMDListingTableViewController *searchResultViewController;
@property (strong, nonatomic) UISearchController *searchController;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation TMDCategoryTableViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Categories";
    
    [self fetchCategories];

    self.searchResultViewController = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([TMDListingTableViewController class])];
    // We want ourselves to be the delegate for this filtered table so didSelectRowAtIndexPath is called for both tables.
    self.searchResultViewController.tableView.delegate = self;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultViewController];
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self.searchController.searchBar sizeToFit];
    
    // Search is now just presenting a view controller. As such, normal view controller
    // presentation semantics apply. Namely that presentation will walk up the view controller
    // hierarchy until it finds the root view controller or one that defines a presentation context.
    //
    self.definesPresentationContext = YES;
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
    [self.activityIndicator startAnimating];
    
    [TMDDataStore fetchCategoriesWithCompletion:^(BOOL success, NSArray *categoriesArray, NSError *error) {
        [self.activityIndicator stopAnimating];
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

// here we are the table view delegate for both our main table and filtered table, so we can
// push from the current navigation controller (resultsTableController's parent view controller
// is not this UINavigationController)
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView != self.tableView) {
        TMDListingDetailTableViewController *detailViewController =
        [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([TMDListingDetailTableViewController class])];
        if (self.searchResultViewController.dataSource.count > indexPath.row) {
            detailViewController.listingId = ((TMDListing *)self.searchResultViewController.dataSource[indexPath.row]).listingId;
            detailViewController.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
            detailViewController.navigationItem.leftItemsSupplementBackButton = YES;
            
            if (self.splitViewController.isCollapsed) {
                [self.navigationController pushViewController:detailViewController animated:YES];
            } else {
                UIViewController *detailNaviOfSplitVC = self.splitViewController.viewControllers.lastObject;
                if ([detailNaviOfSplitVC isKindOfClass:[UINavigationController class]]) {
                    [(UINavigationController *)detailNaviOfSplitVC setViewControllers:@[detailViewController] animated:NO];
                } else {
                    //To fix a bug when the detailVC of splitVC is not a navigationController;
                    //How to reappear this occasion: Search and enter detailedPage in portrait mode, and then turn to
                    //landscape mode, and then tap another searched result.
                    UINavigationController *newNavi = [[UINavigationController alloc]initWithRootViewController:detailViewController];
                    
                    UINavigationController *firstNavi = self.splitViewController.viewControllers.firstObject;
                    if (firstNavi) {
                        self.splitViewController.viewControllers = @[firstNavi, newNavi];
                    } else {
                        self.splitViewController.viewControllers = @[newNavi];
                    }
                }
            }
        }
    }
    [self.searchController.searchBar resignFirstResponder];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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

#pragma mark - UISearchResultsUpdating
// Called when the search bar's text or scope has changed or when the search bar becomes first responder.
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    NSString *strippedText = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (strippedText.length > 0) {
        //To Clear result table before loading new ones
        self.searchResultViewController.dataSource = nil;
        [self.searchResultViewController.tableView reloadData];
        [self.searchResultViewController.activityIndicator startAnimating];
        [TMDDataStore searchListsWithSearchString:searchText completion:^(BOOL success, NSArray<TMDListing *> *listings, NSError *error) {
            [self.searchResultViewController.activityIndicator stopAnimating];
            self.searchResultViewController.dataSource = listings;
            [self.searchResultViewController.tableView reloadData];
        }];
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

@end
