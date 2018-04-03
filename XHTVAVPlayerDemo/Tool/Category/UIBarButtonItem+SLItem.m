//
//  UIBarButtonItem+SLItem.m
//  customTabBarDemo
//
//  Created by 乔冬 on 16/5/19.
//  Copyright © 2016年 XinHuaTV. All rights reserved.
//

#import "UIBarButtonItem+SLItem.h"

@implementation UIBarButtonItem (SLItem)
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:controlEvents];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}
+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title Image:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:controlEvents];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}
+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title
                                       font:(UIFont *)font
                                      Image:(UIImage *)image
                                  highImage:(UIImage *)highImage
                                     target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:controlEvents];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}
+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title
                                       font:(UIFont *)font
                                     target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:controlEvents];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
