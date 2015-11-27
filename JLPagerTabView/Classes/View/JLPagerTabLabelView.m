//
//  JLPagerTabLabelView.m
//  JLPagerTabView
//
//  Created by xinmei on 15/11/27.
//  Copyright © 2015年 H.I.T. All rights reserved.
//

#import "JLPagerTabLabelView.h"

@implementation JLPagerTabLabelView

- (instancetype) initWithFrame:(CGRect)frame Text:(NSString *)text{
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _label.text = text;
        _label.font = [UIFont systemFontOfSize:15];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor colorWithRed:17/255.0 green:17/255.0 blue:17/255.0 alpha:1];
        [self addSubview:_label];
    }
    return self;
}

@end