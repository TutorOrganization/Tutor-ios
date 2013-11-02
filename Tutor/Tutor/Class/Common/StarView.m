//
//  StarView.m
//  Tutor
//
//  Created by syzhou on 13-11-2.
//  Copyright (c) 2013年 syzhou. All rights reserved.
//

#import "StarView.h"

@implementation StarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        for (NSInteger i = 0; i < 5; i++) {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(i * (17 + 5), 0, 17, 17)];
            img.image = [UIImage imageNamed:@"icon_star_off"];
            img.tag = 100 + i;
            [self addSubview:img];
        }
    }
    return self;
}

- (void)setFStar:(CGFloat)fStar {
    _fStar = fStar;
    
    int star = lroundf(fStar);
    if (fStar > star) {
        star++;
    }
    
    for (int i = 0; i < 5; i++) {
        UIImageView *imgv = (UIImageView *)[self viewWithTag:100 + i];
        
        if (i < star) {
            imgv.image = [UIImage imageNamed:@"icon_star_on"];
        } else {
            imgv.image = [UIImage imageNamed:@"icon_star_off"];
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_edit) {
        UITouch *touch = [touches anyObject];
        CGPoint localPoint = [touch locationInView:self];
        self.fStar = localPoint.x / 23;
    }
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
