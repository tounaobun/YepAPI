//
//  YEPAPIClient+User.h
//  Yep
//
//  Created by benson on 8/30/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

#import "YEPAPIClient.h"
#import "YEPUserModel.h"
#import "EnumDef.h"
#import <CoreLocation/CoreLocation.h>

@interface YEPAPIClient (User)

- (void)postUserRegisterWithUserModel:(YEPUserModel *)model
                              success:(SuccessBlock)success
                              notice:(OptionBlock)notice
                             progress:(ProgressBlock)progress
                              failure:(FailureBlock)failure;

- (void)postUserListWithStartIndex:(NSInteger)startIndex
                            gender:(NSString *)gender
                               age:(NSString *)age
                              type:(YEPUserListType)type
                     socialAccount:(NSString *)socialAccount
                               tag:(NSString *)tag
                           success:(SuccessBlock)success
                            notice:(OptionBlock)notice
                           failure:(FailureBlock)failure;

- (void)postUserInfoWithUserId:(NSString *)userId
                         token:(NSString *)token
                       success:(SuccessBlock)success
                        notice:(OptionBlock)notice
                       failure:(FailureBlock)failure;

- (void)postUserReportWithUserId:(NSString *)userId
                           token:(NSString *)token
                         success:(SuccessBlock)success
                          notice:(OptionBlock)notice
                         failure:(FailureBlock)failure;

- (void)postUserLoginWithEmail:(NSString *)email
                      password:(NSString *)password
                        success:(SuccessBlock)success
                         notice:(OptionBlock)notice
                        failure:(FailureBlock)failure;

- (void)getUserLogoutWithToken:(NSString *)token
                       success:(SuccessBlock)success
                        notice:(OptionBlock)notice
                       failure:(FailureBlock)failure;

- (void)getDeleteUserWithToken:(NSString *)token
                       success:(SuccessBlock)success
                        notice:(OptionBlock)notice
                       failure:(FailureBlock)failure;

- (void)postLikeUserWithUserId:(NSString *)userId
                         token:(NSString *)token
                       success:(SuccessBlock)success
                        notice:(OptionBlock)notice
                       failure:(FailureBlock)failure;

- (void)postUnLikeUserWithUserId:(NSString *)userId
                           token:(NSString *)token
                         success:(SuccessBlock)success
                          notice:(OptionBlock)notice
                         failure:(FailureBlock)failure;

- (void)postInterestListWithStartIndex:(NSInteger)startIndex
                                  type:(YEPInterestListType)type
                                 token:(NSString *)token
                               success:(SuccessBlock)success
                                notice:(OptionBlock)notice
                               failure:(FailureBlock)failure;

- (void)postUpdateProfileWithParams:(NSDictionary *)params
                              video:(NSURL *)videoURL
                          sculpture:(UIImage *)sculpture
                              token:(NSString *)token
                            success:(SuccessBlock)success
                           progress:(ProgressBlock)progress
                             notice:(OptionBlock)notice
                            failure:(FailureBlock)failure;

- (void)getUserStatusWithToken:(NSString *)token
                       success:(SuccessBlock)success
                        notice:(OptionBlock)notice
                       failure:(FailureBlock)failure;

- (void)postClickSocialAccountWithUserId:(NSString *)userId
                                    type:(YEPSocialAppType)type
                                   token:(NSString *)token
                                 success:(SuccessBlock)success
                                  notice:(OptionBlock)notice
                                 failure:(FailureBlock)failure;

- (void)postUserLocationLogWithCoordinate:(CLLocationCoordinate2D)coordinate
                                    token:(NSString *)token
                                  success:(SuccessBlock)success
                                   notice:(OptionBlock)notice
                                  failure:(FailureBlock)failure;

- (void)postUserLocationSetWithHideMyLocation:(BOOL)hideMyLocation
                                        token:(NSString *)token
                                      success:(SuccessBlock)success
                                       notice:(OptionBlock)notice
                                      failure:(FailureBlock)failure;

- (void)postUserLocationNearbyWithCoordinate:(CLLocationCoordinate2D)coordinate
                                     success:(SuccessBlock)success
                                      notice:(OptionBlock)notice
                                     failure:(FailureBlock)failure;
@end
