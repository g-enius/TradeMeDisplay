//
//  TMDataStore.h
//  TradeMeDisplay
//
//  Created by Charles on 4/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMNetworkService.h"

@interface TMDataStore : NSObject

+ (void)fetchCategoriesWithNumber:(NSInteger)number depth:(NSInteger)depth region:(NSInteger)region with_counts:(BOOL)with_counts completion:(fetchCategoriesCompletion)completion;

@end
