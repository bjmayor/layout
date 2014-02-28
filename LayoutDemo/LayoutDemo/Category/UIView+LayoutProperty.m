//
//  UIView+LayoutProperty.m
//  MojiWeatherHD
//
//  Created by shunpingliu on 14-2-26.
//  Copyright (c) 2014年 Moji China. All rights reserved.
//

#import "UIView+LayoutProperty.h"
#import <objc/runtime.h>
static const void *marginLeftKey    = @"marginLeftKey";
static const void *marginRightKey   = @"marginRightKey";
static const void *marginTopKey     = @"marginTopKey";
static const void *marginBottomKey  = @"marginBottomKey";
static const void *alignTypeKey     = @"alignTypeKey";
@implementation UIView (LayoutProperty)
@dynamic margin;
@dynamic marginTop;
@dynamic marginBottom;
@dynamic marginLeft;
@dynamic marginRight;
@dynamic alignType;

- (UIEdgeInsets)margin
{
    return UIEdgeInsetsMake(self.marginTop, self.marginLeft, self.marginBottom, self.marginRight);
}

- (void)setMargin:(UIEdgeInsets)margin
{
    self.marginTop = margin.top;
    self.marginLeft = margin.left;
    self.marginBottom = margin.bottom;
    self.marginRight = margin.right;
}

- (CGFloat)marginTop
{
    return [objc_getAssociatedObject(self, marginTopKey) floatValue];
}

- (void)setMarginTop:(CGFloat)marginTop
{
    objc_setAssociatedObject(self, marginTopKey, [NSNumber numberWithFloat:marginTop], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)marginLeft
{
    return [objc_getAssociatedObject(self, marginLeftKey) floatValue];
}

- (void)setMarginLeft:(CGFloat)marginLeft
{
    objc_setAssociatedObject(self, marginLeftKey, [NSNumber numberWithFloat:marginLeft], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)marginBottom
{
    return [objc_getAssociatedObject(self, marginBottomKey) floatValue];
}

- (void)setMarginBottom:(CGFloat)marginBottom
{
    objc_setAssociatedObject(self, marginBottomKey, [NSNumber numberWithFloat:marginBottom], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)marginRight
{
    return [objc_getAssociatedObject(self, marginRightKey) floatValue];
}

- (void)setMarginRight:(CGFloat)marginRight
{
    objc_setAssociatedObject(self, marginRightKey, [NSNumber numberWithFloat:marginRight], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(AlignType)alignType
{
    return [objc_getAssociatedObject(self, alignTypeKey) intValue];
}

- (void)setAlignType:(AlignType)alignType
{
    objc_setAssociatedObject(self, alignTypeKey, [NSNumber numberWithInt:alignType], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
