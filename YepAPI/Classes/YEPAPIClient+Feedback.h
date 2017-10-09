//
//  YEPAPIClient+Feedback.h
//  Yep
//
//  Created by benson on 9/11/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

#import "YEPAPIClient.h"

@interface YEPAPIClient (Feedback)

- (void)postSendFeedbackWithContent:(NSString *)content
                              token:(NSString *)token
                            success:(SuccessBlock)success
                             notice:(OptionBlock)notice
                            failure:(FailureBlock)failure;

@end
