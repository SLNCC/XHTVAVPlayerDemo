//
//  SLNAppDelegateTool.h
//  VerificationCode
//
//  Created by 乔冬 on 17/4/11.
//  Copyright © 2017年 XinHuaTV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
 #import <UserNotifications/UserNotifications.h>
typedef enum {
     NTVUserLoginStyleNone = 0,
    
}NTVUserLoginStyle;

@interface SLNAppDelegateTool : NSObject<UNUserNotificationCenterDelegate>

+ (void)exitApplication;
//setUINavigationBar
+(void)setNavigationBarAppearance;
//setUITabBar
+(void)setTabBarAppearance;

+(void)slnChooseRootController:(id)viewController;

//登录之后choose根控制器
+(void)slnChooseToMineControllerWithStoreIsAuto:(BOOL)isAuto;
//登录之后choose根控制器
+(void)slnChooseToRootControllerWithStoreIsAuto:(BOOL)isAuto
                          WithNTVUserLoginStyle:(NTVUserLoginStyle )ntvUserLoginStyle;
//指定跟控制器我的
+(void)slnChooseToMineControllerWithStoreIsAuto:(BOOL)isAuto
                          WithNTVUserLoginStyle:(NTVUserLoginStyle )ntvUserLoginStyle;

//注册通知
+(NSString *)slnDeviceTokenStringWithData:(NSData *)deviceToken;
+(void)registeNotification:(UIApplication *)application
                  Delegate:(id )delegate;

//支付宝APp跳转
+ (void)alipayApplication:(UIApplication *)app openURL:(NSURL *)url;
+ (void)slnTokenMethod;

@end
