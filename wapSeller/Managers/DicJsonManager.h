//
//  DicJsonManager.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/29.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DicJsonManager : NSObject
+ (NSString*)convertToJSONData:(id)infoDict;
@end