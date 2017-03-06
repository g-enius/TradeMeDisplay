//
//  TMDSearchResult.m
//  TradeMeDisplay
//
//  Created by Charles on 6/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import "TMDSearchResult.h"
#import "NSDictionary+SafeConvert.h"

@implementation TMDSearchResult

- (instancetype)initWithJSONDic:(NSDictionary *)jsonDic {
    self = [self init];
    if (self) {
        self.totalCount = [jsonDic integerForKey:@"TotalCount" defaultValue:0];
        self.page = [jsonDic integerForKey:@"Page" defaultValue:0];
        self.pageSize = [jsonDic integerForKey:@"PageSize" defaultValue:0];
        self.list = [TMDListing createWithJSONArray:[jsonDic arrayForKey:@"List"]];
    }
    
    return self;
}

@end
