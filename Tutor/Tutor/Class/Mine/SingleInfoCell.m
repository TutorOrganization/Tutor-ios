//
//  SingleInfoCell.m
//  Tutor
//
//  Created by syzhou on 13-11-4.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "SingleInfoCell.h"
#import "UILabel+SY.h"

@implementation SingleInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.imgvBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.imgvBG.userInteractionEnabled = YES;
        [self.contentView addSubview:self.imgvBG];
        
        self.lblTitle = [UILabel createLabelWithFrame:CGRectMake(10, 0, 200, self.frame.size.height) font:kOrderCellFont addView:self.contentView];
        
        self.imgvAcssory = [[UIImageView  alloc] initWithFrame:CGRectMake(205, 55, 9, 15)];
        self.imgvAcssory.image = [UIImage imageNamed:@"icon_RightArrow@2x.png"];
        [self.contentView addSubview:self.imgvAcssory];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
