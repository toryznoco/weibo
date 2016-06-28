//
//  TRComposeToolBar.h
//  微博
//
//  Created by Tory on 15/11/10.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TRComposeToolBar;
@protocol TRComposeToolBarDelegate <NSObject>

@optional
- (void)composeToolBar:(TRComposeToolBar *)toolBar didClickBtn:(NSInteger)index;

@end

@interface TRComposeToolBar : UIView

@property (nonatomic, weak) id<TRComposeToolBarDelegate> delegate;

@end
