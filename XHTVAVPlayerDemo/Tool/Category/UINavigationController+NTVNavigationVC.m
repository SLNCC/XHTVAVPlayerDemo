//
//  UINavigationController+NTVNavigationVC.m
//  DisabledProject
//
//  Created by 乔冬 on 17/5/2.
//  Copyright © 2017年 com.xinhuatv. All rights reserved.
//

#import "UINavigationController+NTVNavigationVC.h"
@implementation UINavigationController (NTVNavigationVC)
- (void)slnEdgesForExtendedLayout{
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}
- (void)popToViewControllerWithNavigationController:(UIViewController *)vc popToControllerWithIndex:(NSInteger )index isToPopViewController:(BOOL)isPopViewController{
    NSArray *controllers = vc.navigationController.viewControllers;
    if ([controllers objectAtIndex:index] != nil) {
        
        [vc.navigationController popToViewController:[controllers objectAtIndex:index] animated:NO];
    }else{
        if (isPopViewController) {
            
            [vc.navigationController popViewControllerAnimated:YES];
        }
    }
    
}
- (void) popToViewControllerWithNavigationController:(UIViewController *)vc popToControllerWithIndex:(NSInteger )index{
    NSArray *controllers = vc.navigationController.viewControllers;
    if ([controllers objectAtIndex:index] != nil) {
        [vc.navigationController popToViewController:[controllers objectAtIndex:index] animated:NO];
    }
    
}
- (void)popToViewControllerWithViewController:(UIViewController *)vc popToControllerWithIndex:(NSInteger )index{
    NSArray *controllers = vc.childViewControllers;
    if ([controllers objectAtIndex:index] != nil) {
        [vc.navigationController popToViewController:[controllers objectAtIndex:index] animated:NO];
    }
    
}




- (void)slnPopToControllerWithNavigationVC:( UIViewController *)vc   ClassVC:(NSString *)classVC{
    NSArray *controllers = vc.navigationController.viewControllers;
    BOOL isFindWIlVc = YES;
    for (int index = 0; index < controllers.count; index ++ ) {
        
        if ( [controllers objectAtIndex:index] != nil  && [[controllers objectAtIndex:index] isKindOfClass:[NSClassFromString(classVC) class]]) {
            isFindWIlVc = NO;
            [vc.navigationController popToViewController:[controllers objectAtIndex:index]  animated:YES];
            break;
        }
    }
    if (isFindWIlVc) {
        [vc.navigationController popToRootViewControllerAnimated:YES];
    }
}
@end
