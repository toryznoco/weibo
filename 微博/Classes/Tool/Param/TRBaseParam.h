//
//  TRBaseParam.h
//  微博
//
//  Created by Tory on 15/10/15.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRBaseParam : NSObject

/**
 *  采用OAuth授权方式为必填参数,访问命令牌
 */
@property (copy, nonatomic) NSString *access_token;

+ (instancetype)param;

@end
