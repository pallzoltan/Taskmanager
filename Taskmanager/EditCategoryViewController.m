//
//  EditCategoryViewController.m
//  Taskmanager
//
//  Created by Páll Zoltán on 10/02/15.
//  Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import "EditCategoryViewController.h"
#import "TaskCategory.h"
#import "HRColorMapView.h"
#import "HRBrightnessSlider.h"
#import "DataUtil.h"

@interface EditCategoryViewController ()

@end

@implementation EditCategoryViewController

- (instancetype)init {
    self = [super initWithNibName:@"AddCategoryViewController" bundle:nil];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameField.text = self.category.name;

    UIColor *color;
    color = [NSKeyedUnarchiver unarchiveObjectWithData:self.category.color];
    self.colorMapView.color = color;
    self.brightnessSlider.color = color;

    self.title = @"Edit category";
}

- (void)handleDoneButton {
    // create category and pop VC
    if (self.nameField.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Name missing" message:@"A category needs a name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    [DataUtil updateCategory:self.category withName:self.nameField.text withColor:self.colorMapView.color];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
