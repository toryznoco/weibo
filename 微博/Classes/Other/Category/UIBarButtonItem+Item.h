//
//  UIBarButtonItem+Item.h
//  微博
//
//  Created by Tory on 15/9/14.
//  Copyright (c) 2015年 normcore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
