//
//  JLPagerTabLabelView.h
//  JLPagerTabView
//
//  Created by xinmei on 15/11/27.
//  Copyright © 2015年 H.I.T. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLPagerTabLabelView : UIControl

@property (nonatomic) UILabel *label;
@property (nonatomic) UIColor *jl_tintColor;

- (instancetype) initWithFrame:(CGRect)frame Text:(NSString *)text;

@end
