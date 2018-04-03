//
//  UITextField+NTVTextField.m
//  DisabledProject
//
//  Created by 乔冬 on 2017/8/23.
//  Copyright © 2017年 com.xinhuatv. All rights reserved.
//

#import "UITextField+NTVTextField.h"

@implementation UITextField (NTVTextField)
- (NSString *)slnCheckPhoneWithTextFeild:(UITextField *)textField imitIndexWithIndex:(NSInteger)index{
    
    if (textField.text.length > index) {
        textField.text = [textField.text substringToIndex:index + 1];
        return textField.text;
    }else{
        return textField.text;
    }
}
@end
