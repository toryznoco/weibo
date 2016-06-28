//
//  TRUserTool.m
//  微博
//
//  Created by Tory on 15/10/15.
//  Copyright © 2015年 normcore. All rights reserved.
//  处理用户业务

#import "TRUserTool.h"
#import "TRHttpTool.h"

#import "TRAccountTool.h"
#import "TRAccount.h"

#import "TRUserParam.h"
#import "TRUserRusult.h"
#import "MJExtension.h"
#import "TRUser.h"

@implementation TRUserTool

+ (void)unreadWithSuccess:(void(^)(TRUserRusult *result))success failure:(void(^)(NSError *error))failure
{
    //  创建参数模型
    TRUserParam *params = [TRUserParam param];
    params.uid = [TRAccountTool account].uid;
    
    [TRHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params.keyValues success:^(id responseObject) {
        //  字典转模型
        TRUserRusult *result = [TRUserRusult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userInfoWithSuccess:(void (^)(TRUser *))success failure:(void (^)(NSError *))failure
{
    TRUserParam *params = [TRUserParam param];
    params.uid = [TRAccountTool account].uid;
    
    [TRHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:params.keyValues success:^(id responseObject) {
        //  用户字典转用户模型
        TRUser *user = [TRUser objectWithKeyValues:responseObject];
        if (success) {
            success(user);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
