//
//  TRAccount.h
//  微博
//
//  Created by Tory on 15/9/24.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *
 "access_token" = "2.00uXHN7CXWgR5D4bcea55962Gw8IQC";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 2219577674;
 */
@interface TRAccount : NSObject<NSCoding>

/**
 *  获取数据的访问命令牌
 */
@property (copy, nonatomic) NSString *access_token;

/**
 *  账号的有效期
 */
@property (copy, nonatomic) NSString *expires_in;

/**
 *  用户的唯一标符
 */
@property (copy, nonatomic) NSString *uid;

/**
 *  过期的时间 = 当前保存时间+有效期
 */
@property (strong, nonatomic) NSDate *expires_date;

/**
 *  账号的有效期
 */
@property (copy, nonatomic) NSString *remind_in;

/**
 *  用户的昵称
 */
@property (copy, nonatomic) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
