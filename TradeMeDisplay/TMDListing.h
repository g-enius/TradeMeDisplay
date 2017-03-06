//
//  TMDListing.h
//  TradeMeDisplay
//
//  Created by Charles on 6/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMDListing : NSObject

@property (assign, nonatomic) NSInteger listingId;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *category;
@property (copy, nonatomic) NSString *picURL;

- (instancetype)initWithJSONDic:(NSDictionary *)jsonDic;

+ (NSArray *)createWithJSONArray:(NSArray *)jsonArray;

@end
