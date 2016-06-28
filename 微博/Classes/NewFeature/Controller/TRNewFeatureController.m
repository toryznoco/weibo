//
//  TRNewFeatureController.m
//  微博
//
//  Created by Tory on 15/9/22.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import "TRNewFeatureController.h"
#import "TRNewFeatureCell.h"

@interface TRNewFeatureController ()

@property (nonatomic, weak) UIPageControl *control;

@end

@implementation TRNewFeatureController
static NSString *ID = @"cell";


- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //  设置cell的尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    
    //  清空行距
    layout.minimumLineSpacing = 0;
    
    //  设置滚动的方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:layout];
}

//  使用UICollectionViewController
//  1.初始化的时候设置布局参数
//  2.必须collectionView要注册cell
//  3.自定义cell
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  注册cell,默认就会创建这个类型cell
    [self.collectionView registerClass:[TRNewFeatureCell class] forCellWithReuseIdentifier:ID];
    
    //  分页
    self.collectionView.pagingEnabled = YES;
    
    //  不要黑边
    self.collectionView.bounces = NO;
    
    //  不要滑动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //  添加pageController
    [self setUpPageControl];
}

// 添加pageController
- (void)setUpPageControl
{
    // 添加pageController,只需要设置位置，不需要管理尺寸
    UIPageControl *control = [[UIPageControl alloc] init];
    
    control.numberOfPages = 4;
    control.pageIndicatorTintColor = [UIColor blackColor];
    control.currentPageIndicatorTintColor = [UIColor redColor];
    
    // 设置center
    control.center = CGPointMake(self.view.width * 0.5, self.view.height);
    _control = control;
    [self.view addSubview:control];
}

#pragma mark - UIScrollView代理
//  只要以滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取当前的偏移量，计算当前第几页
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
    // 设置页数
    _control.currentPage = page;
}

#pragma mark - UICollectionView代理和数据源
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

//  返回cell长什么样子
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //  首先从缓存池取cell
    //  看下当前是否有注册cell，如果注册了cell，就会帮您创建cell
    //  没有注册，报错
    TRNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    //  给cell传值
    
    //  拼接图片名称
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld", indexPath.row + 1];
    cell.image = [UIImage imageNamed:imageName];
    
    [cell setIndexPath:indexPath count:4];
    
    return cell;
}

@end
