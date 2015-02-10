//
//  AddTaskViewController.m
//  Taskmanager
//
//  Created by Páll Zoltán on 05/02/15.
//  Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import "AddTaskViewController.h"
#import "PickerLabel.h"
#import "TaskCategory.h"
#import "NSManagedObject+MagicalFinders.h"
#import "YOLO.h"
#import "DatePickerLabel.h"
#import "DataUtil.h"

@interface AddTaskViewController ()
@property (weak, nonatomic) IBOutlet UILabel *categoryValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateValueLabel;

@property(nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // set up categories:

    NSMutableArray *taskCategories;
    taskCategories = [@[] mutableCopy];
    self.categories = [TaskCategory MR_findAllSortedBy:@"creationDate" ascending:YES];
    self.categories.each(^(TaskCategory *taskCategory) {
        [taskCategories addObject:@{
                @"name": taskCategory.name,
                @"category": taskCategory
        }];
    });
    self.categoryLabel.data = taskCategories;
    self.categoryLabel.delegate = self;
    self.categoryLabel.selectedIndex = 0;


    // set up date:
    self.dateLabel.delegate = self;
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm aa"];
    self.dateLabel.date = [NSDate date];

    //
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(handleDoneButton:)];

    self.markAsDoneButton.hidden = YES;
    self.title = @"Add task";
}

- (void)handleDoneButton:(UIButton *)doneButton {

    if (self.nameTextField.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Name is empty" message:@"The name should be filled in before you save the task." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }

    [DataUtil createTaskWithName:self.nameTextField.text category:self.categories[self.categoryLabel.selectedIndex] date:self.dateLabel.date notification:self.notificationSwitch.on];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)pickerLabel:(PickerLabel *)label didSelectRow:(NSInteger)row {
    self.categoryValueLabel.text = self.categoryLabel.data[row][@"name"];
}

- (void)datePickerLabel:(DatePickerLabel *)label didUpdateDate:(NSDate *)date {
    self.dateValueLabel.text = [self.dateFormatter stringFromDate:date];
}


- (IBAction)handleMarkAsDoneButton:(UIButton *)sender {
}
@end
