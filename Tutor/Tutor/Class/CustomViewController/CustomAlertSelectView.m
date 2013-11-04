//
//  CustomAlertSelectView.m
//  Tutor
//
//  Created by hank on 13-11-3.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "CustomAlertSelectView.h"
#import "Toolkit.h"

@implementation CustomAlertSelectView

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)strTitle
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if([Toolkit isSystemIOS7])
            _originY = 20;
        
        
        _arrayData = @[@"长沙", @"南京", @"北京", @"上海", @"乌龙木齐", @"哈尔滨", @"南昌"];
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        UIView *viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        viewBG.backgroundColor = [UIColor blackColor];
        viewBG.alpha = 0.7f;
        [self addSubview:viewBG];
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, _originY + NavigationBar_HEIGHT + 20, 556 / 2.0, 672 / 2.0)];
        contentView.center = CGPointMake(self.center.x, contentView.center.y);
        contentView.userInteractionEnabled = YES;
        [self addSubview:contentView];
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentView.frame.size.width, 44)];
        headerView.backgroundColor = [UIColor colorWithRed:68 / 255.0f green:147 / 255.0f blue:36 / 255.0f alpha:1.0f];
        headerView.userInteractionEnabled = YES;
        [contentView addSubview:headerView];
        
        UIButton *btnClose = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [btnClose addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpInside];
        btnClose.backgroundColor = [UIColor clearColor];
        btnClose.titleLabel.font = [UIFont systemFontOfSize:14];
        [btnClose setTitle:@"关闭" forState:UIControlStateNormal];
        [headerView addSubview:btnClose];
        
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
        lblTitle.text = strTitle;
        lblTitle.font = [UIFont systemFontOfSize:18];
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.center = CGPointMake(headerView.center.x, lblTitle.center.y);
        lblTitle.backgroundColor = [UIColor clearColor];
        [headerView addSubview:lblTitle];
        
        UIButton *btnRight = [[UIButton alloc] initWithFrame:CGRectMake(headerView.frame.size.width - 44 - 5, 0, 44, 44)];
        [btnRight addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpInside];
        btnRight.backgroundColor = [UIColor clearColor];
        btnRight.titleLabel.font = [UIFont systemFontOfSize:14];
        [btnRight setTitle:@"完成" forState:UIControlStateNormal];
        [headerView addSubview:btnRight];
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, contentView.frame.size.width, contentView.frame.size.height - 44) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.rowHeight = 85 / 2.0;
        tableView.dataSource = self;
        if ([Toolkit isSystemIOS7])
            tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [contentView addSubview:tableView];
    }
    return self;
}

- (void)touchUp:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(CustomAlertSelectViewSelectFinish:)])
        [self.delegate CustomAlertSelectViewSelectFinish:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayData.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"CustomAlertSelectView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = [_arrayData objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(CustomAlertSelectViewSelectFinish:)])
        [self.delegate CustomAlertSelectViewSelectFinish:self];
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
