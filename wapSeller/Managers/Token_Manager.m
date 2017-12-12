//
//  Token_Manager.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/12/4.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "Token_Manager.h"

@implementation Token_Manager
+ (void)chekToken:(id  _Nullable)responseObject{
    //NSLog(@"%@",responseObject);
    NSString *status = [NSString stringWithFormat:@"%@",responseObject[@"status"]];
    if ([status isEqualToString:@"-1"]) {
        //失效
        [[NSNotificationCenter defaultCenter] postNotificationName:@"failedoutlogin" object:nil];
        
        //清空
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:IS_LOGIN];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:SecurityKey];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:UserID];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:LoginTel];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:PromoterId];

        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:IS_Seller];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:Seller_AuditResult];
        
        //#define IS_LOGIN             @"is_login_mjyg"    //是否登录
        //#define SecurityKey          @"securityKey_mj"   //SecurityKey
        //#define UserID               @"useridoid"        //用户id
        //#define LoginTel             @"logintel"         //账户
        //#define PromoterId           @"promoterId"       //邀请码
        
        //#define IS_Seller             @"isSeller"          //up提交与否
        //#define Seller_AuditResult    @"sellerAuditResult" //up审核结果
        //#define IS_HaveUPCommit       @"ishaveupcommit"    //up是否有提交
        
    }
}
@end
