//
//  AddCategoryViewController.h
//  Taskmanager
//
//  Created by Páll Zoltán on 10/02/15.
//  Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HRColorMapView;
@class HRBrightnessSlider;

@interface AddCategoryViewController : UIViewController

@property (weak, nonatomic) IBOutlet HRColorMapView *colorMapView;
@property (weak, nonatomic) IBOutlet HRBrightnessSlider *brightnessSlider;
@property (weak, nonatomic) IBOutlet UITextField *nameField;

- (void)handleDoneButton;

@end
