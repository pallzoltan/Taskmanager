//
//  EditTaskViewController.m
//  Taskmanager
//
//  Created by Páll Zoltán on 06/02/15.
//  Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import "EditTaskViewController.h"
#import "DataUtil.h"

@interface EditTaskViewController ()

@end

@implementation EditTaskViewController

- (instancetype)init {
    self = [super initWithNibName:@"AddTaskViewController" bundle:nil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([self.categories indexOfObject:self.task.category] == NSNotFound) {
        self.categoryLabel.selectedIndex = 0;
    } else {
        self.categoryLabel.selectedIndex = [self.categories indexOfObject:self.task.category];
    }

    self.dateLabel.date = self.task.date;

    self.nameTextField.text = self.task.name;
    self.notificationSwitch.on = self.task.notification.boolValue;
    self.markAsDoneButton.hidden = NO;
    [self updateMarkAsDoneButton];
}

- (void)handleDoneButton:(id)doneButton {
    if (self.nameTextField.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Name is empty" message:@"The name should be filled in before you save the task." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }

    [DataUtil updateTask:self.task withName:self.nameTextField.text category:self.categories[self.categoryLabel.selectedIndex] date:self.dateLabel.date notification:self.notificationSwitch.on];

    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)handleMarkAsDoneButton:(UIButton *)sender {
    [DataUtil markDoneState:!self.task.done.boolValue forTask:self.task];

    [self updateMarkAsDoneButton];
}

- (void) updateMarkAsDoneButton {
    if (self.task.done.boolValue) {
        [self.markAsDoneButton setTitle:@"Mark as not done" forState:UIControlStateNormal];
    } else {
        [self.markAsDoneButton setTitle:@"Mark as done" forState:UIControlStateNormal];
    }
}


@end
