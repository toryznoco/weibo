//
//  TRTabBar.h
//  微博
//
//  Created by Tory on 15/9/11.
//  Copyright (c) 2015年 normcore. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TRTabBar;

@protocol TRTabBarDelegate <NSObject>

@optional

- (void)tabBar:(TRTabBar *)tabBar didClickButton:(NSInteger)index;

/**
 *  点击加号按钮的时候调用
 */
- (void)tabBarDidClickPlusButton:(TRTabBar *)tabBar;

@end

@interface TRTabBar : UIView

// items:保存每一个按钮对应tabBarItem模型
@property (strong, nonatomic) NSArray *items;

@property (weak, nonatomic) id<TRTabBarDelegate> delegate;

@end
