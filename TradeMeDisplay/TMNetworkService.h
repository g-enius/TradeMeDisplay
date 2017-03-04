//
//  TMNetworkService.h
//  TradeMeDisplay
//
//  Created by Charles on 5/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^fetchCategoriesCompletion)(BOOL sucess, NSArray *catalogueArray, NSError *parseError, NSError *httpError);

@interface TMNetworkService : NSObject

+ (void)fetchCategoriesWithParameters:(NSDictionary *)parameters completion:(fetchCategoriesCompletion)completion;

@end
