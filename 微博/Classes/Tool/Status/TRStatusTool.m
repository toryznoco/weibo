//
//  TRStatusTool.m
//  微博
//
//  Created by Tory on 15/10/15.
//  Copyright © 2015年 normcore. All rights reserved.
//  处理微博数据

#import "TRStatusTool.h"

#import "TRHttpTool.h"
#import "TRStatus.h"
#import "TRAccountTool.h"
#import "TRAccount.h"

#import "TRStatusParam.h"
#import "TRStatusResult.h"

#import "MJExtension.h"

@implementation TRStatusTool

+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    //  创建参数模型
    TRStatusParam *params = [[TRStatusParam alloc] init];
    params.access_token = [TRAccountTool account].access_token;
    
    if (sinceId) {
        //  有新的微博数据，才需要下拉刷新
        params.since_id = sinceId;
    }
    
    [TRHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params.keyValues success:^(id responseObject) {
        //  请求成功的回调
        TRStatusResult *result = [TRStatusResult objectWithKeyValues:responseObject];
        
//        //  获取到微博数据转换成模型
//        //  获取微博字典数组
//        NSArray *dictArr = responseObject[@"statuses"];
//        //  把字典数组转换成模型数组
//        NSArray *statuses = [TRStatus objectArrayWithKeyValuesArray:dictArr];
        
        if (success) {
            success(result.statuses);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)moreStatusWithMaxId:(NSString *)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    //  创建参数模型
    TRStatusParam *params = [[TRStatusParam alloc] init];
    params.access_token = [TRAccountTool account].access_token;
    
    if (maxId) {
        //  有新的微博数据，才需要下拉刷新
        params.max_id = maxId;
    }
    
    [TRHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params.keyValues success:^(id responseObject) {    //  HttpTool请求成功的回调
        //  请求成功代码先保存
        
        //  把结果字典转换成结果模型
        TRStatusResult *result = [TRStatusResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.statuses);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
