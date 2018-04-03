//
//  UINavigationController+NTVNavigationVC.h
//  DisabledProject
//
//  Created by 乔冬 on 17/5/2.
//  Copyright © 2017年 com.xinhuatv. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UINavigationController (NTVNavigationVC)
- (void)slnEdgesForExtendedLayout;
/**
 *  返回指定的位置如果对象出错，返回到上一级
 *
 *  @param  vc c
 *  @param index   要返回的指定的页面 --从根控制器算起 0，1，2，...
 *  @param isPopViewController YES返回到上一级 NO 什么也不操作
 */
- (void)popToViewControllerWithNavigationController:(UIViewController *)vc popToControllerWithIndex:(NSInteger )index isToPopViewController:(BOOL)isPopViewController;

- (void)popToViewControllerWithNavigationController:(UIViewController *)vc popToControllerWithIndex:(NSInteger )index;
- (void)popToViewControllerWithViewController:(UIViewController *)vc popToControllerWithIndex:(NSInteger )index;
- (void)pooToNTVAIDParentController:(UIViewController *)nav;
- (void)pooToNTVAIDParentController:(UIViewController *)nav PointToIndex:(NSInteger )index;
//vc 当前self   classVC 要返回的类 
- (void)slnPopToControllerWithNavigationVC:( UIViewController *)vc   ClassVC:(NSString *)classVC;
@end
