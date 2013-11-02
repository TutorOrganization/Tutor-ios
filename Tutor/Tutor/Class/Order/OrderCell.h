//
//  OrderCell.h
//  Tutor
//
//  Created by syzhou on 13-10-31.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+SY.h"

@interface OrderCell : UITableViewCell

@property (nonatomic, strong) UILabel *lblClassName;
@property (nonatomic, strong) UILabel *lblClassTime;
@property (nonatomic, strong) UILabel *lblOrderStatus;
@property (nonatomic, strong) UIImageView *imgvOrderType;

@end
