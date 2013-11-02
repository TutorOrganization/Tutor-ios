//
//  OrderCell.m
//  Tutor
//
//  Created by syzhou on 13-10-31.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "OrderCell.h"
#import "UIImage+NSBundle.h"

@implementation OrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = BACKGROUND_COLOR;
        UIView *vBg = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 110)];
        [self.contentView addSubview:vBg];
        vBg.backgroundColor = [UIColor whiteColor];
        vBg.layer.cornerRadius = 3;
        vBg.layer.borderWidth = 0.5;
        vBg.layer.borderColor = [RGBCOLOR(204.0, 204.0, 204.0) CGColor];
        
        CGFloat offset = 5;
        
        UILabel *lblClassNameKey = [UILabel createLabelWithFrame:CGRectMake(10, 10, 65, 18) font:kOrderCellFont addView:vBg];
        lblClassNameKey.text = @"课程类型:";
        _lblClassName = [UILabel createLabelWithFrame:CGRectMake(95, 15, 200, 18) font:kOrderCellFont addView:vBg];
        
        UILabel *lblClassTimeKey = [UILabel createLabelWithFrame:CGRectMake(10, lblClassNameKey.frame.origin.y + lblClassNameKey.frame.size.height + offset, 65, 18) font:kOrderCellFont addView:vBg];
        lblClassTimeKey.text = @"课程时间:";
        _lblClassTime = [UILabel createLabelWithFrame:CGRectMake(95, lblClassTimeKey.frame.origin.y, 200, 18) font:kOrderCellFont addView:vBg];

        UILabel *lblOrderTypeKey = [UILabel createLabelWithFrame:CGRectMake(10, lblClassTimeKey.frame.origin.y + lblClassTimeKey.frame.size.height + offset, 65, 18) font:kOrderCellFont addView:vBg];
        lblOrderTypeKey.text = @"订单类型:";
        _imgvOrderType = [[UIImageView alloc ] initWithFrame:CGRectMake(95, lblOrderTypeKey.frame.origin.y, 22, 22)];
        _imgvOrderType.userInteractionEnabled = YES;
        [vBg addSubview:_imgvOrderType];
        
        UILabel *lblOrderStatusKey = [UILabel createLabelWithFrame:CGRectMake(10, lblOrderTypeKey.frame.origin.y + lblOrderTypeKey.frame.size.height + offset, 65, 18) font:kOrderCellFont addView:vBg];
        lblOrderStatusKey.text = @"订单状态:";
        _lblOrderStatus = [UILabel createLabelWithFrame:CGRectMake(95, lblOrderStatusKey.frame.origin.y, 60, 18) font:kOrderCellFont addView:vBg];
        
        _vStar = [[StarView alloc] initWithFrame:CGRectMake(185, _lblOrderStatus.frame.origin.y, 110, 17)];
        [vBg addSubview:_vStar];
        
        UIImageView *imgv = [[UIImageView  alloc] initWithFrame:CGRectMake(292, 55, 9, 15)];
        imgv.image = [UIImage imageNamed:@"icon_RightArrow@2x.png"];
        [self addSubview:imgv];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDictOrderInfo:(NSDictionary *)dictOrderInfo {
    _dictOrderInfo = dictOrderInfo;
    _lblClassName.text = [dictOrderInfo objectForKey:@"ClassName"];
    _lblClassTime.text = [dictOrderInfo objectForKey:@"Time"];
    
    if ([[dictOrderInfo objectForKey:@"OrderType"] isEqualToString:@"teach"]) {
        _imgvOrderType.image = [UIImage imageWithBundleName:@"icon_OrderType_Tec@2x.png"];
    } else {
        _imgvOrderType.image = [UIImage imageWithBundleName:@"icon_OrderType_Par@2x.png"];
    }
    _lblOrderStatus.text = [dictOrderInfo objectForKey:@"OrderStatus"];
    _vStar.fStar = [[dictOrderInfo objectForKey:@"Star"] floatValue];
}

@end
