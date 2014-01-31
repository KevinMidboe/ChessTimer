//
//  ViewController.m
//  ChessTimer
//
//  Created by Kevin Midboe on 09/01/14.
//  Copyright (c) 2014 KevinMidboe. All rights reserved.
//

#import "ViewController.h"
#import "SettingsViewController.h"

@interface ViewController ()
{
    
}
//@property (strong, nonatomic) IBOutlet UILabel *minuteLabel;

@end

@implementation ViewController
@synthesize passedValue;

- (IBAction)startTimerP1
{
    [P2Timer invalidate];
    if (started == NO)
    {
        P2Timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(displayTimerP2) userInfo:nil repeats:YES];
        AudioServicesPlaySystemSound(SoundID);
        lblTimerP2.textColor = [UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
        lblTimerP1.textColor = [UIColor colorWithRed:219/255.0f green:219/255.0f blue:219/255.0f alpha:1.0f];
        started = YES;
    }
    else
        if (P1Timer.isValid == false)
        {
            P1Timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(displayTimerP1) userInfo:nil repeats:YES];
            AudioServicesPlaySystemSound(SoundID);
            lblTimerP1.textColor = [UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
            lblTimerP2.textColor = [UIColor colorWithRed:219/255.0f green:219/255.0f blue:219/255.0f alpha:1.0f];
        }
}
- (void)displayTimerP1
{
    timeP1 -= 0.1;
    //Can skip this if want to save CPU.
    milliseconds = timeP1;
    seconds = milliseconds / 10;
    minutes = seconds / 60;
    NSString *timerOutput = [NSString stringWithFormat:@"%2d:%02d:%d",minutes % 60, seconds % 60, milliseconds % 10];
    if (timeP1 <= 0 && timeRunout == NO)
    {
        [P1Timer invalidate];
        UIAlertView *alert = [[UIAlertView alloc] init];
        [alert setTitle:@"Congratulations!"];
        [alert setMessage:@"P1 you are the winner! Type your name below to submit your time and name to the leaderboards."];
        [alert setDelegate:self];
        [alert addButtonWithTitle:@"Cancel"];
        [alert addButtonWithTitle:@"Submit"];
        
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField* answerField = [alert textFieldAtIndex:0];
        answerField.keyboardType = UIKeyboardAppearanceDefault;
        answerField.placeholder = @"Your Name";
        [alert show];
        timeRunout = YES;
    }
    //Pop-Up and scoring system.
    
    lblTimerP1.text = timerOutput;
}
- (IBAction)startTimerP2
{
    [P1Timer invalidate];
    if (started == NO)
    {
        P1Timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(displayTimerP1) userInfo:nil repeats:YES];
        AudioServicesPlaySystemSound(SoundID);
        lblTimerP1.textColor = [UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
        lblTimerP2.textColor = [UIColor colorWithRed:219/255.0f green:219/255.0f blue:219/255.0f alpha:1.0f];
        started = YES;
    }
    else
        if (P2Timer.isValid == false)
        {
            P2Timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(displayTimerP2) userInfo:nil repeats:YES];
            AudioServicesPlaySystemSound(SoundID);
            lblTimerP2.textColor = [UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
            lblTimerP1.textColor = [UIColor colorWithRed:219/255.0f green:219/255.0f blue:219/255.0f alpha:1.0f];
        }
}
- (void)displayTimerP2
{
    timeP2 -= 0.1;
    //Can skip this if want to save CPU.
    milliseconds = timeP2;
    seconds = milliseconds / 10;
    minutes = seconds / 60;
    NSString *timerOutput = [NSString stringWithFormat:@"%2d:%02d:%d",minutes % 60, seconds % 60, milliseconds % 10];
    if (timeP2 <= 0 && timeRunout == NO)
    {
        [P2Timer invalidate];
        UIAlertView *alert = [[UIAlertView alloc] init];
        [alert setTitle:@"Congratulations!"];
        [alert setMessage:@"P2 you are the winner! Type your name below to submit your time and name to the leaderboards."];
        [alert setDelegate:self];
        [alert addButtonWithTitle:@"Cancel"];
        [alert addButtonWithTitle:@"Submit"];
        
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField* answerField = [alert textFieldAtIndex:0];
        answerField.keyboardType = UIKeyboardAppearanceDefault;
        answerField.placeholder = @"Your Name";
        [alert show];
        timeRunout = YES;
    }
    //Pop-Up and scoring system.
    
    lblTimerP2.text = timerOutput;
}

- (void)pauseButton
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    if (P1Timer.isValid == true)
    {
        resumeControl = 0;
    }
    else if (P2Timer.isValid == true)
    {
        resumeControl = 1;
    }
    else
    {
        resumeControl = 2;
    }
    
    if (resumeControl != 2)
    {
        [P1Timer invalidate];
        [P2Timer invalidate];
        
        pauseButton.hidden = YES;
        startButton.hidden = NO;
        startTimerP1.hidden = YES;
        startTimerP2.hidden = YES;
        
        lblTimerP1.textColor = [UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
        lblTimerP2.textColor = [UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
    }
    
}

-(void)startButton
{
    [self updateLabels];
}

-(IBAction)reset
{
    if (P1Timer.isValid == true)
    {
        resumeControl = 0;
    }
    else if (P2Timer.isValid == true)
    {
        resumeControl = 1;
    }
    else
    {
        resumeControl = 2;
    }
    [P1Timer invalidate];
    [P2Timer invalidate];
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:@"Alert!"];
    [alert setMessage:@"Are you sure you want to reset the timer?"];
    [alert setDelegate:self];
    [alert addButtonWithTitle:@"No"];
    [alert addButtonWithTitle:@"Yes"];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self updateLabels];
    }
    if (buttonIndex == 1)
    {
        [self resetClock];
    }
}

- (void)resetClock
{
    timeP1 = defaultTime;
    timeP2 = defaultTime;
    
    milliseconds = defaultTime;
    seconds = milliseconds / 10;
    minutes = seconds / 60;
    NSString *timerOutput = [NSString stringWithFormat:@"%2d:%02d:%d",minutes % 60, seconds % 60, milliseconds % 10];
    lblTimerP1.text = timerOutput;
    lblTimerP2.text = timerOutput;
    
    started = NO;
    timeRunout = NO;
    lblTimerP1.textColor = [UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
    lblTimerP2.textColor = [UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
}

- (void)updateLabels
{
    if (resumeControl == 0)
    {
        P1Timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(displayTimerP1) userInfo:nil repeats:YES];
        lblTimerP1.textColor = [UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
        lblTimerP2.textColor = [UIColor colorWithRed:219/255.0f green:219/255.0f blue:219/255.0f alpha:1.0f];
        pauseButton.hidden = NO;
        startButton.hidden = YES;
        startTimerP1.hidden = NO;
        startTimerP2.hidden = NO;
    }
    else if (resumeControl == 1)
    {
        P2Timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(displayTimerP2) userInfo:nil repeats:YES];
        lblTimerP2.textColor = [UIColor colorWithRed:255/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
        lblTimerP1.textColor = [UIColor colorWithRed:219/255.0f green:219/255.0f blue:219/255.0f alpha:1.0f];
        pauseButton.hidden = NO;
        startButton.hidden = YES;
        startTimerP1.hidden = NO;
        startTimerP2.hidden = NO;
    }
}

- (void)checkForSettingsupdate
{
        //Check if there is an update.
        /*if (defaultTime != newTime)
        {
            newTime = 15000;
            defaultTime = newTime;
            [self resetClock];
            [updateCheckTimer invalidate];
        }*/
    NSString *output = [NSString stringWithFormat:@"%li", (long)passedValue];
    label.text = output;
    [updateCheckTimer invalidate];
    //label.text = @"HEI!";
}

- (void)viewDidLoad
{
    lblTimerP1.transform = CGAffineTransformMakeRotation(-M_PI / 1);
    
    defaultTime = 15000;
    
    [self resetClock];
    
    NSURL *buttonURL  = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"dingSFX1" ofType:@"aiff"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)buttonURL, &SoundID);
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)settingsView:(id)sender
{
    [P1Timer invalidate];
    [P2Timer invalidate];
    updateCheckTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(checkForSettingsupdate) userInfo:nil repeats:YES];
    ViewController *SVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    [self presentViewController:SVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
