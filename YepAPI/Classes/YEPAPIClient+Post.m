//
//  YEPAPIClient+Post.m
//  Yep
//
//  Created by benson on 9/11/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

#import "YEPAPIClient+Post.h"
#import "NSMutableDictionary+Kit.h"
#import "UIImage+Addition.h"
#import "NSString+Util.h"
#import "YEPAPIClientConfig.h"

@implementation YEPAPIClient (Post)

- (void)postNewPostWithContent:(NSString *)content
                          pics:(NSArray *)pics
                         token:(NSString *)token
                       success:(SuccessBlock)success
                      progress:(ProgressBlock)progress
                        notice:(OptionBlock)notice
                       failure:(FailureBlock)failure {
    NSMutableDictionary *params = @{}.mutableCopy;
    [params yep_setValue:content forKey:@"content"];
    
    // multiparts.
    NSMutableArray *multiparts = @[].mutableCopy;
    for(NSInteger i = 0; i < pics.count; i++) {
        UIImage *pic = pics[i];
        UIImage *compressedImage = [pic yep_resizeImageWithMaxSize:CGSizeMake(1080, 1920)];
        NSData *imagedata = UIImagePNGRepresentation(compressedImage);
        NSString *mimeType = [NSString yep_mimeTypeForImageData:imagedata];
        NSString *fileName = [NSString stringWithFormat:@"postImage_%ld.png",(long)i];
        NSDictionary *dict = @{@"data": imagedata,@"mimetype": mimeType,@"name": @"pics[]",@"fileName": fileName};
        [multiparts addObject:dict];
    }
    NSString *path = [NSString stringWithFormat:@"api/postapi/newPost?timestamp=%@&token=%@",TimeStamp,token];
    [self POST:path parameters:params multiparts:multiparts success:success notice:notice progress:progress failure:failure];
}

- (void)postPostListWithStartIndex:(NSInteger)startIndex
                           success:(SuccessBlock)success
                            notice:(OptionBlock)notice
                           failure:(FailureBlock)failure {
    NSMutableDictionary *params = @{}.mutableCopy;
    [params yep_setValue:@(startIndex) forKey:@"startidx"];
    NSString *path = [NSString stringWithFormat:@"api/postapi/postList?timestamp=%@",TimeStamp];
    [self POST:path parameters:params success:success notice:notice failure:failure];
}

- (void)postReportPostWithPostId:(NSString *)postId
                           token:(NSString *)token
                         success:(SuccessBlock)success
                          notice:(OptionBlock)notice
                         failure:(FailureBlock)failure {
    NSMutableDictionary *params = @{}.mutableCopy;
    [params yep_setValue:postId forKey:@"post_id"];
    NSString *path = [NSString stringWithFormat:@"api/postapi/reportPost?timestamp=%@&token=%@",TimeStamp,token];
    [self POST:path parameters:params success:success notice:notice failure:failure];
}

@end
