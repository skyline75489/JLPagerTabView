//
//  JLPagerTabViewController.m
//  JLPagerTabView
//
//  Created by xinmei on 15/11/27.
//  Copyright © 2015年 H.I.T. All rights reserved.
//

#import "JLPagerTabViewController.h"
#import "JLPagerTabBarView.h"

#define TABBAR_HEIGHT (70)

@interface JLPagerTabViewController ()

@property (nonatomic) JLPagerTabBarView *tabBarView;
@property (nonatomic) UIScrollView *contentScrollView;
@property (nonatomic) NSArray<UIViewController *> *backingViewControllers;
@property (nonatomic) NSInteger backingSelectedIndex;

@property (nonatomic) BOOL isDragging;
@end

@implementation JLPagerTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tabBarView];
    [self.view addSubview:self.contentScrollView];
    
    self.isDragging = NO;
}

- (JLPagerTabBarView *)tabBarView {
    if (!_tabBarView) {
        _tabBarView = [[JLPagerTabBarView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, TABBAR_HEIGHT)];
        _tabBarView.backgroundColor = [UIColor whiteColor];
        _tabBarView.delegate = self;
    }
    return _tabBarView;
}

- (UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, TABBAR_HEIGHT, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - TABBAR_HEIGHT)];
        _contentScrollView.delegate = self;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.userInteractionEnabled = YES;
        _contentScrollView.bounces = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _contentScrollView;
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers {
    _backingViewControllers = viewControllers;
    [_backingViewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *_) {
        [self addChildViewController:viewController];
        viewController.view.frame = CGRectMake(CGRectGetWidth(self.view.frame) * idx, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - TABBAR_HEIGHT);
        [self.contentScrollView addSubview:viewController.view];
    }];
    
    self.contentScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * _backingViewControllers.count, CGRectGetHeight(self.view.frame) - TABBAR_HEIGHT);
    
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [self.tabBarView setSelectedIndex:selectedIndex];
    [self didSelectIndex:selectedIndex];
}

- (void)didSelectIndex:(NSUInteger)selectedIndex{
    _backingSelectedIndex = selectedIndex;
    
    [self.contentScrollView setContentOffset:CGPointMake(CGRectGetWidth(self.view.frame) * selectedIndex, 0) animated:YES];
    self.isDragging = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isDragging) {
        [self.tabBarView moveIndicatorToOffset:scrollView.contentOffset.x / self.backingViewControllers.count];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSUInteger index = scrollView.contentOffset.x / CGRectGetWidth(self.view.frame);
    [self.tabBarView setSelectedIndex:index];
    _backingSelectedIndex = index;
}


@end
