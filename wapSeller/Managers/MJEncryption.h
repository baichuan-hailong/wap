//
//  MJEncryption.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/27.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJEncryption : NSObject
//md5加密方法
+ (NSString *)md5EncryptWithString:(NSString *)string;
@end
