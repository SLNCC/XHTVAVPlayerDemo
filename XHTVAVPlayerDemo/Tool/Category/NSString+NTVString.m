//
//  NSString+NTVString.m
//  DisabledProject
//
//  Created by 乔冬 on 17/5/17.
//  Copyright © 2017年 com.xinhuatv. All rights reserved.
//

#import "NSString+NTVString.h"

@implementation NSString (NTVString)
+(NSString *)slnShowString:(NSNumber *)number{
    NSInteger index = [number integerValue];
    NSString *string;
    switch (index) {
        case 101:
            string = @"待审核";
            break;
        case 102:
            string = @"待支付";
            break;
        case 103:
            string = @"已支付";
            break;
        case 104:
            string = @"待收货";
            break;
        case 106:
            string = @"申请失败";
            break;
        case 199:
            string = @"申请完成";
            break;
            
    }
    return string;
}

/**
 @method 获取指定宽度情况ixa，字符串value的高度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param andWidth 限制字符串显示区域的宽度
 @result float 返回的高度
 */
+ (float) heightForString:(NSString *)value font:(UIFont *)font andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}

+ (BOOL)isHaveIllegalChar:(NSString *)str{
    
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[`~!@#$%^&*()|{}':;'\\[\\].<>/~！@#￥%……&*（）——+|{}【】‘：”“’]"];
    NSRange range = [str rangeOfCharacterFromSet:doNotWant];
    return range.location<str.length;
}
+ (NSString *)slnSex:(NSString *)sex{
    NSString *sex1;
    NSInteger sexIndex = [sex integerValue];
    if (sexIndex == 0) {
        sex1 =  @"";
    }else if (sexIndex == 1) {
        sex1 =  @"男";
    }else if (sexIndex == 2){
        sex1 =  @"女";
    }else{
        sex1 =  @"";
    }
    return sex1;
}
@end
