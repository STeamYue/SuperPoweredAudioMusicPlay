//
//  STMusicUIBaseViewC.m
//  SuperPoweredAudioMusicPlay
//
//  Created by 岳克奎 on 17/1/19.
//  Copyright © 2017年 岳克奎. All rights reserved.
//

#import "STMusicUIBaseViewC.h"

@interface STMusicUIBaseViewC ()

@end

@implementation STMusicUIBaseViewC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 * @brief:     创建新的音乐功能层ViewC(ViewC作为子ViewC)
 *
 * @discussion:1.作为子ViewC
 *             2.写在在基础类，供所有子类调用
 *             3.
 */
+(STMusicUIBaseViewC *)showSTMusicFunctionViewCOnSuperViewC:(UIViewController *)superViewC
                                              ofFrameRect:(CGRect)frameRect
                                          newViewCNameStr:(NSString *)newViewCNameStr
                                                 complete:(void(^)(BOOL finished,
                                                                   STMusicUIBaseViewC *newViewC))block{
    //superViewC
    if (!superViewC) {
        if(block){
            block(YES,nil);
        }
        return nil;
    }
    //clear
    for (UIViewController *oneViewC in superViewC.childViewControllers) {
        if ([oneViewC isKindOfClass:[self class]]) {
            [oneViewC removeFromParentViewController];
            [oneViewC.view removeFromSuperview];
        }
    }
    //class
    Class newViewControllerClass = NSClassFromString(newViewCNameStr);
    //new
    STMusicUIBaseViewC *newViewC = [[newViewControllerClass alloc]initWithNibName:newViewCNameStr
                                                                           bundle:nil];
    //
    newViewC.recordSuperViewC = superViewC;
    //frame
    newViewC.view.frame = frameRect;
    //child
    [superViewC addChildViewController:newViewC];
    [superViewC.view addSubview:newViewC.view];
    
    //block
    if (block) {
        block(YES,nil);
    }
    
    return newViewC;
}
-(void)setDelegate:(id<STMusicUIBaseViewCDelegate>)delegate{
    _delegate = delegate;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
