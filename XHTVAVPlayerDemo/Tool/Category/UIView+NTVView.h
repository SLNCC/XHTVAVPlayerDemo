//
//  UIView+NTVView.h
//  XHTVShortVideoProject
//
//  Created by 乔冬 on 2017/11/22.
//  Copyright © 2017年 XinHuaTV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NTVView)
//给UILabel设置行间距和字间距
- (void)setLabelSpace:(UILabel*)label
            withValue:(NSString*)str
             withFont:(UIFont*)font ;

//计算UILabel的高度(带有行间距的情况)
- (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font
                     withWidth:(CGFloat)width;

- (CGSize)getSpaceViewSize:(NSString*)str
                     withFont:(UIFont*)font ;
@end
