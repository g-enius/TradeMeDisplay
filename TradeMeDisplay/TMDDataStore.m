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

@implementation TMDDataStore

+ (void)fetchCategoriesWithDepth:(NSUInteger)depth region:(NSUInteger)region with_counts:(BOOL)with_counts completion:(fetchCategoriesCompletion)completion {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    
    parameter[@"depth"]= @(depth);
    parameter[@"region"] = @(region);
    parameter[@"with_counts"] = @(with_counts);
    
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


+ (void)searchListsWithBuy:(NSString *)buy
                  category:(NSString *)category
                 clearance:(NSString *)clearance
                 condition:(NSString *)condition
                   expired:(BOOL)expired
                 listed_as:(NSString *)listed_as
            member_listing:(NSInteger)member_listing
                      page:(NSInteger)page pay:(NSString *)pay
                photo_size:(NSString *)photo_size
       return_did_you_mean:(BOOL)return_did_you_mean
             return_metada:(BOOL)return_metada
           shipping_method:(NSString *)shipping_method
                sort_order:(NSString *)sort_order
                completion:(searchListingsCompletion)completion {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"buy"] = buy;
    parameter[@"category"] = category;
    parameter[@"clearance"] = clearance;
    parameter[@"condition"] = condition;
    parameter[@"expired"] = @(expired);
    parameter[@"listed_as"] = listed_as;
    parameter[@"member_listing"] = @(member_listing);
    parameter[@"page"] = @(page);
    parameter[@"pay"] = pay;
    parameter[@"buy"] = buy;
    parameter[@"photo_size"] = photo_size;
    parameter[@"return_did_you_mean"] = @(return_did_you_mean);
    parameter[@"return_metada"] = @(return_metada);
    parameter[@"shipping_method"] = shipping_method;
    parameter[@"sort_order"] = sort_order;
    
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

@end
