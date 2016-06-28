//
//  TRHttpTool.h
//  微博
//
//  Created by Tory on 15/10/10.
//  Copyright © 2015年 normcore. All rights reserved.
//  处理网络的请求

#import <Foundation/Foundation.h>
@class TRUploadParam;
@interface TRHttpTool : NSObject

/**
*  发送get请求
*
*  @param URLString  请求的基本url
*  @param parameters 请求的参数字典
*  @param success    请求成功的回调
*  @param failure    请求失败的回调
*/
+ (void)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

/**
 *  发送post请求
 *
 *  @param URLString  请求的基本url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)POST:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

/**
 *  上传post请求
 *
 *  @param URLString  请求的基本url
 *  @param parameters 请求的参数字典
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+ (void)Upload:(NSString *)URLString
    parameters:(id)parameters uploadParam:(TRUploadParam *)uploadParam
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;


@end
