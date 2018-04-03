//
//  NSDate+SLDate.m
//  XinhuaVideo
//
//  Created by 乔冬 on 16/8/15.
//  Copyright © 2016年 com.xinhuashixun. All rights reserved.
//

#import "NSDate+SLDate.h"

@implementation NSDate (SLDate)

+(NSString *)currentMonthString{

    NSInteger day = [self currentDay ];
    if(day >5){
        return [NSString stringWithFormat:@"%ld", (long)[self currentNextMonth] ];
        
    }else{
        return  [NSString stringWithFormat:@"%ld", (long)[self currentMonth] ];
    }

}
+ (NSInteger)currentMonth{
    NSDate *currentDate = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];
    // 设置属性，因为我只需要年和月，这个属性还可以支持时，分，秒
    NSDateComponents *cmp = [calender components:(NSCalendarUnitMonth | NSCalendarUnitYear  | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:currentDate];
    NSInteger month =  cmp.month;
    return month;
}
+ (NSInteger)currentDay{
    NSDate *currentDate = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *cmp = [calender components:(NSCalendarUnitMonth | NSCalendarUnitYear  | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:currentDate];
       NSInteger day =  cmp.day;
    return day;
}
+ (NSInteger)oneDayWIthDate:(NSDate *)date{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *cmp = [calender components:(NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:date];
    NSInteger day =  cmp.day;
    return day;
}
+ (NSInteger)oneHourWIthDate:(NSDate *)date{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *cmp = [calender components:(NSCalendarUnitMonth | NSCalendarUnitYear  | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    NSInteger day =  cmp.hour;
    return day;
}
+ (NSInteger)oneMinuteWIthDate:(NSDate *)date{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *cmp = [calender components:(NSCalendarUnitMonth | NSCalendarUnitYear  | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    NSInteger minute =  cmp.minute;
    return minute;
}
+ (NSInteger)oneSeondWIthDate:(NSDate *)date{
    NSCalendar *calender = [NSCalendar currentCalendar];
    // 设置属性，因为我只需要年和月，这个属性还可以支持时，分，秒
    NSDateComponents *cmp = [calender components:(NSCalendarUnitMonth | NSCalendarUnitYear  | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    NSInteger second =  cmp.second;
    return second;
}
+ (NSInteger )currentNextMonth{
    NSCalendar *calender = [NSCalendar currentCalendar];
    // 设置属性，因为我只需要年和月，这个属性还可以支持时，分，秒
    NSDateComponents *cmp = [calender components:(NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[[NSDate alloc] init]];
    //设置下个月，即在现有的基础上加上一个月(2016年12月 减去一个月 会得到2017年1月)
    [cmp setMonth:[cmp month] + 1];
    NSInteger month = cmp.month;
    return  month;
}
+(NSString*)currentDateString{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *timeStr = [dateFormatter stringFromDate:currentDate];
    return timeStr;
}
+(NSString*)currentDateString24{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString *timeStr = [dateFormatter stringFromDate:currentDate];
    return timeStr;
}
+(NSString*)currentDateMonthYearMonthDayHourAndMuniteString{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm"];
    NSString *timeStr = [dateFormatter stringFromDate:currentDate];
    return timeStr;
}
+(NSString*)currentDateMonthYearString{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY年MM月"];
    NSString *timeStr = [dateFormatter stringFromDate:currentDate];
    return timeStr;
}
+(NSInteger)slnGetYear:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];

    NSString *timeStr = [dateFormatter stringFromDate:date];
    return [timeStr integerValue];
}
+(NSInteger)slnGetCurrentYear{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *timeStr = [dateFormatter stringFromDate:currentDate];
    return [timeStr integerValue];
}
+ (NSString *)slnGetYearSinceHostory: (NSInteger ) HostoryMS{
    if (HostoryMS <= 0) {
        return @"";
    }
    NSDate *hostory = [[NSDate alloc]initWithTimeIntervalSince1970:HostoryMS/1000.0];
    NSInteger hostoryYear = [self slnGetYear:hostory];
    NSInteger nowYear = [self slnGetCurrentYear];
    NSString *year = [NSString stringWithFormat:@"%ld",(nowYear - hostoryYear)];
    return year;
}
+ (NSString *)slnGetAgeSinceHostory: (NSDate *  ) hostory{
    NSInteger hostoryYear = [self slnGetYear:hostory];
    NSInteger nowYear = [self slnGetCurrentYear];
    NSString *year = [NSString stringWithFormat:@"%ld",(nowYear - hostoryYear)];
    return year;
}
+ (NSString *)intervalSinceHostory: (NSDate *) HostoryDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *timeStr = [dateFormatter stringFromDate:HostoryDate];
    return timeStr;
}


- (int)intervalSinceNow: (NSString *) theDate
{
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    
    if (cha/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        return [timeString intValue];
    }
    return -1;
}
+ (NSString *)timeWithTimeIntervalString:(NSInteger )time
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:time/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)slnDateFormatNeedStringWithTime:(NSInteger )time DateFormat:(NSString *)dateFormat{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:dateFormat];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:time/ 1000.0];
    if ([self oneDayWIthDate:date] == [self currentDay]) {
        NSString *string = [NSString stringWithFormat:@"%ld:%ld",(long)[self oneHourWIthDate:date],(long)[self oneMinuteWIthDate:date]];
        return string;
    }else{
        NSString* dateString = [formatter stringFromDate:date];
        return dateString;
    }
    
}
+ (NSString *)slnDateFormatStringWithTime:(NSInteger )time DateFormat:(NSString *)dateFormat
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:dateFormat];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:time/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
+ (long)slnTimeInterval{
      NSTimeInterval currentDate = [NSDate date].timeIntervalSince1970 * 1000;
    return (long)currentDate;
}
+ (NSString *)caculateTimeStrWithTime:(long)time {
    NSTimeInterval currentDate = [[NSDate alloc] init].timeIntervalSince1970;
    long beginTime = time / 1000;
    long endTime = (long)currentDate;
    long result = endTime - beginTime;
    DLog(@"%ld", result);
    // 计算时间跨度
    NSString *timeResult;
    if (result / 60 <= 59) {
        // 五分钟到六十分钟
        
        timeResult = [NSString stringWithFormat:@"%ld分钟前",result/60];
    } else if (result / 60 <= 1439) {
        // 六十分钟到二十四小时
        timeResult = [NSString stringWithFormat:@"%ld小时前",result/3600];
    } else {
        // 一天外
        DLog(@"%ld",time);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:beginTime];
        NSString *currentDateStr = [dateFormatter stringFromDate:date];
        
        timeResult = [NSString stringWithFormat:@"%@",currentDateStr];
    }
    return timeResult;
}
@end
