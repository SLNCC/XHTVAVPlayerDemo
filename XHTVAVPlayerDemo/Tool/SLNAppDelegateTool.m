//
//  SLNAppDelegateTool.m
//  VerificationCode
//
//  Created by 乔冬 on 17/4/11.
//  Copyright © 2017年 XinHuaTV. All rights reserved.
//

#import "SLNAppDelegateTool.h"
//#import "SLNStoreTool.h"
//#import "NTVAppLoginViewController.h"
#import "NTVTabBarController.h"
//#import "NTVDisableMainController.h"
#import "NTVNavigationController.h"
//#import <AlipaySDK/AlipaySDK.h>
@interface  SLNAppDelegateTool()
@end
@implementation SLNAppDelegateTool


//setUINavigationBar
+(void)setNavigationBarAppearance{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigation_img"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    [ [UINavigationBar appearance]setTitleVerticalPositionAdjustment : 40.0 forBarMetrics : UIBarMetricsDefault ] ;
//    [ self . navigationItem . leftBarButtonItem setBackgroundVerticalPositionAdjustment :  40.0 forBarMetrics : UIBarMetricsDefault ] ;
}
//setUITabBar
+(void)setTabBarAppearance{
    CGFloat size = 13;
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor colorwithHexString:@"#333333"],NSFontAttributeName:[UIFont boldSystemFontOfSize:size]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor colorwithHexString:@"#44388c"],NSFontAttributeName:[UIFont boldSystemFontOfSize:size]} forState:UIControlStateSelected];
}

//跳转很控制器
+(void)slnChooseRootController:(id)viewController{
    UIWindow *window = [[UIApplication sharedApplication] delegate].window;
    window.rootViewController = viewController;
}
//登录之后choose根控制器
//+(void)slnChooseToRootControllerWithStoreIsAuto:(BOOL)isAuto
//               WithNTVUserLoginStyle:(NTVUserLoginStyle )ntvUserLoginStyle
//{
//    UIWindow *window = [[UIApplication sharedApplication] delegate].window;
//    if (isAuto && (ntvUserLoginStyle == NTVUserLoginStyleDisabledPerson) ) {
//
//        window.rootViewController = [[NTVTabBarController alloc]init];
//    }else{
//           UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[NTVAppLoginViewController alloc]init]];
//            window.rootViewController = nav;
//    }
//
//}
//+(void)slnChooseToMineControllerWithStoreIsAuto:(BOOL)isAuto{
//    NTVUserLoginStyle ntvUserLoginStyle = [[SLNStoreTool shareInstance] slnReadUserLoginStyle];
//    [self slnChooseToMineControllerWithStoreIsAuto:isAuto WithNTVUserLoginStyle:ntvUserLoginStyle];
//}
//+(void)slnChooseToMineControllerWithStoreIsAuto:(BOOL)isAuto
//                          WithNTVUserLoginStyle:(NTVUserLoginStyle )ntvUserLoginStyle
//{
//    UIWindow *window = [[UIApplication sharedApplication] delegate].window;
//
//    if (isAuto) {
//        switch (ntvUserLoginStyle) {
//            case NTVUserLoginStyleDisabledNone:
//                      [self jumptoLoginVCIsAuto:isAuto];
//                   break;
//            case NTVUserLoginStyleDisabledPerson:
//                {
//                    NTVNavigationController *nav = [[NTVNavigationController alloc]initWithRootViewController:[[NTVDisableMainController alloc]init]];
//                    window.rootViewController = nav;
//                }
//                break;
//            case NTVUserLoginStyleHeartPerson:
//               {
//
//               }
//                break;
//            case NTVUserLoginStyleFullTimeMember:
//                {
//
//                }
//                break;
//
//        }
//    }else{
//        [self jumptoLoginVCIsAuto:isAuto];
//    }
//
//}
//+(void)jumptoLoginVCIsAuto:(BOOL)isAuto{
//
//
//    UIWindow *window = [[UIApplication sharedApplication] delegate].window;
//    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *lastVersion = [defaults objectForKey:versionKey];
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
//
//
//    NTVAppLoginViewController *vc =    [[NTVAppLoginViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//    if ([currentVersion isEqualToString:lastVersion]) {
////        [vc slnChooseLoginView];
//        [[SLNStoreTool new]slnBaseUserDefaultsStoreValue:@(YES) Key:@"ISLOGIN"];
//
//    } else {
//        [defaults setObject:currentVersion forKey:versionKey];
//        [defaults synchronize];
//    }
//
//    window.rootViewController = nav;
//}
//注册远程通知

+(void)registeNotification:(UIApplication *)application Delegate:(id )delegate {
        if (   [[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
            //请求通知权限, 本地和远程共用
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    
                    NSLog(@"请求成功");
                } else {
                    DLog(@"请求失败");
                }
            }];
            
            //注册远程通知
            [[UIApplication sharedApplication] registerForRemoteNotifications];
            
            //设置通知的代理
            center.delegate = delegate;

        }else if (  [[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            
            if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)]) {
                UIUserNotificationSettings *notiSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound) categories:nil];
                [application registerUserNotificationSettings:notiSettings];
                [application registerForRemoteNotifications];
            }
            
    }else{
        
        UIRemoteNotificationType type = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:type];
        
    }


}

+(NSString *)slnDeviceTokenStringWithData:(NSData *)deviceToken{
    
    NSString *pushToken = [[[[deviceToken description]
                             stringByReplacingOccurrencesOfString:@"<"
                             withString:@""]
                            stringByReplacingOccurrencesOfString:@">"
                            withString:@""]
                           stringByReplacingOccurrencesOfString:@" "
                           withString:@""];
//    [[SLNStoreTool shareInstance]slnDeviceTokenStore:pushToken];
    return pushToken;
}


//iOS 10
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
//    NSDictionary *userInfo = notification.request.content.userInfo;
//    DLog(@"%@",userInfo);
    completionHandler(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert);
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
//      NSDictionary *userInfo = response.notification.request.content.userInfo;
//     DLog(@"%@",userInfo);
    completionHandler(UIBackgroundFetchResultNewData);
}
//随机生成
+(NSString*) uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result  = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}
+ (void)exitApplication {
    //    exit(0);
    UIWindow *window = [[UIApplication sharedApplication] delegate].window;
    [UIView animateWithDuration:0.5f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
    
}


+ (void)alipayApplication:(UIApplication *)app openURL:(NSURL *)url{
    //    if ([url.host isEqualToString:@"safepay"]) {
    //        //跳转支付宝钱包进行支付，处理支付结果
    //        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
    //            [[NSNotificationCenter defaultCenter]postNotificationName:@"aliPayReslut" object:nil userInfo:resultDic];
    //            DLog(@"result === %@",resultDic);
    //        }];
    //    }
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            [[NSNotificationCenter defaultCenter]postNotificationName:NTVAliPayReslut object:nil userInfo:resultDic];
//            DLog(@"result === %@",resultDic);
//        }];
    }
    
}
// 获取token
+ (void)slnTokenMethod{
//    [[NTVAccessToken sharedInstance] getAccessToken];
}
@end
