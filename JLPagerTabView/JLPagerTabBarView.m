//
//  JLPagerTabBarView.m
//  JLPagerTabView
//
//  Created by skyline on 15/11/27.
//  Copyright © 2015年 H.I.T. All rights reserved.
//

#import "JLPagerTabBarView.h"
#import "JLPagerTabLabelView.h"

@interface JLPagerTabBarView ()

@property (nonatomic) NSMutableArray<JLPagerTabLabelView *> *labels;
@property (nonatomic) CGFloat currentLabelOffset;
@property (nonatomic) NSUInteger selectedIndex;
@property (nonatomic) UIColor *normalColor;
@property (nonatomic) UIColor *highlightColor;
@property (nonatomic) UIView *floatIndicatorView;
@property (nonatomic) NSArray *barTitles;

@end

@implementation JLPagerTabBarView

- (instancetype) initWithFrame:(CGRect)frame barTitles:(NSArray *)titles{
    self = [super initWithFrame:frame];
    if (self) {
        _labels = [[NSMutableArray alloc] init];
        _currentLabelOffset = 0;
        _tabCounts = 0;
        _labelWidth = 0;
        _normalColor = [UIColor blackColor];
        self.backgroundColor = [UIColor whiteColor];
        self.jl_tintColor = [UIColor redColor];
        if ([self respondsToSelector:@selector(tintColor)]) {
            self.jl_tintColor = self.tintColor;
        }
        _highlightColor = self.jl_tintColor;
        
        self.tabCounts = titles.count;
        self.barTitles = titles;
        [self.barTitles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *_) {
            [self addLabel:title];
        }];
        
        [self addSubview:self.floatIndicatorView];
        
    }
    return self;
}

- (UIView *)floatIndicatorView {
    if (!_floatIndicatorView) {
        _floatIndicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.labelWidth, 1)];
        _floatIndicatorView.backgroundColor = _highlightColor;
    }
    return _floatIndicatorView;
}

- (void)setTabCounts:(CGFloat)tabCounts {
    _tabCounts = tabCounts;
    _labelWidth = CGRectGetWidth(self.frame) / _tabCounts;
}

- (void)addLabel:(NSString *)text {
    JLPagerTabLabelView *v = [[JLPagerTabLabelView alloc] initWithFrame:CGRectMake(self.currentLabelOffset, 0, self.labelWidth, self.frame.size.height - 1) Text:text];
    self.currentLabelOffset += self.labelWidth;
    [self.labels addObject:v];
    [self addSubview:v];
    [v addTarget:self action:@selector(didSelectedLabel:) forControlEvents:UIControlEventTouchDown];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [self.labels enumerateObjectsUsingBlock:^(JLPagerTabLabelView *view, NSUInteger index, BOOL *stop) {
        if (index == selectedIndex) {
            [self moveIndicatorToIndex:index];
            view.label.textColor = self.highlightColor;
        } else {
            view.label.textColor = self.normalColor;
        }
    }];
}

- (void)didSelectedLabel:(id)sender {
    [self.labels enumerateObjectsUsingBlock:^(JLPagerTabLabelView *view, NSUInteger index, BOOL *stop) {
        if (view == sender) {
            [self setSelectedIndex:index];
            if ([self.delegate respondsToSelector:@selector(didSelectIndex:)]) {
                [self.delegate didSelectIndex:index];
            }
        }
    }];
}

- (void)moveIndicatorToOffset:(CGFloat)offset {
    CGFloat maxOffset = self.frame.size.width - self.labelWidth;
    CGFloat minOffset = 0;
    CGFloat targetOffset = offset;
    if (targetOffset > maxOffset) {
        targetOffset = maxOffset;
    }
    if (targetOffset < minOffset) {
        targetOffset = minOffset;
    }
    _floatIndicatorView.frame = CGRectMake(targetOffset, self.frame.size.height - 1, self.labelWidth, 1);
}

- (void)moveIndicatorToIndex:(NSUInteger)index {
    [UIView animateWithDuration:0.2 animations:^(){
        CGRect labelFrame = self.labels[index].frame;
        [self moveIndicatorToOffset:labelFrame.origin.x];
    }];
}

@end
