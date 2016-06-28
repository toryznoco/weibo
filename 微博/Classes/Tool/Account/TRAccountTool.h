//
//  TRAccountTool.h
//  微博
//
//  Created by Tory on 15/9/24.
//  Copyright © 2015年 normcore. All rights reserved.
//  专门处理账号的业务（账号的存储和读取）

#import <Foundation/Foundation.h>

@class TRAccount;
@interface TRAccountTool : NSObject

+ (void)saveAccount:(TRAccount *)account;

+ (TRAccount *)account;

+ (void)accountWithCode:(NSString *)code success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
