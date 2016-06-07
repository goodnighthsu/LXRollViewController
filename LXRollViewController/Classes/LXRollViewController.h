//
//  LXRollViewController.h
//  LXRollViewController
//
//  Created by Leon on 16/6/6.
//  Copyright © 2016年 mojie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXRollViewController : UIViewController

@property (nonatomic, strong) NSMutableArray <id> *datas;
///
@property (nonatomic, assign) CGFloat rollInterval;
@property (nonatomic, strong) UIImage *placeholderImage;

@property (nonatomic, copy) void (^clickRollView)(NSInteger index);

///刷新页面
- (void)refreshWithDatas:(NSArray *)datas;

@end
