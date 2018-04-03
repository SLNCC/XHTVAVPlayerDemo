//
//  UIImageView+NTVImageView.m
//  DisabledProject
//
//  Created by 乔冬 on 2017/7/28.
//  Copyright © 2017年 com.xinhuatv. All rights reserved.
//

#import "UIImageView+NTVImageView.h"

@implementation UIImageView (NTVImageView)
- (void)ntvImageViewFillAndClipsWithImgView:(UIImageView *)imgView{
    [imgView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    imgView.contentMode =  UIViewContentModeScaleAspectFill;
    imgView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    imgView.clipsToBounds  = YES;
}
@end
