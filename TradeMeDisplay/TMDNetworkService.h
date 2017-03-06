//
//  TMDNetworkService.h
//  TradeMeDisplay
//
//  Created by Charles on 5/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TMDCategory;
@class TMDSearchResult;
@class TMDListedItemDetail;

typedef void (^FetchRootCategoryCompletion)(BOOL success, TMDCategory *rootCategory, NSError *error);
typedef void (^SearchResultCompletion)(BOOL success, TMDSearchResult *result, NSError *error);
typedef void (^RetrieveListingDetailCompletion)(BOOL success, TMDListedItemDetail *detail, NSError *error);

@interface TMDNetworkService : NSObject

+ (void)fetchRootCategoryWithParameters:(NSDictionary *)parameters completion:(FetchRootCategoryCompletion)completion;
+ (void)searchResultWithParameters:(NSDictionary *)parameters completion:(SearchResultCompletion)completion;
+ (void)retrieveListingDetailWithParameters:(NSDictionary *)parameters completion:(RetrieveListingDetailCompletion)completion;

@end
