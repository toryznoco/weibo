//
//  TRStatusResult.h
//  微博
//
//  Created by Tory on 15/10/15.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface TRStatusResult : NSObject<MJKeyValue>

/**
 *  用户的微博数组(TRStatus)
 */
@property (strong, nonatomic) NSArray *statuses;

/**
 *  用户最近微博总数
 */
@property (assign, nonatomic) int total_number;

@end
