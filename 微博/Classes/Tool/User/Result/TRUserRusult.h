//
//  TRUserRusult.h
//  微博
//
//  Created by Tory on 15/10/15.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRUserRusult : NSObject
/**
 *  新微博未读数
 */
@property (assign, nonatomic) int status;
/**
 *  新粉丝数
 */
@property (assign, nonatomic) int follower;
/**
 *  新评论数
 */
@property (assign, nonatomic) int cmt;
/**
 *  新私信数
 */
@property (assign, nonatomic) int dm;
/**
 *  新提及我的微博数
 */
@property (assign, nonatomic) int mention_status;
/**
 *  新提及我的评论数
 */
@property (assign, nonatomic) int mention_cmt;
/**
 *  消息的总和
 */
- (int)messageCount;

/**
 *  未读数的总和
 */
- (int)totalCount;

@end
