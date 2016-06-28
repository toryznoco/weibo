//
//  TRStatusToolBar.m
//  微博
//
//  Created by Tory on 15/10/24.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import "TRStatus.h"
#import "TRStatusToolBar.h"

@interface TRStatusToolBar ()

@property (nonatomic, strong) NSMutableArray *btns;

@property (nonatomic, strong) NSMutableArray *divides;

@property (nonatomic, weak) UIButton *retweet;
@property (nonatomic, weak) UIButton *comment;
@property (nonatomic, weak) UIButton *unlike;

@end

@implementation TRStatusToolBar

- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)divides
{
    if (_divides == nil) {
        _divides = [NSMutableArray array];
    }
    return _divides;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //  添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"timeline_card_bottom_background"];
    }
    return self;
}

//  添加所有子控件
- (void)setUpAllChildView
{
    //  转发
    UIButton *retweet = [self setUpOneButtonWithTitle:@"转发" image:[UIImage imageNamed:@"timeline_icon_retweet"]];
    _retweet = retweet;
    
    //  评论
    UIButton *comment = [self setUpOneButtonWithTitle:@"评论" image:[UIImage imageNamed:@"timeline_icon_comment"]];
    _comment = comment;
    
    //  赞
    UIButton *unlike = [self setUpOneButtonWithTitle:@"赞" image:[UIImage imageNamed:@"timeline_icon_unlike"]];
    _unlike = unlike;
    
    for (int i = 0; i < 2; i++)
    {
        UIImageView * divideV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:divideV];
        [self.divides addObject:divideV];
    }
}

- (UIButton *)setUpOneButtonWithTitle:(NSString *)title image:(UIImage *)image
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //  设置按钮的frame
    NSInteger count = self.btns.count;
    CGFloat w = TRScreenW / count;
    CGFloat h = self.height;
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.btns[i];
        x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
    }
    
    int i = 1;
    for (UIImageView *divide in self.divides) {
        UIButton *btn = self.btns[i];
        divide.x = btn.x;
        i++;
    }
}

- (void)setStatus:(TRStatus *)status
{
    _status = status;
    
    //  设置转发的标题
    [self setBtn:_retweet Title:status.reposts_count];
    
    //  设置评论的标题
    [self setBtn:_comment Title:status.comments_count];
    
    //  设置赞
    [self setBtn:_unlike Title:status.attitudes_count];
}

//  设置按钮的标题
- (void)setBtn:(UIButton *)btn Title:(NSInteger)count
{
    //  > 10000 10100 1.2w
    NSString *title = nil;
    if (count) {
        if (count > 10000)
        {
            CGFloat floatCount = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1fw", floatCount];
            title = [title stringByReplacingOccurrencesOfString:@"" withString:@""];
        }else{
            //  < 10000
            title = [NSString stringWithFormat:@"%ld", count];
        }
        
        //  设置转发
        [btn setTitle:title forState:UIControlStateNormal];
    }
}

@end
