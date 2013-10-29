//
//  Toolkit.m
//  Blinq
//
//  Created by Sugar on 13-8-27.
//  Copyright (c) 2013年 Sugar Hou. All rights reserved.
//

#import "Toolkit.h"
#import "Consdef.h"

@implementation Toolkit

+ (BOOL)isSystemIOS7
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO;
}

+ (NSString *)getSystemLanguage
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kSystemLanguage];
}

+ (void)setSystemLanguage:(NSString *)strLanguage
{
    if (strLanguage)
        [[NSUserDefaults standardUserDefaults] setObject:strLanguage forKey:kSystemLanguage];
}

+(UIImage *)drawsimiLine:(UIImageView *)imageView
{
    UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
    
    CGFloat lengths[] = {5,5};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor whiteColor].CGColor);
    
    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
    CGContextMoveToPoint(line, 0.0, 20.0);    //开始画线
    CGContextAddLineToPoint(line, 310.0, 20.0);
    CGContextStrokePath(line);
    
    return UIGraphicsGetImageFromCurrentImageContext();
}

+ (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

+ (BOOL)isEnglishSysLanguage
{
    return [[self getSystemLanguage] isEqualToString:kEnglish] ? YES : NO;
}

@end
