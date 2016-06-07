//
//  LXViewController.m
//  LXRollViewController
//
//  Created by leon.xu on 06/07/2016.
//  Copyright (c) 2016 leon.xu. All rights reserved.
//

#import "LXViewController.h"
#import <Masonry/Masonry.h>
#import <LXRollViewController/LXRollViewController.h>

@interface LXViewController ()

@end

@implementation LXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString *urlString = @"http://image18-c.poco.cn/mypoco/myphoto/20160607/15/17929525720160607155646089.jpg?711x400_120";
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *urlString1 = @"http://image18-c.poco.cn/mypoco/myphoto/20160607/15/17929525720160607155843054.jpg?711x400_120";
    NSURL *url1 = [NSURL URLWithString:urlString1];
    
    LXRollViewController *rollVC = [[LXRollViewController alloc] init];
    [rollVC setClickRollView:^(NSInteger index) {
        NSLog(@"click : %li", index);
    }];
    [self.view addSubview:rollVC.view];
    [self addChildViewController:rollVC];
    [rollVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(@200);
    }];
    //刷新页面
    [rollVC refreshWithDatas:@[url, url1]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
