//
//  MJEncryption.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/27.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJEncryption.h"
#import <CommonCrypto/CommonDigest.h>


//秘钥
static NSString *encryptionKey = @"hl";


@implementation MJEncryption

+ (NSString *)md5EncryptWithString:(NSString *)string{
    //return [self md5:[NSString stringWithFormat:@"%@%@", encryptionKey, string]];
    return [self md5:[NSString stringWithFormat:@"%@", string]];
}

+ (NSString *)md5:(NSString *)string{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    NSString *lowresult = [result lowercaseString];
    return lowresult;
}





@end
