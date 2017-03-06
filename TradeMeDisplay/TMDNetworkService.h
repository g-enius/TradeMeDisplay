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

typedef void (^fetchRootCategoryCompletion)(BOOL success, TMDCategory *rootCategory, NSError *error);
typedef void (^fetchListingCompletion)(BOOL success, TMDSearchResult *result, NSError *error);

@interface TMDNetworkService : NSObject

+ (void)fetchRootCategoryWithParameters:(NSDictionary *)parameters completion:(fetchRootCategoryCompletion)completion;
+ (void)searchResultWithParameters:(NSDictionary *)parameters completion:(fetchListingCompletion)completion;

@end
