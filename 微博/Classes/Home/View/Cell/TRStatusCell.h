//
//  TRStatusCell.h
//  微博
//
//  Created by Tory on 15/10/24.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TRStatusFrame;
@interface TRStatusCell : UITableViewCell

@property (nonatomic, strong) TRStatusFrame *statusF;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
