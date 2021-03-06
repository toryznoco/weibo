//
//  TRCover.h
//  微博
//
//  Created by Tory on 15/9/14.
//  Copyright (c) 2015年 normcore. All rights reserved.
//

#import <UIKit/UIKit.h>
//  代理什么时候用，一般自定义控件的时候都用代理
//  为什么？因为一个控件以后可能要扩充新的功能，为了程序的扩展性，一般用代理

@class TRCover;
@protocol TRCoverDelegate <NSObject>

@optional
//  点击蒙板的时候调用
- (void)coverDidClickCover:(TRCover *)cover;

@end

@interface TRCover : UIView

/**
 *  显示蒙板
 */
+ (instancetype)show;

// 设置浅灰色蒙板
@property (nonatomic, assign) BOOL dimBackground;

@property (nonatomic, weak) id<TRCoverDelegate> delegate;

@end
