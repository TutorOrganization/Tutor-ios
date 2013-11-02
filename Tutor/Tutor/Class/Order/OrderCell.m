//
//  OrderCell.m
//  Tutor
//
//  Created by syzhou on 13-10-31.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = BACKGROUND_COLOR;
        UIView *vBg = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 125)];
        [self.contentView addSubview:vBg];
        vBg.layer.cornerRadius = 1;
        vBg.layer.borderColor = [RGBCOLOR(204.0, 204.0, 204.0) CGColor];
        
        UILabel *lblClassNameKey = [UILabel createLabelWithFrame:CGRectMake(10, 10, 65, 25) font:[UIFont systemFontOfSize:15] addView:self];
        lblClassNameKey.text = @"课程类型";
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
