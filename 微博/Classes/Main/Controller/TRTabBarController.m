//
//  TRTabBarController.m
//  微博
//
//  Created by Tory on 15/9/7.
//  Copyright (c) 2015年 normcore. All rights reserved.
//

#import "TRTabBarController.h"
#import "TRTabBar.h"

#import "TRHomeViewController.h"
#import "TRMessageViewController.h"
#import "TRDiscoverViewController.h"
#import "TRProfileViewController.h"

#import "TRNavigationController.h"

#import "TRUserTool.h"
#import "TRUserRusult.h"

#import "TRComposeViewConreoller.h"

@interface TRTabBarController ()<TRTabBarDelegate>

@property (strong, nonatomic) NSMutableArray *items;

@property (weak, nonatomic) TRHomeViewController *home;

@property (weak, nonatomic) TRMessageViewController *message;

@property (weak, nonatomic) TRProfileViewController *profile;
@end

@implementation TRTabBarController

- (NSMutableArray *)items
{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //  添加所有子控制器
    [self setUpAllChildViewController];
    
    //  自定义tabBar
    [self setUpTabBar];
    
    //  每隔一段时间请求未读数
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(requestUnread) userInfo:nil repeats:YES];
}

//  请求未读数
- (void)requestUnread
{
    //  请求微博的未读数
    [TRUserTool unreadWithSuccess:^(TRUserRusult *result) {
        //  设置首页未读数
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        
        //  设置消息的未读数
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        
        //  设置我的未读数
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        
        //  设置应用程序所有未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 设置tabBar
- (void)setUpTabBar
{
    //  自定义tabBar
    TRTabBar *tabBar = [[TRTabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];
    
    //  设置代理
    tabBar.delegate = self;
    
    //  给tabBar传递tabBarItem模型
    tabBar.items = self.items;
    
    //  添加自定义tabBar
    [self.tabBar addSubview:tabBar];
    
    //  移除系统的tabBar
//    [self.tabBar removeFromSuperview];
}

#pragma mark - 当点击tabBar上的按钮调用
- (void)tabBar:(TRTabBar *)tabBar didClickButton:(NSInteger)index
{
    if (index == 0 && self.selectedIndex == index) {    //  点击首页，刷新
        [_home refresh];
    }
    self.selectedIndex = index;
}

//  点击加号按钮的时候调用
- (void)tabBarDidClickPlusButton:(TRTabBar *)tabBar
{
    //  创建发送微博控制器
    TRComposeViewConreoller *composeVc = [[TRComposeViewConreoller alloc] init];
    TRNavigationController *nav = [[TRNavigationController alloc] initWithRootViewController:composeVc];
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //  移除系统的tabBarButton
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
    }
}

#pragma mark - 添加所有子控制器
/**
 *  添加所有子控制器
 */
- (void)setUpAllChildViewController
{
    //  首页
    TRHomeViewController *home = [[TRHomeViewController alloc] init];
    [self setUpOneChildViewController:home withImage:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageNamed:@"tabbar_home_selected"] title:@"首页"];
    _home = home;
    
    //  消息
    TRMessageViewController *message = [[TRMessageViewController alloc] init];
    [self setUpOneChildViewController:message withImage:[UIImage imageNamed:@"tabbar_message_center"] selectedImage:[UIImage imageNamed:@"tabbar_message_center_selected"] title:@"消息"];
    _message = message;
    
    //  发现
    TRDiscoverViewController *discover = [[TRDiscoverViewController alloc] init];
    [self setUpOneChildViewController:discover withImage:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageNamed:@"tabbar_discover_selected"] title:@"发现"];
    
    //  我
    TRProfileViewController *profile = [[TRProfileViewController alloc] init];
    [self setUpOneChildViewController:profile withImage:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageNamed:@"tabbar_profile_selected"] title:@"我"];
    _profile = profile;
}

// navigationItem决定导航条上的内容
// 导航条上的内容由栈顶控制器的navigationItem决定

#pragma mark - 添加一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)vc withImage:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    //    // navigationItem模型
    //    vc.navigationItem.title = title;
    //
    //    // 设置子控件对应tabBarItem的模型属性
//    vc.tabBarItem.title = title;
    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //  保存tabBarItem模型到数组
    [self.items addObject:vc.tabBarItem];
    
    //  initWithRootViewController底层就会调用导航控制器的push，把根控制器压入栈
    TRNavigationController *nav = [[TRNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end
