//
//  FirstPageViewController.m
//  Tutor
//
//  Created by hank on 13-10-28.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "FirstPageViewController.h"
#import "Toolkit.h"
#import "CustomFristPageCell.h"
#import "PullDownView.h"
#import "MapViewController.h"
#import "CustomAlertSelectView.h"
#import "DetailViewController.h"

@interface FirstPageViewController ()<UITextFieldDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, PullDownViewDelegata, CustomAlertSelectViewDelegate>
{
    int _orginY;
    UIPageControl *_pageControl;
    UITableView *_tableViewTeacher;
    UITableView *_tableViewStudent;
    UIImageView *_imgFilterTeacher;
    UIImageView *_imgFilterStudent;
    UIScrollView *_scrollViewBG;
    PullDownView *_pullView;
    UITextField *_textField;
    CustomAlertSelectView *_alertSelectView;
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
    
    self.view.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0f];
    if ([Toolkit isSystemIOS7])
        _orginY = 20;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _orginY + NavigationBar_HEIGHT)];
    topView.backgroundColor = [UIColor colorWithRed:255 / 255.0f green:237 / 255.0f blue:68 / 255.0f alpha:1.0f];
    topView.userInteractionEnabled = YES;
    topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithBundleName:@"topbar.png"]];
    [self.view addSubview:topView];
    
    UILabel *lblCityName = [[UILabel alloc] initWithFrame:CGRectMake(5,  _orginY + 10, 40, 20)];
    lblCityName.font = [UIFont systemFontOfSize:20];
    lblCityName.tag = 9999;
    lblCityName.text = @"上海";
    lblCityName.textColor = [UIColor whiteColor];
    lblCityName.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lblCityName];
    
    UIImageView *arrowPull = [[UIImageView alloc] initWithFrame:CGRectMake(lblCityName.frame.origin.x + lblCityName.frame.size.width + 5, 0, 23 / 2.0, 13 / 2.0)];
    arrowPull.image = [UIImage imageWithBundleName:@"arrowPull.png"];
    arrowPull.center = CGPointMake(arrowPull.center.x, lblCityName.center.y);
    [self.view addSubview:arrowPull];
    
    UIButton *btnSelectCity = [[UIButton alloc] initWithFrame:CGRectMake(0, _orginY + 10, 60 + 23 / 2.0, NavigationBar_HEIGHT - 10)];
    [btnSelectCity addTarget:self action:@selector(touchUpChangeCity:) forControlEvents:UIControlEventTouchUpInside];
    btnSelectCity.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btnSelectCity];
    
    UIImageView *searchView = [[UIImageView alloc] initWithFrame:CGRectMake(75, _orginY + 10, 388 / 2.0, 51 / 2.0)];
    searchView.image = [UIImage imageWithBundleName:@"SearchBG.png"];
    searchView.userInteractionEnabled = YES;
    [self.view addSubview:searchView];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, searchView.frame.size.width - 30, searchView.frame.size.height)];
    _textField.delegate = self;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.returnKeyType = UIReturnKeySearch;
    [searchView addSubview:_textField];
    
    UIButton *btnMap = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 36 / 2.0 - 10, lblCityName.frame.origin.y, 36 / 2.0, 36 / 2.0)];
    [btnMap setImage:[UIImage imageWithBundleName:@"btnMap.png"] forState:UIControlStateNormal];
    [btnMap addTarget:self action:@selector(touchUpMap:) forControlEvents:UIControlEventTouchUpInside];
    btnMap.backgroundColor = [UIColor clearColor];
    btnMap.center = CGPointMake(btnMap.center.x, lblCityName.center.y);
    [self.view addSubview:btnMap];
    
    _scrollViewBG = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _orginY + NavigationBar_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - _orginY - NavigationBar_HEIGHT - TabBar_HEIGHT)];
    _scrollViewBG.tag = 100;
    _scrollViewBG.userInteractionEnabled = YES;
    _scrollViewBG.alwaysBounceHorizontal = YES;
    _scrollViewBG.showsHorizontalScrollIndicator = NO;
    _scrollViewBG.showsVerticalScrollIndicator = NO;
    _scrollViewBG.contentSize = CGSizeMake(SCREEN_WIDTH * 2, _scrollViewBG.frame.size.height);
    _scrollViewBG.pagingEnabled = YES;
    _scrollViewBG.delegate = self;
    [self.view addSubview:_scrollViewBG];
    
    _imgFilterTeacher = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 71 / 2.0)];
    _imgFilterTeacher.image = [UIImage imageWithBundleName:@"filterBGsmall.png"];
    _imgFilterTeacher.userInteractionEnabled = YES;
    [_scrollViewBG addSubview:_imgFilterTeacher];
    
    UILabel *lblFilter = nil;
    UIImageView *imgArrow = nil;
    NSArray *arrayTextTeacher = [[NSArray alloc] initWithObjects:@"价格", @"位置", @"年级" ,nil];
    NSArray *arrayTextStudent = [[NSArray alloc] initWithObjects:@"价格", @"年级", @"性别" ,@"评价", nil];
    for (int i = 0; i < 3; i++)
    {
        lblFilter = [[UILabel alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH / 3.0 + 30, 8, 30, 20)];
        lblFilter.font = [UIFont systemFontOfSize:14];
        lblFilter.text = [arrayTextTeacher objectAtIndex:i];
        lblFilter.backgroundColor = [UIColor clearColor];
        [_imgFilterTeacher addSubview:lblFilter];
        
        imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(lblFilter.frame.origin.x + lblFilter.frame.size.width + 5, 10, 23 / 2.0, 13 / 2.0)];
        imgArrow.image = [UIImage imageNamed:@"pullDownArrow.png"];
        imgArrow.center = CGPointMake(imgArrow.center.x, lblFilter.center.y);
        [_imgFilterTeacher addSubview:imgArrow];
        
        UIButton *btnClickPull = [[UIButton alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH / 3.0, 0, SCREEN_WIDTH / 3.0, _imgFilterTeacher.frame.size.height)];
        btnClickPull.backgroundColor = [UIColor clearColor];
        btnClickPull.tag = 1000 + i;
        [btnClickPull addTarget:self action:@selector(touchUpPull:) forControlEvents:UIControlEventTouchUpInside];
        [_imgFilterTeacher addSubview:btnClickPull];
    }
    
    _imgFilterStudent = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, 71 / 2.0)];
    _imgFilterStudent.image = [UIImage imageWithBundleName:@"filterBG.png"];
    _imgFilterStudent.userInteractionEnabled = YES;
    [_scrollViewBG addSubview:_imgFilterStudent];
    
    for (int i = 0; i < 4; i++)
    {
        lblFilter = [[UILabel alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH / 4.0 + 20, 8, 30, 20)];
        lblFilter.font = [UIFont systemFontOfSize:14];
        lblFilter.text = [arrayTextStudent objectAtIndex:i];
        lblFilter.backgroundColor = [UIColor clearColor];
        [_imgFilterStudent addSubview:lblFilter];
        
        imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(lblFilter.frame.origin.x + lblFilter.frame.size.width + 5, 10, 23 / 2.0, 13 / 2.0)];
        imgArrow.image = [UIImage imageNamed:@"pullDownArrow.png"];
        imgArrow.center = CGPointMake(imgArrow.center.x, lblFilter.center.y);
        [_imgFilterStudent addSubview:imgArrow];
        
        UIButton *btnClickPull = [[UIButton alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH / 4.0, 0, SCREEN_WIDTH / 4.0, _imgFilterStudent.frame.size.height)];
        btnClickPull.backgroundColor = [UIColor clearColor];
        btnClickPull.tag = 1000 + 3 + i;
        [btnClickPull addTarget:self action:@selector(touchUpPull:) forControlEvents:UIControlEventTouchUpInside];
        [_imgFilterStudent addSubview:btnClickPull];
    }
    
    _tableViewTeacher = [[UITableView alloc] initWithFrame:CGRectMake(0, 71/ 2.0, SCREEN_WIDTH, _scrollViewBG.frame.size.height - 71 / 2.0) style:UITableViewStylePlain];
    _tableViewTeacher.delegate = self;
    _tableViewTeacher.rowHeight = 100;
    _tableViewTeacher.dataSource = self;
    if ([Toolkit isSystemIOS7])
        _tableViewTeacher.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [_scrollViewBG addSubview:_tableViewTeacher];
    
    _tableViewStudent = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 71 / 2.0, SCREEN_WIDTH, _tableViewTeacher.frame.size.height) style:UITableViewStylePlain];
    _tableViewStudent.delegate = self;
    _tableViewStudent.rowHeight = 100;
    _tableViewStudent.dataSource = self;
    if ([Toolkit isSystemIOS7])
        _tableViewStudent.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [_scrollViewBG addSubview:_tableViewStudent];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - TabBar_HEIGHT - 30, 40, 20)];
    _pageControl.numberOfPages = 2;
    _pageControl.center = CGPointMake(self.view.center.x, _pageControl.center.y + 3);
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_pageControl];
    
//    FilterView *filterView = [[FilterView alloc] initWithFrame:CGRectMake(0, _orginY + NavigationBar_HEIGHT, SCREEN_WIDTH, 70 / 2.0)];
//    [self.view addSubview:filterView];
}

- (void)touchUpChangeCity:(UIButton *)sender
{
    _alertSelectView = [[CustomAlertSelectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) andTitle:@"城市选择"];
    _alertSelectView.delegate = self;
    [self.view addSubview:_alertSelectView];
}

- (void)touchUpMap:(UIButton *)sender
{
    MapViewController *mapViewCol = [[MapViewController alloc] init];
    [self.navigationController pushViewController:mapViewCol animated:YES];
}

- (void)touchUpPull:(UIButton *)sender
{
    int index = (int)sender.tag - 1000;
    _pullView = [[PullDownView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) andIndex:index];
    _pullView.delegate = self;
    [self.view addSubview:_pullView];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self cleanKeyBoard];
    if (scrollView.tag == 100)
    {
        _pageControl.currentPage = roundf(scrollView.contentOffset.x / scrollView.contentSize.width);
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"FirstPageReuseIdentifier";
    CustomFristPageCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[CustomFristPageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.headerView.image = [UIImage imageWithBundleName:@"btnBook.png"];
    cell.lblName.text = @"黄先生";
    cell.lblTitle.text = @"陆家嘴家教";
    cell.lblCost.text = @"$ 50元/小时";
    cell.lblDistance.text = @"3.5公里";
    cell.lblSubject.text = @"数学，英语，语文";
    if (tableView == _tableViewStudent)
        cell.userType = StudentUser;
    else if (tableView == _tableViewTeacher)
        cell.userType = TeacherUser;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailViewCol = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:detailViewCol animated:YES];
}

#pragma  mark - PullDownViewDelegate
- (void)PullDownViewDidSelectAtIndex:(NSInteger)index
{
    [_pullView removeFromSuperview];
}

#pragma mark - CleanKeyBoard
- (void)cleanKeyBoard
{
    [_textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self cleanKeyBoard];
    
    return YES;
}

#pragma mark - 下拉列表
- (void)CustomAlertSelectViewSelectFinish:(CustomAlertSelectView *)customAlertView
{
    [_alertSelectView removeFromSuperview];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#endif

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
