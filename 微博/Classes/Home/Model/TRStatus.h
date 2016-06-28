//
//  TRStatus.h
//  微博
//
//  Created by Tory on 15/9/25.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"
#import "TRUser.h"

/* 
 pic_urls 配图数组
 */

@interface TRStatus : NSObject<MJKeyValue>

/**
 *  转发微博
 */
@property (strong, nonatomic) TRStatus *retweeted_status;
/**
 *  转发微博昵称
 */
@property (nonatomic, copy) NSString *retweetName;
/**
 *  用户
 */
@property (strong, nonatomic) TRUser *user;
/**
 *  微博创建时间
 */
@property (copy, nonatomic) NSString *created_at;
/**
 *  字符串型的微博ID
 */
@property (copy, nonatomic) NSString *idstr;
/**
 *  微博信息内容
 */
@property (copy, nonatomic) NSString *text;
/**
 *  微博来源
 */
@property (copy, nonatomic) NSString *source;
/**
 *  转发数
 */
@property (assign, nonatomic) int reposts_count;
/**
 *  评论数
 */
@property (assign, nonatomic) int comments_count;
/**
 *  表态数(赞)
 */
@property (assign, nonatomic) int  attitudes_count;
/**
 *  配图数组(TRPhoto)
 */
@property (strong, nonatomic) NSArray *pic_urls;
@end
