//
//  CustomTabBarViewController.m
//  Blinq
//
//  Created by Sugar on 13-8-12.
//  Copyright (c) 2013年 Sugar Hou. All rights reserved.
//

#import "CustomTabBarViewController.h"
#import "CommenDef.h"
#import "Toolkit.h"
#import "UIImage+NSBundle.h"



#define tabBarButtonNum 5

@interface CustomTabBarViewController ()
{
    NSArray *_arrayImages;
    UIButton *_btnSelected;
    UIView *_tabBarBG;
}
@end

@implementation CustomTabBarViewController

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
    //隐藏系统tabbar
    self.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
//    NSArray *arrayImages = [[NSArray alloc] initWithObjects:localUI(kBtnHome) , localUI(kBtnCertifite), localUI(kBtnTask), localUI(kBtnChat), localUI(kBtnAboutMe), nil];
//	NSArray *arrayImages_H = [[NSArray alloc] initWithObjects:localUI(kBtnHome_H) , localUI(kBtnCertifite_H), localUI(kBtnTask_H), localUI(kBtnChat_H), localUI(kBtnAboutMe_H), nil];
    _tabBarBG = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - TabBar_HEIGHT, SCREEN_WIDTH, TabBar_HEIGHT)];
    _tabBarBG.backgroundColor = [UIColor colorWithRed:88 / 255.0 green:86 / 255.0 blue:87 / 255.0 alpha:1.0f];
    [self.view addSubview:_tabBarBG];
    
    //自定义tabbar的按钮和图片
	
//    int tabBarWitdh = SCREEN_WIDTH * 1.0f / tabBarButtonNum;
//	for(int i = 0; i < tabBarButtonNum; i++)
//	{
//		CGRect frame=CGRectMake(i * tabBarWitdh, 0, tabBarWitdh, 49);
//    
//		UIButton * btnTabBar = [[UIButton alloc] initWithFrame:frame];
//		[btnTabBar setImage: [UIImage imageWithBundleName:[arrayImages objectAtIndex:i]] forState:UIControlStateNormal];
//        [btnTabBar setImage:[UIImage imageWithBundleName:[arrayImages_H objectAtIndex:i]] forState:UIControlStateSelected];
//		btnTabBar.tag = i + 1000;
//		[btnTabBar addTarget:self action:@selector(onTabButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//		[_tabBarBG addSubview:btnTabBar];
//	}
//    
    //首页
//    HomeViewController *homePageViewController = [[HomeViewController alloc] init];
//    if ([Toolkit isSystemIOS7])
//        homePageViewController.automaticallyAdjustsScrollViewInsets = NO;
//    UINavigationController *homePageNavigation =[[UINavigationController alloc]initWithRootViewController:homePageViewController];
////    homePageNavigation.automaticallyAdjustsScrollViewInsets = YES;
//    homePageViewController.hidesBottomBarWhenPushed = YES;
//    homePageNavigation.navigationBar.hidden=YES;
//    
//    //邀请好友
//    CertifiedViewController *certifiedViewController = [[CertifiedViewController alloc] init];
//    UINavigationController *certifiedNavigation = [[UINavigationController alloc] initWithRootViewController:certifiedViewController];
//    certifiedViewController.hidesBottomBarWhenPushed = YES;
//    certifiedNavigation.navigationBarHidden=YES;
//
//    //加入到真正的tabbar
//    self.viewControllers=[NSArray arrayWithObjects:homePageNavigation,certifiedNavigation, nil];
    
    UIButton *btnSender = (UIButton *)[self.view viewWithTag:0 + 1000];
    [self onTabButtonPressed:btnSender];
}
//点击tab页时的响应
-(void)onTabButtonPressed:(UIButton *)sender
{
    if (_btnSelected == sender)
        return ;
    
    if (_btnSelected)
        _btnSelected.selected = !_btnSelected.selected;
    
    sender.selected = !sender.selected;
    _btnSelected = sender;
    [self setSelectedIndex:sender.tag - 1000];
}

- (void)selectTableBarIndex:(NSInteger)index
{
    if (index < 0 || index > 5)
        return ;
    UIButton *btnSender = (UIButton *)[self.view viewWithTag:index + 1000];
    [self onTabButtonPressed:btnSender];
}

//隐藏tabbar
- (void)hideCustomTabBar
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	_tabBarBG.frame=CGRectMake(0, SCREEN_HEIGHT, 320, _tabBarBG.frame.size.height);
	[UIView commitAnimations];
	
}
//显示tabbar
-(void)showTabBar
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	_tabBarBG.frame=CGRectMake(0, SCREEN_HEIGHT - TabBar_HEIGHT, SCREEN_WIDTH, _tabBarBG.frame.size.height);
	[UIView commitAnimations];
}

- (void)goToHomePage
{
    [self setSelectedIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
