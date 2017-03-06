//
//  TMDCategory.h
//  TradeMeDisplay
//
//  Created by Charles on 5/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TMDCategory : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *number;
@property (strong, nonatomic) NSArray<TMDCategory *> *Subcategories;

- (instancetype)initWithJSONDic:(NSDictionary *)jsonDic;
+ (NSArray<TMDCategory *> *)createWithJSONArray:(NSArray *)jsonArray;

@end
