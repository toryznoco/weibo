//
//  TRUser.h
//  微博
//
//  Created by Tory on 15/9/30.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRUser : NSObject
/**
 *  微博昵称
 */
@property (copy, nonatomic) NSString *name;
/**
 *  微博头像
 */
@property (strong, nonatomic) NSURL *profile_image_url;

/*会员类型 > 2代表是会员*/
@property (nonatomic, assign) int mbtype;

/*会员等级*/
@property (nonatomic, assign) int mbrank;

@property (nonatomic, assign, getter=isVip) BOOL vip;

@end
