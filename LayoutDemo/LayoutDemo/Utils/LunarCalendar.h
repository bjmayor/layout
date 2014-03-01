//
//  LunarCalendar.h
//  Clock
//  NSChineseCalendar有bug, 有些日子不准..所以需要自己写
//  Created by shunping liu on 12-7-13.
//  Copyright (c) 2012年 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LunarCalendar : NSObject
{
    @private
    NSInteger lcMonth;
    NSInteger lcYear;
    NSInteger lcDay;
    
    NSArray *_chineseMonths;
    NSArray *_chineseDays;
    BOOL isLeap;
}

@property (nonatomic, assign) NSInteger lcYear;
@property (nonatomic, assign) NSInteger lcMonth;
@property (nonatomic, assign) NSInteger lcDay;

@property (nonatomic, strong) NSArray *chineseMonths;
@property (nonatomic, strong) NSArray *chineseDays;


- (id)initWithDate:(NSDate*)date;
+ (LunarCalendar*)initWithDate:(NSDate*)date;
@end

NSString *chineseCalendarWithDate(NSDate *date);