//
//  BaseNavigationController.m
//  Blinq
//
//  Created by user on 13-9-2.
//  Copyright (c) 2013年 Sugar Hou. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UIImage+NSBundle.h"
#import "Toolkit.h"
#import "Consdef.h"

#define DefaultLeftImageWidth 44

@implementation BaseNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
 
    self.view.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0f];
    if ([Toolkit isSystemIOS7])
        _orginY = 20;
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _orginY + NavigationBar_HEIGHT)];
    _topView.backgroundColor = [UIColor colorWithRed:255 / 255.0f green:237 / 255.0f blue:68 / 255.0f alpha:1.0f];
    _topView.userInteractionEnabled = YES;
    _topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithBundleName:@"topbar.png"]];
    [self.view addSubview:_topView];
    
    _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftImageWidth, _orginY + 0, SCREEN_WIDTH - 2 * DefaultLeftImageWidth, NavigationBar_HEIGHT)];
    _lblTitle.backgroundColor = [UIColor clearColor];
    _lblTitle.adjustsFontSizeToFitWidth = YES;
    _lblTitle.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    _lblTitle.textColor = [UIColor whiteColor];
    _lblTitle.textAlignment = NSTextAlignmentCenter;
    _lblTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    _lblTitle.numberOfLines = 0;
    _lblTitle.center = _topView.center;
    [self.view addSubview:_lblTitle];
    
    _imgLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, _orginY, 60, NavigationBar_HEIGHT)];
    _imgLeft.backgroundColor = [UIColor clearColor];
    [_topView addSubview:_imgLeft];
    
    _btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, _orginY, 60, NavigationBar_HEIGHT)];
    [_btnLeft addTarget:self action:@selector(clickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    _btnLeft.backgroundColor = [UIColor clearColor];
    [_topView addSubview:_btnLeft];
    
    _imgRight = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60 - 20, _orginY, 60, NavigationBar_HEIGHT)];
    _imgRight.backgroundColor = [UIColor clearColor];
    [_topView addSubview:_imgRight];
    
    _btnRight = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, _orginY, 60, NavigationBar_HEIGHT)];
    _btnRight.backgroundColor = [UIColor clearColor];
    [_btnRight addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:_btnRight];
}

- (void)setBarTitle:(NSString *)strTitle
{
    _lblTitle.text = strTitle;
    _lblTitle.center = CGPointMake(self.view.center.x, NavigationBar_HEIGHT / 2.0 + _orginY);
}

- (void)setBarTitleColor:(UIColor *)color
{
    _lblTitle.textColor = color;
}

- (void)addLeftButton:(NSString *)strImage
{
    UIImage *imgBtn = [UIImage imageWithBundleName:strImage];
    _imgLeft.image = imgBtn;
    [_imgLeft setFrame:CGRectMake(_btnLeft.frame.origin.x, _btnLeft.frame.origin.y, imgBtn.size.width / 2.0, imgBtn.size.height / 2.0)];
    _imgLeft.center = CGPointMake(20, NavigationBar_HEIGHT / 2.0 + _orginY);
}

- (void)addRightButton:(NSString *)strImage
{
    UIImage *imgBtn = [UIImage imageWithBundleName:strImage];
    _imgRight.image = imgBtn;
    [_imgRight setFrame:CGRectMake(_btnRight.frame.origin.x, _btnRight.frame.origin.y, imgBtn.size.width / 2.0, imgBtn.size.height / 2.0)];
    _imgRight.center = CGPointMake(SCREEN_WIDTH - 30, NavigationBar_HEIGHT / 2.0 + _orginY);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#endif

- (void)clickLeftButton:(UIButton *)sender
{
    NSLog(@"left button click");
}

- (void)clickRightButton:(UIButton *)sender
{
    NSLog(@"right button click");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
}


@end
