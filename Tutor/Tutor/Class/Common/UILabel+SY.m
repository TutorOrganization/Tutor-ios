//
//  UILabel+SY.m
//  Tutor
//
//  Created by syzhou on 13-11-1.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "UILabel+SY.h"

@implementation UILabel (SY)

+ (id)createLabelWithFrame:(CGRect)rect font:(UIFont *)font  addView:(UIView *)superView {
    return [UILabel createLabelWithFrame:rect font:font textAligment:UITextAlignmentLeft addView:superView];
}


+ (id)createLabelWithFrame:(CGRect)rect font:(UIFont *)font textAligment:(UITextAlignment)alignment addView:(UIView *)superView {
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.font = font;
    label.textAlignment = alignment;
    [superView addSubview:label];
    
    return label;
}

@end
