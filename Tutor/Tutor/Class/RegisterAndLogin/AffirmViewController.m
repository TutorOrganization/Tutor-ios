//
//  AffirmViewController.m
//  Tutor
//
//  Created by hank on 13-11-1.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "AffirmViewController.h"

#define kButtonTagOffset 1000

@interface AffirmViewController ()

@end

@implementation AffirmViewController

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
    [self setBarTitle:@"实名认证"];
    [self addLeftButton:@"btnBack.png"];
    self.view.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0f];
    
    NSArray *arrayPlaceHolder = @[@"请输入真实姓名", @"请输入身份证信息", @"毕业院校或者在读院校", @"请输入学位", @"请输入专业"];
    int lineRowNum = 0;
    UIImageView *inputViewBG = nil;
    if (self.affirmUser == StudentAffirm)
    {
        lineRowNum = 4;
        inputViewBG = [[UIImageView alloc] initWithFrame:CGRectMake(10, _orginY + NavigationBar_HEIGHT + 10, SCREEN_WIDTH - 20, 439 / 2.0)];
        inputViewBG.image = [UIImage imageWithBundleName:@"backGroundAffirmBig.png"];
        inputViewBG.userInteractionEnabled = YES;
        [self.view addSubview:inputViewBG];
    }
    else if (self.affirmUser == ParentsAffirm)
    {
        lineRowNum = 2;
        inputViewBG = [[UIImageView alloc] initWithFrame:CGRectMake(10, _orginY + NavigationBar_HEIGHT + 10, SCREEN_WIDTH - 20, 179 / 2.0)];
        inputViewBG.image = [UIImage imageWithBundleName:@"backGroundAffirmBig.png"];
        inputViewBG.userInteractionEnabled = YES;
        [self.view addSubview:inputViewBG];
    }
    
    UITextField *textField = nil;
    UIImageView *imgViewLine = nil;
    for (int i = 0; i < lineRowNum; i++)
    {
        imgViewLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 90 / 2.0 * (i + 1), inputViewBG.frame.size.width, 1)];
        imgViewLine.image = [UIImage imageWithBundleName:@"cellLineAffirm.png"];
        [inputViewBG addSubview:imgViewLine];
        
        textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 90 / 2.0 * i, 200, 90 / 2.0)];
        textField.font = [UIFont systemFontOfSize:14];
        textField.textColor = [UIColor blackColor];
        textField.tag = kButtonTagOffset + i;
        textField.placeholder = [arrayPlaceHolder objectAtIndex:i];
        textField.backgroundColor = [UIColor clearColor];
        [inputViewBG addSubview:textField];
    }
    
    if (self.affirmUser == StudentAffirm)
    {
        textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 90 / 2.0 * lineRowNum, 200, 90 / 2.0)];
        textField.font = [UIFont systemFontOfSize:14];
        textField.textColor = [UIColor blackColor];
        textField.tag = lineRowNum + kButtonTagOffset;
        textField.placeholder = [arrayPlaceHolder objectAtIndex:lineRowNum];
        textField.backgroundColor = [UIColor clearColor];
        [inputViewBG addSubview:textField];
    }
    
    UIButton *btnAffirmInfo = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 10 - 174 / 2.0, inputViewBG.frame.origin.y + 90 / 2.0, 174 / 2, 90 / 2.0)];
    [btnAffirmInfo addTarget:self action:@selector(touchUpAffirmInfo:) forControlEvents:UIControlEventTouchUpInside];
    [btnAffirmInfo setImage:[UIImage imageWithBundleName:@"btnAffirmInfo.png"] forState:UIControlStateNormal];
    btnAffirmInfo.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btnAffirmInfo];
    
    UIImageView *documentAffirmBG = [[UIImageView alloc] initWithFrame:CGRectMake(10, inputViewBG.frame.origin.y + inputViewBG.frame.size.height + 10 + _orginY, 600 / 2.0, 139 / 2.0)];
    documentAffirmBG.image = [UIImage imageWithBundleName:@"documentAffirmBG.png"];
    documentAffirmBG.userInteractionEnabled = YES;
    [self.view addSubview:documentAffirmBG];
    
    UIButton *btnUploadPhoto = [[UIButton alloc] initWithFrame:documentAffirmBG.frame];
    [btnUploadPhoto addTarget:self action:@selector(touchUpUpLoadPhoto:) forControlEvents:UIControlEventTouchUpInside];
    btnUploadPhoto.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btnUploadPhoto];
    
    UIImageView *demoPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(10, documentAffirmBG.frame.size.height / 2.0 - 103 / 4, 133 / 2.0, 103 / 2.0)];
    demoPhoto.image = [UIImage imageWithBundleName:@"demoPerCard.png"];
    demoPhoto.userInteractionEnabled = YES;
    [documentAffirmBG addSubview:demoPhoto];
    
    UILabel *lblPersonCardText = [[UILabel alloc] initWithFrame:CGRectMake(demoPhoto.frame.origin.x + demoPhoto.frame.size.width + 10, demoPhoto.frame.origin.y, documentAffirmBG.frame.size.width - 20 - (demoPhoto.frame.origin.x + demoPhoto.frame.size.width + 10), 20)];
    lblPersonCardText.text = @"上传手持证件照片";
    lblPersonCardText.textAlignment = NSTextAlignmentCenter;
    lblPersonCardText.textColor = [UIColor colorWithRed:204 / 255.0 green:204 / 255.0 blue:204 / 255.0 alpha:1.0f];
    lblPersonCardText.font = [UIFont systemFontOfSize:14];
    lblPersonCardText.center = CGPointMake(lblPersonCardText.center.x, demoPhoto.center.y);
    lblPersonCardText.backgroundColor = [UIColor clearColor];
    [documentAffirmBG addSubview:lblPersonCardText];

    UIImageView *arrowImg = [[UIImageView alloc] initWithFrame:CGRectMake(documentAffirmBG.frame.size.width - 20, demoPhoto.frame.origin.y, 10, 32 / 2.0)];
    arrowImg.image = [UIImage imageWithBundleName:@"btnRightArrow.png"];
    arrowImg.center = CGPointMake(arrowImg.center.x, demoPhoto.center.y);
    [documentAffirmBG addSubview:arrowImg];
    
    UIButton *btnFinish = [[UIButton alloc] initWithFrame:CGRectMake(0, documentAffirmBG.frame.origin.y + documentAffirmBG.frame.size.height + 20 + _orginY * 2, 600 / 2.0, 69 / 2.0)];
    [btnFinish addTarget:self action:@selector(touchUpFinish:) forControlEvents:UIControlEventTouchUpInside];
    btnFinish.center = CGPointMake(self.view.center.x, btnFinish.center.y);
    [btnFinish setImage:[UIImage imageWithBundleName:@"btnFinish.png"] forState:UIControlStateNormal];
    btnFinish.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btnFinish];
}

- (void)resignKeyboard
{
    UITextField *textField = nil;
    for (int i = 0; i < 5; i++)
    {
        textField = (UITextField *)[self.view viewWithTag:kButtonTagOffset + i];
        [textField resignFirstResponder];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self resignKeyboard];
}

- (void)touchUpAffirmInfo:(UIButton *)sender
{

}

- (void)touchUpUpLoadPhoto:(UIButton *)sender
{

}

- (void)touchUpFinish:(UIButton *)sender
{

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
