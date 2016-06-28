//
//  TRHomeViewController.m
//  微博
//
//  Created by Tory on 15/9/14.
//  Copyright (c) 2015年 normcore. All rights reserved.
//

#import "TRHomeViewController.h"
#import "UIBarButtonItem+Item.h"
#import "TRTitleButton.h"
#import "TRPopMenu.h"
#import "TRCover.h"
#import "TROneViewController.h"


#import "TRStatus.h"
#import "TRUser.h"

#import "MJExtension.h"
#import "UIImageView+WebCache.h"

#import "MJRefresh.h"

#import "TRStatusTool.h"
#import "TRUserTool.h"
#import "TRAccountTool.h"
#import "TRAccount.h"

#import "TRStatusCell.h"

#import "TRStatusFrame.h"

@interface TRHomeViewController ()<TRCoverDelegate>

@property (weak, nonatomic) TRTitleButton *titleButton;

@property (strong, nonatomic) TROneViewController *one;

/**
 *  ViewModel:TRStatusFrame
 */
@property (strong, nonatomic) NSMutableArray *statusFrames;

@end

@implementation TRHomeViewController

- (NSMutableArray *)statusFrames
{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (TROneViewController *)one
{
    if (_one == nil) {
        _one = [[TROneViewController alloc] init];
    }
    return _one;
}

// UIBarButtonItem:决定导航条上按钮的内容
// UINavigationItem:决定导航条上内容
// UITabBarItem:决定tabBar上按钮的内容
// ios7之后，会把tabBar上和导航条上的按钮渲染
// 导航条上自定义按钮的位置是由系统决定，尺寸才需要自己设置。
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    //  取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //  设置导航条内容
    [self setUpNavigationBar];
    
    //  请求最新微博数据
    //  添加下拉刷新控件
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];

    //  自动下拉刷新
    [self.tableView headerBeginRefreshing];
    
    //  添加上拉刷新控件
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    
    //  一开始展示之前的微博名称，然后再发送用户信息请求，直接赋值
    
    //  请求当前用户的昵称
    [TRUserTool userInfoWithSuccess:^(TRUser *user) {
        //  请求当前账号的用户信息
        //  设置导航条的标题
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        
        //  获取当前账号
        TRAccount *account = [TRAccountTool account];
        account.name = user.name;
        
        //  保存用户的名称
        [TRAccountTool saveAccount:account];
        
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 刷新最新的微博
-(void)refresh
{
    [self.tableView headerBeginRefreshing];
}

#pragma mark - 请求更多旧微博
- (void)loadMoreStatus
{
    NSString *maxIdStr = nil;
    
    if (self.statusFrames.count) {
        //  有新的微博数据，才需要下拉刷新
        TRStatus *s = [[self.statusFrames lastObject] status];
        long long maxId = [s.idstr longLongValue] - 1;
        maxIdStr = [NSString stringWithFormat:@"%lld", maxId];
    }
    
    //  请求更多微博数据
    [TRStatusTool moreStatusWithMaxId:maxIdStr success:^(NSArray *statuses) {
        //  结束上拉刷新
        [self.tableView footerEndRefreshing];
        
        //  模型转换视图模型 TRStatus -> TRStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (TRStatus *status in statuses) {
            TRStatusFrame *statusF = [[TRStatusFrame alloc] init];
            statusF.status = status;
            [statusFrames addObject:statusF];
        }
        
        //  把数组中的元素添加进去
        [self.statusFrames addObjectsFromArray:statusFrames];
        
        //  刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

// block保存一段代码
- (void)text
{
    //  (void (^)(id responseObject))success
    //  void(^)() block 类型 myBlock block变量名
    void(^myBlock)() = ^(){
        NSLog(@"myblock");
    };
    //  Block调用
//    myBlock();
    //  inline
//    (^<#blockName#>)(<#parameterTypes#>) = ^(<#parameters#>) {
//        <#statements#>
//    };
}


//  {:json字典 [:json数组
#pragma mark - 请求最新微博
- (void)loadNewStatus
{
    NSString *sinceId = nil;
    if (self.statusFrames.count) {  //  有新的微博数据，才需要下拉刷新
        TRStatus *s = [self.statusFrames[0] status];
        sinceId = s.idstr;
    }
    
    [TRStatusTool newStatusWithSinceId:sinceId success:^(NSArray *statuses){
        //  请求成功的block
        
        //  展示最新的微博数
        [self showNewStatusCount:statuses.count];
        
        //  结束下拉刷新
        [self.tableView headerEndRefreshing];
        
        //  模型转换视图模型 TRStatus -> TRStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (TRStatus *status in statuses) {
            TRStatusFrame *statusF = [[TRStatusFrame alloc] init];
            statusF.status = status;
            [statusFrames addObject:statusF];
        }
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        //  把最新的微博数插入到最前面
        [self.statusFrames insertObjects:statusFrames atIndexes:indexSet];
        
        //  刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        //
    }];
}

#pragma mark - 展示最新的微博数
- (void)showNewStatusCount:(NSInteger)count
{
    if (count == 0) {
        return;
    }
    //  展示最新的微博数
    CGFloat h = 35;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - h;
    CGFloat x = 0;
    CGFloat w = self.view.width;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"最新微博数%ld", count];
    label.textAlignment = NSTextAlignmentCenter;
    
    //  插入导航控制器下导航条下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //  动画往下面平移
    [UIView animateWithDuration:0.25 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, h);
    } completion:^(BOOL finished) {
        
        //  往上面平移
        [UIView animateWithDuration:0.25 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
            
            //  还原
            label.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

#pragma mark - 设置导航条
- (void)setUpNavigationBar
{
    //  左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendsearch) forControlEvents:UIControlEventTouchUpInside];
    
    //  右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    //  titleView
    TRTitleButton *titleButton = [TRTitleButton buttonWithType:UIButtonTypeCustom];
    _titleButton = titleButton;
//    NSLog(@"%@",[TRAccountTool account].name);
    NSString *title = [TRAccountTool account].name?:@"首页";
    [titleButton setTitle:title forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    
    //  高亮的时候不需要调整图片
    titleButton.adjustsImageWhenHighlighted = NO;
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
}

//  以后只要显示在最前面的空间，一般都加在主窗口
//  点击标题按钮
- (void)titleClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    //  弹出蒙板
    TRCover *cover = [TRCover show];
    cover.delegate = self;
    
    //  弹出pop菜单
    CGFloat popW = 200;
    CGFloat popX = (self.view.width - 200) * 0.5;
    CGFloat popH = popW;
    CGFloat popY = 55;
    TRPopMenu *menu = [TRPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    menu.contentView = self.one.view;
}

//  点击蒙板的时候调用
- (void)coverDidClickCover:(TRCover *)cover
{
    //  隐藏pop菜单
    [TRPopMenu hide];
    
    _titleButton.selected = NO;
}

- (void)friendsearch
{
    
}

- (void)pop
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  创建cell
    TRStatusCell *cell = [TRStatusCell cellWithTableView:tableView];
    
    //  获取status模型
    TRStatusFrame *statusF = self.statusFrames[indexPath.row];
    
    //  给cell传递模型
    cell.statusF = statusF;
    
//    //  用户昵称
//    cell.textLabel.text = status.user.name;
//    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
//    cell.detailTextLabel.text = status.text;
    return cell;
}

//  返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  获取statusF模型
    TRStatusFrame *statusF = self.statusFrames[indexPath.row];
    return statusF.cellHeight;
}

@end
