//
//  TMDListedItemDetail.h
//  TradeMeDisplay
//
//  Created by Charles on 6/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMDListedItemDetail : NSObject

@property (assign, nonatomic) NSInteger listingId;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *categoryId;
@property (assign, nonatomic) NSInteger startPrice;
@property (assign, nonatomic) NSInteger buyNowPrice;
@property (copy, nonatomic) NSString *startDate;
@property (copy, nonatomic) NSString *endDate;
@property (copy, nonatomic) NSString *photoURLString;
@property (copy, nonatomic) NSString *body;

- (instancetype)initWithJSONDic:(NSDictionary *)jsonDic;

@end
