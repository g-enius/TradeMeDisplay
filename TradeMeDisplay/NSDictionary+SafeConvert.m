//
//  NSDictionary+SafeConvert.m
//  TradeMeDisplay
//
//  Created by Charles on 5/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import "NSDictionary+SafeConvert.h"

@implementation NSDictionary (SafeConvert)

- (NSString *)stringForKey:(NSString *)key
{
    NSObject *object = [self objectForKey:key];
    
    if (object == nil || object == [NSNull null]) {
        return @"";
    }
    
    if ([object isKindOfClass:[NSString class]]) {
        return (NSString *)object;
    }
    
    //if the server passed a double
    if ([object isKindOfClass:[NSNumber class]]) {
        static NSNumberFormatter *TMDecimalNumberFormatter = nil;
        if (!TMDecimalNumberFormatter) {
            TMDecimalNumberFormatter = [[NSNumberFormatter alloc]init];
        }
        TMDecimalNumberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        TMDecimalNumberFormatter.groupingSeparator = @"";
        return [TMDecimalNumberFormatter stringFromNumber:(NSNumber *)object];
    }

    return [NSString stringWithFormat:@"%@",object];
}

- (NSArray *)arrayForKey:(NSString *)key
{
    NSObject *object = [self objectForKey:key];
    
    if ([object isKindOfClass:[NSArray class]]) {
        return (NSArray *)object;
    } else if ([object isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary *)object allValues];
    }
    return nil;
}

- (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue
{
    NSObject *object = [self objectForKey:key];
    
    if (object == nil || object == [NSNull null]) {
        return defaultValue;
    }
    
    if ([object respondsToSelector:@selector(boolValue)]) {
        return [(id)object boolValue];
    }
    return defaultValue;
}

- (NSInteger)integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue
{
    NSObject *object = [self objectForKey:key];
    
    if (object == nil || object == [NSNull null]) {
        return defaultValue;
    }
    
    if ([object respondsToSelector:@selector(integerValue)]) {
        return [(id)object integerValue];
    }
    return defaultValue;
}

@end
