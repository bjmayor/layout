//
//  UIView+GridLayout.h
//  MojiWeatherHD
//
//  Created by shunpingliu on 14-3-3.
//  Copyright (c) 2014年 Moji China. All rights reserved.
//

#import <UIKit/UIKit.h>

/***************************网格布局***************************/
/**@brief 网格布局
 *
 */
@interface UIView (GridLayout)
@property (nonatomic, assign) int row;
@property (nonatomic, assign) int column;
@property (nonatomic, assign) int numOfUnit;
- (void)gridLayoutInRow:(int)row column:(int)column;
/**@brief 使用之前必须有调用过- (void)gridLayoutInRow:(int)row column:(int)column
 ** 或者设置了行信息
 *
 */
- (void)gridLayout;

- (UIView*)viewAtRow:(int)row column:(int)column;
@end
