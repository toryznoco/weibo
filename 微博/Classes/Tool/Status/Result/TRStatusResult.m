//
//  TRStatusResult.m
//  微博
//
//  Created by Tory on 15/10/15.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import "TRStatusResult.h"

#import "TRStatus.h"

@implementation TRStatusResult

+ (NSDictionary *)objectClassInArray
{
    return @{@"statuses":[TRStatus class]};
}

@end
