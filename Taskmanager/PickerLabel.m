//
//  DatePickerLabel.m
//  Taskmanager
//
//  Created by Páll Zoltán on 05/02/15.
//  Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import "PickerLabel.h"
#import "TaskCategory.h"

@interface PickerLabel ()
@property(nonatomic, strong) UIPickerView *pickerView;
@end

@implementation PickerLabel

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    self.userInteractionEnabled = YES;

    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;

    return self;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];

    [self becomeFirstResponder];
}

- (UIView *)inputView {
    return self.pickerView;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.data.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSDictionary *categoryDefinition;
    categoryDefinition = self.data[row];
    return categoryDefinition[@"name"];
}

- (void)setData:(NSArray *)data {
    _data = data;

    [self.pickerView reloadAllComponents];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    @try {
        [self.delegate pickerLabel:self didSelectRow:row];
    } @catch (id e) {
        //
    }
}

- (int)selectedIndex {
    return [self.pickerView selectedRowInComponent:0];
}

- (void)setSelectedIndex:(int)selectedIndex {
    [self.pickerView selectRow:selectedIndex inComponent:0 animated:YES];

    [self pickerView:self.pickerView didSelectRow:selectedIndex inComponent:0];
}

@end
