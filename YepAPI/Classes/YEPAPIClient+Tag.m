//
//  YEPAPIClient+Tag.m
//  Yep
//
//  Created by benson on 9/12/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

#import "YEPAPIClient+Tag.h"
#import "YEPAPIClientConfig.h"

@implementation YEPAPIClient (Tag)

- (void)postTagListWithSuccess:(SuccessBlock)success
                        notice:(OptionBlock)notice
                       failure:(FailureBlock)failure {
    NSMutableDictionary *params = @{}.mutableCopy;
    NSString *path = [NSString stringWithFormat:@"api/tagapi/tagList?timestamp=%@",TimeStamp];
    [self POST:path parameters:params success:success notice:notice failure:failure];
}

@end
