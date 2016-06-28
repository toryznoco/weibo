//
//  TRAccountTool.m
//  微博
//
//  Created by Tory on 15/9/24.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import "TRAccountTool.h"
#import "TRAccount.h"
#import "AFNetworking.h"

#import "TRHttpTool.h"
#import "TRAccountParam.h"

#import "MJExtension.h"

#define TRAuthorizeBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define TRClient_id     @"3107245601"
#define TRRedirect_uri  @"http://www.baidu.com"
#define TRClient_secret @"e70ea1c176257fdeff7a054ab02c3a64"

#define TRAccountFileName  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation TRAccountTool

//  类方法一般用静态变量代替成员属性
static TRAccount *_account;
+ (void)saveAccount:(TRAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:TRAccountFileName];
}

+ (TRAccount *)account
{
    if (_account == nil) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:TRAccountFileName];
        //  判断下账号是否过期，如果过期直接返回nil
        //  2015 < 2017
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) { //  过期
            return nil;
        }
    }
    return _account;
}

+ (void)accountWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure
{
    //  创建参数模型
    TRAccountParam *params = [[TRAccountParam alloc] init];
    params.client_id = TRClient_id;
    params.client_secret = TRClient_secret;
    params.grant_type = @"authorization_code";
    params.code = code;
    params.redirect_uri = TRRedirect_uri;
    
    //  发送POST请求
    [TRHttpTool POST:@"https://api.weibo.com/oauth2/access_token" parameters:params.keyValues success:^(id responseObject) {
        //  字典转模型
        TRAccount *account = [TRAccount accountWithDict:responseObject];
        
        //  保存账号信息：数据存储一般我们开发中会搞一个业务类，专门处理数据的存储
        //  以后我不想用归档，用数据库，直接改业务类
        [TRAccountTool saveAccount:account];
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
