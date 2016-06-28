//
//  TRUser.m
//  微博
//
//  Created by Tory on 15/9/30.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import "TRUser.h"

@implementation TRUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    _vip = mbtype > 2;
}

@end
