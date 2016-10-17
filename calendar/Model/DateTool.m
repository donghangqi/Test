//
//  DateTool.m
//  calendar
//
//  Created by 董航琪 on 16/10/9.
//  Copyright © 2016年 董航琪. All rights reserved.
//

#import "DateTool.h"

@implementation DateTool
- (NSInteger)GetDate:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
    return components.day;
}

- (NSInteger)GetMonth:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
    return components.month;
}

- (NSInteger)GetYear:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
    return components.year;
}

- (NSInteger)GetWeekdayOfFirstDay:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //设置周日为每个星期的第一天
    [calendar setFirstWeekday:1];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
    //设置为1号
    [components setDay:1];
    //反向生成每个月1号的date
    NSDate *firstdate = [calendar dateFromComponents:components];
    //得到1号是礼拜几
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstdate];
    return firstWeekday - 1;
}

- (NSInteger)GetTotalDayOfTheMonth:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange totaldays = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldays.length;
}

- (NSDate *)GetTodayOfTheLastMonth:(NSDate *)date {
    NSDateComponents *components = [[NSDateComponents alloc]init];
    [components setMonth:-1];
    NSDate *newdate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:date options:0];
    return newdate;
}

- (NSDate *)GetTodayOfTheNextMonth:(NSDate *)date {
    NSDateComponents *components = [[NSDateComponents alloc]init];
    [components setMonth:1];
    NSDate *newdate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:date options:0];
    return newdate;
}

- (NSInteger)GetWeekdayOfToday:(NSDate *)date {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
    [components setDay:[self GetDate:date]];
    NSInteger weekdayoftoday = [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:date];
    return weekdayoftoday - 1;
}

- (NSDate *)GetTheDateOfNextWeek:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc]init];
    components.day = +7;
    NSDate *newdate = [calendar dateByAddingComponents:components toDate:date options:0];
    return newdate;
}

- (NSDate *)GetTheDateOfLastWeek:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc]init];
    components.day = -7;
    NSDate *newdate = [calendar dateByAddingComponents:components toDate:date options:0];
    return newdate;
}

- (NSInteger)GetWhichWeekInThisYear:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange totaldays = [calendar rangeOfUnit:NSCalendarUnitWeekOfYear inUnit:NSCalendarUnitYear forDate:date];
    return totaldays.length;
}

- (NSDate *)GetTomorrowDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc]init];
    components.day = +1;
    NSDate *newdate = [calendar dateByAddingComponents:components toDate:date options:0];
    return newdate;
}

- (NSDate *)GetYesterdayDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc]init];
    components.day = -1;
    NSDate *newdate = [calendar dateByAddingComponents:components toDate:date options:0];
    return newdate;
}

- (NSDate *)GetDateWithString:(NSString *)dateString {
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [format dateFromString:dateString];
    return date;
}
@end

