//
//  TRRootTool.m
//  微博
//
//  Created by Tory on 15/9/24.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import "TRRootTool.h"
#import "TRTabBarController.h"
#import "TRNewFeatureController.h"
#define TRVersionKey @"version"

@implementation TRRootTool

//  选择根控制器
+ (void)chooseRootViewController:(UIWindow *)window
{
    //  获取当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    //  获取上一次的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:TRVersionKey];
    
    //  v1.0
    //  判断当前是否有新的版本
    if ([currentVersion isEqualToString:lastVersion]) {
        //  没有最新的版本号
        //  创建tabBarVc
        TRTabBarController *tabBarVc = [[TRTabBarController alloc] init];
        
        //  设置窗口的根控制器
        window.rootViewController = tabBarVc;
    }
    else
    {
        //  有最新版本号
        //  进入新特性界面
        TRNewFeatureController *vc = [[TRNewFeatureController alloc] init];
        
        window.rootViewController = vc;
        
        //  保存当前的版本，用偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:TRVersionKey];
    }
}

@end
