//
//  YEPAPIClient+Feedback.m
//  Yep
//
//  Created by benson on 9/11/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

#import "YEPAPIClient+Feedback.h"
#import "NSMutableDictionary+Kit.h"
#import "YEPAPIClientConfig.h"

@implementation YEPAPIClient (Feedback)

- (void)postSendFeedbackWithContent:(NSString *)content
                              token:(NSString *)token
                            success:(SuccessBlock)success
                             notice:(OptionBlock)notice
                            failure:(FailureBlock)failure {
    NSMutableDictionary *params = @{}.mutableCopy;
    [params yep_setValue:content forKey:@"content"];
    NSString *path = [NSString stringWithFormat:@"api/feedbackapi/newFeedback?timestamp=%@&token=%@",TimeStamp,token];
    [self POST:path parameters:params success:success notice:notice failure:failure];
}

@end
