//
//  UIView+GridLayout.m
//  MojiWeatherHD
//
//  Created by shunpingliu on 14-3-3.
//  Copyright (c) 2014年 Moji China. All rights reserved.
//

#import "UIView+GridLayout.h"

@implementation UIView (GridLayout)
@dynamic row;
@dynamic column;
@dynamic numOfUnit;
- (void)gridLayoutInRow:(int)row column:(int)column
{
    self.row = row;
    self.column = column;
    [self gridLayout];
}
- (void)gridLayout
{
    
}

- (UIView*)viewAtRow:(int)row column:(int)column
{
    return nil;
}
@end
