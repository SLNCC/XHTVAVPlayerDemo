//
//  NTVMPMoviePlayerController.m
//  AVPlayerDemo
//
//  Created by 乔冬 on 2018/3/26.
//  Copyright © 2018年 XinHuaTV. All rights reserved.
//

#import "NTVMPMoviePlayerController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "KRVideoPlayerController.h"
@interface NTVMPMoviePlayerController ()
@property (nonatomic,strong) KRVideoPlayerController *videoController;
@property (strong, nonatomic) MPMoviePlayerController * movieplayer;
@end

@implementation NTVMPMoviePlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      self.view.backgroundColor = [UIColor whiteColor];
    UIButton *slFirstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    slFirstBtn.frame = CGRectMake(50, 120, kWidth - 100, 40);
    [slFirstBtn setTitle:@"播放" forState:UIControlStateNormal];
    slFirstBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [slFirstBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [slFirstBtn addTarget:self action:@selector(slFirstBtnClikedAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:slFirstBtn];
    


}
- (void)localMPMoviePlayerController{
    NSURL*movieURL = [NSURL URLWithString:@"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8"];
    MPMoviePlayerController *movieplayer = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    self. movieplayer = movieplayer;
    //    self.movieplayer.shouldAutoplay = YES;
    // 设置尺寸
//    _movieplayer.view.frame = self.view.bounds;
//    _movieplayer.view.autoresizingMask =UIViewAutoresizingFlexibleWidth |
//    UIViewAutoresizingFlexibleHeight;
    _movieplayer.view.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 180);
    // 添加到控制器的view上
    [self.view addSubview:_movieplayer.view]; // 播放
    [_movieplayer play];
    
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.movieplayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.movieplayer];
    [_movieplayer play];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)slFirstBtnClikedAction{
    //MPMoviePlayerViewController--自带播放UI 不可控
//        [self localMPMoviePlayerController];
    NSString *string = @"http://111.13.171.164/storage/7-0/1-1/260000/44779-179600-257693.mp4";
//    string =   @"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8";
    NSURL *videoURL = [NSURL URLWithString:string];
    [self playVideoWithURL:videoURL];
}

-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.movieplayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",self.movieplayer.playbackState);
            break;
    }
}

-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    NSLog(@"播放完成.%li",self.movieplayer.playbackState);
}

-(void)dealloc{
    //移除所有通知监控
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark --MPMoviePlayerViewController
- (void)ntvMPMoviePlayerViewController{
    NSURL*movieURL = [NSURL URLWithString:@"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8"];
    MPMoviePlayerViewController *movieplayer = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];
    [self presentMoviePlayerViewControllerAnimated:movieplayer];
}


- (void)playVideoWithURL:(NSURL *)url
{
    if (!self.videoController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, width, width*(9.0/16.0))];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController showInWindow];
    }
    self.videoController.contentURL = url;
}

@end
