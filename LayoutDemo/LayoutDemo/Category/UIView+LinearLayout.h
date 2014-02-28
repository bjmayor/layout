//
//  UIView+LinearLayout.h
//  MojiWeatherHD
//
//  Created by shunpingliu on 14-2-26.
//  Copyright (c) 2014年 Moji China. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+LayoutProperty.h"

typedef enum {
    LayoutHorizontal,//水平
    LayoutVertical//垂直
} LayoutDirection;



/**@brief 现在没有支持对齐，水平布局是左对齐， 垂直布局是顶对齐。目前只负责一行/一列的布局
 *
 *
 */
@interface UIView (LinearLayout)
//线性布局
- (void)linearLayout:(LayoutDirection)direction;
@property (nonatomic, assign) float totalWidth;
@property (nonatomic, assign) float totalHeight;
@property (nonatomic, assign) BOOL debugMode;
@end
