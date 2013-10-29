//
//  WelcomeViewController.m
//  Tutor
//
//  Created by hank on 13-10-28.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "WelcomeViewController.h"
#import "UIImage+NSBundle.h"
#import "LoginViewController.h"
#import "CustomTabBarViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

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
    
    UIImageView *imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 168 / 2.0, 168 / 2.0)];
    imgLogo.image = [UIImage imageWithBundleName:@"imgLogo.png"];
    imgLogo.center = CGPointMake(self.view.center.x, self.view.center.y - 80);
    [self.view addSubview:imgLogo];
    
    UILabel *lblInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, imgLogo.frame.origin.y + imgLogo.frame.size.height + 10, 200, 20)];
    lblInfo.text = @"欢迎使用家教宝";
    lblInfo.textAlignment = NSTextAlignmentCenter;
    lblInfo.textColor = [UIColor blackColor];
    lblInfo.center = CGPointMake(self.view.center.x, lblInfo.center.y);
    lblInfo.font = [UIFont systemFontOfSize:20];
    lblInfo.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblInfo];
    
    UIButton *btnFindTutor = [[UIButton alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT - 89 / 2.0 - 135 / 2.0, 290 / 2.0, 89 / 2.0)];
    [btnFindTutor setImage:[UIImage imageWithBundleName:@"btnFindtutor.png"] forState:UIControlStateNormal];
    [btnFindTutor addTarget:self action:@selector(touchUpFindTutor:) forControlEvents:UIControlEventTouchUpInside];
    btnFindTutor.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btnFindTutor];
    
    UIButton *btnDoTutor = [[UIButton alloc] initWithFrame:CGRectMake(20 + 290 / 2.0, SCREEN_HEIGHT - 89 / 2.0 - 135 / 2.0, 290 / 2.0, 89 / 2.0)];
    [btnDoTutor setImage:[UIImage imageWithBundleName:@"btnDotutor.png"] forState:UIControlStateNormal];
    [btnDoTutor addTarget:self action:@selector(touchUpDoTutor:) forControlEvents:UIControlEventTouchUpInside];
    btnDoTutor.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btnDoTutor];
}

- (void)touchUpFindTutor:(UIButton *)sender
{
    CustomTabBarViewController *custTabBarViewCol = [[CustomTabBarViewController alloc] init];
    [self.navigationController pushViewController:custTabBarViewCol animated:YES];
}

- (void)touchUpDoTutor:(UIButton *)sender
{
    LoginViewController *loginViewCol = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginViewCol animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
