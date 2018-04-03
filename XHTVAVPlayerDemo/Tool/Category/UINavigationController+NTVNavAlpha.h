//
//  UINavigationController+NTVNavAlpha.h
//  XHTVShortVideoProject
//
//  Created by 乔冬 on 2018/1/8.
//  Copyright © 2018年 XinHuaTV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (NTVNavAlpha)

@end
@interface UIViewController (NTVNavAlpha)

/// navAlpha
@property (nonatomic, assign) CGFloat navAlpha;

/// navbackgroundColor
@property (null_resettable, nonatomic, strong) UIColor *navBarTintColor;

/// tintColor
@property (null_resettable, nonatomic, strong) UIColor *navTintColor;
//setBackgroundImage
@property (null_resettable, nonatomic, strong) UIImage *navBackgroundImage;

@end
