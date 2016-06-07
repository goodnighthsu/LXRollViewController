
# LXRollViewController
* 简单的无限轮播ViewController
* 轮播内容可以为**NSURL**或**UIImage**

![Demmo](http://image18-c.poco.cn/mypoco/myphoto/20160607/16/17929525720160607161048013.gif?318x565_110)

[![CI Status](http://img.shields.io/travis/leon.xu/LXRollViewController.svg?style=flat)](https://travis-ci.org/leon.xu/LXRollViewController)
[![Version](https://img.shields.io/cocoapods/v/LXRollViewController.svg?style=flat)](http://cocoapods.org/pods/LXRollViewController)
[![License](https://img.shields.io/cocoapods/l/LXRollViewController.svg?style=flat)](http://cocoapods.org/pods/LXRollViewController)
[![Platform](https://img.shields.io/cocoapods/p/LXRollViewController.svg?style=flat)](http://cocoapods.org/pods/LXRollViewController)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

1.内容为url

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


2.内容为image

    UIImage *image1 = [UIImage imagedName:@"image1"];
    UIImage *image2 = [UIImage imagedName:@"image2"];

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
	[rollVC refreshWithDatas:@[image1, image2]];

## Requirements

## Installation

LXRollViewController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "LXRollViewController"
```

## Author

leon.xu, goodnighthsu@msn.com

## License

LXRollViewController is available under the MIT license. See the LICENSE file for more info.