//
//  NSString+NTVString.h
//  DisabledProject
//
//  Created by 乔冬 on 17/5/17.
//  Copyright © 2017年 com.xinhuatv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NTVString)
+(NSString *)slnShowString:(NSNumber *)number;
+ (float) heightForString:(NSString *)value font:(UIFont *)font andWidth:(float)width;
/**
 *  检测字符
 */
+ (BOOL)isHaveIllegalChar:(NSString *)str;

@end
