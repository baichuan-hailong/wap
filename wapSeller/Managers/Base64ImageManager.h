//
//  Base64ImageManager.h
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/29.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64ImageManager : NSObject

//image - base64
+ (NSString *) image2DataURL: (UIImage *) image;


//base64 - image
+ (UIImage *) dataURL2Image: (NSString *) imgSrc;
@end
