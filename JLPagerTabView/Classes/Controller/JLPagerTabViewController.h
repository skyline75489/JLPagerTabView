//
//  JLPagerTabViewController.h
//  JLPagerTabView
//
//  Created by skyline on 15/11/27.
//  Copyright © 2015年 H.I.T. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLPagerTabBarView.h"

@interface JLPagerTabViewController : UIViewController<JLPagerTabBarDelegate, UIScrollViewDelegate>

@property (nonatomic) CGFloat barHeight;

- (instancetype)initWithTabTitles:(NSArray *)titles;
- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers;
- (void)setSelectedIndex:(NSUInteger)selectedIndex;

@end
