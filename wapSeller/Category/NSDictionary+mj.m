//
//  NSDictionary+mj.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/30.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "NSDictionary+mj.h"

@implementation NSDictionary (mj)


- (NSDictionary *)prefectWithDic{
    NSString * identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSString *sourceType = @"1";
    NSString *openId = identifierForVendor;
    NSString *charset = @"UTF-8";
    NSString *dataType = @"json";
    NSDictionary *pradic = @{@"sourceType":sourceType,
                             @"openId":openId,
                             @"charset":charset,
                             @"dataType":dataType,
                             @"data":[DicJsonManager convertToJSONData:self]};
    return pradic;
}

//[[NSUserDefaults standardUserDefaults] setObject:object[@"data"][@"securityKey"] forKey:SecurityKey]
- (NSDictionary *)signWithSecurityKey{
    NSString * identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSString *sourceType           = @"1";
    NSString *openId               = identifierForVendor;
    NSString *charset              = @"UTF-8";
    NSString *dataType             = @"json";
    NSString *security_Key =  [[NSUserDefaults standardUserDefaults] stringForKey:SecurityKey];
    
    //NSLog(@"security_Key --- %@",security_Key);
    
    //String queryString = “sourceType=” + sourceType + “openId=” + openId+ “&charset=” + charset + “&dataType=” + dataType + “&data=” + data+ securityKey;
    NSString *queryString = [NSString stringWithFormat:@"sourceType=%@&openId=%@&charset=%@&dataType=%@&data=%@%@",sourceType,openId,charset,dataType,[DicJsonManager convertToJSONData:self],security_Key];
    NSString *dataSign = [MJEncryption md5EncryptWithString:queryString];
    //NSLog(@"dataSign --- %@",dataSign);
    NSDictionary *pradic = @{@"sourceType":sourceType,
                             @"openId":openId,
                             @"charset":charset,
                             @"dataType":dataType,
                             @"dataSign":dataSign,
                             @"data":[DicJsonManager convertToJSONData:self]};
    return pradic;
}







@end
