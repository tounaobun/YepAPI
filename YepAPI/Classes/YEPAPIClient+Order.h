//
//  YEPAPIClient+Order.h
//  Yep
//
//  Created by benson on 9/20/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

#import "YEPAPIClient.h"

@interface YEPAPIClient (Order)

- (void)postOrderValidation:(NSString *)receipt
                      token:(NSString *)token
                    success:(SuccessBlock)success
                     notice:(OptionBlock)notice
                    failure:(FailureBlock)failure;
    
@end
