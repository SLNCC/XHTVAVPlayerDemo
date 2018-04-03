//
//  MBProgressHUD+NTVMBProgressHUD.m
//  DisabledProject
//
//  Created by 乔冬 on 17/4/18.
//  Copyright © 2017年 com.xinhuatv. All rights reserved.
//

#import "MBProgressHUD+NTVMBProgressHUD.h"

@implementation MBProgressHUD (NTVMBProgressHUD)
+ (void)ntvShowHUDAddView:(UIView *)view  WithLabelText:(NSString *)text AfterDelay:(NSTimeInterval)delay{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.layer.cornerRadius = 10;
    hud.labelText = text;
    [hud hideAnimated:YES afterDelay:delay];
//    [hud hide:YES afterDelay:delay];
    
}
+ (void)ntvShowHUDAddView:(UIView *)view  WithText:(NSString *)text{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.layer.cornerRadius = 10;
    hud.labelText = text;
}
+ (void)ntvShowHUDAddView:(UIView *)view  WithLabelText:(NSString *)text Font:(UIFont *)font{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.layer.cornerRadius = 10;
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    hud.label.font = font;
    [hud hideAnimated:YES afterDelay:1.5f];
//    [hud hide:YES afterDelay:1.5f];
    
}
+ (void)ntvShowHUDAddView:(UIView *)view  WithLabelText:(NSString *)text{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
     hud.layer.cornerRadius = 10;
    hud.label.text = text;
    
    [hud hideAnimated:YES afterDelay:1.5f];
//    [hud hide:YES afterDelay:1.5f];

}
+ (void)ntvShowHUDAddView:(UIView *)view {
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}
+ (void)ntvHideHUDAddView:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
}
+ (void)ntvHideAllHUDAddView:(UIView *)view {
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}
@end
