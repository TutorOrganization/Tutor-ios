//
//  DetailViewController.m
//  Tutor
//
//  Created by hank on 13-11-3.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    [self addLeftButton:@"back.png"];
    [self setBarTitle:@"黄小雨"];
    
    UILabel *lblBack = [[UILabel alloc] initWithFrame:CGRectMake(_imgLeft.frame.origin.x + _imgLeft.frame.size.width + 5, _imgLeft.frame.origin.y, 40, 20)];
    lblBack.font = [UIFont systemFontOfSize:18];
    lblBack.textColor = [UIColor whiteColor];
    lblBack.text = @"首页";
    lblBack.backgroundColor = [UIColor clearColor];
    [_topView addSubview:lblBack];
    
    UILabel *lblCollect = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50, _imgLeft.frame.origin.y, 40, 20)];
    lblCollect.font = [UIFont systemFontOfSize:18];
    lblCollect.textColor = [UIColor whiteColor];
    lblCollect.text = @"收藏";
    lblCollect.center = CGPointMake(lblCollect.center.x, lblBack.center.y);
    lblCollect.backgroundColor = [UIColor clearColor];
    [_topView addSubview:lblCollect];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 10 + _orginY + NavigationBar_HEIGHT, SCREEN_WIDTH - 40, 30)];
    lblTitle.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
    lblTitle.text = @"辅导中小学语文和数学";
    lblTitle.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblTitle];
    
    UILabel *lblSubject = [[UILabel alloc] initWithFrame:CGRectMake(20, lblTitle.frame.origin.y + lblTitle.frame.size.height + 10, 42, 20)];
    lblSubject.font = [UIFont systemFontOfSize:14];
    lblSubject.text = @"科目：";
    lblSubject.textColor = [UIColor colorWithRed:87 / 255.0 green:87 / 255.0 blue:87 / 255.0 alpha:1.0];
    lblSubject.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblSubject];
    
    UILabel *lblSubjectContent = [[UILabel alloc] initWithFrame:CGRectMake(lblSubject.frame.origin.x + lblSubject.frame.size.width, lblSubject.frame.origin.y, SCREEN_WIDTH - (lblSubject.frame.origin.x + lblSubject.frame.size.width + 10), 20)];
    lblSubjectContent.textColor = [UIColor colorWithRed:87 / 255.0 green:87 / 255.0 blue:87 / 255.0 alpha:1.0];
    lblSubjectContent.font = [UIFont systemFontOfSize:14];
    lblSubjectContent.text = @"生物   化学    数学    物理";
    lblSubjectContent.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblSubjectContent];
    
    UILabel *lblGrade = [[UILabel alloc] initWithFrame:CGRectMake(20, lblSubject.frame.origin.y + lblSubject.frame.size.height + 10, 42, 20)];
    lblGrade.font = [UIFont systemFontOfSize:14];
    lblGrade.text = @"年级：";
    lblGrade.textColor = [UIColor colorWithRed:87 / 255.0 green:87 / 255.0 blue:87 / 255.0 alpha:1.0];
    lblGrade.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblGrade];
    
    UILabel *lblGradeContent = [[UILabel alloc] initWithFrame:CGRectMake(lblGrade.frame.origin.x + lblGrade.frame.size.width, lblGrade.frame.origin.y, SCREEN_WIDTH - (lblGrade.frame.origin.x + lblGrade.frame.size.width + 10), 20)];
    lblGradeContent.font = [UIFont systemFontOfSize:14];
    lblGradeContent.text = @"小学/初中/高中";
    lblGradeContent.textColor = [UIColor colorWithRed:87 / 255.0 green:87 / 255.0 blue:87 / 255.0 alpha:1.0];
    lblGradeContent.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblGradeContent];
    
    UILabel *lblPrice = [[UILabel alloc] initWithFrame:CGRectMake(20, lblGrade.frame.origin.y + lblGrade.frame.size.height + 10, 42, 20)];
    lblPrice.font = [UIFont systemFontOfSize:14];
    lblPrice.text = @"价格：";
    lblPrice.textColor = [UIColor colorWithRed:87 / 255.0 green:87 / 255.0 blue:87 / 255.0 alpha:1.0];
    lblPrice.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblPrice];
    
    UILabel *lblPriceContent = [[UILabel alloc] initWithFrame:CGRectMake(lblPrice.frame.origin.x + lblPrice.frame.size.width, lblPrice.frame.origin.y, SCREEN_WIDTH - (lblPrice.frame.origin.x + lblPrice.frame.size.width + 10), 20)];
    lblPriceContent.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
    lblPriceContent.text = @"60元/小时";
    lblPriceContent.textColor = [UIColor colorWithRed:255 / 255.0 green:113 / 255.0 blue:37 / 255.0 alpha:1.0];
    lblPriceContent.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblPriceContent];

}

- (void)clickLeftButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickRightButton:(UIButton *)sender
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
