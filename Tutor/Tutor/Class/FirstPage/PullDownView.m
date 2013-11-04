//
//  PullDownView.m
//  Tutor
//
//  Created by hank on 13-11-3.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "PullDownView.h"
#import "Toolkit.h"
#import "UIImage+NSBundle.h"

@implementation PullDownView

- (id)initWithFrame:(CGRect)frame andIndex:(NSInteger)index
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        if ([Toolkit isSystemIOS7])
            _originY = 20;
        _selectedIndex = index;
        UIView *viewBG = [[UIView alloc] initWithFrame:self.bounds];
        viewBG.backgroundColor = [UIColor blackColor];
        viewBG.alpha = 0.7;
        [self addSubview:viewBG];
        
        UILabel *lblFilter = nil;
        NSArray *arrayText = nil;
        UIImageView *imgArrow = nil;
        
        if (index < 3)
        {
            arrayText = [[NSArray alloc] initWithObjects:@"价格", @"位置", @"年级" ,nil];
            _imgHeader = [[UIImageView alloc] initWithFrame:CGRectMake(0, _originY + NavigationBar_HEIGHT, SCREEN_WIDTH, 71 / 2.0)];
            _imgHeader.image = [UIImage imageWithBundleName:@"filterBGsmall.png"];
            _imgHeader.userInteractionEnabled = YES;
            [self addSubview:_imgHeader];
            
        }
        else
        {
            _originIndex = 3;
            arrayText = [[NSArray alloc] initWithObjects:@"价格", @"年级", @"性别" ,@"评价", nil];
            _imgHeader = [[UIImageView alloc] initWithFrame:CGRectMake(0, _originY + NavigationBar_HEIGHT, SCREEN_WIDTH, 71 / 2.0)];
            _imgHeader.image = [UIImage imageWithBundleName:@"filterBG.png"];
            _imgHeader.userInteractionEnabled = YES;
            [self addSubview:_imgHeader];
        }
        
        int gap = [arrayText count] == 3 ? 30 : 20;
        for (int i = 0; i < arrayText.count; i++)
        {
            lblFilter = [[UILabel alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH / arrayText.count + gap, 8, 30, 20)];
            lblFilter.font = [UIFont systemFontOfSize:14];
            lblFilter.text = [arrayText objectAtIndex:i];
            lblFilter.backgroundColor = [UIColor clearColor];
            [_imgHeader addSubview:lblFilter];
            
            imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(lblFilter.frame.origin.x + lblFilter.frame.size.width + 5, 10, 23 / 2.0, 13 / 2.0)];
            imgArrow.image = [UIImage imageNamed:@"pullDownArrow.png"];
            imgArrow.tag = 2000 + _originIndex + i;
            imgArrow.center = CGPointMake(imgArrow.center.x, lblFilter.center.y);
            [_imgHeader addSubview:imgArrow];
            
            UIButton *btnClickPull = [[UIButton alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH / arrayText.count, 0, SCREEN_WIDTH / arrayText.count, _imgHeader.frame.size.height)];
            btnClickPull.backgroundColor = [UIColor clearColor];
            btnClickPull.tag = 1000 + i;
            [btnClickPull addTarget:self action:@selector(touchUpPull:) forControlEvents:UIControlEventTouchUpInside];
            [_imgHeader addSubview:btnClickPull];
        }
    
        [self createPullView:index];
    }
    return self;
}

- (void)createPullView:(NSInteger)index
{
    UIImageView *imgSelect = (UIImageView *)[_imgHeader viewWithTag:2000 + _selectedIndex];
    imgSelect.image = [UIImage imageWithBundleName:@"pullDownArrow.png"];
    imgSelect.transform = CGAffineTransformMakeRotation(0);
    
    UIImageView *imgArrow = (UIImageView *)[_imgHeader viewWithTag:2000 + index];
    imgArrow.image = [UIImage imageWithBundleName:@"pullDowndeArrow.png"];
    imgArrow.transform = CGAffineTransformMakeRotation(M_PI);
    
    _arrayData = nil;
    if (index == 0 || index == 3)
    {
        _arrayData = @[@"不限", @"40元内", @"80元内", @"100元内"];
    }
    else if (index == 1)
    {
        _arrayData = @[@"不限", @"5公里", @"10公里"];
    }
    else if (index == 2 || index == 4)
    {
        _arrayData = @[@"不限", @"小学", @"初中", @"高中"];
    }
    else if (index == 5)
    {
        _arrayData = @[@"不限", @"男", @"女"];
    }
    
    if (!_viewSelectBG)
    {
        _viewSelectBG = [[UIView alloc] initWithFrame:CGRectMake(0, _originY + NavigationBar_HEIGHT + 71 / 2.0, SCREEN_WIDTH, SCREEN_HEIGHT - _originY + NavigationBar_HEIGHT + 71 / 2.0)];
        _viewSelectBG.backgroundColor = [UIColor clearColor];
        _viewSelectBG.userInteractionEnabled = YES;
        [self addSubview:_viewSelectBG];
    }
    
    for (int i = 0; i < _arrayData.count; i++)
    {
        UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, i * 45, SCREEN_WIDTH, 45)];
        viewBG.backgroundColor = [UIColor whiteColor];
        viewBG.userInteractionEnabled = YES;
        [_viewSelectBG addSubview:viewBG];
        
        UIButton *btnSelect = [[UIButton alloc] initWithFrame:viewBG.frame];
        [btnSelect addTarget:self action:@selector(touchUpSelect:) forControlEvents:UIControlEventTouchUpInside];
        btnSelect.backgroundColor = [UIColor clearColor];
        btnSelect.tag = 1200 + i;
        [_viewSelectBG addSubview:btnSelect];
        
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 20)];
        lblTitle.font = [UIFont systemFontOfSize:18];
        lblTitle.text = [_arrayData objectAtIndex:i];
        lblTitle.backgroundColor = [UIColor clearColor];
        [viewBG addSubview:lblTitle];
        
        UIImageView *imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 23 / 2.0 - 10, 0, 23 / 2.0, 13 / 2.0)];
        imgArrow.image = [UIImage imageWithBundleName:@"pullDownArrow.png"];
        imgArrow.center = CGPointMake(imgArrow.center.x, lblTitle.center.y);
        [viewBG addSubview:imgArrow];
        imgArrow.transform = CGAffineTransformMakeRotation(-M_PI / 2.0);
        
        UIImageView *ImgLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 1 / 2.0)];
        ImgLine.image = [UIImage imageWithBundleName:@"allLine.png"];
        [viewBG addSubview:ImgLine];
    }
}

#pragma mark - 点击上面的head Bar
- (void)touchUpPull:(UIButton *)sender
{
    int index = _selectedIndex;
    [_viewSelectBG removeFromSuperview];
    _viewSelectBG = nil;
    if (_selectedIndex < 3)
    {
        index = (int)sender.tag - 1000;
    }
    else
    {
        index = (int)sender.tag - 1000 + 3;
    }
    [self createPullView:index];
    _selectedIndex = index;
}

- (void)touchUpSelect:(UIButton *)sender
{
    NSInteger index = sender.tag - 1200;
    if ([self.delegate respondsToSelector:@selector(PullDownViewDidSelectAtIndex:)])
        [self.delegate PullDownViewDidSelectAtIndex:index];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
