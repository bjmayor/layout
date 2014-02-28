//
//  UIView+LayoutProperty.h
//  MojiWeatherHD
//
//  Created by shunpingliu on 14-2-26.
//  Copyright (c) 2014年 Moji China. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    AlignTop,//上对齐，竖屏布局时默认
    AlignLeft,//左对齐，横屏布局时默认
    AlignVerticalCenter,//父视图中垂直居中, 此时忽略marginLeft,marginRight
    AlignHorizontalCenter,//父视图中水平居中，此时忽略marginTop, marginBottom
    AliginCenter,//父视图中居中，此时忽略margin属性
}AlignType;//会影响到margin


@interface UIView (LayoutProperty)
@property (nonatomic, assign) UIEdgeInsets margin;
@property (nonatomic, assign) CGFloat marginLeft;
@property (nonatomic, assign) CGFloat marginRight;
@property (nonatomic, assign) CGFloat marginTop;
@property (nonatomic, assign) CGFloat marginBottom;
@property (nonatomic, assign) AlignType alignType;
@end
