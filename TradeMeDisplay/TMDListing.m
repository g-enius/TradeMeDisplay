//
//  TMDListing.m
//  TradeMeDisplay
//
//  Created by Charles on 6/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import "TMDListing.h"
#import "NSDictionary+SafeConvert.h"

@implementation TMDListing

- (instancetype)initWithJSONDic:(NSDictionary *)jsonDic {
    self = [super init];
    if (self) {
        self.title = [jsonDic stringForKey:@"Title"];
        self.listingId = [jsonDic integerForKey:@"ListingId" defaultValue:0];
        self.picURL = [jsonDic stringForKey:@"PictureHref"];
        self.category = [jsonDic stringForKey:@"Category"];
    }
    
    return self;
}

+ (NSArray *)createWithJSONArray:(NSArray *)jsonArray {
    if ([jsonArray isKindOfClass:[NSArray class]]) {
        NSMutableArray *listingArray = [NSMutableArray array];
        
        for (NSDictionary *dic in jsonArray) {
            TMDListing *listing = [[TMDListing alloc]initWithJSONDic:dic];
            if (listing) {
                [listingArray addObject:listing];
            }
        }
        
        return [listingArray copy];
    } else {
        return nil;
    }
}

@end
