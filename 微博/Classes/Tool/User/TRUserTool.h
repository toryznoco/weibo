//
//  TRUserTool.h
//  微博
//
//  Created by Tory on 15/10/15.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TRUserRusult,TRUser;

@interface TRUserTool : NSObject

/**
 *  请求用户的未读数
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)unreadWithSuccess:(void(^)(TRUserRusult *result))success failure:(void(^)(NSError *error))failure;

/**
 *  请求用户的信息
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)userInfoWithSuccess:(void(^)(TRUser *user))success failure:(void(^)(NSError *error))failure;

@end
