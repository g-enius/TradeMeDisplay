//
//  TMDDataStore.h
//  TradeMeDisplay
//
//  Created by Charles on 4/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMDNetworkService.h"

@class TMDCategory;
@class TMDSearchResult;
@class TMDListing;

typedef void (^searchListingsCompletion)(BOOL success, NSArray<TMDListing *> *listings, NSError *error);
typedef void (^fetchCategoriesCompletion)(BOOL success, NSArray<TMDCategory *> *categories, NSError *error);

@interface TMDDataStore : NSObject

//ADD SOME PROPERTIES AND CHANGE THESE METHODS TO INSTANCE METHODS IF YOU WANT TO STORE SOME DATA

+ (void)fetchCategoriesWithDepth:(NSUInteger)depth region:(NSUInteger)region with_counts:(BOOL)with_counts completion:(fetchCategoriesCompletion)completion;

+ (void)searchListsWithBuy:(NSString *)buy
                 category:(NSString *)category
                clearance:(NSString *)clearance
                condition:(NSString *)condition
                  expired:(BOOL)expired
                listed_as:(NSString *)listed_as
           member_listing:(NSInteger)member_listing
                     page:(NSInteger)page
                      pay:(NSString *)pay
                photo_size:(NSString *)photo_size
      return_did_you_mean:(BOOL)return_did_you_mean
            return_metada:(BOOL)return_metada
           shipping_method:(NSString *)shipping_method
               sort_order:(NSString *)sort_order
               completion:(searchListingsCompletion)completion;

@end
