//
//  TRUserParam.h
//  微博
//
//  Created by Tory on 15/10/15.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRBaseParam.h"

@interface TRUserParam : TRBaseParam

/**
 *  当前登录用户唯一标识符
 */
@property (copy, nonatomic) NSString *uid;

@end
