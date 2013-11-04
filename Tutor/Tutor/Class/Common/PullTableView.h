//
//  PullTableView.h
//  PullandPushDemo
//
//  Created by syzhou on 13-7-11.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

/*
 tips:
 必须实现两个UITableview的代理，两UIScrollView的代理，一个PullTableView的代理，如下
 - (NSInteger)tableView:(PullTableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
 return [tableView.marrayDataSource count];
 }
 - (UITableViewCell *)tableView:(PullTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
 
 
 - (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
 [_tableview endedDragScrollVieww:scrollView];//照写就行
 }
 
 - (void)scrollViewDidScroll:(UIScrollView *)scrollView {
 [_tableview ifNeedLoadingNextpage:scrollView];//照写就行
 }
 
 - (void)pullTableView:(PullTableView *)pullTableView LoadingPage:(NSInteger)intPage {
 //    请求数据，然后调用LoadindDataSuccess或者LoadindDataFailed；
 }
 */

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


#define kInitPage 0
#define PageSize 20

@protocol PullTableViewDelegate;
@class EGORefreshTableHeaderView;
@interface PullTableView : UITableView <UITableViewDataSource,UITableViewDelegate> {
    NSMutableArray *_marrayDataSource;
    EGORefreshTableHeaderView *_refreshHeaderView;
    __weak id <PullTableViewDelegate> _pullDelegate;
    
    NSInteger _intCurrentPage;
    
    BOOL _bIsLoading;//正在翻页,结束前不要refresh
    BOOL _bIsRefresh;//正在下拉，结束前不要Loading
    
    BOOL _bSurpportRefresh;//支持下拉
    BOOL _bSurpportPages;//支持翻页
}

@property (nonatomic, assign) BOOL bSurpportRefresh;
@property (nonatomic, assign) BOOL bSurpportPages;

@property (nonatomic, weak) id <PullTableViewDelegate> pullDelegate;
@property (nonatomic, strong) NSMutableArray *marrayDataSource;


- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style delegate:(id)delgate;

- (void)LoadindDataSuccess:(NSArray *)arrayDataSource;//用户请求数据成功时调用
- (void)LoadindDataFailed ;//用户请求数据失败时

//ifNeedLoadingNextpage与endedDragScrollVieww必须在scrollview的代理中实现，见第10行提示
- (void)ifNeedLoadingNextpage:(UIScrollView *)scrollView;
- (void)endedDragScrollVieww:(UIScrollView *)scrollView;

@end

@protocol PullTableViewDelegate

@required

- (void)pullTableView:(PullTableView *)pullTableView LoadingPage:(NSInteger)intPage;

@end




typedef enum{
	EGOOPullRefreshPulling = 0,
	EGOOPullRefreshNormal,
	EGOOPullRefreshLoading,
} EGOPullRefreshState;

@protocol EGORefreshTableHeaderDelegate;
@interface EGORefreshTableHeaderView : UIView {
	
	__weak id _delegate;
	EGOPullRefreshState _state;
    
	UILabel *_lastUpdatedLabel;
	UILabel *_statusLabel;
	CALayer *_arrowImage;
	UIActivityIndicatorView *_activityView;
	
    
}

@property(nonatomic,weak) id <EGORefreshTableHeaderDelegate> delegate;

- (void)refreshLastUpdatedDate;
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

@end

@protocol EGORefreshTableHeaderDelegate
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view;
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view;
@optional
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view;
@end