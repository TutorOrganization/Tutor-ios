//
//  OrderViewController.m
//  Tutor
//
//  Created by hank on 13-10-28.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderCell.h"

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
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44+ _orginY, SCREEN_WIDTH, self.view.frame.size.height - TabBar_HEIGHT - (44+ _orginY))];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = BACKGROUND_COLOR;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _marrayDatasource = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
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
                               @"OrderStatus":@"已完成",
                               @"Star":@"0.5"};
        NSDictionary *dic2 = @{@"ClassName":@"电子琴",
                               @"Time":@"2013年10月30日",
                               @"OrderType":@"par",
                               @"OrderStatus":@"已完成",
                               @"Star":@"1.5"};
        [_marrayDatasource addObject:dict];
        [_marrayDatasource addObject:dic2];
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
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdentifier];
    if (!cell) {
        cell = [[OrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strIdentifier];
    }
    
    cell.dictOrderInfo = [_marrayDatasource objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

#pragma mark - UITableview delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
