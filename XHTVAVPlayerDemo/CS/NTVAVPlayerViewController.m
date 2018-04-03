//
//  NTVAVPlayerViewController.m
//  AVPlayerDemo
//
//  Created by 乔冬 on 2018/3/26.
//  Copyright © 2018年 XinHuaTV. All rights reserved.
//

#import "NTVAVPlayerViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
@interface NTVAVPlayerViewController ()

@end

@implementation NTVAVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];


    UIButton *slFirstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    slFirstBtn.frame = CGRectMake(50, 120, kWidth - 100, 40);
    [slFirstBtn setTitle:@"播放" forState:UIControlStateNormal];
    slFirstBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [slFirstBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [slFirstBtn addTarget:self action:@selector(slFirstBtnClikedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:slFirstBtn];
   
}
- (void)slFirstBtnClikedAction:(UIButton *)sender{
    NSString *videoString = @"http://111.13.171.164/storage/7-0/1-1/260000/44779-179600-257693.mp4";
//    videoString = @"http://live.hkstv.hk.lxdns.com/live/hks/playlist.m3u8";
    NSURL*url = [NSURL URLWithString:videoString];
    AVPlayerViewController* play = [[AVPlayerViewController alloc]init];
    play.player= [[AVPlayer alloc]initWithURL:url];
    if (@available(iOS 9.0, *)) {
        play.allowsPictureInPicturePlayback=YES;
    } else {
        // Fallback on earlier versions
    }//这个是允许画中画的
    [play.player play]; //这里我设置直接播放,页面弹出后会直接播放,要不然还需要点击一下播放按钮
    [self presentViewController:play animated:YES completion:nil];
    DLog(@"%@",play.contentOverlayView)

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}



@end
