//
//  YEPAPIClient.m
//  Yep
//
//  Created by benson on 8/29/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

#import "YEPAPIClient.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "NSString+MD5.h"
#import "YEPAPIClientConfig.h"

@interface YEPAPIClient ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation YEPAPIClient

+ (instancetype)sharedInstance {
    static YEPAPIClient *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YEPAPIClient alloc] init];
        sharedInstance.sessionManager = [self configSessionManager];
    });
    return sharedInstance;
}

+ (AFHTTPSessionManager *)configSessionManager {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kServerBaseURL] sessionConfiguration:configuration];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    sessionManager.responseSerializer = responseSerializer;
    [sessionManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", @"text/json", @"application/json", nil]];
    sessionManager.responseSerializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 301)]; // statusCode 200 - 500
    [sessionManager.requestSerializer setTimeoutInterval:kServerAPITimeOut];
    return sessionManager;
}

#pragma mark - GET ========

- (void)GET:(NSString *)path parameters:(NSDictionary *)params success:(SuccessBlock)success notice:(OptionBlock)notice failure:(FailureBlock)failure {

    NSString *signedPath = [NSString stringWithFormat:@"%@&sign=%@",path,[self generateSignWithPath:path]];
    WS(weakSelf)
    [self.sessionManager GET:signedPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger statusCode = ((NSHTTPURLResponse *)task.response).statusCode;
        NSInteger code = [responseObject[@"code"] integerValue];
        if (statusCode == kStatusCodeSuccess && code == kStatusCodeSuccess) {
            // statusCode & "code" 200 success
            !success?:success(task,responseObject);
        } else {
            // something wrong.
            [weakSelf handleNoticeWithResponseObject:responseObject];
            !notice?:notice(task,responseObject);
            [MBProgressHUD yep_dismissInfo:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure?:failure(task,error);
        [MBProgressHUD yep_dismissInfo:[error localizedDescription]];
    }];
}

#pragma mark - POST ========

- (void)POST:(NSString *)path parameters:(NSDictionary *)params success:(SuccessBlock)success notice:(OptionBlock)notice failure:(FailureBlock)failure {

    NSString *signedPath = [NSString stringWithFormat:@"%@&sign=%@",path,[self generateSignWithPath:path]];
    WS(weakSelf)
    [self.sessionManager POST:signedPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger statusCode = ((NSHTTPURLResponse *)task.response).statusCode;
        NSInteger code = [responseObject[@"code"] integerValue];
        if (statusCode == kStatusCodeSuccess && code == kStatusCodeSuccess) {
            // statusCode & "code" 200 success
            !success?:success(task,responseObject);
        } else {
            // something wrong.
            [weakSelf handleNoticeWithResponseObject:responseObject];
            !notice?:notice(task,responseObject);
            [MBProgressHUD yep_dismissInfo:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !failure?:failure(task,error);
        [MBProgressHUD yep_dismissInfo:[error localizedDescription]];
    }];
}

- (void)POST:(NSString *)path parameters:(NSDictionary *)params multiparts:(NSArray *)multiparts success:(SuccessBlock)success notice:(OptionBlock)notice progress:(ProgressBlock)progress failure:(FailureBlock)failure {
    
    NSString *signedPath = [NSString stringWithFormat:@"%@&sign=%@",path,[self generateSignWithPath:path]];
    WS(weakSelf)
    [self.sessionManager POST:signedPath parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSDictionary *dict in multiparts) {
            [formData appendPartWithFileData:dict[@"data"]
                                        name:dict[@"name"]
                                    fileName:dict[@"fileName"]
                                    mimeType:dict[@"mimetype"]];
        }
    } progress:^(NSProgress *uploadProgress) {
        !progress?:progress(uploadProgress);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSInteger statusCode = ((NSHTTPURLResponse *)task.response).statusCode;
        if (statusCode == kStatusCodeSuccess) {
            // 200 success
            !success?:success(task,responseObject);
        } else {
            // something wrong.
            [weakSelf handleNoticeWithResponseObject:responseObject];
            !notice?:notice(task,responseObject);
            [MBProgressHUD yep_dismissInfo:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        !failure?:failure(task,error);
        [MBProgressHUD yep_dismissInfo:[error localizedDescription]];
    }];

}

// generate sign value.
- (NSString *)generateSignWithPath:(NSString *)path {
    NSString *secretIngredient = [NSString stringWithFormat:@"%@%@%@",kMD5SaltValue,kServerBaseURL,path];
    NSString *sign = [secretIngredient yep_MD5String].lowercaseString;
    return sign;
}

- (void)handleNoticeWithResponseObject:(id)responseObject {
    NSString *code = responseObject[@"code"];
    if (code != nil && code.integerValue == 1) {
        // token expired. Log out user.
        [YEPUserModel removeCurrentUser];
    }
}

@end
