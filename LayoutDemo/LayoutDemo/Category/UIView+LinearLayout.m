//
//  UIView+LinearLayout.m
//  MojiWeatherHD
//
//  Created by shunpingliu on 14-2-26.
//  Copyright (c) 2014年 Moji China. All rights reserved.
//

#import "UIView+LinearLayout.h"
#import <objc/runtime.h>
#import "UIColor+Colours.h"
static const void *totalWidthKey  = @"totalWidthKey";
static const void *totalHeightKey  = @"totalHeightKey";
static const void *debugModeKey  = @"debugModeKey";

@implementation UIView (LinearLayout)
@dynamic totalWidth;
@dynamic totalHeight;
@dynamic debugMode;

- (float)totalHeight
{
    return [objc_getAssociatedObject(self, totalHeightKey) floatValue];
}

- (float)totalWidth
{
    return [objc_getAssociatedObject(self, totalWidthKey) floatValue];
}

- (void)setTotalHeight:(float)totalHeight
{
    objc_setAssociatedObject(self, totalHeightKey, [NSNumber numberWithFloat:totalHeight], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setTotalWidth:(float)totalWidth
{
    objc_setAssociatedObject(self, totalWidthKey, [NSNumber numberWithFloat:totalWidth], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (BOOL)debugMode
{
    return [objc_getAssociatedObject(self, debugModeKey) boolValue];
}

- (void)setDebugMode:(BOOL)debugMode
{
    objc_setAssociatedObject(self, debugModeKey, [NSNumber numberWithBool:debugMode], OBJC_ASSOCIATION_ASSIGN);
}

- (void)linearLayout:(LayoutDirection)direction
{
    float startX = 0, startY=0;
    float totalWidth =0 , totolHeight = 0;
    
    for (UIView *subView in self.subviews) {
        if (subView.isHidden) {
            continue;
        }
        if (self.debugMode) {
            subView.backgroundColor = [UIColor randomColor];
        }
        
        switch (direction) {
            case LayoutVertical:
            {
                if (AlignHorizontalCenter == subView.alignType) {
                    subView.marginLeft = (self.frame.size.width-subView.frame.size.width)/2.0;
                }
                subView.frame = CGRectMake(subView.marginLeft, startY+subView.marginTop, subView.frame.size.width, subView.frame.size.height);
                startY += subView.frame.size.height+subView.marginTop+subView.marginBottom;
                totolHeight +=subView.frame.size.height+subView.marginTop+subView.marginBottom;
            }
                break;
            case LayoutHorizontal:
            {
                if (AlignVerticalCenter == subView.alignType) {
                    subView.marginTop = (self.frame.size.height-subView.frame.size.height)/2.0;
                }
                subView.frame = CGRectMake(startX+subView.marginLeft, subView.marginTop, subView.frame.size.width, subView.frame.size.height);
                startX+=subView.frame.size.width+subView.marginLeft+subView.marginRight;
                totalWidth +=subView.frame.size.width+subView.marginLeft+subView.marginRight;
            }
                break;
            default:
                break;
        }
    }
    self.totalHeight = MAX(totolHeight, [self maxHeight]);
    self.totalWidth = MAX(totalWidth, [self maxWidth]);
}

- (float)maxWidth
{
    float maxWidth = 0;
    for (UIView *subView in self.subviews) {
        if (subView.isHidden) {
            continue;
        }
        CGFloat width = subView.frame.size.width + subView.marginLeft+subView.marginRight;
        if (width > maxWidth) {
            maxWidth = width;
        }
    }
    return maxWidth;
}

- (float)maxHeight
{
    float maxHeight = 0;
    for (UIView *subView in self.subviews) {
        if (subView.isHidden) {
            continue;
        }
        CGFloat height = subView.frame.size.height+subView.marginTop+subView.marginBottom;
        if (height > maxHeight) {
            maxHeight = height;
        }
    }
    return maxHeight;
}
@end
