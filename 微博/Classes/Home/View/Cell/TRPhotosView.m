//
//  TRPhotoView.m
//  微博
//
//  Created by Tory on 15/10/31.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import "TRPhotosView.h"
#import "TRPhoto.h"
#import "UIImageView+WebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#import "TRPhotoView.h"

@implementation TRPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //  添加9个子控件
        [self setUpAllChildView];
    }
    return self;
}

//  添加9个子控件
- (void)setUpAllChildView
{
    for (int i = 0; i < 9; i++) {
        TRPhotoView *imageV = [[TRPhotoView alloc] init];

        imageV.tag = i;
        //  添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageV addGestureRecognizer:tap];
        
        [self addSubview:imageV];
    }
}

#pragma mark - 点击图片的时候调用
- (void)tap:(UITapGestureRecognizer *)tap
{
    UIImageView *tapView = tap.view;
    //  TRPhoto ->MJPhoto
    int i = 0;
    NSMutableArray * arrM = [NSMutableArray array];
    for (TRPhoto *photo in _pic_urls) {
        MJPhoto *p = [[MJPhoto alloc] init];
        NSString *urlStr = photo.thumbnail_pic.absoluteString;
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        p.url = [NSURL URLWithString:urlStr];
 
        p.index = i;
        p.srcImageView = tapView;
        [arrM addObject:p];
        i++;
    }
    //  弹出图片浏览器
    //  创建浏览器对象
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
    //  MJPhoto
    brower.photos = arrM;
    brower.currentPhotoIndex = tapView.tag;
    [brower show];
}

- (void)setPic_urls:(NSArray *)pic_urls
{
    //  4
    _pic_urls = pic_urls;
    NSInteger count = self.subviews.count;
    for (int i = 0; i < count ; i++) {
        
        TRPhotoView *imageV = self.subviews[i];
        
        if (i < pic_urls.count) { // 显示
            imageV.hidden = NO;
            
            //  获取TRPhoto模型
            TRPhoto *photo = pic_urls[i];
            
            imageV.photo = photo;
            
           
        }else{
            imageV.hidden = YES;
        }
    }
}

//  计算尺寸
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 70;
    CGFloat h = 70;
    CGFloat margin = 10;
    int col = 0;
    int rol = 0;
    int cols = _pic_urls.count == 4?2:3;
    //  计算显示出来的imageView
    for (int i = 0; i < _pic_urls.count; i++) {
        col = i % cols;
        rol = i / cols;
        UIImageView *imageV = self.subviews[i];
        x = col * (w + margin);
        y = rol * (h + margin);
        imageV.frame = CGRectMake(x, y, w, h);
    }
}

@end
