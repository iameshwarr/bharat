//
//  IntialViewController.m
//  Bharat+
//
//  Created by Eshwar M R on 12/13/16.
//  Copyright © 2016 Genpact. All rights reserved.
//

#import "IntialViewController.h"
#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface IntialViewController ()

{
    AVAudioPlayer *player;
}
@end

@implementation IntialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    NSString *soundFilePath = [NSString stringWithFormat:@"%@/bharathumkojaansepyarahai-lyricvideohindienglish_cutted.mp3",[[NSBundle mainBundle] resourcePath]];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    
    [player play];
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [player stop];
}
-(IBAction)buttonClicked:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:[NSNumber numberWithBool:YES] forKey:@"Agree"];
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *mVC = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ViewController"];
    UINavigationController *mNavigationController = [[UINavigationController alloc] initWithRootViewController:mVC];
    [[UIApplication sharedApplication].keyWindow setRootViewController:mNavigationController];
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
