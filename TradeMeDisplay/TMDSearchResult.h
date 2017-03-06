//
//  TMDSearchResult.h
//  TradeMeDisplay
//
//  Created by Charles on 6/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMDListing.h"

@interface TMDSearchResult : NSObject

@property (assign, nonatomic) NSInteger totalCount;
@property (assign, nonatomic) NSInteger page;
@property (assign, nonatomic) NSInteger pageSize;
@property (strong, nonatomic) NSArray <TMDListing *> *list;

- (instancetype)initWithJSONDic:(NSDictionary *)jsonDic;

@end
