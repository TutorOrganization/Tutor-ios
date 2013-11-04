//
//  CustomFristPageCell.h
//  Tutor
//
//  Created by hank on 13-11-3.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomFristPageCell : UITableViewCell
{
    UIImageView *_headerView;
    UILabel *_lblTitle;
    UILabel *_lblName;
    UILabel *_lblCost;
    UILabel *_lblDistance;
    UILabel *_lblSubject;
    UIImageView *_imgViewUser;
}

@property(nonatomic, copy)UIImageView *headerView;
@property(nonatomic, copy)UILabel *lblTitle;
@property(nonatomic, copy)UILabel *lblName;
@property(nonatomic, copy)UILabel *lblCost;
@property(nonatomic, copy)UILabel *lblDistance;
@property(nonatomic, copy)UILabel *lblSubject;
@property(nonatomic)SystemUser userType;
@end
