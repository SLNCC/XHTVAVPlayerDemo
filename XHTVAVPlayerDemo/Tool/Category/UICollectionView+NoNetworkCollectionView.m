//
//  UICollectionView+NoNetworkCollectionView.m
//  XinhuaVideo
//
//  Created by 乔冬 on 16/6/28.
//  Copyright © 2016年 com.xinhuashixun. All rights reserved.
//

#import "UICollectionView+NoNetworkCollectionView.h"

@implementation UICollectionView (NoNetworkCollectionView)
static char *noContent = "noCollection";
static char *title = "notitle";
- (void)setNoContentView:(UIImageView *)noContentView {
    objc_setAssociatedObject(self,noContent , noContentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImageView *)noContentView {
    return objc_getAssociatedObject(self, noContent);
}

-(void)setTitleLabel:(UILabel *)titleLabel{
    objc_setAssociatedObject(self, title, titleLabel,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UILabel *)titleLabel{
    return objc_getAssociatedObject(self, title);
}
- (void)addNetWorkSubViews {
    [self slnSetAttributeWithIcon:@"" Text:@""];
    [self slnLayoutviewWithOrginY:0.0];

}
- (void)addNetWorkSubViewsImg:(NSString *)iconImg  Text:(NSString *)text {

    [self slnSetAttributeWithIcon:iconImg Text:text];
    [self slnLayoutviewWithOrginY:0.0];
    
}
- (void)addNetWorkSubViewsImg:(NSString *)iconImg  OrginY:(CGFloat)orginY Text:(NSString *)text {
    
    [self slnSetAttributeWithIcon:iconImg Text:text];
    [self slnLayoutviewWithOrginY:orginY];
    
}
- (void)slnSetAttributeWithIcon:(NSString *)iconstr Text:(NSString *)text{
        [self removeSubViews];
        self.noContentView =  [self slnImgView];
        NSString *iconStr;
        if (iconstr.length > 0) {
            iconStr = iconstr;
        }else{
            iconStr =   @"emptyIcon";
        }
        self.noContentView.image = [UIImage imageNamed:iconStr];
        [self addSubview:self.noContentView];
        
        self.titleLabel = [self slnTitleLabel];
    
        NSString *textStr;
        if (text.length > 0) {
            textStr = text;
        }else{
            textStr =   @"当前页面没有数据";
        }
        self.titleLabel.text = textStr;
        [self addSubview:self.titleLabel];

}
-(void)slnLayoutviewWithOrginY:(CGFloat)orginy{
    
    CGFloat  SCREENHEIGHT =  [UIScreen mainScreen].bounds.size.height;
    CGFloat SCREENWIDTH = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat iconW = 218/2.0;
    CGFloat iconH = 156/2.0;
    CGFloat margin = 56/2.0;
    CGFloat labelH = 35;
    CGFloat ogrinY = (SCREENHEIGHT  - iconW - margin - labelH - kNavBarHeight - kMenuHeight)/2.0;
    if (orginy > 0.0) {
        ogrinY = orginy;
    }
    self.noContentView.frame = CGRectMake((SCREENWIDTH - iconW )/2.0, ogrinY, iconW, iconH);
    self.titleLabel.frame = CGRectMake(0, ogrinY + iconH + margin, SCREENWIDTH, labelH);
}
-(UIImageView *)slnImgView{
    UIImageView *slnImgView = [[UIImageView alloc] init];
    slnImgView.contentMode = UIViewContentModeScaleAspectFit;
    return slnImgView;
}
-(UILabel *)slnTitleLabel{
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.userInteractionEnabled = YES;
    titleLabel.textColor = [UIColor colorwithHexString:@"f67172"];
    return titleLabel;
    
}
- (void)removeSubViews{
    [self.noContentView removeFromSuperview];
    [self.titleLabel removeFromSuperview];
}
@end
