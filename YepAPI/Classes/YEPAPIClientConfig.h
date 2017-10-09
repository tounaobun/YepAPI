//
//  YEPAPIClientConfig.h
//  Yep
//
//  Created by benson on 10/9/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

#ifndef YEPAPIClientConfig_h
#define YEPAPIClientConfig_h

#define kServerAPITimeOut 60 /* in seconds */
#define kServerBaseURL @"https://www.yepapp.tech/"

/* MD5 Salt */
#define kMD5SaltValue @"$2017@YePapp$"

#define kStatusCodeSuccess 200

#define TimeStamp [NSString stringWithFormat:@"%.f",[[NSDate date] timeIntervalSince1970]]

#endif /* YEPAPIClientConfig_h */
