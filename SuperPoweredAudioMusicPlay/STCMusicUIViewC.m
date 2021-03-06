//
//  STCMusicUIViewC.m
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 17/1/19.
//  Copyright © 2017年 岳克奎. All rights reserved.
//

#import "STCMusicUIViewC.h"

@interface STCMusicUIViewC ()

@end

@implementation STCMusicUIViewC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(void)sendDataFromSTCMusicViewCToSTCMusicUIViewCOfSTMusicModel:(STMusicModel *)stMusicModel{
    //拿到了modle
    self.musicInfoShowLab.text =[NSString stringWithFormat:@"%@ %@",stMusicModel.musicNameStr,stMusicModel.musicSingerNameStr];
    self.musicSurplusTimeShowLab.text = @"12";
    self.musicLrcShowView.lrcModelDataSoueceMArray = stMusicModel.lrcModelDataSourceArray;
    self.musicLrcShowView.lrcTimePointDataMArray = stMusicModel.lrcTimePointDataArray;
}
-(void)sendDataFromSTCMusicPlayerCenterManagerToSTMusicUIViewCOfMusicTotalDuration:(CGFloat)musicTotalDuration andMusicCurrentDuration:(CGFloat)musicCurrentDuration andMusicProgress:(CGFloat)musicProgress{
    //剩余时间
    NSString *surplusDuration = [NSString stringWithFormat:@"%f",(musicTotalDuration- musicCurrentDuration)];
    if ([NSThread isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.musicSurplusTimeShowLab.text = [surplusDuration st_timeTypeOfSToTimeTypeOfMS];
            if(self.musicLrcShowView.lrcTimePointDataMArray.count>0&& self.musicLrcShowView.lrcModelDataSoueceMArray .count>0)
                [self.musicLrcShowView showMusicPlayerPlayingOfcurrentTime:musicCurrentDuration
                                                         andMusicTotalTime:musicTotalDuration
                                                          andMusicProgress:musicProgress];
        });
    }else{
        dispatch_sync(dispatch_get_main_queue(), ^{
            //剩余时间
            self.musicSurplusTimeShowLab.text = [surplusDuration st_timeTypeOfSToTimeTypeOfMS];
            if(self.musicLrcShowView.lrcTimePointDataMArray.count>0&& self.musicLrcShowView.lrcModelDataSoueceMArray .count>0)
                [self.musicLrcShowView showMusicPlayerPlayingOfcurrentTime:musicCurrentDuration
                                                         andMusicTotalTime:musicTotalDuration
                                                          andMusicProgress:musicProgress];
        });
    }
    
    
}
-(void)sendDataFromSTCMusicViewCToSTCMusicUIViewCOfSTSMusicState:(BOOL)stCMusicState{
    [self.musicControlStateBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",ST_MUSIC_PLAYER_CENTER_MANAGER.recordSTCMusicPlayerState?@"music_stop_playing":@"music_resume_playing"]]
                               forState:UIControlStateNormal];
}
/*
 暂停与播放
 
 */
- (IBAction)musicControlBtnShowStateClick:(UIButton *)sender {
    ST_MUSIC_CENTER_MANAGER.musicPlayerPlayingState = !ST_MUSIC_CENTER_MANAGER.musicPlayerPlayingState;
    
}
/*
 关闭音效界面
 
 */

- (IBAction)closeMusicClick:(UIButton *)sender {
    //音乐要暂停
     [ST_MUSIC_PLAYER_CENTER_MANAGER setRecordSTCMusicPlayerState:YES];
    ST_MUSIC_CENTER_MANAGER.musicViewCShowControllerState = !ST_MUSIC_PLAYER_CENTER_MANAGER.recordSTCMusicPlayerState;
   
}


@end
