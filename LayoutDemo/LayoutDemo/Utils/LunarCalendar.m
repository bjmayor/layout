//
//  LunarCalendar.m
//  Clock
//
//  Created by shunping liu on 12-7-13.
//  Copyright (c) 2012年 tencent. All rights reserved.
//

#import "LunarCalendar.h"

@interface NSDate(custom)
//以年月日初始化一个NSDate对象
+ (NSDate*)dateFromYear:(int)year Month:(int)month Day:(int)day;
@end

@implementation NSDate(custom)
//以年月日初始化一个NSDate对象
+(NSDate*)dateFromYear:(int)year Month:(int)month Day:(int)day
{
    NSString *date = [NSString stringWithFormat:@"%4d-%02d-%02d", year, month, day];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSDate *returnDate = [formater dateFromString:date];
    return returnDate;
}
@end

@interface LunarCalendar(private)
//返回农历year年的总天数
- (NSInteger)daysOfYear:(NSInteger)year;

//返回农历year年闰月的天数
- (NSInteger)leapDays:(NSInteger)year;

//返回闰月
- (NSInteger)leapMonthOfYear:(NSInteger)year;

//获取某年某一月的天数
- (NSInteger)daysOfMonth:(NSInteger)month Year:(NSInteger)year;

- (void)initCusor;

@end

@implementation LunarCalendar
@synthesize lcYear;
@synthesize lcMonth;
@synthesize lcDay;
@synthesize chineseDays = _chineseDays;
@synthesize chineseMonths = _chineseMonths;

//公历转农历需要用查表法, 没有万能公式

int lunarInfo[] = {0x04bd8,0x04ae0,0x0a570,0x054d5,0x0d260
    ,0x0d950,0x16554,0x056a0,0x09ad0,0x055d2,
0x04ae0,0x0a5b6,0x0a4d0,0x0d250,0x1d255,0x0b540,0x0d6a0,0x0ada2,0x095b0,0x14977,
0x04970,0x0a4b0,0x0b4b5,0x06a50,0x06d40,0x1ab54,0x02b60,0x09570,0x052f2,0x04970,
0x06566,0x0d4a0,0x0ea50,0x06e95,0x05ad0,0x02b60,0x186e3,0x092e0,0x1c8d7,0x0c950,
0x0d4a0,0x1d8a6,0x0b550,0x056a0,0x1a5b4,0x025d0,0x092d0,0x0d2b2,0x0a950,0x0b557,
0x06ca0,0x0b550,0x15355,0x04da0,0x0a5d0,0x14573,0x052d0,0x0a9a8,0x0e950,0x06aa0,
0x0aea6,0x0ab50,0x04b60,0x0aae4,0x0a570,0x05260,0x0f263,0x0d950,0x05b57,0x056a0,
0x096d0,0x04dd5,0x04ad0,0x0a4d0,0x0d4d4,0x0d250,0x0d558,0x0b540,0x0b5a0,0x195a6,
0x095b0,0x049b0,0x0a974,0x0a4b0,0x0b27a,0x06a50,0x06d40,0x0af46,0x0ab60,0x09570,
0x04af5,0x04970,0x064b0,0x074a3,0x0ea50,0x06b58,0x055c0,0x0ab60,0x096d5,0x092e0,
0x0c960,0x0d954,0x0d4a0,0x0da50,0x07552,0x056a0,0x0abb7,0x025d0,0x092d0,0x0cab5,
0x0a950,0x0b4a0,0x0baa4,0x0ad50,0x055d9,0x04ba0,0x0a5b0,0x15176,0x052b0,0x0a930,
0x07954,0x06aa0,0x0ad50,0x05b52,0x04b60,0x0a6e6,0x0a4e0,0x0d260,0x0ea65,0x0d530,
0x05aa0,0x076a3,0x096d0,0x04bd7,0x04ad0,0x0a4d0,0x1d0b6,0x0d250,0x0d520,0x0dd45,
    0x0b5a0,0x056d0,0x055b2,0x049b0,0x0a577,0x0a4b0,0x0aa50,0x1b255,0x06d20,0x0ada0};

- (id)init
{
    if (self = [super init]) {
        _chineseMonths=[NSArray arrayWithObjects:
                         @"正月", @"二月", @"三月", @"四月", @"五月",
                         @"六月", @"七月", @"八月", 
                         @"九月", @"十月", @"冬月", @"腊月", nil];
        
        
        _chineseDays=[NSArray arrayWithObjects:
                       @"初一", @"初二", @"初三", @"初四", @"初五", 
                       @"初六", @"初七", @"初八", @"初九", @"初十", 
                       @"十一", @"十二", @"十三", @"十四", @"十五",
                       @"十六", @"十七", @"十八", @"十九", @"二十",
                       @"廿一", @"廿二", @"廿三", @"廿四", @"廿五",
                       @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    }
    return self;
}

//计算date对应的农历
- (id)initWithDate:(NSDate*)date
{
    if(self = [super init])
    {
        if (!(self = [self init])) return nil;
        //用户可能会调系统时间.必须支持到1970年,1969冬月23
        NSDate *baseDate = [NSDate dateFromYear:1969 Month:12 Day:31];
        
        NSTimeInterval totalTimes = [date timeIntervalSinceDate:baseDate];
        NSInteger offset = totalTimes/86400.0;
        
        NSInteger i, leapMonth=0, temp=0;

        
        //补上农历到1970年的差异
        offset -= 37;//36天后到农历1970腊月廿九, 后面要补1, 因为是从1号开始

        
        for(i=1970; i<2050 && offset>0; i++) {
            temp = [self daysOfYear:i];
            offset -= temp;
        }
        
        if(offset<0) {
            offset += temp;
            i--;
        }
        self.lcYear = i;
        
        leapMonth = [self leapMonthOfYear:i]; //闰哪个月
        isLeap = NO;
        for(i=1; i<13 && offset>0; i++) 
        {
            //闰月, 有闰月时, 一年有13月
            if(leapMonth>0 && i==(leapMonth+1) && isLeap==NO)
            { 
                --i;
                isLeap = YES;
                temp = [self leapDays:self.lcYear];
            }
            else
            {
                temp = [self daysOfMonth:i Year:self.lcYear]; 
            }
            
            //解除闰月
            if(isLeap && i==(leapMonth+1))
            {
                isLeap = NO;
            }
            offset -= temp;

        }
        
        if(offset==0 && leapMonth>0 && i==leapMonth+1)
        {
            if(isLeap)
            { 
                isLeap = NO; 
            }
            else
            { 
                isLeap = YES;
                --i;
            }
        }
        
        if(offset<0)
        { 
            offset += temp;
            --i; 
        }
        self.lcMonth = i;
        self.lcDay = offset + 1;
    }
    return self;
}

//返回农历year年的总天数
- (NSInteger)daysOfYear:(NSInteger)someYear
{
    int i, sum=348;
    for (i=0x8000; i>0x8; i>>=1)
    {
        sum += (lunarInfo[someYear-1900] & i) ? 1: 0;
    }
    return sum+[self leapDays:someYear];
}

//返回农历year年闰月的天数
- (NSInteger)leapDays:(NSInteger)someYear
{
    if([self leapMonthOfYear: someYear]) 
    {
        return((lunarInfo[someYear-1900] & 0x10000)? 30: 29);
    }
    else 
    {
        return(0);

    }
}

//返回闰月
- (NSInteger)leapMonthOfYear:(NSInteger)someYear
{
    return lunarInfo[someYear-1900] & 0xf;
}


//获取某年某一月的天数
- (NSInteger)daysOfMonth:(NSInteger)aMonth Year:(NSInteger)aYear
{
    return( (lunarInfo[aYear-1900] & (0x10000>>aMonth))? 30: 29 );
}

- (NSString*)chineseMonth:(int)aMonth
{
    return [self.chineseMonths objectAtIndex:aMonth-1];
}

- (NSString*)chineseDay:(int)aDay
{
    return [self.chineseDays objectAtIndex:aDay-1];
}


+ (LunarCalendar*)initWithDate:(NSDate*)date
{
    LunarCalendar *lunarCalendar = [[LunarCalendar alloc] initWithDate:date];
    return lunarCalendar;
}
@end


NSString *chineseCalendarWithDate(NSDate *date)
{
/*
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅",	@"丁卯",	@"戊辰",
                             @"己巳",	@"庚午",	@"辛未",	@"壬申",	@"癸酉",
                             @"甲戌",	@"乙亥",	@"丙子",	@"丁丑", @"戊寅",
                             @"己卯",	@"庚辰",	@"辛己",	@"壬午",	@"癸未",
                             @"甲申",	@"乙酉",	@"丙戌",	@"丁亥",	@"戊子",	
                             @"己丑",	@"庚寅",	@"辛卯",	@"壬辰",	@"癸巳",
                             @"甲午",	@"乙未",	@"丙申",	@"丁酉",	@"戊戌",	
                             @"己亥",	@"庚子",	@"辛丑",	@"壬寅",	@"癸丑",
                             @"甲辰",	@"乙巳",	@"丙午",	@"丁未",	@"戊申",	
                             @"己酉",	@"庚戌",	@"辛亥",	@"壬子",	@"癸丑",
                             @"甲寅",	@"乙卯",	@"丙辰",	@"丁巳",	@"戊午",
                             @"己未",	@"庚申",	@"辛酉",	@"壬戌",	@"癸亥", nil];
*/
    if (!date) {
        return @"";
    }

    LunarCalendar *lunar = [LunarCalendar initWithDate:date];
    

    NSString *m_str = [lunar chineseMonth:lunar.lcMonth];
    NSString *d_str = [lunar chineseDay:lunar.lcDay];

    NSString *chineseCal_str =[NSString stringWithFormat: @"农历%@%@",m_str,d_str];
    return chineseCal_str;
}


