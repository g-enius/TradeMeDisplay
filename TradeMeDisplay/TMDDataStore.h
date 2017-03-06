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

+ (void)fetchCategoriesWithCompletion:(fetchCategoriesCompletion)completion;

+ (void)searchListsWithCategory:(NSString *)category
               completion:(searchListingsCompletion)completion;

@end
