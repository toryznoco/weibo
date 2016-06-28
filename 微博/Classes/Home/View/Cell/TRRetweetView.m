//
//  TRRetweetView.m
//  微博
//
//  Created by Tory on 15/10/24.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import "TRRetweetView.h"

#import "TRStatus.h"
#import "TRStatusFrame.h"
#import "TRPhotosView.h"

@interface TRRetweetView ()

//  昵称
@property (nonatomic, weak) UILabel *nameView;

//  正文
@property (nonatomic, weak) UILabel *textView;

//  配图
@property (nonatomic, weak) TRPhotosView *photosView;

@end

@implementation TRRetweetView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //  添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
    }
    return self;
}

//  添加所有子控件
- (void)setUpAllChildView
{
    //  昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.textColor = [UIColor blueColor];
    nameView.font = TRNameFont;
    [self addSubview:nameView];
    _nameView = nameView;
    
    //  正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = TRTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
    
    //  配图
    TRPhotosView *photosView = [[TRPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
}

- (void)setStatusF:(TRStatusFrame *)statusF
{
    _statusF = statusF;
    
    TRStatus *status = statusF.status;
    
    //  昵称
    _nameView.frame = statusF.retweetNameFrame;
    _nameView.text =  status.retweetName;
    
    //  正文
    _textView.frame = statusF.retweetTextFrame;
    _textView.text = status.retweeted_status.text;
    
    //  配图
    _photosView.frame = statusF.retweetPhotosFrame;
    _photosView.pic_urls = status.retweeted_status.pic_urls;
}

@end
