//
//  UIImage+image.h
//  微博
//
//  Created by Tory on 15/9/7.
//  Copyright (c) 2015年 normcore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (image)

+ (instancetype)imageWithOriginalName:(NSString *)imageName;

+ (instancetype)imageWithStretchableName:(NSString *)imageName;

@end

