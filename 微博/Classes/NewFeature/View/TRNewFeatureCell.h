//
//  TRNewFeatureCell.h
//  微博
//
//  Created by Tory on 15/9/22.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRNewFeatureCell : UICollectionViewCell

@property (strong, nonatomic) UIImage *image;

//  判断是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;

@end
