//
//  PullTableView.m
//  PullandPushDemo
//
//  Created by syzhou on 13-7-11.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "PullTableView.h"


#define backColor [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0f]

@interface PullTableView ()

- (void)getDataSource;
- (void)doneLoadingTableViewData;
- (void)showFootView ;
- (void)hiddenFootView ;
@end

@implementation PullTableView
@synthesize bSurpportPages = bSurpportPages;
@synthesize bSurpportRefresh = _bSurpportRefresh;

@synthesize marrayDataSource = _marrayDataSource;
@synthesize pullDelegate = _pullDelegate;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style delegate:(id)delgate {
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Initialization code
        _intCurrentPage = kInitPage;
        _bIsLoading = NO;
        _bIsRefresh = NO;
        _bSurpportPages  = NO;
        _bSurpportRefresh = NO;
        
        self.pullDelegate = delgate;
        self.dataSource = delgate;
        self.delegate = delgate;
        
        [self getDataSource];
        
        self.clipsToBounds = YES;
        
        self.backgroundColor = backColor;
    }
    return self;
}


- (void)setBSurpportRefresh:(BOOL)bSurpportRefresh {
    _bSurpportRefresh = bSurpportRefresh;
    if (bSurpportRefresh) {
        if (_refreshHeaderView == nil) {
            _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
            _refreshHeaderView.delegate = (id)self;
            [self addSubview:_refreshHeaderView];
        }
        
        //  update the last update date
        [_refreshHeaderView refreshLastUpdatedDate];
    } else {
        [_refreshHeaderView removeFromSuperview];
        _refreshHeaderView = nil;
    }
}

- (void)setBSurpportPages:(BOOL)SurpportPages {
    _bSurpportPages = SurpportPages;
    if (!_bSurpportPages) {
        [self hiddenFootView];
    }
}

- (void)LoadindDataSuccess:(NSArray *)arrayDataSource {
    if (_bSurpportPages && _bIsLoading) {
        NSMutableArray *marray = [NSMutableArray arrayWithArray:self.marrayDataSource];
        [marray addObjectsFromArray:arrayDataSource];
        self.marrayDataSource = marray;
        if ([arrayDataSource count] < PageSize) {
            _bIsLoading = YES;
            [self hiddenFootView];
        } else {
            _bIsLoading = NO;
        }
        _intCurrentPage++;
        
    } else {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
        
        self.marrayDataSource = [NSMutableArray arrayWithArray:arrayDataSource] ;
        _bIsRefresh = NO;
        
        _intCurrentPage = 1;
    }
    
    [self hiddenFootView];
    [self reloadData];
}

- (void)LoadindDataFailed {
    _bIsLoading = NO;
    _bIsRefresh = NO;
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:self];
    [self hiddenFootView];
}

- (void)getDataSource {
    [_pullDelegate pullTableView:self LoadingPage:_intCurrentPage];
}

- (void)ifNeedLoadingNextpage:(UIScrollView *)scrollView {
    
    if (scrollView == self && (scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height) && !_bIsLoading && !_bIsRefresh) {
        [self getDataSource];
        _bIsLoading = YES;
        
        if (_intCurrentPage > 0) {
            if (_bSurpportPages) {
                [self showFootView];
            }
        }
    }
    
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)endedDragScrollVieww:(UIScrollView *)scrollView {
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)showFootView {
    UIActivityIndicatorView *vActivity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    
    
    UIView *vBusy = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    vBusy.backgroundColor = backColor;
    [vBusy addSubview:vActivity];
    self.tableFooterView = vBusy;
    [vActivity startAnimating];
}

- (void)hiddenFootView {
    self.tableFooterView = nil;
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    _bIsRefresh = YES;
    _intCurrentPage = 0;
    
    [_pullDelegate pullTableView:self LoadingPage:_intCurrentPage];
    
}
- (void)doneLoadingTableViewData {
    
    //  model should call this when its done loading
    //    _reloading = NO;
    //
    _bIsRefresh = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    //    _bIsRefresh = YES;
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return  _bIsRefresh; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end


#define TEXT_COLOR [UIColor blackColor]
#define FLIP_ANIMATION_DURATION 0.18f
#define BACK_COlOR [UIColor colorWithRed:242.0/255.0 green:243/255.0 blue:227.0/255.0 alpha:1]
@interface EGORefreshTableHeaderView (Private)
- (void)setState:(EGOPullRefreshState)aState;
@end

@implementation EGORefreshTableHeaderView

@synthesize delegate=_delegate;


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = BACK_COlOR;
        //        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
        
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 30.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont systemFontOfSize:12.0f];
		label.textColor = TEXT_COLOR;
        //		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        //		label.shadowColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
        //		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
        
		[self addSubview:label];
		_lastUpdatedLabel=label;
        
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont boldSystemFontOfSize:13.0f];
        //		label.textColor = TEXT_COLOR;
        //		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        //		label.shadowColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
        //		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		[self addSubview:label];
		_statusLabel=label;
		
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(25.0f, frame.size.height - 65.0f, 30.0f, 55.0f);
		layer.contentsGravity = kCAGravityResizeAspect;
		layer.contents = (id)[UIImage imageNamed:@"updateArrow.png"].CGImage;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			layer.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		
		[[self layer] addSublayer:layer];
		_arrowImage=layer;
		
		UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		view.frame = CGRectMake(25.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
		[self addSubview:view];
		_activityView = view;
		
		
		[self setState:EGOOPullRefreshNormal];
		
    }
	
    return self;
	
}


#pragma mark -
#pragma mark Setters

- (void)refreshLastUpdatedDate {
	
	if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceLastUpdated:)]) {
		
		NSDate *date = [_delegate egoRefreshTableHeaderDataSourceLastUpdated:self];
		
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setAMSymbol:@"AM"];
		[formatter setPMSymbol:@"PM"];
		[formatter setDateFormat:@"MM/dd/yyyy hh:mm:a"];
		_lastUpdatedLabel.text = [NSString stringWithFormat:@"最后更新: %@", [formatter stringFromDate:date]];
		[[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"EGORefreshTableView_LastRefresh"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
	} else {
		
		_lastUpdatedLabel.text = nil;
		
	}
    
}

- (void)setState:(EGOPullRefreshState)aState{
	
	switch (aState) {
		case EGOOPullRefreshPulling:
			
			_statusLabel.text = NSLocalizedString(@"放手刷新...", @"Release to refresh status");
			[CATransaction begin];
			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
			_arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];
			
			break;
		case EGOOPullRefreshNormal:
			
			if (_state == EGOOPullRefreshPulling) {
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
				_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
			}
			
			_statusLabel.text = NSLocalizedString(@"下拉刷新...", @"Pull down to refresh status");
			[_activityView stopAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			_arrowImage.hidden = NO;
			_arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
			
			[self refreshLastUpdatedDate];
			
			break;
		case EGOOPullRefreshLoading:
			
			_statusLabel.text = NSLocalizedString(@"加载中...", @"Loading Status");
			[_activityView startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			_arrowImage.hidden = YES;
			[CATransaction commit];
			
			break;
		default:
			break;
	}
	
	_state = aState;
}


#pragma mark -
#pragma mark ScrollView Methods

- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
	
	if (_state == EGOOPullRefreshLoading) {
		
		CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
		offset = MIN(offset, 60);
		scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
		
	} else if (scrollView.isDragging) {
		
		BOOL _loading = NO;
		if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
			_loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
		}
		
		if (_state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !_loading) {
			[self setState:EGOOPullRefreshNormal];
		} else if (_state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !_loading) {
			[self setState:EGOOPullRefreshPulling];
		}
		
		if (scrollView.contentInset.top != 0) {
			scrollView.contentInset = UIEdgeInsetsZero;
		}
		
	}
	
}

- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
	
	BOOL _loading = NO;
	if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
		_loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
	}
	
	if (scrollView.contentOffset.y <= - 65.0f && !_loading) {
		
		if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDidTriggerRefresh:)]) {
			[_delegate egoRefreshTableHeaderDidTriggerRefresh:self];
		}
		
		[self setState:EGOOPullRefreshLoading];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
		[UIView commitAnimations];
		
	}
	
}

- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration: 0.2];
	[scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
	[UIView commitAnimations];
	
	[self setState:EGOOPullRefreshNormal];
    
}


@end