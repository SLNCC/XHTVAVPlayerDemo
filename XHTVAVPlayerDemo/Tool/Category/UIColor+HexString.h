//
//  UIColor+HexString.h
//  雷达动画
//
//  Created by 乔冬 on 16/5/5.
//  Copyright © 2016年 XinHuaTV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)
/**
 *  十六进制的颜色转换为UIColor
 *
 *  @param color   十六进制的颜色
 *
 *  @return   UIColor
 */
+ (UIColor *)colorwithHexString:(NSString *)color;
@end
