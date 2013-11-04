//
//  RegisterAndLoginViewController.m
//  Tutor
//
//  Created by hank on 13-10-28.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "LoginViewController.h"
#import "AffirmViewController.h"
#import "RegisterViewController.h"

#define kTextFiledUserName 100
#define kTextFiledUserPassWord 101

#define kTextUserInfo @"请输入您的账号"
#define kTextPassWord @"请输入6-12个字符"

@interface LoginViewController ()<UITextFieldDelegate>

@end

@implementation LoginViewController

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
    
    [self setBarTitle:@"用户登录"];
    [self addLeftButton:@"btnBack.png"];
    self.view.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0f];
    
    UIImageView *imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(0, _orginY + NavigationBar_HEIGHT + 20, 600 / 2.0, 79 / 2.0)];
    imgUser.image = [UIImage imageWithBundleName:@"loginInputView.png"];
    imgUser.center = CGPointMake(self.view.center.x, imgUser.center.y);
    imgUser.userInteractionEnabled = YES;
    [self.view addSubview:imgUser];
    
    UILabel *lblUserName = [[UILabel alloc] initWithFrame:CGRectMake(10, (79 / 2.0 - 20) / 2.0, 50, 20)];
    lblUserName.backgroundColor = [UIColor clearColor];
    lblUserName.text = @"账号：";
    lblUserName.font = [UIFont systemFontOfSize:14];
    [imgUser addSubview:lblUserName];
    
    UITextField *textFieldUserName = [[UITextField alloc] initWithFrame:CGRectMake(lblUserName.frame.origin.x + lblUserName.frame.size.width + 10, 0, imgUser.frame.size.width - lblUserName.frame.origin.x - lblUserName.frame.size.width - 10, 20)];
    textFieldUserName.placeholder = kTextUserInfo;
    textFieldUserName.tag = kTextFiledUserName;
    textFieldUserName.clearButtonMode = UITextFieldViewModeWhileEditing;
    textFieldUserName.center = CGPointMake(textFieldUserName.center.x, lblUserName.center.y);
    textFieldUserName.delegate = self;
    [imgUser addSubview:textFieldUserName];
    
    UIImageView *imgUserPassWord = [[UIImageView alloc] initWithFrame:CGRectMake(0, _orginY + NavigationBar_HEIGHT + 30 + 79 / 2.0, 600 / 2.0, 79 / 2.0)];
    imgUserPassWord.image = [UIImage imageWithBundleName:@"loginInputView.png"];
    imgUserPassWord.center = CGPointMake(self.view.center.x, imgUserPassWord.center.y);
    imgUserPassWord.userInteractionEnabled = YES;
    [self.view addSubview:imgUserPassWord];
    
    UILabel *lblUserPassWord = [[UILabel alloc] initWithFrame:CGRectMake(10, (79 / 2.0 - 20) / 2.0, 50, 20)];
    lblUserPassWord.backgroundColor = [UIColor clearColor];
    lblUserPassWord.text = @"密码：";
    lblUserPassWord.font = [UIFont systemFontOfSize:14];
    [imgUserPassWord addSubview:lblUserPassWord];
    
    UITextField *textFieldUserPassWord = [[UITextField alloc] initWithFrame:CGRectMake(lblUserPassWord.frame.origin.x + lblUserPassWord.frame.size.width + 10, 0, imgUserPassWord.frame.size.width - lblUserPassWord.frame.origin.x - lblUserPassWord.frame.size.width - 10, 20)];
    textFieldUserPassWord.tag = kTextFiledUserPassWord;
    textFieldUserPassWord.secureTextEntry = YES;
    textFieldUserPassWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    textFieldUserPassWord.center = CGPointMake(textFieldUserName.center.x, lblUserPassWord.center.y);
    textFieldUserPassWord.delegate = self;
    textFieldUserPassWord.backgroundColor = [UIColor clearColor];
    textFieldUserPassWord.placeholder = kTextPassWord;
    [imgUserPassWord addSubview:textFieldUserPassWord];
    
    UILabel *lblforgetPassWord = [[UILabel alloc] initWithFrame:CGRectMake(imgUser.frame.origin.x + imgUser.frame.size.width - 80, imgUserPassWord.frame.origin.y + imgUserPassWord.frame.size.height + 10, 80, 20)];
    lblforgetPassWord.backgroundColor = [UIColor clearColor];
    lblforgetPassWord.text = @"忘记密码？";
    lblforgetPassWord.textColor = [UIColor colorWithRed:74 / 255.0 green:145 / 255.0 blue:200 / 255.0 alpha:1.0f];
    lblforgetPassWord.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:lblforgetPassWord];
    
    UIButton *btnForgetPassWord = [[UIButton alloc] initWithFrame:lblforgetPassWord.frame];
    [btnForgetPassWord addTarget:self action:@selector(touchUpForgetPassWord:) forControlEvents:UIControlEventTouchUpInside];
    btnForgetPassWord.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btnForgetPassWord];
    
    UIButton *btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(0, btnForgetPassWord.frame.origin.y + btnForgetPassWord.frame.size.height + 40, 600 / 2.0, 69 / 2.0)];
    [btnLogin setImage:[UIImage imageWithBundleName:@"btnLogin.png"] forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    btnLogin.center = CGPointMake(self.view.center.x, btnLogin.center.y);
    btnLogin.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btnLogin];
    
    UIButton *btnLookLook = [[UIButton alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT - 69 / 2.0 - 20 - 20 + _orginY, 290 / 2.0, 69 / 2.0)];
    [btnLookLook setImage:[UIImage imageWithBundleName:@"btnLook.png"] forState:UIControlStateNormal];
    [btnLookLook addTarget:self action:@selector(lookAround:) forControlEvents:UIControlEventTouchUpInside];
    btnLookLook.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btnLookLook];
    
    UIButton *btnNewUserRegister = [[UIButton alloc] initWithFrame:CGRectMake(20 + 290 / 2.0, SCREEN_HEIGHT - 69 / 2.0 - 20 - 20 + _orginY, 290 / 2.0, 69 / 2.0)];
    [btnNewUserRegister setImage:[UIImage imageWithBundleName:@"btnNewRegister.png"] forState:UIControlStateNormal];
    [btnNewUserRegister addTarget:self action:@selector(newUserRegister:) forControlEvents:UIControlEventTouchUpInside];
    btnNewUserRegister.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btnNewUserRegister];
}

- (void)resignKeyBoard
{
    [(UITextField *)[self.view viewWithTag:kTextFiledUserName] resignFirstResponder];
    [(UITextField *)[self.view viewWithTag:kTextFiledUserPassWord] resignFirstResponder];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self resignKeyBoard];
}

- (void)login:(UIButton *)sender
{
    NSLog(@"login");
    [self resignKeyBoard];
}

#pragma mark - 随便看看
- (void)lookAround:(UIButton *)sender
{
    [self resignKeyBoard];
    
    AffirmViewController *affirmViewCol = [[AffirmViewController alloc] init];
    affirmViewCol.affirmUser = ParentsAffirm;
    [self.navigationController pushViewController:affirmViewCol animated:YES];
}

- (void)newUserRegister:(UIButton *)sender
{
    [self resignKeyBoard];
    RegisterViewController *registerViewCol = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerViewCol animated:YES];
}

- (void)touchUpForgetPassWord:(UIButton *)sender
{
    NSLog(@"forget password");
    [self resignKeyBoard];
}

- (void)clickLeftButton:(UIButton *)sender
{
    [self resignKeyBoard];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == kTextFiledUserPassWord)
    {
        return range.location < 12;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
