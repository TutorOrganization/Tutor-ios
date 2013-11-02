//
//  OrderViewController.m
//  Tutor
//
//  Created by hank on 13-10-28.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "OrderViewController.h"

@interface OrderViewController ()

@end

@implementation OrderViewController

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
    [self setBarTitle:@"我的订单"];
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height - TabBar_HEIGHT)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = BACKGROUND_COLOR;
    [self.view addSubview:_tableView];
    
    [self getOrderList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getOrderList {
    for (int i = 0; i < 10; i++) {
        NSDictionary *dict = @{@"ClassName":@"数学 物理化学",
                               @"Time":@"2013年10月29日",
                               @"OrderType":@"teach",
                               @"OrderStatus":@"已完成"};
        [_marrayDatasource addObject:dict];
    }
    
    [_tableView reloadData];
}

#pragma mark - UITableview datasouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger intRow = [_marrayDatasource count];
    return intRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *strIdentifier = @"MyOrder";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIdentifier];
        
        
    }
    
    return cell;
}

@end
