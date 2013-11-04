//
//  PullDownView.h
//  Tutor
//
//  Created by hank on 13-11-3.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PullDownViewDelegata <NSObject>

- (void)PullDownViewDidSelectAtIndex:(NSInteger)index;

@end


@interface PullDownView : UIView
{
    int _originY;
    NSArray *_arrayData;
    int _originIndex; //起始的index
    UIView *_viewSelectBG;
    int _selectedIndex;
    UIImageView *_imgHeader;
}
- (id)initWithFrame:(CGRect)frame andIndex:(NSInteger)index;

@property(nonatomic, weak)id<PullDownViewDelegata> delegate;

@end
