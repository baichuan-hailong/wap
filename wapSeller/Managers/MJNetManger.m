//
//  MJNetManger.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/25.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJNetManger.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetExportSession.h>
#import <AVFoundation/AVMediaFormat.h>

@implementation MJNetManger

/**
 *  获得全局唯一的网络请求实例单例方法
 *
 *  @return 网络请求类的实例
 */

+(instancetype)shareManager{
    static MJNetManger  *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:API]];
    });
    return manager;
}


#pragma mark - 重写initWithBaseURL
/**
 *
 *
 *  @param url baseUrl
 *
 *  @return 通过重写夫类的initWithBaseURL方法,返回网络请求类的实例
 */

- (instancetype)initWithBaseURL:(NSURL *)url{
    if (self = [super initWithBaseURL:url]) {
        
        //self.requestSerializer                 = [AFJSONRequestSerializer  serializer];
        //self.responseSerializer                = [AFJSONResponseSerializer serializer];
        self.requestSerializer                 = [AFHTTPRequestSerializer  serializer];
        //self.responseSerializer                = [AFHTTPResponseSerializer serializer];
        self.responseSerializer                = [AFJSONResponseSerializer serializer];
        
        
        
        //服务器端配置的包含公钥的证书分发到客户端后,需要转换为DER格式的证书文件.
        //openssl x509 -outform der -in tv.diveinedu.com.crt -out tv.diveinedu.com.der
        //NSString *certFilePath = [[NSBundle mainBundle] pathForResource:@"mjyg_server" ofType:@"cer"];
        //NSLog(@"%@",certFilePath);
        //NSData   *certData = [NSData dataWithContentsOfFile:certFilePath];
        //NSSet    *certSet = [NSSet setWithObject:certData];
        //NSLog(@"%@",certData);
        //AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey withPinnedCertificates:certSet];
        //self.securityPolicy = policy;
        //允许非权威机构颁发的证书
        //self.securityPolicy.allowInvalidCertificates = YES;
        //也不验证域名一致性
        //self.securityPolicy.validatesDomainName = NO;
        //关闭缓存避免干扰测试
        //self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        
        
        
        /**设置请求超时时间*/
        self.requestSerializer.timeoutInterval = 3;
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
        //form-data
        [self.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"enctype"];
        //[self.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
        //[self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return self;
}

 - (void)addHttpHeaderInfo{
     //User-Agent
     //[self.requestSerializer setValue:[NSString stringWithFormat:@"sesame/%@ (iPhone %@;%@)",@"version",@"device_name",@"device_info"] forHTTPHeaderField:@"User-Agent"];
    //[self.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",@"token"] forHTTPHeaderField:@"Authorization"];
 }


#pragma mark - 网络请求的类方法---get/post
/**
 *  网络请求的实例方法
 *
 *  @param type         get / post
 *  @param urlString    请求的地址
 *  @param paraments    请求的参数
 *  @param successBlock 请求成功的回调
 *  @param failureBlock 请求失败的回调
 *  @param progress 进度
 */

-(void)requestWithType:(HttpRequestType)type withUrlString:(NSString *)urlString withParaments:(id)paraments withSuccessBlock:(requestSuccess)successBlock withFailureBlock:(requestFailure)failureBlock progress:(downloadProgress)progress{
    
    //update
    [[MJNetManger shareManager] addHttpHeaderInfo];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    switch (type) {
            case HttpRequestTypeGet:{
                [[MJNetManger shareManager] GET:urlString parameters:paraments progress:^(NSProgress * _Nonnull downloadProgress) {
                    progress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    successBlock(responseObject);
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [Token_Manager chekToken:responseObject];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    failureBlock(error);
                    [ProgressHUD_Manager showTo:[UIApplication sharedApplication].keyWindow tipText:@"网络错误"];
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                }];
                break;
            }
            case HttpRequestTypePost:{
                [[MJNetManger shareManager] POST:urlString parameters:paraments progress:^(NSProgress * _Nonnull uploadProgress) {
                    progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    successBlock(responseObject);
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    failureBlock(error);
                    [ProgressHUD_Manager showTo:[UIApplication sharedApplication].keyWindow tipText:@"网络错误"];
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                }];
            }
    }
}




#pragma mark - 多图上传
/**
 *  上传图片
 *
 *  @param operations   上传图片等预留参数---视具体情况而定 可移除
 *  @param imageArray   上传的图片数组
 *  @parm  width        图片要被压缩到的宽度
 *  @param urlString    上传的url---请填写完整的url
 *  @param successBlock 上传成功的回调
 *  @param failureBlock 上传失败的回调
 *  @param progress     上传进度
 *
 */
-(void)uploadImageWithOperations:(NSDictionary *)operations withImageArray:(NSArray *)imageArray withtargetWidth:(CGFloat )width withUrlString:(NSString *)urlString withSuccessBlock:(requestSuccess)successBlock withFailurBlock:(requestFailure)failureBlock withUpLoadProgress:(uploadProgress)progress{
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:urlString parameters:operations constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSUInteger i = 0 ;
        /**出于性能考虑,将上传图片进行压缩*/
        for (UIImage * image in imageArray) {
            //image的分类方法
            UIImage *  resizedImage =  [UIImage IMGCompressed:image targetWidth:width];
            NSData * imgData = UIImageJPEGRepresentation(resizedImage, .5);
            //拼接data
            [formData appendPartWithFileData:imgData name:[NSString stringWithFormat:@"picflie%ld",(long)i] fileName:@"image.png" mimeType:@" image/jpeg"];
            i++;
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}





@end
