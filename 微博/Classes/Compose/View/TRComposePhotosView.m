//
//  TRComposePhotosView.m
//  微博
//
//  Created by Tory on 15/11/11.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import "TRComposePhotosView.h"

@implementation TRComposePhotosView

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
}

//  每添加一个子控件的时候也会调用，特殊如果再viewDidLoad添加子控件，就不会调用layoutSubviews
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger cols = 3;
    CGFloat margin = 10;
    CGFloat wh = (self.width - (cols - 1) * margin) / cols;
    
    CGFloat x = 0;
    CGFloat y = 0;
    NSInteger col = 0;
    NSInteger row = 0;
    
    for (int i = 0 ; i < self.subviews.count; i++) {
        UIImageView *imageV = self.subviews[i];
        col = i % cols;
        row = i / cols;
        x = col * (margin + wh);
        y = row * (margin + wh);
        imageV.frame = CGRectMake(x, y, wh, wh);
    }
}

@end
