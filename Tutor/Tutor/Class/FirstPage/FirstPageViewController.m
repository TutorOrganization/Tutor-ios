//
//  FirstPageViewController.m
//  Tutor
//
//  Created by hank on 13-10-28.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "FirstPageViewController.h"
#import "Toolkit.h"

@interface FirstPageViewController ()
{
    int _orginY;
}
@end

@implementation FirstPageViewController

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
    
    UILabel *lblCityName = [[UILabel alloc] initWithFrame:CGRectMake(5, _topView.frame.size.height - 20 - 10, 60, 20)];
    lblCityName.font = [UIFont systemFontOfSize:20];
    lblCityName.text = @"上海";
    lblCityName.textColor = [UIColor whiteColor];
    lblCityName.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblCityName];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
