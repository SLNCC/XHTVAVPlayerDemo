//
//  UIView+Frame.h
//  customTabBarDemo
//
//  Created by 乔冬 on 16/5/19.
//  Copyright © 2016年 XinHuaTV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
//宽高位置大小
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

//中心点的x与y
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@end
