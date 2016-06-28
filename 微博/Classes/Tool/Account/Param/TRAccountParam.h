//
//  TRAccountParam.h
//  微博
//
//  Created by Tory on 15/10/15.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRAccountParam : NSObject
/**
 *  AppKey
 */
@property (copy, nonatomic) NSString *client_id;
/**
 *  AppSecret
 */
@property (copy, nonatomic) NSString *client_secret;
/**
 *  填写authorization_code
 */
@property (copy, nonatomic) NSString *grant_type;
/**
 *  调用authorize获得的code值。
 */
@property (copy, nonatomic) NSString *code;
/**
 *  回调地址
 */
@property (copy, nonatomic) NSString *redirect_uri;
@end
