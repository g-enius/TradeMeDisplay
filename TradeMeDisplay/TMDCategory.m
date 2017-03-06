//
//  TMDCategory.m
//  TradeMeDisplay
//
//  Created by Charles on 5/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import "TMDCategory.h"
#import "NSDictionary+SafeConvert.h"

@implementation TMDCategory

- (instancetype)initWithJSONDic:(NSDictionary *)jsonDic {
    self = [super init];
    if (self) {
        self.name = [jsonDic stringForKey:@"Name"];
        self.number = [jsonDic stringForKey:@"Number"];
        self.Subcategories =  [TMDCategory createWithJSONArray:[jsonDic arrayForKey:@"Subcategories"]];
    }
    
    return self;
}

+ (NSArray<TMDCategory *> *)createWithJSONArray:(NSArray *)jsonArray {
    if (![jsonArray isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    NSMutableArray *categoryArray = [NSMutableArray array];
    for (NSDictionary *jsonDic in jsonArray) {
        TMDCategory *category =  [[TMDCategory alloc] initWithJSONDic:jsonDic];
        if (category) {
            [categoryArray addObject:category];
        }
    }
    return [categoryArray copy];
}

@end
