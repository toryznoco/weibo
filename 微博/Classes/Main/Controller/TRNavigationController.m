//
//  TRNavigationController.m
//  微博
//
//  Created by Tory on 15/9/14.
//  Copyright (c) 2015年 normcore. All rights reserved.
//

#import "TRNavigationController.h"
#import "UIBarButtonItem+Item.h"

@interface TRNavigationController ()<UINavigationControllerDelegate>

@property (strong, nonatomic) id popDelegate;

@end

@implementation TRNavigationController

+ (void)initialize
{
    // 获取当前类的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    // 设置导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    
    //  注意导航条上按钮不可能，用模型的文字属性设置是不好使
//    //  设置不可用
//    titleAttr = [NSMutableDictionary dictionary];
//    titleAttr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    [item setTitleTextAttributes:titleAttr forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    
    
    
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//  导航控制器即将显示新的控制器的时候调用
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //  获取主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    //  获取tabBarVc rootViewController
    UITabBarController *tabBarVC = (UITabBarController *)keyWindow.rootViewController;
    
    //  移除系统的tabBarButton
    for (UIView *tabBarButton in tabBarVC.tabBar.subviews)
    {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
            [tabBarButton removeFromSuperview];
        }
    }
}

//  导航控制器跳转完成的时候调用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0])
    {
        //  显示根控制器
        //  还原滑动返回手势的代理
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }
    else
    {
        //  不是显示根控制器
        //  实现滑动返回功能
        //  清空滑动返回手势的代理,就能实现滑动功能
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //  设置非根控制器的导航条的内容
    if (self.viewControllers.count != 0)
    {
        //  非根控制器
        //  设置导航条的内容
        //  设置导航条左边和右边
        //  如果把导航条上的返回按钮覆盖，滑动返回功能就没有
        //  左边
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(backToPre) forControlEvents:UIControlEventTouchUpInside];
        
        //  右边
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(backToRoot) forControlEvents:UIControlEventTouchUpInside];
        
    }
    [super pushViewController:viewController animated:animated ];
}

- (void)backToPre
{
    [self popViewControllerAnimated:YES];
}

- (void)backToRoot
{
    [self popToRootViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
