//
//  UIView+LayoutProperty.m
//  MojiWeatherHD
//
//  Created by shunpingliu on 14-2-26.
//  Copyright (c) 2014年 Moji China. All rights reserved.
//

#import "UIView+LayoutProperty.h"
#import <objc/runtime.h>
static const void *marginLeftKey    = @"mj_marginLeftKey";
static const void *marginRightKey   = @"mj_marginRightKey";
static const void *marginTopKey     = @"mj_marginTopKey";
static const void *marginBottomKey  = @"mj_marginBottomKey";
static const void *alignTypeKey     = @"mj_alignTypeKey";
static const void *fillTypeKey      = @"mj_fillTypeKey";
static const void *weightKey        = @"mj_weightKey";
@implementation UIView (LayoutProperty)
@dynamic margin;
@dynamic lMarginTop;
@dynamic marginBottom;
@dynamic marginLeft;
@dynamic marginRight;
@dynamic alignType;
@dynamic fillType;
@dynamic weight;

- (UIEdgeInsets)margin
{
    return UIEdgeInsetsMake(self.lMarginTop, self.marginLeft, self.marginBottom, self.marginRight);
}

- (void)setMargin:(UIEdgeInsets)margin
{
    self.lMarginTop = margin.top;
    self.marginLeft = margin.left;
    self.marginBottom = margin.bottom;
    self.marginRight = margin.right;
}

- (CGFloat)lMarginTop
{
    return [objc_getAssociatedObject(self, marginTopKey) floatValue];
}

- (void)setLMarginTop:(CGFloat)marginTop
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

- (FillType)fillType
{
    return [objc_getAssociatedObject(self, fillTypeKey) intValue];
}

- (void)setFillType:(FillType)fillType
{
    objc_setAssociatedObject(self, fillTypeKey, [NSNumber numberWithInt:fillType], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)weight
{
    CGFloat weight = [objc_getAssociatedObject(self, weightKey) floatValue];
    return weight <0.0001 ? 1 : weight;
}

- (void)setWeight:(CGFloat)weight
{
    objc_setAssociatedObject(self, weightKey, [NSNumber numberWithFloat:weight], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
