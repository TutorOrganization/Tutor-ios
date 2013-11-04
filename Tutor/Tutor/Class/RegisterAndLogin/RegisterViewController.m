//
//  RegisterViewController.m
//  Tutor
//
//  Created by hank on 13-10-28.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "RegisterViewController.h"

#define kTextFiledUserName 100
#define kTextFiledUserPassWord 101
#define kTextFiledUserPassWordAffirm 102

#define kTextUserInfo @"请输入您的手机号码"
#define kTextPassWord @"请输入6-12个字符"

@interface RegisterViewController ()<UITextFieldDelegate>
{
    UIImageView *_imgCheck;
    BOOL _agreeUserProtocol;
}
@end

@implementation RegisterViewController

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
    
    [self setBarTitle:@"用户注册"];
    [self addLeftButton:@"btnBack.png"];
    self.view.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0f];

    UIImageView *declarationBG = [[UIImageView alloc] initWithFrame:CGRectMake(10, _orginY + NavigationBar_HEIGHT + 10, 600 / 2.0, 338 / 2.0)];
    declarationBG.center = CGPointMake(self.view.center.x, declarationBG.center.y);
    declarationBG.image = [UIImage imageWithBundleName:@"declarationBG.png"];
    [self.view addSubview:declarationBG];
    
    UIButton *btnCheck = [[UIButton alloc] initWithFrame:CGRectMake(0, declarationBG.frame.origin.y + declarationBG.frame.size.height + 10, SCREEN_WIDTH, 30)];
    btnCheck.backgroundColor = [UIColor clearColor];
//    [btnCheck setImage:[UIImage imageWithBundleName:@"check.png"] forState:UIControlStateNormal];
    [btnCheck addTarget:self action:@selector(checkDeclaration:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCheck];
    
    _imgCheck = [[UIImageView alloc] initWithFrame:CGRectMake(10, declarationBG.frame.origin.y + declarationBG.frame.size.height + 10, 16, 16)];
    _imgCheck.backgroundColor = [UIColor clearColor];
    _imgCheck.image = [UIImage imageWithBundleName:@"check.png"];
//    [btnCheck setImage:[UIImage imageWithBundleName:@"check.png"] forState:UIControlStateNormal];
//    [btnCheck addTarget:self action:@selector(checkDeclaration:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_imgCheck];
    
    UILabel *lblCheckInfo = [[UILabel alloc] initWithFrame:CGRectMake(_imgCheck.frame.origin.x + _imgCheck.frame.size.width + 10, _imgCheck.frame.origin.y, 150, 20)];
    lblCheckInfo.font = [UIFont systemFontOfSize:14];
    lblCheckInfo.text = @"《用户使用协议》";
    lblCheckInfo.center = CGPointMake(lblCheckInfo.center.x, _imgCheck.center.y);
    lblCheckInfo.textColor = [UIColor blackColor];
    lblCheckInfo.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblCheckInfo];
    
    UIImageView *imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(10, lblCheckInfo.frame.origin.y + lblCheckInfo.frame.size.height + 20, 600 / 2.0, 79 / 2.0)];
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
    textFieldUserName.font = [UIFont systemFontOfSize:14];
    textFieldUserName.placeholder = kTextUserInfo;
    textFieldUserName.tag = kTextFiledUserName;
    textFieldUserName.keyboardType = UIKeyboardTypeNumberPad;
    textFieldUserName.clearButtonMode = UITextFieldViewModeWhileEditing;
    textFieldUserName.center = CGPointMake(textFieldUserName.center.x, lblUserName.center.y);
    textFieldUserName.delegate = self;
    [imgUser addSubview:textFieldUserName];
    
    UIImageView *imgUserAffirmCode = [[UIImageView alloc] initWithFrame:CGRectMake(10, imgUser.frame.origin.y + imgUser.frame.size.height + 10, 370 / 2.0, 79 / 2.0)];
    imgUserAffirmCode.image = [UIImage imageWithBundleName:@"shortCellAffirm.png"];
//    imgUserAffirmCode.center = CGPointMake(self.view.center.x, imgUserAffirmCode.center.y);
    imgUserAffirmCode.userInteractionEnabled = YES;
    [self.view addSubview:imgUserAffirmCode];
    
//    UILabel *lblUserPassWord = [[UILabel alloc] initWithFrame:CGRectMake(10, (79 / 2.0 - 20) / 2.0, 50, 20)];
//    lblUserPassWord.backgroundColor = [UIColor clearColor];
//    lblUserPassWord.text = @"密码：";
//    lblUserPassWord.font = [UIFont systemFontOfSize:14];
//    [imgUserPassWord addSubview:lblUserPassWord];
    
    UITextField *textFieldAffirmCode = [[UITextField alloc] initWithFrame:CGRectMake(20, imgUser.frame.origin.y + imgUser.frame.size.height + 10, 370 / 2.0 - 20, 79 / 2.0)];
    textFieldAffirmCode.font = [UIFont systemFontOfSize:14];
    textFieldAffirmCode.tag = kTextFiledUserPassWord;
    textFieldAffirmCode.secureTextEntry = YES;
    textFieldAffirmCode.clearButtonMode = UITextFieldViewModeWhileEditing;
//    textFieldAffirmCode.center = imgUserAffirmCode.center;
    textFieldAffirmCode.delegate = self;
    textFieldAffirmCode.backgroundColor = [UIColor clearColor];
    textFieldAffirmCode.placeholder = kTextPassWord;
    [self.view addSubview:textFieldAffirmCode];
    
    UIButton *btnGetAffirmCode = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 10 - 210 / 2.0, imgUserAffirmCode.frame.origin.y, 210 / 2.0, 79 / 2.0)];
    [btnGetAffirmCode addTarget:self action:@selector(getAffirmCode:) forControlEvents:UIControlEventTouchUpInside];
    [btnGetAffirmCode setImage:[UIImage imageWithBundleName:@"btnAffirmCode.png"] forState:UIControlStateNormal];
    btnGetAffirmCode.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btnGetAffirmCode];
    
    UIImageView *imgUserPassWordAffirm = [[UIImageView alloc] initWithFrame:CGRectMake(0, imgUserAffirmCode.frame.origin.y + imgUserAffirmCode.frame.size.height + 10, 600 / 2.0, 79 / 2.0)];
    imgUserPassWordAffirm.image = [UIImage imageWithBundleName:@"loginInputView.png"];
    imgUserPassWordAffirm.center = CGPointMake(self.view.center.x, imgUserPassWordAffirm.center.y);
    imgUserPassWordAffirm.userInteractionEnabled = YES;
    [self.view addSubview:imgUserPassWordAffirm];
    
    UILabel *lblUserPassWordAffirm = [[UILabel alloc] initWithFrame:CGRectMake(10, (79 / 2.0 - 20) / 2.0, 80, 20)];
    lblUserPassWordAffirm.backgroundColor = [UIColor clearColor];
    lblUserPassWordAffirm.text = @"密码：";
    lblUserPassWordAffirm.font = [UIFont systemFontOfSize:14];
    [imgUserPassWordAffirm addSubview:lblUserPassWordAffirm];
    
    UITextField *textFieldUserPassWordAffirm = [[UITextField alloc] initWithFrame:CGRectMake(lblUserPassWordAffirm.frame.origin.x + lblUserPassWordAffirm.frame.size.width + 10, 0, imgUserPassWordAffirm.frame.size.width - lblUserPassWordAffirm.frame.origin.x - lblUserPassWordAffirm.frame.size.width - 10, 20)];
    textFieldUserPassWordAffirm.font = [UIFont systemFontOfSize:14];
    textFieldUserPassWordAffirm.tag = kTextFiledUserPassWordAffirm;
    textFieldUserPassWordAffirm.secureTextEntry = YES;
    textFieldUserPassWordAffirm.clearButtonMode = UITextFieldViewModeWhileEditing;
    textFieldUserPassWordAffirm.center = CGPointMake(textFieldUserPassWordAffirm.center.x, lblUserPassWordAffirm.center.y);
    textFieldUserPassWordAffirm.delegate = self;
    textFieldUserPassWordAffirm.backgroundColor = [UIColor clearColor];
    textFieldUserPassWordAffirm.placeholder = kTextPassWord;
    [imgUserPassWordAffirm addSubview:textFieldUserPassWordAffirm];
    
    UIButton *btnRegister = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 69 / 2.0 - 20 - _orginY, 600 / 2.0, 69 / 2.0)];
    [btnRegister addTarget:self action:@selector(touchUpRegister:) forControlEvents:UIControlEventTouchUpOutside];
    [btnRegister setImage:[UIImage imageWithBundleName:@"btnRegister.png"] forState:UIControlStateNormal];
    btnRegister.backgroundColor = [UIColor clearColor];
    btnRegister.center = CGPointMake(self.view.center.x, btnRegister.center.y);
    [self.view addSubview:btnRegister];
}

- (void)checkDeclaration:(UIButton *)sender
{
    _agreeUserProtocol = !_agreeUserProtocol;
    if (_agreeUserProtocol)
        _imgCheck.backgroundColor = [UIColor blackColor];
    else
        _imgCheck.backgroundColor = [UIColor clearColor];
}

#pragma mark - 点击注册
- (void)touchUpRegister:(UIButton *)sender
{

}

#pragma mark - 获取验证码
- (void)getAffirmCode:(UIButton *)sender
{

}

#pragma UITextFile
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == kTextFiledUserPassWord || textField.tag == kTextFiledUserPassWordAffirm)
    {
        return range.location < 12;
    }
    
    return YES;
}

- (void)resignKeyBoard
{
    [(UITextField *)[self.view viewWithTag:kTextFiledUserName] resignFirstResponder];
    [(UITextField *)[self.view viewWithTag:kTextFiledUserPassWord] resignFirstResponder];
    [(UITextField *)[self.view viewWithTag:kTextFiledUserPassWordAffirm] resignFirstResponder];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self resignKeyBoard];
}

- (void)clickLeftButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
