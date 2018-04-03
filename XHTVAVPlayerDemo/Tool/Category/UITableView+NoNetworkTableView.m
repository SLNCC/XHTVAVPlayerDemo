//
//  UITableView+NoNetworkTableView.m
//  XinhuaVideo
//
//  Created by 乔冬 on 16/6/27.
//  Copyright © 2016年 com.xinhuashixun. All rights reserved.
//

#import "UITableView+NoNetworkTableView.h"
static char *noContent = "noContent";
static char *slBackground = "slBackground";
static char *title = "title";
NSString * const KnoNetworkTableViewRefreshEventNotification = @"KnoNetworkTableViewRefreshEventNotification";
NSString *const KnoNetworkTableViewRefreshLabel = @"数据出错或者网络出错，点击刷新";
@implementation UITableView (NoNetworkTableView)

- (void)setNoContentView:(UIImageView *)noContentView {
    objc_setAssociatedObject(self,noContent , noContentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImageView *)noContentView {
    return objc_getAssociatedObject(self, noContent);
}
-(void)setSlBackgroundView:(UIView *)slBackgroundView{
    objc_setAssociatedObject(self, slBackground, slBackgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)slBackgroundView{
    return objc_getAssociatedObject(self, slBackground);
}

-(void)setTitleLabel:(UILabel *)titleLabel{
    objc_setAssociatedObject(self, title, titleLabel,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UILabel *)titleLabel{
    return objc_getAssociatedObject(self, title);
}
- (void)refreshAction{
    [[NSNotificationCenter defaultCenter]postNotificationName:KnoNetworkTableViewRefreshEventNotification object:nil];
}
- (void)addNetWorkSubViewsImg:(NSString *)iconImg  OrginY:(CGFloat)orginY Text:(NSString *)text{
    [self slnSetAttributesWithIcon:iconImg Text:text];
    [self slnLayoutviewWithOrginY:orginY];
}
- (void)addNetNoWorkSubViews:(NSString *)icon titleLabel:(NSString *)string {
    [self slnSetAttributesWithIcon:icon Text:string];
        [self slnLayoutviewWithOrginY:0.0];
    

}

- (void)addNetWorkSubViews {
    [self slnSetAttributesWithIcon:@"" Text:@""];
    [self slnLayoutviewWithOrginY:0.0];
}

- (void)slnSetAttributesWithIcon:(NSString *)iconstr Text:(NSString *)text{
    
    [self removeSubViews];
    
    self.slBackgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UITapGestureRecognizer *tap =  [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(refreshAction)];
    [self.slBackgroundView addGestureRecognizer:tap];
    [self addSubview:self.slBackgroundView];
    
    self.noContentView =  [self slnImgView];
    NSString *iconStr;
    if (iconstr.length > 0) {
        iconStr = iconstr;
    }else{
        iconStr =  @"emptyIcon";
        
    }
    
    self.noContentView.image =  [UIImage imageNamed:iconStr];
    [self addSubview:self.noContentView];
    
    self.titleLabel = [self slnTitleLabel];
    self.titleLabel.userInteractionEnabled = YES;
    NSString *textStr;
    if (text.length > 0) {
        textStr = text;
    }else{
        textStr =     @"当前页面没有数据";
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
    self.noContentView.frame = CGRectMake((SCREENWIDTH - iconW )/2.0, ogrinY, iconW, iconH);
    self.titleLabel.frame = CGRectMake(0, ogrinY + iconH + margin, SCREENWIDTH, labelH);
}
-(UIImageView *)slnImgView{
    UIImageView *slnImgView = [[UIImageView alloc] init];
    slnImgView.userInteractionEnabled = YES;
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
    [UITapGestureRecognizer cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshAction) object:nil];
    [self.slBackgroundView  removeFromSuperview];
    if (self.noContentView || self.titleLabel) {
        [self.noContentView removeFromSuperview];
        [self.titleLabel removeFromSuperview];
    }
}
@end
