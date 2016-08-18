//
//  ICPGuidePage.m
//  IceCreamPlane
//
//  Created by zengruofan on 16/8/18.
//  Copyright © 2016年 zruof. All rights reserved.
//

#import "ICPGuidePage.h"
#import "MediaPlayer/MediaPlayer.h"
#import "AVFoundation/AVFoundation.h"

@interface ICPGuidePage()
@property(nonatomic,strong)MPMoviePlayerController *moviePlayer;
@property(nonatomic ,strong)AVAudioSession *avaudioSession;

@end

@implementation ICPGuidePage

-(void) viewDidLoad {
    [super viewDidLoad];
    self.avaudioSession = [AVAudioSession sharedInstance];
    NSError *error = nil;
    [self.avaudioSession setCategory:AVAudioSessionCategoryAmbient error:&error];
    
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"1.mp4" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    
    _moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:url];
    //    _moviePlayer.controlStyle = MPMovieControlStyleDefault;
    [_moviePlayer play];
    [_moviePlayer.view setFrame:self.view.bounds];
    
    [self.view addSubview:_moviePlayer.view];
    _moviePlayer.shouldAutoplay = YES;
    [_moviePlayer setControlStyle:MPMovieControlStyleNone];
    [_moviePlayer setFullscreen:YES];
    
    [_moviePlayer setRepeatMode:MPMovieRepeatModeOne];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackStateChanged)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_moviePlayer];
    
}

//ios以后隐藏状态栏
-(BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)playbackStateChanged{
    //取得目前状态
    MPMoviePlaybackState playbackState = [_moviePlayer playbackState];
    
    //状态类型
    switch (playbackState) {
        case MPMoviePlaybackStateStopped:
            [_moviePlayer play];
            break;
            
        case MPMoviePlaybackStatePlaying:
            NSLog(@"播放中");
            break;
            
        case MPMoviePlaybackStatePaused:
            [_moviePlayer play];
            break;
            
        case MPMoviePlaybackStateInterrupted:
            NSLog(@"播放被中断");
            break;
            
        case MPMoviePlaybackStateSeekingForward:
            NSLog(@"往前快转");
            break;
            
        case MPMoviePlaybackStateSeekingBackward:
            NSLog(@"往后快转");
            break;
            
        default:
            NSLog(@"无法辨识的状态");
            break;
    }
}


@end
