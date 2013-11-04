//
//  MoreViewController.m
//  Tutor
//
//  Created by hank on 13-10-28.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

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
    [self setBarTitle:@"更多"];
    
    UITableView *tablview = [[UITableView alloc] initWithFrame:CGRectMake(10, _orginY + 44 + 10, 300, self.view.frame.size.height - (_orginY + 44 + 80)) style:UITableViewStyleGrouped];
    tablview.delegate = self;
    tablview.dataSource = self;
    tablview.showsVerticalScrollIndicator = NO;
    tablview.backgroundColor = BACKGROUND_COLOR;
    tablview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tablview];
    
    UIButton *btnInvit = [[UIButton alloc] initWithFrame:CGRectMake(10, tablview.frame.origin.y + tablview.frame.size.height + 20, 300, 44)];
    [btnInvit setBackgroundImage:[UIImage imageWithBundleName:@"btn_invit@2x.png"] forState:UIControlStateNormal];
    tablview.tableFooterView = btnInvit;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1){
        return 4;
    } else  {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
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
            strTitle = @"切换城市";
            strImageName = @"table_cell_top@2x.png";
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            strTitle = @"帮助";
            strImageName = @"table_cell_top@2x.png";
        } else if (indexPath.row == 1) {
            strTitle = @"意见反馈";
            strImageName = @"table_cell_middle@2x.png";
        } else if (indexPath.row == 2) {
            strTitle = @"检测更新";
            strImageName = @"table_cell_middle@2x.png";
        } else if (indexPath.row == 3) {
            strTitle = @"分享";
            strImageName = @"table_cell_middle@2x.png";
        } else if (indexPath.row == 4) {
            strTitle = @"给个评分";
            strImageName = @"table_cell_middle@2x.png";
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            strTitle = @"关于我们";
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
    return 10;
}
@end
