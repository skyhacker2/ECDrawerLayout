//
//  DrawerView2.m
//  ECDrawerLayout
//
//  Created by Eleven Chen on 15/8/19.
//  Copyright (c) 2015年 Eleven Chen. All rights reserved.
//

#import "DrawerView2.h"
#import "ECExtension.h"

@implementation DrawerView2

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype) init
{
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        UILabel *title = [[UILabel alloc] init];
        title.adjustsFontSizeToFitWidth = YES;
        title.textColor = [UIColor whiteColor];
        title.font = [UIFont systemFontOfSize:15];
        title.text = @"Eleven Chen";
        [self addSubview:title];
        title.translatesAutoresizingMaskIntoConstraints = NO;
        [title layoutMarginLeftSuperView:15];
        [title layoutMarginTopSuperView:50];
    }
    
    return self;
}

@end
