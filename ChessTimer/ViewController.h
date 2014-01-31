//
//  ViewController.h
//  ChessTimer
//
//  Created by Kevin Midboe on 09/01/14.
//  Copyright (c) 2014 KevinMidboe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController : UIViewController
//<ViewControllerDelegate>
{
    int startTime, defaultTime, timeP1, timeP2, minutes, seconds, milliseconds, resumeControl, count, newTime;
    bool started, timeRunout;
    
    NSTimer *P1Timer, *P2Timer, *updateCheckTimer;
    
    IBOutlet UILabel *lblTimerP1;
    IBOutlet UILabel *lblTimerP2;
    
    IBOutlet UIButton *startTimerP1;
    IBOutlet UIButton *startTimerP2;
    IBOutlet UIButton *pauseButton;
    IBOutlet UIButton *startButton;
    IBOutlet UIImage *imageViewer0;
    IBOutlet UIImage *imageViewer1;
    
    IBOutlet UILabel *label;
    NSInteger passedValue;
    
    SystemSoundID SoundID;
}
@property (nonatomic)NSInteger passedValue;

- (IBAction)settingsView:(id)sender;

- (IBAction)startTimerP1;
- (IBAction)startTimerP2;
- (IBAction)displayTimerP1;
- (IBAction)displayTimerP2;

- (IBAction)pauseButton;
- (IBAction)startButton;
- (IBAction)reset;


@end




