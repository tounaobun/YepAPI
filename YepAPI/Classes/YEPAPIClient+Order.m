//
//  YEPAPIClient+Order.m
//  Yep
//
//  Created by benson on 9/20/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

#import "YEPAPIClient+Order.h"
#import "NSMutableDictionary+Kit.h"
#import "YEPAPIClientConfig.h"

@implementation YEPAPIClient (Order)

- (void)postOrderValidation:(NSString *)receipt
                      token:(NSString *)token
                    success:(SuccessBlock)success
                     notice:(OptionBlock)notice
                    failure:(FailureBlock)failure {
        NSMutableDictionary *params = @{}.mutableCopy;
        [params yep_setValue:receipt forKey:@"receipt"];
        NSString *path = [NSString stringWithFormat:@"api/orderapi/orderValidation?timestamp=%@&token=%@",TimeStamp,token];
        [self POST:path parameters:params success:success notice:notice failure:failure];
}
    
@end
