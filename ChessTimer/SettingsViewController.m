//
//  SettingsViewController.m
//  ChessTimer
//
//  Created by Kevin Midboe on 10/01/14.
//  Copyright (c) 2014 KevinMidboe. All rights reserved.
//

#import "SettingsViewController.h"
#import "ViewController.h"
#import "Twitter/Twitter.h"

@interface SettingsViewController ()
{
    int value;
}

@end

@implementation SettingsViewController
{
    //NSString *minuteDataString;
}
@synthesize ViewControllerData;

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _minutes.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _minutes[row];
}

- (IBAction)tweetShare:(id)sender
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                
                NSLog(@"Cancelled");
                
            } else
                
            {
                NSLog(@"Done");
            }
            
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler =myBlock;
        
        //Adding the Text to the facebook post value from iOS
        [controller setInitialText:@"Check out this awesome app! #ChessClock "];
        
        //Adding the URL to the facebook post value from iOS
        
        //[controller addURL:[NSURL URLWithString:@"http://www.mobile.safilsunny.com"]];
        
        //Adding the Image to the facebook post value from iOS
        
        //[controller addImage:[UIImage imageNamed:@"fb.png"]];
        
        [self presentViewController:controller animated:YES completion:Nil];
        
    }
    else{
        NSLog(@"UnAvailable");
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    _minutes = @[@"3 minutes", @"5 minutes", @"15 minutes", @"25 minutes", @"30 minutes", @"60 minutes",  @"60 minutes or 20 moves", @"120 minutes or 40 moves"];
    
    _minuteValues = @[@1800.0f, @3000.0f, @9000.0f, @15000.0f, @18000.0f, @36000.0f, @36000.0f, @72000.0f];

    [_picker selectRow:3 inComponent:0 animated:YES];
}

#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    value = [_minuteValues[row] intValue];
    NSString *output = [NSString stringWithFormat:@"%i",value];
    resultLabel.text = output;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using
    //[segue destinationViewController].
    
    // Pass the selected object to the new view controller.
}
*/

/*- (IBAction)sendMinuteData:(id)sender
{
    minuteDataString = @"Hello!";
    self.resultLabel.text = self->minuteDataString;
    [viewControllerDelegate updateLabel];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"NewViewController"])
    {
        ViewController *destViewController = segue.destinationViewController;
        destViewController.minuteDataString = minuteDataString;
    }
}*/

- (IBAction)dismissSettings:(id)sender
{
    ViewController *home = [[ViewController alloc] initWithNibName:nil bundle:nil];
	self.ViewControllerData = home;
	ViewControllerData.passedValue = 12;
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end