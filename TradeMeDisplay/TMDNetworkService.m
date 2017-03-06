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
#import "TMDListedItemDetail.h"

#define REQUEST_HEADER_VAULE [NSString stringWithFormat:@"OAuth oauth_consumer_key=%@, oauth_signature_method=PLAINTEXT, oauth_signature=%@%%26",ConsumerKey, ConsumerSecreat]

static NSString * const RequestHeader = @"Authorization";
static NSString * const ConsumerKey = @"A1AC63F0332A131A78FAC304D007E7D1";
static NSString * const ConsumerSecreat = @"EC7F18B17A062962C6930A8AE88B16C7";
static NSString * const CategoryURL = @"https://api.tmsandbox.co.nz/v1/Categories/0.json";
static NSString * const ListingURL = @"https://api.tmsandbox.co.nz/v1/Search/General.json";
static NSString * const ListingDetailURL = @"https://api.tmsandbox.co.nz/v1/Listings/";
static NSString * const NetworkErrorDescription = @"Network Error, Please try later.";
static NSInteger const ParseErrorCode = 1024;
static NSString * const ParseErrorDescripion = @"Parse Error";
static NSString * const CategoryErrorDomain = @"CategoryErrorDomain";
static NSString * const ListingErrorDomain = @"ListingErrorDomain";
static NSString * const ListingDetailErrorDomain = @"ListingDetailErrorDomain";

@implementation TMDNetworkService

+ (void)fetchRootCategoryWithParameters:(NSDictionary *)parameters
                             completion:(FetchRootCategoryCompletion)completion
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //NO NEED FOR AUTHORIZATION
    [manager GET:CategoryURL
      parameters:parameters
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if (completion) {
                TMDCategory *rootCategory = [[TMDCategory alloc]initWithJSONDic:responseObject];
                completion(YES, rootCategory, nil);
            }
        } else if (completion) {
            NSError *ParseError = [NSError errorWithDomain:CategoryErrorDomain
                                                      code:ParseErrorCode
                                                  userInfo:@{NSLocalizedDescriptionKey:ParseErrorDescripion}];
            completion(NO, nil, ParseError);
        }
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError *httpError = [NSError errorWithDomain:CategoryErrorDomain
                                                 code:error.code
                                             userInfo:\
  @{NSLocalizedDescriptionKey:[ParseErrorDescripion stringByAppendingFormat:@" (%ld)",error.code]}];
        if (completion) {
            completion(NO, nil, httpError);
        }
    }];
}

+ (void)searchResultWithParameters:(NSDictionary *)parameters
                        completion:(SearchResultCompletion)completion {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //NEED AUTHORIZATION
    [manager.requestSerializer setValue:REQUEST_HEADER_VAULE forHTTPHeaderField:RequestHeader];
    
    [manager GET:ListingURL
      parameters:parameters progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]) {
            if (completion) {
                TMDSearchResult *result = [[TMDSearchResult alloc]initWithJSONDic:responseObject];
                completion(YES, result, nil);
            }
        } else if(completion) {
            NSError *parseError = [NSError errorWithDomain:ListingErrorDomain
                                                      code:ParseErrorCode
                                                  userInfo:@{NSLocalizedDescriptionKey:ParseErrorDescripion}];
            completion(NO, nil, parseError);
        }
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError *httpError = [NSError errorWithDomain:ListingErrorDomain
                                                 code:error.code
                                             userInfo:\
  @{NSLocalizedDescriptionKey:[ParseErrorDescripion stringByAppendingFormat:@" (%ld)",error.code]}];
        if (completion) {
            completion(NO, nil, httpError);
        }
    }];
}

+ (void)retrieveListingDetailWithParameters:(NSDictionary *)parameters
                                 completion:(RetrieveListingDetailCompletion)completion {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //NEED AUTHORIZATION
    [manager.requestSerializer setValue:REQUEST_HEADER_VAULE forHTTPHeaderField:RequestHeader];
    
    NSInteger listingId = [parameters[@"ListingId"] integerValue];
    NSString *requestURL = [NSString stringWithFormat:@"%@%ld.json", ListingDetailURL, listingId];
    
    [manager GET:requestURL
      parameters:parameters progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             if ([responseObject isKindOfClass:[NSDictionary class]]) {
                 if (completion) {
                     TMDListedItemDetail *detail = [[TMDListedItemDetail alloc]initWithJSONDic:responseObject];
                     completion(YES, detail, nil);
                 }
             } else if (completion) {
                 NSError *parseError = [NSError errorWithDomain:ListingDetailErrorDomain
                                                           code:ParseErrorCode
                                                       userInfo:@{NSLocalizedDescriptionKey:ParseErrorDescripion}];
                 completion(NO, nil, parseError);
             }
        
    }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if (completion) {
                 NSError *httpError = [NSError errorWithDomain:ListingDetailErrorDomain
                                                          code:error.code
                                                      userInfo:\
  @{NSLocalizedDescriptionKey:[ParseErrorDescripion stringByAppendingFormat:@" (%ld)",error.code]}];
                 completion(NO, nil, httpError);
             }
    }];
}

@end
