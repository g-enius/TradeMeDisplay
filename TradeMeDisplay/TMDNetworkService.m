//
//  TMDNetworkService.m
//  TradeMeDisplay
//
//  Created by Charles on 5/03/17.
//  Copyright © 2017 Charles. All rights reserved.
//

#import "TMDNetworkService.h"
#import "AFNetworking.h"
#import "TMDCategory.h"
#import "TMDSearchResult.h"

#define REQUEST_HEADER_VAULE [NSString stringWithFormat:@"OAuth oauth_consumer_key=%@, oauth_signature_method=PLAINTEXT, oauth_signature=%@%%26",ConsumerKey, ConsumerSecreat]

static NSString * const RequestHeader = @"Authorization";
static NSString * const ConsumerKey = @"A1AC63F0332A131A78FAC304D007E7D1";
static NSString * const ConsumerSecreat = @"EC7F18B17A062962C6930A8AE88B16C7";
static NSString * const CategoryURL = @"https://api.tmsandbox.co.nz/v1/Categories/0.json";
static NSString * const ListingURL = @"https://api.tmsandbox.co.nz/v1/Search/General.json";
static NSString * const NetworkErrorDescription = @"Network Error, Please try later.";
static NSInteger const parseErrorCode = 1024;
static NSString * const parseErrorDescripion = @"Parse Error";
static NSString * const CategoryErrorDomain = @"CategoryErrorDomain";
static NSString * const ListingErrorDomain = @"ListingErrorDomain";

@implementation TMDNetworkService

+ (void)fetchRootCategoryWithParameters:(NSDictionary *)parameters completion:(fetchRootCategoryCompletion)completion
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:REQUEST_HEADER_VAULE forHTTPHeaderField:RequestHeader];
    
    [manager GET:CategoryURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            TMDCategory *rootCategory = [[TMDCategory alloc]initWithJSONDic:responseObject];
            if (completion) {
                completion(YES, rootCategory, nil);
            }
        } else if (completion) {
            NSError *parseError = [NSError errorWithDomain:CategoryErrorDomain code:parseErrorCode userInfo:@{NSLocalizedDescriptionKey:parseErrorDescripion}];
            completion(NO, nil, parseError);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError *httpError = [NSError errorWithDomain:CategoryErrorDomain code:error.code userInfo:@{NSLocalizedDescriptionKey:error.description}];
        if (completion) {
            completion(NO, nil, httpError);
        }
    }];
}

+ (void)searchResultWithParameters:(NSDictionary *)parameters completion:(fetchListingCompletion)completion {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:REQUEST_HEADER_VAULE forHTTPHeaderField:RequestHeader];
    
    [manager GET:ListingURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]) {
            TMDSearchResult *result = [[TMDSearchResult alloc]initWithJSONDic:responseObject];
            if (completion) {
                completion(YES, result, nil);
            }
        } else if(completion) {
            NSError *parseError = [NSError errorWithDomain:ListingErrorDomain code:parseErrorCode userInfo:@{NSLocalizedDescriptionKey:parseErrorDescripion}];
            completion(NO, nil, parseError);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError *httpError = [NSError errorWithDomain:ListingErrorDomain code:error.code userInfo:@{NSLocalizedDescriptionKey:error.description}];
        if (completion) {
            completion(NO, nil, httpError);
        }
    }];
}

@end
