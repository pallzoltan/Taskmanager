//
//  DatePickerLabel.h
//  Taskmanager
//
//  Created by Páll Zoltán on 05/02/15.
//  Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PickerLabel;

@protocol PickerLabelDelegate

@optional
- (void)pickerLabel:(PickerLabel *)label didSelectRow:(NSInteger)row;

@end

@interface PickerLabel : UILabel <UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic, strong) NSArray *data;
@property(nonatomic, strong) id<PickerLabelDelegate> delegate;
@property(nonatomic) int selectedIndex;
@end
