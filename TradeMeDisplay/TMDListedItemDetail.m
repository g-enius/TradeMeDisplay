//
//  TMDListedItemDetail.m
//  TradeMeDisplay
//
//  Created by Charles on 6/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import "TMDListedItemDetail.h"
#import "NSDictionary+SafeConvert.h"

@implementation TMDListedItemDetail

- (instancetype)initWithJSONDic:(NSDictionary *)jsonDic {
    if (self = [super init]) {
        self.listingId = [jsonDic integerForKey:@"ListingId" defaultValue:0];
        self.title = [jsonDic stringForKey:@"Title"];
        self.categoryId = [jsonDic stringForKey:@"Category"];
        self.startPrice = [jsonDic integerForKey:@"StartPrice" defaultValue:0];
        self.buyNowPrice = [jsonDic integerForKey:@"BuyNowPrice" defaultValue:0];
        self.startDate = [jsonDic stringForKey:@"StartDate"];
        self.endDate = [jsonDic stringForKey:@"EndDate"];
        self.body = [jsonDic stringForKey:@"Body"];
        
        NSArray *photos = [jsonDic arrayForKey:@"Photos"];
        if (photos.count > 0 && [photos[0] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *valueDic = photos[0][@"Value"];
            self.photoURLString = [valueDic stringForKey:@"FullSize"];
        }
    }
    
    return self;
}

@end
