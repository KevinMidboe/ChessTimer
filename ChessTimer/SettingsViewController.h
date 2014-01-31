//
//  SettingsViewController.h
//  ChessTimer
//
//  Created by Kevin Midboe on 10/01/14.
//  Copyright (c) 2014 KevinMidboe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface SettingsViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource>
{
    ViewController *ViewControllerData;
	IBOutlet UITextField *textfield;
    IBOutlet UILabel *resultLabel;
}

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) NSArray *minutes;
@property (strong, nonatomic) NSArray *minuteValues;

@property (nonatomic, retain)ViewController*ViewControllerData;

- (IBAction)tweetShare:(id)sender;
- (IBAction)dismissSettings:(id)sender;

@end
