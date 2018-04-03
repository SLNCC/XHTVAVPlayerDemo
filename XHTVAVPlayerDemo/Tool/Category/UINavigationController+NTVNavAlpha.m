//
//  UINavigationController+NTVNavAlpha.m
//  XHTVShortVideoProject
//
//  Created by 乔冬 on 2018/1/8.
//  Copyright © 2018年 XinHuaTV. All rights reserved.
//

#import "UINavigationController+NTVNavAlpha.h"
#import "UINavigationBar+NTVNavBar.h"
@implementation UINavigationController (NTVNavAlpha)

/// UINavigationBar
-(void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item {
    navigationBar.tintColor = self.topViewController.navTintColor;
    navigationBar.barTintColor = self.topViewController.navBarTintColor;
    navigationBar.navAlpha = self.topViewController.navAlpha;
}
-(BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item {
    navigationBar.tintColor = self.topViewController.navTintColor;
    navigationBar.barTintColor = self.topViewController.navBarTintColor;
    navigationBar.navAlpha = self.topViewController.navAlpha;
    return YES;
}

@end

#pragma mark - UIViewController + NavAlpha

static char *vcAlphaKey = "vcAlphaKey";
static char *vcColorKey = "vcColorKey";
static char *vcNavtintColorKey = "vcNavtintColorKey";
static char *vcNavBackgroundImageKey = "vcNavBackgroundImageKey";
@implementation UIViewController (NavAlpha)

-(CGFloat)navAlpha {
    if (objc_getAssociatedObject(self, vcAlphaKey) == nil) {
        return 1;
    }
    return [objc_getAssociatedObject(self, vcAlphaKey) floatValue];
}
-(void)setNavAlpha:(CGFloat)navAlpha {
    CGFloat alpha = MAX(MIN(navAlpha, 1), 0);// 0~1
    self.navigationController.navigationBar.navAlpha = alpha;
    objc_setAssociatedObject(self, vcAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// backgroundColor
-(UIColor *)navBarTintColor {
    UIColor *color = objc_getAssociatedObject(self, vcColorKey);
    if (color == nil) {
        color = [UINavigationBar appearance].barTintColor;
    }
    return color;
}
-(void)setNavBarTintColor:(UIColor *)navBarTintColor {
    self.navigationController.navigationBar.barTintColor = navBarTintColor;
    objc_setAssociatedObject(self, vcColorKey, navBarTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// tintColor
-(UIColor *)navTintColor {
    UIColor *color = objc_getAssociatedObject(self, vcNavtintColorKey);
    if (color == nil) {
        color = [UINavigationBar appearance].tintColor;
    }
    return color;
}
-(void)setNavTintColor:(UIColor *)tintColor {
    self.navigationController.navigationBar.tintColor = tintColor;
    objc_setAssociatedObject(self, vcNavtintColorKey, tintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIImage *)navBackgroundImage{
    UIImage *navBackgroundImage = objc_getAssociatedObject(self, vcNavBackgroundImageKey);
    if (navBackgroundImage == nil) {
        navBackgroundImage = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    }
    return navBackgroundImage;
}
- (void)setNavBackgroundImage:(UIImage *)navBackgroundImage{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_img"] forBarMetrics:UIBarMetricsDefault];
    objc_setAssociatedObject(self, vcNavBackgroundImageKey, navBackgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


