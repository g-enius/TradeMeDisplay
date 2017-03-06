//
//  TMDDataStore.m
//  TradeMeDisplay
//
//  Created by Charles on 4/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import "TMDDataStore.h"
#import "TMDNetworkService.h"
#import "TMDCategory.h"
#import "TMDSearchResult.h"

static const NSInteger resultCount = 20;

@implementation TMDDataStore

+ (void)fetchCategoriesWithCompletion:(FetchCategoriesCompletion)completion {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    
    parameter[@"depth"]= @(1);
    
    [TMDNetworkService fetchRootCategoryWithParameters:parameter completion:^(BOOL success, TMDCategory *rootCategory, NSError *error) {
        if (success) {
            NSMutableArray *categories = [NSMutableArray array];
            for (TMDCategory *subCategory in rootCategory.Subcategories) {
                if (subCategory) {
                    [categories addObject:subCategory];
                }
            }
            
            if (completion) {
                completion(YES, [categories copy], error);
            }
        } else if (completion) {
            completion(NO, nil, error);
        }
    }];
}


+ (void)searchListsWithCategory:(NSString *)category
                completion:(SearchListingsCompletion)completion {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"category"] = category;
    parameter[@"rows"] = @(resultCount);
    
    [TMDNetworkService searchResultWithParameters:parameter completion:^(BOOL success, TMDSearchResult *result, NSError *error) {
        if (success) {
            NSMutableArray *listingsArray = [NSMutableArray array];
            for (TMDListing *listing in result.list) {
                if (listing) {
                    [listingsArray addObject:listing];
                }
            }
            if (completion) {
                completion(YES, [listingsArray copy], nil);
            }
        } else if (completion) {
            completion(NO, nil,error);
        }
    }];
}

+ (void)retrieveListingDetailsWithLisingId:(NSInteger)listingId
                                completion:(RetrieveListingDetailCompletion)completion {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"ListingId"] = @(listingId);
    
    [TMDNetworkService retrieveListingDetailWithParameters:parameter
                                                completion:^(BOOL success, TMDListedItemDetail *detail, NSError *error) {
                                                    if (success) {
                                                        if (completion) {
                                                            completion(YES, detail, nil);
                                                        }
                                                    } else if (completion) {
                                                        completion(NO,nil, error);
                                                    }
                                                }];
}

@end
