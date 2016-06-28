//
//  UIImage+image.m
//  微博
//
//  Created by Tory on 15/9/7.
//  Copyright (c) 2015年 normcore. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)

+ (instancetype)imageWithOriginalName:(NSString *)imageName;
{
    UIImage*image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
