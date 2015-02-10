//
//  AddTaskViewController.h
//  Taskmanager
//
//  Created by Páll Zoltán on 05/02/15.
//  Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerLabel.h"
#import "DatePickerLabel.h"

@interface AddTaskViewController : UIViewController <PickerLabelDelegate, DatePickerLabelDelegate>

@property(nonatomic, strong) NSArray *categories;
@property(weak, nonatomic) IBOutlet UITextField *nameTextField;
@property(strong, nonatomic) IBOutlet UISwitch *notificationSwitch;
@property(weak, nonatomic) IBOutlet PickerLabel *categoryLabel;
@property (weak, nonatomic) IBOutlet DatePickerLabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *markAsDoneButton;

- (IBAction)handleMarkAsDoneButton:(UIButton *)sender;

- (void)handleDoneButton:(UIButton *)doneButton;
@end
