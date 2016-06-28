//
//  TRBaseParam.m
//  微博
//
//  Created by Tory on 15/10/15.
//  Copyright © 2015年 normcore. All rights reserved.
//  基本的参数模型

#import "TRBaseParam.h"
#import "TRAccountTool.h"
#import "TRAccount.h"

@implementation TRBaseParam

+ (instancetype)param
{
    TRBaseParam *param = [[self alloc] init];
    
    param.access_token = [TRAccountTool account].access_token;
    
    return param;
}

@end
