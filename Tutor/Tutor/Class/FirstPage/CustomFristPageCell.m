//
//  CustomFristPageCell.m
//  Tutor
//
//  Created by hank on 13-11-3.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "CustomFristPageCell.h"

@interface CustomFristPageCell ()
{
    
}
@end

@implementation CustomFristPageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 92 / 2, 92 / 2)];
        _headerView.layer.cornerRadius = 5.0f;
        [self addSubview:_headerView];
        
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10 + 92 / 2.0 + 20, 13, 150, 20)];
        _lblTitle.font = [UIFont systemFontOfSize:20];
        _lblTitle.textColor = [UIColor blackColor];
        _lblTitle.backgroundColor = [UIColor clearColor];
        [self addSubview:_lblTitle];
        
        _lblName = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + 92 / 2.0 + 5, 92 / 2.0, 20)];
        _lblName.font = [UIFont systemFontOfSize:14];
        _lblName.textColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1.0];
        _lblName.backgroundColor = [UIColor clearColor];
        [self addSubview:_lblName];
        
        _lblCost = [[UILabel alloc] initWithFrame:CGRectMake(_lblTitle.frame.origin.x, _lblTitle.frame.origin.y + _lblTitle.frame.size.height + 10, 100, 20)];
        _lblCost.backgroundColor = [UIColor clearColor];
        _lblCost.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
        _lblCost.textColor = [UIColor colorWithRed:255 / 255.0 green:114 / 255.0 blue:37 / 255.0 alpha:1.0];
        [self addSubview:_lblCost];
        
        UIImageView *imgViewLocation = [[UIImageView alloc] initWithFrame:CGRectMake(_lblCost.frame.origin.x + _lblCost.frame.size.width + 20, _lblCost.frame.origin.y, 21 / 2.0, 27 / 2.0)];
        imgViewLocation.image = [UIImage imageNamed:@"imgLocation.png"];
        imgViewLocation.center = CGPointMake(imgViewLocation.center.x, _lblCost.center.y);
        [self addSubview:imgViewLocation];
        
        _lblDistance = [[UILabel alloc] initWithFrame:CGRectMake(imgViewLocation.frame.origin.x + imgViewLocation.frame.size.width + 10, imgViewLocation.frame.origin.y, 100, 20)];
        _lblDistance.backgroundColor = [UIColor clearColor];
        _lblDistance.textColor = [UIColor blackColor];
        _lblDistance.center = CGPointMake(_lblDistance.center.x, imgViewLocation.center.y);
        [self addSubview:_lblDistance];
        
        
        UILabel *lblKemu = [[UILabel alloc] initWithFrame:CGRectMake(_lblTitle.frame.origin.x, _lblCost.frame.origin.y + _lblCost.frame.size.height + 10, 45, 20)];
        lblKemu.font = [UIFont systemFontOfSize:14];
        lblKemu.text = @"科目：";
        lblKemu.textColor = [UIColor colorWithRed:108 / 255.0 green:108 / 255.0 blue:108 / 255.0 alpha:1.0];
        lblKemu.backgroundColor = [UIColor clearColor];
        [self addSubview:lblKemu];
        
        _lblSubject = [[UILabel alloc] initWithFrame:CGRectMake(lblKemu.frame.origin.x + lblKemu.frame.size.width, lblKemu.frame.origin.y, SCREEN_WIDTH - lblKemu.frame.origin.x + lblKemu.frame.size.width, 20)];
        _lblSubject.center = CGPointMake(_lblSubject.center.x, lblKemu.center.y);
        _lblSubject.font = [UIFont systemFontOfSize:14];
        _lblSubject.textColor = [UIColor colorWithRed:108 / 255.0 green:108 / 255.0 blue:108 / 255.0 alpha:1.0];
        _lblSubject.backgroundColor = [UIColor clearColor];
        [self addSubview:_lblSubject];
        
        UIImageView *viewAccess = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 24 / 2.0 - 10, 60, 24 / 2.0, 41 / 2.0)];
        viewAccess.image = [UIImage imageNamed:@"rightArrow.png"];
        [self addSubview:viewAccess];
    }
    return self;
}

- (void)setUserType:(SystemUser)userType
{
    if (!_imgViewUser)
    {
        _imgViewUser = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 66 / 2.0, _lblTitle.frame.origin.y, 66 / 2.0, 39 / 2.0)];
        [self addSubview:_imgViewUser];
    }
    
    if (userType == StudentUser)
    {
        _imgViewUser.image = [UIImage imageNamed:@"imgStudent.png"];
    }
    else if (userType == TeacherUser)
    {
        _imgViewUser.image = [UIImage imageNamed:@"imgTeacher.png"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
