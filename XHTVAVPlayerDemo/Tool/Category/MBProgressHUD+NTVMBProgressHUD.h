//
//  MBProgressHUD+NTVMBProgressHUD.h
//  DisabledProject
//
//  Created by 乔冬 on 17/4/18.
//  Copyright © 2017年 com.xinhuatv. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (NTVMBProgressHUD)
+ (void)ntvShowHUDAddView:(UIView *)view  WithLabelText:(NSString *)text AfterDelay:(NSTimeInterval)delay;
+ (void)ntvShowHUDAddView:(UIView *)view  WithLabelText:(NSString *)text;
+ (void)ntvShowHUDAddView:(UIView *)view  WithText:(NSString *)text;
+ (void)ntvShowHUDAddView:(UIView *)view  WithLabelText:(NSString *)text Font:(UIFont *)font;
+ (void)ntvShowHUDAddView:(UIView *)view ;
+ (void)ntvHideHUDAddView:(UIView *)view ;
+ (void)ntvHideAllHUDAddView:(UIView *)view;
@end
