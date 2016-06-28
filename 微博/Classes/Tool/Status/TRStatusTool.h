//
//  TRStatusTool.h
//  微博
//
//  Created by Tory on 15/10/15.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRStatusTool : NSObject

/**
 *  请求更新的微博数据
 *
 *  @param sinceId  返回比这个更大的微博数据
 *  @param sucess   请求成功的时候回调(statuses(TRStatus模型))
 *  @param failure  请求失败的时候回调，错误传递给外界
 */
+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure;

/**
 *  请求更多的微博数据
 *
 *  @param maxId   放回小于等于这个id的微博数据
 *  @param success 请求成功的时候回调
 *  @param failure 请求失败的时候回调
 */
+ (void)moreStatusWithMaxId:(NSString *)maxId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure;

@end
