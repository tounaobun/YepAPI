//
//  YEPAPIClient+User.m
//  Yep
//
//  Created by benson on 8/30/17.
//  Copyright © 2017 Anthony. All rights reserved.
//


#import "YEPAPIClient+User.h"
#import "UIImage+Addition.h"
#import "NSMutableDictionary+Kit.h"
#import "NSString+Util.h"
#import "YEPAPIClientConfig.h"

@implementation YEPAPIClient (User)

- (void)postUserRegisterWithUserModel:(YEPUserModel *)model
                              success:(SuccessBlock)success
                               notice:(OptionBlock)notice
                             progress:(ProgressBlock)progress
                              failure:(FailureBlock)failure {
    
    // multiparts.
    NSMutableArray *multiparts = @[].mutableCopy;
    // sculpture
    if (model.sculptureImage) {
        UIImage *compressedImage = [model.sculptureImage yep_resizeImageWithMaxSize:CGSizeMake(1080, 1920)];
        NSData *imagedata = UIImagePNGRepresentation(compressedImage);
        NSString *mimeType1 = [NSString yep_mimeTypeForImageData:imagedata];
        NSDictionary *dict1 = @{@"data": imagedata,@"mimetype": mimeType1,@"name": @"sculpture",@"fileName": @"sculpture.png"};
        [multiparts addObject:dict1];
        NSData *resizedImageData = UIImageJPEGRepresentation([model.sculptureImage yep_resizeImageWithMaxSize:CGSizeMake(300, 400)], 1.0);
        NSString *mimeType2 = [NSString yep_mimeTypeForImageData:resizedImageData];
        NSDictionary *dict2 = @{@"data": resizedImageData,@"mimetype": mimeType2,@"name": @"sculpture_s",@"fileName": @"sculpture_s.jpg"};
        [multiparts addObject:dict2];
    }

    if (model.videoFileURL) {
        NSDictionary *dict = @{@"data": [NSData dataWithContentsOfURL:model.videoFileURL],@"mimetype": @"video/quicktime",@"name": @"video_url",@"fileName": @"video.mov"};
        [multiparts addObject:dict];
    }
    
    NSString *path = [NSString stringWithFormat:@"api/userapi/register?timestamp=%@",TimeStamp];
    NSDictionary *params = [model yy_modelToJSONObject];
    [self POST:path parameters:params multiparts:multiparts success:success notice:notice progress:progress failure:failure];
}

- (void)postUserListWithStartIndex:(NSInteger)startIndex
                            gender:(NSString *)gender
                               age:(NSString *)age
                              type:(YEPUserListType)type
                     socialAccount:(NSString *)socialAccount
                               tag:(NSString *)tag
                           success:(SuccessBlock)success
                            notice:(OptionBlock)notice
                           failure:(FailureBlock)failure {
    
    NSMutableDictionary *params = @{}.mutableCopy;
    [params yep_setValue:@(startIndex) forKey:@"startidx"];
    [params yep_setValue:gender forKey:@"gender"];
    [params yep_setValue:age forKey:@"age"];
    [params yep_setValue:@(type + 1) forKey:@"type"];
    [params yep_setValue:socialAccount forKey:@"social_account"];
    [params yep_setValue:tag forKey:@"tag"];
    
    NSString *path = [NSString stringWithFormat:@"api/userapi/userList?timestamp=%@",TimeStamp];
    [self POST:path parameters:params success:success notice:notice failure:failure];
}

- (void)postUserInfoWithUserId:(NSString *)userId
                         token:(NSString *)token
                       success:(SuccessBlock)success
                        notice:(OptionBlock)notice
                       failure:(FailureBlock)failure {
    NSMutableDictionary *params = @{}.mutableCopy;
    [params yep_setValue:userId forKey:@"user_id"];
    NSString *path = [NSString stringWithFormat:@"api/userapi/userInfo?timestamp=%@",TimeStamp];
    if (token.length > 0) {
        // if has token
        path = [NSString stringWithFormat:@"%@&token=%@",path,token];
    }
    [self POST:path parameters:params success:success notice:notice failure:failure];
}

- (void)postUserReportWithUserId:(NSString *)userId
                           token:(NSString *)token
                         success:(SuccessBlock)success
                          notice:(OptionBlock)notice
                         failure:(FailureBlock)failure {
    NSMutableDictionary *params = @{}.mutableCopy;
    [params yep_setValue:userId forKey:@"user_id"];
    NSString *path = [NSString stringWithFormat:@"api/userapi/reportUser?timestamp=%@&token=%@",TimeStamp,token];
    [self POST:path parameters:params success:success notice:notice failure:failure];
}

- (void)postUserLoginWithEmail:(NSString *)email
                      password:(NSString *)password
                       success:(SuccessBlock)success
                        notice:(OptionBlock)notice
                       failure:(FailureBlock)failure {
    NSMutableDictionary *params = @{}.mutableCopy;
    [params yep_setValue:email forKey:@"email"];
    [params yep_setValue:password forKey:@"password"];
    NSString *path = [NSString stringWithFormat:@"api/userapi/login?timestamp=%@",TimeStamp];
    [self POST:path parameters:params success:success notice:notice failure:failure];
}

- (void)getUserLogoutWithToken:(NSString *)token
                       success:(SuccessBlock)success
                        notice:(OptionBlock)notice
                       failure:(FailureBlock)failure {
    NSMutableDictionary *params = @{}.mutableCopy;
    NSString *path = [NSString stringWithFormat:@"api/userapi/logout?timestamp=%@&token=%@",TimeStamp,token];
    [self GET:path parameters:params success:success notice:notice failure:failure];
}

- (void)getDeleteUserWithToken:(NSString *)token
                       success:(SuccessBlock)success
                        notice:(OptionBlock)notice
                       failure:(FailureBlock)failure {
    NSMutableDictionary *params = @{}.mutableCopy;
    NSString *path = [NSString stringWithFormat:@"api/userapi/deleteUser?timestamp=%@&token=%@",TimeStamp,token];
    [self GET:path parameters:params success:success notice:notice failure:failure];
}

- (void)postLikeUserWithUserId:(NSString *)userId
                         token:(NSString *)token
                       success:(SuccessBlock)success
                        notice:(OptionBlock)notice
                       failure:(FailureBlock)failure {
    NSMutableDictionary *params = @{}.mutableCopy;
    [params yep_setValue:userId forKey:@"user_id"];
    NSString *path = [NSString stringWithFormat:@"api/userapi/likeUser?timestamp=%@&token=%@",TimeStamp,token];
    [self POST:path parameters:params success:success notice:notice failure:failure];
}

- (void)postUnLikeUserWithUserId:(NSString *)userId
                           token:(NSString *)token
                         success:(SuccessBlock)success
                          notice:(OptionBlock)notice
                         failure:(FailureBlock)failure {
    NSMutableDictionary *params = @{}.mutableCopy;
    [params yep_setValue:userId forKey:@"user_id"];
    NSString *path = [NSString stringWithFormat:@"api/userapi/unlikeUser?timestamp=%@&token=%@",TimeStamp,token];
    [self POST:path parameters:params success:success notice:notice failure:failure];
}

- (void)postInterestListWithStartIndex:(NSInteger)startIndex
                                  type:(YEPInterestListType)type
                                 token:(NSString *)token
                               success:(SuccessBlock)success
                                notice:(OptionBlock)notice
                               failure:(FailureBlock)failure {
    NSMutableDictionary *params = @{}.mutableCopy;
    [params yep_setValue:@(startIndex) forKey:@"startidx"];
    NSString *typeName = [EnumDef InterestListValueForType:type];
    NSString *path = [NSString stringWithFormat:@"api/userapi/%@?timestamp=%@&token=%@",typeName,TimeStamp,token];
    [self POST:path parameters:params success:success notice:notice failure:failure];
}

- (void)postUpdateProfileWithParams:(NSDictionary *)params
                              video:(NSURL *)videoURL
                          sculpture:(UIImage *)sculpture
                              token:(NSString *)token
                            success:(SuccessBlock)success
                           progress:(ProgressBlock)progress
                             notice:(OptionBlock)notice
                            failure:(FailureBlock)failure {

    // multiparts.
    NSMutableArray *multiparts = @[].mutableCopy;
    // sculpture
    if (sculpture) {
        UIImage *compressedImage = [sculpture yep_resizeImageWithMaxSize:CGSizeMake(1080, 1920)];
        NSData *imagedata = UIImagePNGRepresentation(compressedImage);
        NSString *mimeType1 = [NSString yep_mimeTypeForImageData:imagedata];
        NSDictionary *dict1 = @{@"data": imagedata,@"mimetype": mimeType1,@"name": @"sculpture",@"fileName": @"sculpture.png"};
        [multiparts addObject:dict1];
        NSData *resizedImageData = UIImageJPEGRepresentation([sculpture yep_resizeImageWithMaxSize:CGSizeMake(300, 400)], 1.0);
        NSString *mimeType2 = [NSString yep_mimeTypeForImageData:resizedImageData];
        NSDictionary *dict2 = @{@"data": resizedImageData,@"mimetype": mimeType2,@"name": @"sculpture_s",@"fileName": @"sculpture_s.jpg"};
        [multiparts addObject:dict2];
    }
    
    if (videoURL) {
        NSDictionary *dict = @{@"data": [NSData dataWithContentsOfURL:videoURL],@"mimetype": @"video/quicktime",@"name": @"video_url",@"fileName": @"video.mov"};
        [multiparts addObject:dict];
    }
    
    NSString *path = [NSString stringWithFormat:@"api/userapi/updateProfile?timestamp=%@&token=%@",TimeStamp,token];
    [self POST:path parameters:params multiparts:multiparts success:success notice:notice progress:progress failure:failure];
}

- (void)getUserStatusWithToken:(NSString *)token
                       success:(SuccessBlock)success
                        notice:(OptionBlock)notice
                       failure:(FailureBlock)failure {
    NSMutableDictionary *params = @{}.mutableCopy;
    NSString *path = [NSString stringWithFormat:@"api/userapi/userStats?timestamp=%@&token=%@",TimeStamp,token];
    [self GET:path parameters:params success:success notice:notice failure:failure];
}

- (void)postClickSocialAccountWithUserId:(NSString *)userId
                                      type:(YEPSocialAppType)type
                                   token:(NSString *)token
                                   success:(SuccessBlock)success
                                    notice:(OptionBlock)notice
                                   failure:(FailureBlock)failure {
    
    NSMutableDictionary *params = @{}.mutableCopy;
    [params yep_setValue:userId forKey:@"user_id"];
    [params yep_setValue:[EnumDef socialAcountValueForType:type] forKey:@"social_account_type"];

    NSString *path = [NSString stringWithFormat:@"api/userapi/clickSocialAccount?timestamp=%@&token=%@",TimeStamp,token];
    [self POST:path parameters:params success:success notice:notice failure:failure];
}

- (void)postUserLocationLogWithCoordinate:(CLLocationCoordinate2D)coordinate
                                    token:(NSString *)token
                                  success:(SuccessBlock)success
                                   notice:(OptionBlock)notice
                                  failure:(FailureBlock)failure {
    
    NSMutableDictionary *params = @{}.mutableCopy;
    
    [params yep_setValue:@(coordinate.latitude).stringValue forKey:@"lat"];
    [params yep_setValue:@(coordinate.longitude).stringValue forKey:@"lng"];
    
    NSString *path = [NSString stringWithFormat:@"api/userapi/userLocationLog?timestamp=%@&token=%@",TimeStamp,token];
    [self POST:path parameters:params success:success notice:notice failure:failure];
}

- (void)postUserLocationSetWithHideMyLocation:(BOOL)hideMyLocation
                                        token:(NSString *)token
                                  success:(SuccessBlock)success
                                   notice:(OptionBlock)notice
                                  failure:(FailureBlock)failure {
    
    NSMutableDictionary *params = @{}.mutableCopy;
    [params yep_setValue:@(hideMyLocation) forKey:@"hidemylocation"];

    NSString *path = [NSString stringWithFormat:@"api/userapi/userLocationSet?timestamp=%@&token=%@",TimeStamp,token];
    [self POST:path parameters:params success:success notice:notice failure:failure];
}

- (void)postUserLocationNearbyWithCoordinate:(CLLocationCoordinate2D)coordinate
                                      success:(SuccessBlock)success
                                       notice:(OptionBlock)notice
                                      failure:(FailureBlock)failure {
    
    NSMutableDictionary *params = @{}.mutableCopy;
    [params yep_setValue:@(coordinate.latitude).stringValue forKey:@"lat"];
    [params yep_setValue:@(coordinate.longitude).stringValue forKey:@"lng"];
    
    NSString *path = [NSString stringWithFormat:@"api/userapi/userNearBy?timestamp=%@",TimeStamp];
    [self POST:path parameters:params success:success notice:notice failure:failure];
}

@end
