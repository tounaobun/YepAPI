//
//  YEPAPIClient+Tag.h
//  Yep
//
//  Created by benson on 9/12/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

#import "YEPAPIClient.h"

@interface YEPAPIClient (Tag)

- (void)postTagListWithSuccess:(SuccessBlock)success
                            notice:(OptionBlock)notice
                           failure:(FailureBlock)failure;
@end
