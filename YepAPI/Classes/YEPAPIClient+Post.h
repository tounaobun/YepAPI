//
//  YEPAPIClient+Post.h
//  Yep
//
//  Created by benson on 9/11/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

#import "YEPAPIClient.h"

@interface YEPAPIClient (Post)

- (void)postNewPostWithContent:(NSString *)content
                          pics:(NSArray *)pics
                         token:(NSString *)token
                       success:(SuccessBlock)success
                      progress:(ProgressBlock)progress
                        notice:(OptionBlock)notice
                       failure:(FailureBlock)failure;

- (void)postPostListWithStartIndex:(NSInteger)startIndex
                           success:(SuccessBlock)success
                            notice:(OptionBlock)notice
                           failure:(FailureBlock)failure;

- (void)postReportPostWithPostId:(NSString *)postId
                           token:(NSString *)token
                         success:(SuccessBlock)success
                          notice:(OptionBlock)notice
                         failure:(FailureBlock)failure;
@end
