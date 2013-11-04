//
//  CustomAlertSelectView.h
//  Tutor
//
//  Created by hank on 13-11-3.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomAlertSelectView;

@protocol CustomAlertSelectViewDelegate <NSObject>

- (void)CustomAlertSelectViewSelectFinish:(CustomAlertSelectView *)customAlertView;

@end

@interface CustomAlertSelectView : UIView<UITableViewDataSource, UITableViewDelegate>
{
    int _originY;
    NSArray *_arrayData;
}

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)strTitle;

@property(nonatomic, weak)id<CustomAlertSelectViewDelegate> delegate;

@end
