//
//  UIBarButtonItem+SLItem.h
//  customTabBarDemo
//
//  Created by 乔冬 on 16/5/19.
//  Copyright © 2016年 XinHuaTV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SLItem)

+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title Image:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title
                                       font:(UIFont *)font
                                      Image:(UIImage *)image
                                  highImage:(UIImage *)highImage
                                     target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvent;
+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title
                                       font:(UIFont *)font
                                     target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end
