//
//  UICollectionView+NoNetworkCollectionView.h
//  XinhuaVideo
//
//  Created by 乔冬 on 16/6/28.
//  Copyright © 2016年 com.xinhuashixun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (NoNetworkCollectionView)
@property (nonatomic,strong)UIImageView *noContentView;
@property (nonatomic,strong)UILabel *titleLabel;
- (void)addNetWorkSubViews;
- (void)addNetWorkSubViewsImg:(NSString *)iconImg  Text:(NSString *)text;
- (void)addNetWorkSubViewsImg:(NSString *)iconImg  OrginY:(CGFloat)orginY Text:(NSString *)text;
- (void)removeSubViews;
@end
