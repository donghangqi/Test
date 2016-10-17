//
//  DateTool.h
//  calendar
//
//  Created by 董航琪 on 16/10/9.
//  Copyright © 2016年 董航琪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTool : NSObject
//得到日期
- (NSInteger)GetDate:(NSDate *)date;
//得到月份
- (NSInteger)GetMonth:(NSDate *)date;
//得到年份
- (NSInteger)GetYear:(NSDate *)date;
//得到月份的第一天是星期几
- (NSInteger)GetWeekdayOfFirstDay:(NSDate *)date;
//得到当前月份的总天数
- (NSInteger)GetTotalDayOfTheMonth:(NSDate *)date;
//得到下个月份的今天
- (NSDate *)GetTodayOfTheNextMonth:(NSDate *)date;
//得到上个月份的今天
- (NSDate *)GetTodayOfTheLastMonth:(NSDate *)date;
//得到今天是周几
- (NSInteger)GetWeekdayOfToday:(NSDate *)date;
//得到一周后的今天
- (NSDate *)GetTheDateOfNextWeek:(NSDate *)date;
//得到一周前的今天
- (NSDate *)GetTheDateOfLastWeek:(NSDate *)date;
//得到今天是今天的第几周
- (NSInteger)GetWhichWeekInThisYear:(NSDate *)date;
//得到下一天的date
- (NSDate *)GetTomorrowDate:(NSDate *)date;
//得到上一天的date
- (NSDate *)GetYesterdayDate:(NSDate *)date;
//字符串转date
- (NSDate *)GetDateWithString:(NSString *)dateString;
@end
