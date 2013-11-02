//
//  UILabel+SY.h
//  Tutor
//
//  Created by syzhou on 13-11-1.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SY)

+ (id)createLabelWithFrame:(CGRect)rect font:(UIFont *)font  addView:(UIView *)superView;
+ (id)createLabelWithFrame:(CGRect)rect font:(UIFont *)font textAligment:(UITextAlignment)alignment addView:(UIView *)superView;

@end
