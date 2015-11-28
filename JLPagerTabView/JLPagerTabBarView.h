//
//  JLPagerTabBarView.h
//  JLPagerTabView
//
//  Created by skyline on 15/11/27.
//  Copyright © 2015年 H.I.T. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JLPagerTabBarDelegate;

@interface JLPagerTabBarView : UIView

@property (nonatomic) id<JLPagerTabBarDelegate> delegate;
@property (nonatomic) UIColor *jl_tintColor;
@property (nonatomic) CGFloat tabCounts;
@property (nonatomic) CGFloat labelWidth;

- (instancetype) initWithFrame:(CGRect)frame barTitles:(NSArray *)titles;

- (void)moveIndicatorToOffset:(CGFloat)offset;
- (void)moveIndicatorToIndex:(NSUInteger)index;
- (void)setSelectedIndex:(NSUInteger)selectedIndex;

@end

@protocol JLPagerTabBarDelegate<NSObject>

- (void)didSelectIndex:(NSUInteger)selectedIndex;

@end