//
//  NSDate+SLDate.h
//  XinhuaVideo
//
//  Created by 乔冬 on 16/8/15.
//  Copyright © 2016年 com.xinhuashixun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SLDate)
+(NSString*)currentDateString;
+(NSString*)currentDateString24;
+(NSString*)currentDateMonthYearString;
+(NSString*)currentDateMonthYearMonthDayHourAndMuniteString;
+ (NSString *)slnGetYearSinceHostory: (NSInteger ) HostoryMS;
+ (NSString *)slnGetAgeSinceHostory: (NSDate *  ) hostory;
+ (NSString *)timeWithTimeIntervalString:(NSInteger )time;
+(NSString *)currentMonthString;
+ (NSString *)slnDateFormatStringWithTime:(NSInteger )time DateFormat:(NSString *)dateFormat;
+ (NSString *)slnDateFormatNeedStringWithTime:(NSInteger )time DateFormat:(NSString *)dateFormat;
+ (NSString *)caculateTimeStrWithTime:(long)time;
+ (long)slnTimeInterval;
@end
