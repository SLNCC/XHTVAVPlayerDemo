//
//  UITableView+NoNetworkTableView.h
//  XinhuaVideo
//
//  Created by 乔冬 on 16/6/27.
//  Copyright © 2016年 com.xinhuashixun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

extern  NSString * const KnoNetworkTableViewRefreshEventNotification;
extern  NSString * const KnoNetworkTableViewRefreshLabel;
@interface UITableView (NoNetworkTableView)
@property (nonatomic,strong)UIView *slBackgroundView;
@property (nonatomic,strong)UIImageView *noContentView;
@property (nonatomic,strong)UILabel *titleLabel;
- (void)addNetWorkSubViews;
- (void)addNetNoWorkSubViews:(NSString *)icon titleLabel:(NSString *)string ;
- (void)addNetWorkSubViewsImg:(NSString *)iconImg  OrginY:(CGFloat)orginY Text:(NSString *)text;
- (void)removeSubViews;
@end
