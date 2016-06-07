//
//  LXRollViewController.m
//  LXRollViewController
//
//  Created by Leon on 16/6/6.
//  Copyright © 2016年 mojie. All rights reserved.
//

#import "LXRollViewController.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

static const NSInteger kBtTag = 100;

@interface LXRollViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) NSTimer *autoRollTimer;
@property (nonatomic, strong) UIPageControl *pageController;
@property (nonatomic, strong) UIScrollView *sv;

@end

@implementation LXRollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.rollInterval= 5.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshWithDatas:(NSArray *)datas
{
    NSAssert(datas != nil && datas.count > 0, @"LXRollView refreshWitDatas: datas can not be nil!");

    self.datas = [NSMutableArray arrayWithArray:datas];
    
    //添加两个占位 first 和 last 用来实现无限循环
    id first  = [self.datas lastObject];
    id last = [self.datas firstObject];
    [self.datas insertObject:first atIndex:0];
    [self.datas addObject:last];
    //Ui
    [self setupUIWithDatas:self.datas];
    //PageController
    if (self.pageController == nil) {
        self.pageController = [[UIPageControl alloc] init];
        [self.view addSubview:self.pageController];
        [self.pageController mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view);
            make.height.equalTo(@28);
        }];
        
        self.autoRollTimer = [NSTimer timerWithTimeInterval:self.rollInterval target:self selector:@selector(onAutoRollTimer:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.autoRollTimer forMode:NSDefaultRunLoopMode];
        [self.autoRollTimer fire];
    }
    
    //
    self.pageController.numberOfPages = self.datas.count -2;
    self.pageController.currentPage = 0;
    self.pageController.frame = CGRectZero;
    [self.pageController sizeForNumberOfPages:self.datas.count -2];
}


- (void)setupUIWithDatas:(NSMutableArray *)datas
{
    [self.sv removeFromSuperview];
    self.sv = nil;
    self.sv = [[UIScrollView alloc] init];
    self.sv.pagingEnabled = YES;
    self.sv.showsHorizontalScrollIndicator = NO;
    self.sv.showsVerticalScrollIndicator = NO;
    self.sv.delegate = self;
    [self.view addSubview:self.sv];
    //Layout
    [self.sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //
    UIView *lastImageView = nil;
    for (NSInteger n = 0; n < self.datas.count; n ++) {
        id content = self.datas[n];
        UIView *imageView = [[UIView alloc] init];
        [self.sv addSubview:imageView];
        UIImageView *picView = [[UIImageView alloc] init];
        picView.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
        if ([content isKindOfClass:[NSURL class]]){
            NSURL *url = content;
            [picView sd_setImageWithURL:url placeholderImage:self.placeholderImage options:SDWebImageRetryFailed];
        }else if ([content isKindOfClass:[UIImage class]]){
            picView.image = content;
        }
        [imageView addSubview:picView];
        [picView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(imageView);
        }];
        
        //Button
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.tag = n+kBtTag-1;
        //第一个展位数据，是原数据的最后一个
        if (n == 0){
            bt.tag = self.datas.count - 2 -1+kBtTag;
        }else if (n == self.datas.count -1)
        {
            //末尾展位数据，是原数据的第一个
            bt.tag = kBtTag;
        }
        
        [bt addTarget:self action:@selector(clickRollView:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:bt];
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(imageView);
        }];
        
        if(lastImageView == nil)
        {
            //第一个
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(self.sv);
                make.top.equalTo(self.sv);
                make.bottom.equalTo(self.sv);
                make.width.equalTo(self.sv);
                make.height.equalTo(self.sv);
            }];
        }else
            if (n == datas.count-1) {
                //最后一个
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.leading.equalTo(lastImageView.mas_trailing);
                    make.trailing.equalTo(self.sv);
                    make.top.equalTo(self.sv);
                    make.bottom.equalTo(self.sv);
                    make.width.equalTo(self.sv);
                }];
            }else{
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.leading.equalTo(lastImageView.mas_trailing);
                    make.top.equalTo(self.sv);
                    make.bottom.equalTo(self.sv);
                    make.width.equalTo(self.sv);
                }];
            }
        
        lastImageView = imageView;
    }
}

#pragma mark - 自动滚动
- (void)onAutoRollTimer:(NSTimer *)timer
{
    NSInteger page = floor(self.sv.contentOffset.x / self.sv.bounds.size.width);
    
    [self.sv setContentOffset:CGPointMake((page +1) *self.sv.bounds.size.width, 0) animated:YES];
}

#pragma mark - ScrollView Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.autoRollTimer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.autoRollTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.rollInterval]];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger width = (NSInteger)scrollView.bounds.size.width;
    if ((NSInteger)scrollView.contentOffset.x % width != 0){
        [scrollView setContentOffset:CGPointMake(width*self.pageController.currentPage, scrollView.contentOffset.y) animated:NO];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self refreshScrollView:scrollView];
}

- (void)refreshScrollView:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x <scrollView.bounds.size.width ) {
        scrollView.contentOffset = CGPointMake(self.pageController.numberOfPages * scrollView.bounds.size.width + scrollView.contentOffset.x, scrollView.contentOffset.y);
        self.pageController.currentPage = self.pageController.numberOfPages - 1;
        return;
    }
    if (scrollView.contentOffset.x >= (self.pageController.numberOfPages+1) *scrollView.bounds.size.width) {
        CGFloat offset = scrollView.contentOffset.x -( self.pageController.numberOfPages +1) *scrollView.bounds.size.width;
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width + offset, scrollView.contentOffset.y);
        self.pageController.currentPage = 0;
        return;
    }
    
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.pageController.currentPage = page - 1;
}

#pragma mark - Click Roll View
- (void)clickRollView:(UIButton *)bt
{
    NSInteger index = bt.tag-kBtTag;
    if (self.clickRollView != nil) {
        self.clickRollView(index);
    }
}

@end
