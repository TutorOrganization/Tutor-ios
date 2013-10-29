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
#import "FirstPageViewController.h"
#import "MineViewController.h"
#import "MoreViewController.h"
#import "OrderViewController.h"
#import "PublicViewController.h"

#define tabBarButtonNum 5

@interface CustomTabBarViewController ()
{
    NSArray *_arrayImages;
    NSArray *_arrayImages_H;
    UIButton *_btnSelected;
    UIImageView *_tabBarBG;
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
    self.view.backgroundColor = [UIColor redColor];
    self.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    _arrayImages = [[NSArray alloc] initWithObjects:@"btnFirstPage.png", @"btnOrder.png", @"btnPublish.png", @"btnMine.png", @"btnMore.png", nil];
	_arrayImages_H = [[NSArray alloc] initWithObjects:@"btnFirstPageH.png", @"btnOderH.png", @"btnPublishH.png", @"btnMineH.png", @"btnMoreH.png", nil];
    _tabBarBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - TabBar_HEIGHT, SCREEN_WIDTH + 1, 99 / 2.0)];
    _tabBarBG.image = [UIImage imageWithBundleName:@"tabBarBG.png"];
    _tabBarBG.userInteractionEnabled = YES;
    [self.view addSubview:_tabBarBG];
    
    //自定义tabbar的按钮和图片
	UIImage *imgBtn = nil;
    UIImageView *imgTabBar = nil;
    int tabBarWitdh = SCREEN_WIDTH * 1.0f / tabBarButtonNum;
	for(int i = 0; i < tabBarButtonNum; i++)
	{
		CGRect frame=CGRectMake(i * tabBarWitdh, 0, tabBarWitdh, 49);
        imgBtn = [UIImage imageWithBundleName:[_arrayImages objectAtIndex:i]];
		UIButton * btnTabBar = [[UIButton alloc] initWithFrame:frame];
        imgTabBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgBtn.size.width / 2.0, imgBtn.size.height / 2.0)];
        imgTabBar.image = imgBtn;
        imgTabBar.tag = 2000 + i;
        [_tabBarBG addSubview:imgTabBar];
        imgTabBar.center = btnTabBar.center;
        btnTabBar.backgroundColor = [UIColor clearColor];
		btnTabBar.tag = i + 1000;
		[btnTabBar addTarget:self action:@selector(onTabButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[_tabBarBG addSubview:btnTabBar];
	}
    imgTabBar.center = CGPointMake(imgTabBar.center.x, imgTabBar.center.y + 6);
//
    //首页
    FirstPageViewController *firstPageViewCol = [[FirstPageViewController alloc] init];
    if ([Toolkit isSystemIOS7])
        firstPageViewCol.automaticallyAdjustsScrollViewInsets = NO;
    UINavigationController *firstPageNavigation =[[UINavigationController alloc]initWithRootViewController:firstPageViewCol];
    firstPageViewCol.hidesBottomBarWhenPushed = YES;
    firstPageNavigation.navigationBar.hidden=YES;
    
    OrderViewController *orderViewCol = [[OrderViewController alloc] init];
    UINavigationController *orderNavigation = [[UINavigationController alloc] initWithRootViewController:orderViewCol];
    orderViewCol.hidesBottomBarWhenPushed = YES;
    orderNavigation.navigationBarHidden=YES;
    
    PublicViewController *publicViewCol = [[PublicViewController alloc] init];
    if ([Toolkit isSystemIOS7])
        publicViewCol.automaticallyAdjustsScrollViewInsets = NO;
    UINavigationController *publishNavigation =[[UINavigationController alloc]initWithRootViewController:publicViewCol];
    publicViewCol.hidesBottomBarWhenPushed = YES;
    publishNavigation.navigationBar.hidden=YES;
    
    //邀请好友
    MineViewController *mineViewCol = [[MineViewController alloc] init];
    UINavigationController *mineNavigation = [[UINavigationController alloc] initWithRootViewController:mineViewCol];
    mineViewCol.hidesBottomBarWhenPushed = YES;
    mineNavigation.navigationBarHidden=YES;
    
    MoreViewController *moreViewCol = [[MoreViewController alloc] init];
    if ([Toolkit isSystemIOS7])
        moreViewCol.automaticallyAdjustsScrollViewInsets = NO;
    UINavigationController *moreNavigation =[[UINavigationController alloc]initWithRootViewController:moreViewCol];
    moreViewCol.hidesBottomBarWhenPushed = YES;
    moreNavigation.navigationBar.hidden=YES;
    
    //加入到真正的tabbar
    self.viewControllers=[NSArray arrayWithObjects:firstPageViewCol, orderViewCol, publicViewCol, mineViewCol, moreViewCol, nil];
    
    UIButton *btnSender = (UIButton *)[self.view viewWithTag:0 + 1000];
    [self onTabButtonPressed:btnSender];
}
//点击tab页时的响应
-(void)onTabButtonPressed:(UIButton *)sender
{
    if (_btnSelected == sender)
        return ;
    
    [(UIImageView *)[self.view viewWithTag:sender.tag - 1000 + 2000] setImage:[UIImage imageWithBundleName:[_arrayImages_H objectAtIndex:sender.tag - 1000]]]; //[_arrayImages_H objectAtIndex:sender.tag - 1000]];
    if (_btnSelected)
        [(UIImageView *)[self.view viewWithTag:_btnSelected.tag - 1000 + 2000] setImage:[UIImage imageWithBundleName:[_arrayImages objectAtIndex:_btnSelected.tag - 1000]]];
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
