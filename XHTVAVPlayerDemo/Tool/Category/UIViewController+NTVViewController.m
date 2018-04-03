//
//  UIViewController+NTVViewController.m
//  DisabledProject
//
//  Created by 乔冬 on 2017/7/26.
//  Copyright © 2017年 com.xinhuatv. All rights reserved.
//

#import "UIViewController+NTVViewController.h"

@implementation UIViewController (NTVViewController)
- (void)slnEdgesForExtendedLayout{
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

@end
