//
//  NSString+Util.m
//  Yep
//
//  Created by benson on 10/9/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

#import "NSString+Util.h"

@implementation NSString (Util)

+ (NSString *)yep_mimeTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
    }
    return nil;
}

@end
