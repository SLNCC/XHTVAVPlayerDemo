//
//  KRVideoPlayerControlView.h
//  KRKit
//
//  Created by aidenluo on 5/23/15.
//  Copyright (c) 2015 36kr. All rights reserved.
//

#import <UIKit/UIKit.h>
  typedef NS_ENUM(NSUInteger, NTVVideoNetErrorStyle) {
    //     #：请求超时-1001
    NTVVideoNetErrorStyleTimeout = -1001,
    //    #找不到服务器：-1003
    NTVVideoNetErrorStyleDataLengthExceedsMaximum = -1003,
    //    #：服务器内部错误-1004
    NTVVideoNetErrorStyleCannotConnectToHost = -1004,
    //   #网络中断：-1005
    NTVVideoNetErrorStyleNetworkConnectionLost  = -1005,
    //   #无网络连接：-1009
    NTVVideoNetErrorStyleNotConnectedToInternet = -1009

};

@interface KRVideoPlayerControlView : UIView

@property (nonatomic, strong, readonly) UIView *topBar;
@property (nonatomic, strong, readonly) UIView *bottomBar;
@property (nonatomic, strong, readonly) UIButton *playButton;
@property (nonatomic, strong, readonly) UIButton *pauseButton;
@property (nonatomic, strong, readonly) UIButton *fullScreenButton;
@property (nonatomic, strong, readonly) UIButton *shrinkScreenButton;
@property (nonatomic, strong, readonly) UIButton *errorButton;
@property (nonatomic, strong, readonly) UISlider *progressSlider;
@property (nonatomic, strong, readonly) UIButton *closeButton;
@property (nonatomic, strong, readonly) UILabel *timeLabel;
@property (nonatomic, strong, readonly) UIActivityIndicatorView *indicatorView;
@property (nonatomic, assign) NTVVideoNetErrorStyle videoNetErrorStyle;

- (void)animateHide;
- (void)animateShow;
- (void)autoFadeOutControlBar;
- (void)cancelAutoFadeOutControlBar;

@end
