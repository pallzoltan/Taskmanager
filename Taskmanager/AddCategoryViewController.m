//
//  AddCategoryViewController.m
//  Taskmanager
//
//  Created by Páll Zoltán on 10/02/15.
//  Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import "AddCategoryViewController.h"
#import "HRColorMapView.h"
#import "HRBrightnessSlider.h"
#import "HRColorInfoView.h"
#import "DataUtil.h"

@interface AddCategoryViewController ()
@property (weak, nonatomic) IBOutlet HRBrightnessSlider *brightnessSlider;
@property (weak, nonatomic) IBOutlet HRColorMapView *colorMapView;
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@end

@implementation AddCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.brightnessSlider.brightnessLowerLimit = @.5;
    self.brightnessSlider.color = [UIColor whiteColor];
    self.colorMapView.saturationUpperLimit = @1;

    [self.colorMapView setBrightness:1];

    self.nameField.placeholder = @"Task name";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(handleDoneButton)];
    
    self.title = @"Add category";
}

- (void)handleDoneButton {
    // create category and pop VC
    if (self.nameField.text.length == 0) {
        [[[UIAlertView alloc] initWithTitle:@"Name missing" message:@"A category needs a name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    [DataUtil createCategoryWithName:self.nameField.text color:self.colorMapView.color];

    [self.navigationController popViewControllerAnimated:YES];
}

@end
