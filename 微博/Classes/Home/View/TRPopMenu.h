//
//  TRPopMenu.h
//  微博
//
//  Created by Tory on 15/9/14.
//  Copyright (c) 2015年 normcore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRPopMenu : UIImageView

// 内容视图
@property (nonatomic, weak) UIView *contentView;

/**
 *  显示弹出菜单
 */
+ (instancetype)showInRect:(CGRect)rect;

/**
 *  隐藏弹出菜单
 */
+ (void)hide;

@end
