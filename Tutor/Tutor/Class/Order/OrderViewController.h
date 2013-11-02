//
//  OrderViewController.h
//  Tutor
//
//  Created by hank on 13-10-28.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationController.h"

@interface OrderViewController : BaseNavigationController <UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSMutableArray *_marrayDatasource;
}

@end
