//
//  NTVAVPlayerController.m
//  AVPlayerDemo
//
//  Created by 乔冬 on 2018/3/27.
//  Copyright © 2018年 XinHuaTV. All rights reserved.
//

#import "NTVAVPlayerController.h"
#import <AVKit/AVKit.h>
#import "KRVideoPlayerControlView.h"
static const CGFloat kVideoPlayerControllerAnimationTimeInterval = 0.3f;
@interface NTVAVPlayerController ()
@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,strong) AVPlayerItem *playerItem;
@property (nonatomic,strong) AVPlayerLayer *playerLayer;
@property (nonatomic,strong) KRVideoPlayerControlView *videoControl;
@property (nonatomic, assign) BOOL isFullscreenMode;
@property (nonatomic, assign) BOOL isStatusBarMode;
@property (nonatomic, assign) CGRect originControlFrame;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic) CGFloat fps;
//进入后台的时间
@property (nonatomic)CMTime currentTime  ;
@end

@implementation NTVAVPlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
 
    self.videoControl = [[KRVideoPlayerControlView alloc]init];
    self.videoControl.frame = CGRectMake(0, 80, kWidth, kWidth*9/16);
    self.videoControl.backgroundColor = [UIColor blackColor];
    [self createVideoPlayView];
    

}
- (void)createVideoPlayView{
    NSString *videoString =
//    @"http://fastwebcache.yod.cn/yanglan/2013suoluosi/2013suoluosi_850/2013suoluosi_850.m3u8";
    @"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8";
//    videoString = @"http://111.13.171.164/storage/7-0/1-1/260000/44779-179600-257693.mp4";
    NSURL *playUrl = [NSURL URLWithString:videoString];
    self.playerItem = [AVPlayerItem playerItemWithURL:playUrl];
    //播放
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //缓存
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    //用于监听缓存足够播放的状态
    [self.playerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    //获取当缓存不够，视频加载不出来的情况
    [self.playerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    //如果要切换视频需要调AVPlayer的replaceCurrentItemWithPlayerItem:方法
    self.player = [AVPlayer playerWithPlayerItem:_playerItem];
    self.fps = [[[_playerItem.asset tracksWithMediaType:AVMediaTypeVideo] firstObject] nominalFrameRate];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:nil];
    self.playerLayer.player = self.player;
    self.playerLayer.frame = self.videoControl.bounds;
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //放置播放器的视图
    [self.view addSubview:self.videoControl];
    // 设置画面缩放模式
    
    [self.videoControl.layer addSublayer:self.playerLayer];
    [self.videoControl.layer  insertSublayer:self.playerLayer below:self.videoControl.bottomBar.layer];
    [self.videoControl.layer  insertSublayer:self.playerLayer below:self.videoControl.topBar.layer];
    [self.videoControl.indicatorView startAnimating];
    self.videoControl.errorButton.hidden = YES;
    [self configControlAction];
    if (self.player.status == AVPlayerStatusReadyToPlay) {
        [self playButtonClick];
    }
}
#pragma mark -- 播放状态/缓存情况观察者
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([object isKindOfClass:[AVPlayerItem class]]) {
        if ([keyPath isEqualToString:@"status"]) {
            switch (_playerItem.status) {
                case AVPlayerItemStatusReadyToPlay:
                    //推荐将视频播放放在这里
                    NSLog(@"播放");
                    [self playButtonClick];

                    [self monitorVideoPlayback];
                    
                    break;
                case AVPlayerItemStatusUnknown:
                    NSLog(@"AVPlayerItemStatusUnknown");
                    break;
                    
                case AVPlayerItemStatusFailed:
                    NSLog(@"AVPlayerItemStatusFailed");
                    DLog (@"%ld",_player.error.code)
                    DLog (@"%ld",_playerItem.error.code)
                    DLog (@"%@",_playerItem.error)
                    [_videoControl.indicatorView stopAnimating];
                    _videoControl.videoNetErrorStyle = (NTVVideoNetErrorStyle)_playerItem.error.code;
                    break;
                    
                default:
                    break;
            }
            
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array = _playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        NSLog(@"当前缓冲时间：%f",totalBuffer);
    }else if ([keyPath isEqualToString:@"playbackBufferEmpty"]){
        //获取当缓存不够，视频加载不出来的情况
        [self.videoControl.indicatorView startAnimating];
    }else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]){
        //用于监听缓存足够播放的状态
          [self.videoControl.indicatorView stopAnimating];
          [self playButtonClick];
    }

}
-(void)dealloc{
    [self deleteObservers];
}
//通过KVO 监听 获取 同时也需要移除Observer
- (void)deleteObservers{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:[self.player currentItem]];
    [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    [self.playerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp" context:nil];
     [self.playerItem removeObserver:self forKeyPath:@"playbackBufferEmpty" context:nil];
//    [self.player removeTimeObsdszszzr jb h h8erver:self];
}
#pragma mark -- 界面控制事件
- (void)configControlAction
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerMovieFinish:) name:AVPlayerItemDidPlayToEndTimeNotification object:[self.player currentItem]];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerPlaybackStalled:) name:AVPlayerItemPlaybackStalledNotification object:[self.player currentItem]];
          [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerPlayFailedToPlayToEndTimeErrorKey:) name:AVPlayerItemFailedToPlayToEndTimeNotification object:[self.player currentItem]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    [self.videoControl.playButton addTarget:self action:@selector(playButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.videoControl.pauseButton addTarget:self action:@selector(pauseButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.videoControl.closeButton addTarget:     self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.videoControl.fullScreenButton addTarget:self action:@selector(fullScreenButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.videoControl.shrinkScreenButton addTarget:self action:@selector(shrinkScreenButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.videoControl.progressSlider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.videoControl.progressSlider addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
    [self.videoControl.progressSlider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside];
    [self.videoControl.progressSlider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpOutside];
    [self.videoControl.errorButton addTarget:self action:@selector(playErrorButtonClick) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark --播放相关的通知
//退出前台
- (void)appWillResignActive:(NSNotification *)notification
{
    DLog(@"appWillResignActive")
    if (self.player) {
        [self pauseButtonClick];
        
        self.currentTime = self.player.currentTime;
    }
}
//返回前台
- (void)appBecomeActive:(NSNotification *)notification{
       DLog(@"appBecomeActive")
            [self.videoControl.indicatorView startAnimating];
    @try {
        [self.player seekToTime:self.currentTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
            if (finished) {
                [self playButtonClick];
            }
        }];
    } @catch (NSException *exception) {
          [self playButtonClick];
         DLog(@"exception")
    }
    [self.videoControl.indicatorView stopAnimating];
}
- (void)playerPlayFailedToPlayToEndTimeErrorKey:(NSNotification *)noti{
    DLog(@"%@",noti.object);
    
    DLog(@"%@", _playerItem.error);
    DLog(@"%ld", _playerItem.error.code);
    DLog(@"%@", _player.error);
    DLog(@"%ld", _player.error.code);
    DLog(@"playerPlayFailedToPlayToEndTimeErrorKey")
}
- (void)playerPlaybackStalled:(NSNotification *)noti{
    DLog(@"%@",noti.object);
   
    DLog(@"%@", _playerItem.error);
    DLog(@"%ld", _playerItem.error.code);
    DLog(@"%@", _player.error);
    DLog(@"%ld", _player.error.code);
    DLog(@"playerPlaybackStalled")
    [self.videoControl.indicatorView stopAnimating];
    [self pauseButtonClick];
}
//播放完毕
- (void)playerMovieFinish:(NSNotification *)noti{
    [self  pauseButtonClick];
    [_player seekToTime:kCMTimeZero];
}
#pragma mark --出错重新尝试
- (void)playErrorButtonClick{
      [self deleteObservers];
    [self createVideoPlayView];
//    if (_player.status == AVPlayerStatusReadyToPlay) {
//        [self  playButtonClick];
//    }else{
//          [_player seekToTime:kCMTimeZero];
//    }
    
}
#pragma mark --UISlider control
- (void)setProgressSliderMaxMinValues {
    float duration = CMTimeGetSeconds(self.playerItem.duration);
    self.videoControl.progressSlider.minimumValue = 0.f;
    if (duration > 0.0) {
        self.videoControl.progressSlider.maximumValue = floorf(duration);
    }
}
- (void)progressSliderTouchBegan:(UISlider *)slider {
    [self  pauseButtonClick];
    [self.videoControl.indicatorView startAnimating];
    [self.videoControl cancelAutoFadeOutControlBar];
}
- (void)progressSliderTouchEnded:(UISlider *)slider {

    float currentTime = floorf(slider.value);
    float totalTime = CMTimeGetSeconds(self.playerItem.duration);
    [self setTimeLabelValues:currentTime totalTime:totalTime];
    CMTime time = CMTimeMakeWithSeconds(currentTime, _fps);
    if(currentTime == 0.0){
        [_player seekToTime:kCMTimeZero];
        [self playButtonClick];
    }else{
        __weak typeof (self) WeakSelf = self;
        [_player seekToTime:time  toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero  completionHandler:^(BOOL finished) {
            DLog(@"呵呵")
            if(WeakSelf.playerItem .status == AVPlayerItemStatusReadyToPlay){
                [WeakSelf playButtonClick];
                [WeakSelf.videoControl autoFadeOutControlBar];
            }else{
                DLog(@"错误")
            }
        }];
    }
}
- (void)progressSliderValueChanged:(UISlider *)slider {
    float currentTime = floorf(slider.value);
    float totalTime = CMTimeGetSeconds(self.playerItem.duration);
    [self setTimeLabelValues:currentTime totalTime:totalTime];
}
#pragma mark -- private
// 获取总时间,但是刚开始有可能是Nan,判断下就ok了
// 这个总时间在外面设置的时候基本都是一起刷新UI显示的所以设置个Timer更新显示就行了
- (NSTimeInterval)totalTime {
    CMTime totalTime = self.player.currentItem.duration;
    NSTimeInterval sec = CMTimeGetSeconds(totalTime);
    if (isnan(sec)) {
        return 0;
    }
    return sec;
}
// 其他的数据AVPlayer 其实都有提供,比如说加载,缓存进度
- (float)loadDataProgress {
    if (self.totalTime == 0) {
        return 0;
    }
    CMTimeRange range = [[self.player.currentItem loadedTimeRanges].lastObject CMTimeRangeValue];
    CMTime loadTime = CMTimeAdd(range.start, range.duration);
    return CMTimeGetSeconds(loadTime) / self.totalTime;
}

- (void)monitorVideoPlayback
{
        float totalTime = CMTimeGetSeconds(self.playerItem.duration);
        __weak typeof (self) WeakSelf = self;
        [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:nil usingBlock:^(CMTime time) {
            AVPlayerItem *item = WeakSelf.playerItem;
            NSInteger currentTime = item.currentTime.value/item.currentTime.timescale;
            NSLog(@"当前播放时间：%ld",currentTime);
            [WeakSelf setTimeLabelValues:currentTime totalTime:totalTime];
            WeakSelf.videoControl.progressSlider.value = ceil(currentTime);
        }];
}
- (void)setTimeLabelValues:(double)currentTime totalTime:(double)totalTime {
    double minutesElapsed = floor(currentTime / 60.0);
    double secondsElapsed = fmod(currentTime, 60.0);
    NSString *timeElapsedString = [NSString stringWithFormat:@"%02.0f:%02.0f", minutesElapsed, secondsElapsed];
    
    double minutesRemaining = floor(totalTime / 60.0);
    double secondsRemaining = floor(fmod(totalTime, 60.0));
    NSString *timeRmainingString = [NSString stringWithFormat:@"%02.0f:%02.0f", minutesRemaining, secondsRemaining];
    self.videoControl.timeLabel.text = [NSString stringWithFormat:@"%@/%@",timeElapsedString,timeRmainingString];
}
- (void)playButtonClick
{

    [self.player play];
    [self.videoControl.indicatorView stopAnimating];
    self.videoControl.playButton.hidden = YES;
    self.videoControl.pauseButton.hidden = NO;
    [self setProgressSliderMaxMinValues];
}

- (void)pauseButtonClick
{
    [self.player pause];
    self.videoControl.playButton.hidden = NO;
    self.videoControl.pauseButton.hidden = YES;
}

//- (void)closeButtonClick
//{
//    [self dismiss];
//}
//
- (void)fullScreenButtonClick
{
    if (self.isFullscreenMode) {
        return;
    }
    self.originControlFrame = self.videoControl.frame;
    CGFloat height = [[UIScreen mainScreen] bounds].size.width;
    CGFloat width = [[UIScreen mainScreen] bounds].size.height;
//    CGRect frame = CGRectMake((height - width) / 2, (width - height) / 2, width, height);
    CGRect frame = CGRectMake(0 ,0, width, height);
    [UIView animateWithDuration:0.3f animations:^{
        self.frame = frame;
        [self.view setTransform:CGAffineTransformMakeRotation(M_PI_2)];
    } completion:^(BOOL finished) {
        self.isFullscreenMode = YES;
        self.isStatusBarMode = !self.isFullscreenMode;
        self.videoControl.fullScreenButton.hidden = YES;
        self.videoControl.shrinkScreenButton.hidden = NO;
    }];


    [self hiddenNavigationBarAndTabBar];
}
- (void)hiddenNavigationBarAndTabBar{
    if (self.navigationController) {
        self.navigationController.navigationBarHidden = !self.navigationController.navigationBarHidden;
    }
    if (self.tabBarController) {
        self.tabBarController.tabBar.hidden = !self.tabBarController.tabBar.hidden ;
    }
}
- (BOOL)prefersStatusBarHidden {
    return self.isStatusBarMode;
}
- (void)shrinkScreenButtonClick
{
    if (!self.isFullscreenMode) {
        return;
    }
    [self hiddenNavigationBarAndTabBar];
    
    [UIView animateWithDuration:0.3f animations:^{
        [self.view setTransform:CGAffineTransformIdentity];
        self.frame =  self.originControlFrame ;
    } completion:^(BOOL finished) {
        self.isFullscreenMode = NO;
        self.isStatusBarMode = !self.isFullscreenMode;
        self.videoControl.fullScreenButton.hidden = NO;
        self.videoControl.shrinkScreenButton.hidden = YES;
    }];
 
}

- (void)setFrame:(CGRect)frame
{
    [self.view setFrame:frame];
    [self.videoControl setFrame:frame];
    [self.playerLayer setFrame:self.videoControl.bounds];
    self.playerLayer.frame = self.videoControl.bounds;
    [self.videoControl setNeedsLayout];
    [self.videoControl layoutIfNeeded];
    [self.playerLayer setNeedsLayout];
    [self.playerLayer layoutIfNeeded];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
