//
//  TRUserRusult.m
//  微博
//
//  Created by Tory on 15/10/15.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import "TRUserRusult.h"

@implementation TRUserRusult

- (int)messageCount
{
    return _cmt + _dm + _mention_cmt + _mention_status;
}

- (int)totalCount
{
    return self.messageCount + _status + _follower;
}

@end
