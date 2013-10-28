//
//  PublicViewController.m
//  Tutor
//
//  Created by hank on 13-10-28.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "PublicViewController.h"

@interface PublicViewController ()

@end

@implementation PublicViewController

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
    [self setBarTitle:@"发布信息"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
