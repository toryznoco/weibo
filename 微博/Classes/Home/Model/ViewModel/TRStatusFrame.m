//
//  TRStatusFrame.m
//  微博
//
//  Created by Tory on 15/10/24.
//  Copyright © 2015年 normcore. All rights reserved.
//  模型 + 对应控件的frame

#import "TRStatusFrame.h"
#import "TRStatus.h"
#import "TRUser.h"



@implementation TRStatusFrame

- (void)setStatus:(TRStatus *)status
{
    _status = status;
    
    //  计算原创微博
    [self setUpOriginalViewFrame];
    
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    
    if (status.retweeted_status) {
        //  计算转发微博
        [self setUpRetweetViewFrame];
        toolBarY = CGRectGetMaxY(_retweetViewFrame);
    }
    
    //  计算工具条
    CGFloat toolBarX = 0;
    CGFloat toolBarW = TRScreenW;
    CGFloat toolBarH = 35;
    _toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    //  计算cell高度
    _cellHeight = CGRectGetMaxY(_toolBarFrame);
}

#pragma mark - 计算原创微博
- (void)setUpOriginalViewFrame
{
    //  头像
    CGFloat imageX = TRStatusCellMargin;
    CGFloat imageY = imageX;
    CGFloat imageWH = 35;
    _originalIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    //  昵称
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + TRStatusCellMargin;
    CGFloat nameY = imageY;
    NSDictionary *nameAttributes = @{NSFontAttributeName: TRNameFont};
    CGSize nameSize = [_status.user.name sizeWithAttributes:nameAttributes];
    _originalNameFrame = (CGRect){{nameX, nameY},nameSize};
    
    //  vip
    if (_status.user.vip) {
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + TRStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        _originalViewFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
    }
    
    //  正文
    CGFloat textX = imageX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + TRStatusCellMargin;
    CGFloat textW = TRScreenW - 2 * TRStatusCellMargin;
    NSDictionary *textAttributes = @{NSFontAttributeName: TRTextFont};
    CGSize textSize = [_status.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil].size;
    _originalTextFrame = (CGRect){{textX, textY}, textSize};
    
    CGFloat originH = CGRectGetMaxY(_originalTextFrame) + TRStatusCellMargin;
    //  配图
    if (_status.pic_urls.count) {
        CGFloat photosX = TRStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_originalTextFrame) + TRStatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:_status.pic_urls.count];
        _originalPhotosFrame = (CGRect){{photosX, photosY}, photosSize};
        originH = CGRectGetMaxY(_originalPhotosFrame) + TRStatusCellMargin;
    }
    
    //  原创微博的frame
    CGFloat originX = 0;
    CGFloat originY = 0;
    CGFloat originW = TRScreenW;
    
    _originalViewFrame = CGRectMake(originX, originY, originW, originH);
}

#pragma mark - 计算配图的尺寸
- (CGSize)photosSizeWithCount:(NSInteger)count
{
    //  获取总列数
    NSInteger cols = count == 4? 2 : 3;
    
    //  获取总行数
    NSInteger rols = (count - 1) / cols + 1;
    CGFloat photoWH = 70;
    CGFloat w = cols * photoWH + (cols - 1) * TRStatusCellMargin;
    CGFloat h = rols * photoWH + (rols - 1) * TRStatusCellMargin;
    
    return CGSizeMake(w, h);
}

#pragma mark - 计算转发微博
- (void)setUpRetweetViewFrame
{
    // 昵称frame
    // 昵称
    CGFloat nameX = TRStatusCellMargin;
    CGFloat nameY = nameX;
    // 注意：一定要是转发微博的用户昵称
    CGSize nameSize = [_status.retweetName sizeWithFont:TRNameFont];
    _retweetNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // 正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_retweetNameFrame) + TRStatusCellMargin;
    
    CGFloat textW = TRScreenW - 2 * TRStatusCellMargin;
    // 注意：一定要是转发微博的正文
    CGSize textSize = [_status.retweeted_status.text sizeWithFont:TRTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _retweetTextFrame = (CGRect){{textX,textY},textSize};
    
    CGFloat retweetH = CGRectGetMaxY(_retweetTextFrame) + TRStatusCellMargin;
    //  配图
    int count = _status.retweeted_status.pic_urls.count;
    if (count) {
        CGFloat photosX = TRStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_retweetTextFrame) + TRStatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:count];
        _retweetPhotosFrame = (CGRect){{photosX, photosY}, photosSize};
        retweetH = CGRectGetMaxY(_retweetPhotosFrame) + TRStatusCellMargin;
    }
    
    // 原创微博的frame
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = TRScreenW;
    
    _retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
}

@end
