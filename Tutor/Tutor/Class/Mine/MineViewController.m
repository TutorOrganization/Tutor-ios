//
//  MineViewController.m
//  Tutor
//
//  Created by hank on 13-10-28.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

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
    [self setBarTitle:@"我"];
    
    UITableView *tablview = [[UITableView alloc] initWithFrame:CGRectMake(10, _orginY + 44 + 20, 300, 250) style:UITableViewStyleGrouped];
    tablview.delegate = self;
    tablview.dataSource = self;
    tablview.showsVerticalScrollIndicator = NO;
    tablview.backgroundColor = BACKGROUND_COLOR;
    tablview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tablview];
    
    UIButton *btnInvit = [[UIButton alloc] initWithFrame:CGRectMake(10, tablview.frame.origin.y + tablview.frame.size.height + 20, 300, 44)];
    [btnInvit setBackgroundImage:[UIImage imageWithBundleName:@"btn_invit@2x.png"] forState:UIControlStateNormal];
    [self.view addSubview:btnInvit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return 3;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *strIndentifier = @"me";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strIndentifier];
        
    }
    NSString *strTitle = nil;
    NSString *strImageName = nil;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            strTitle = @"最近联系人";
            strImageName = @"table_cell_top@2x.png";
        } else if (indexPath.row == 1) {
            strTitle = @"消息";
            strImageName = @"table_cell_bottom@2x.png";
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            strTitle = @"我的收藏";
            strImageName = @"table_cell_top@2x.png";
        } else if (indexPath.row == 1) {
            strTitle = @"我的教育宝帐号";
            strImageName = @"table_cell_middle@2x.png";
        } else if (indexPath.row == 2) {
            strTitle = @"个人信息";
            strImageName = @"table_cell_bottom@2x.png";
        }
    }
    
    cell.textLabel.text = strTitle;
    
    UIImageView *imgv =  [[UIImageView alloc] initWithImage:[UIImage imageWithBundleName:strImageName]];
    imgv.frame = CGRectMake(0, 0, 300, 45);
    cell.backgroundView = imgv;
    
    UIImageView *imgvac = [[UIImageView  alloc] initWithFrame:CGRectMake(200, 55, 9, 15)];
    imgvac.image = [UIImage imageNamed:@"icon_RightArrow@2x.png"];
    cell.accessoryView = imgvac;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        view.backgroundColor = BACKGROUND_COLOR;
        return view;
    } else {
        return nil;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

#pragma mark - UITableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
