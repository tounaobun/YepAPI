//
//  YEPAPIClient.h
//  Yep
//
//  Created by benson on 8/29/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock)(NSURLSessionDataTask *operation, id responseObject);
typedef void (^FailureBlock)(NSURLSessionDataTask *operation, NSError *error);
typedef void (^OptionBlock)(NSURLSessionDataTask *operation, id responseObject);
typedef void (^ProgressBlock)(NSProgress *uploadProgress);

@interface YEPAPIClient : NSObject

+ (instancetype)sharedInstance;

- (void)GET:(NSString *)path parameters:(NSDictionary *)params success:(SuccessBlock)success notice:(OptionBlock)notice failure:(FailureBlock)failure;

- (void)POST:(NSString *)path parameters:(NSDictionary *)params success:(SuccessBlock)success notice:(OptionBlock)notice failure:(FailureBlock)failure;

- (void)POST:(NSString *)path parameters:(NSDictionary *)params multiparts:(NSArray *)multiparts success:(SuccessBlock)success notice:(OptionBlock)notice progress:(ProgressBlock)progress failure:(FailureBlock)failure;

@end
