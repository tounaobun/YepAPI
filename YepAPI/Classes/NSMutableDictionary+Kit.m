//
//  NSMutableDictionary+Kit.m
//  Yep
//
//  Created by benson on 9/8/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

#import "NSMutableDictionary+Kit.h"

@implementation NSMutableDictionary (Kit)

- (void)yep_setValue:(id)value forKey:(NSString *)key
{
    id tempValue = value;
    if (!tempValue
        || [tempValue isKindOfClass:[NSNull class]]
        || !key
        || ![key isKindOfClass:[NSString class]]
        ) {
        return;
    }
    self[key] = tempValue;
}

@end
