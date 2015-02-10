//
// Created by Páll Zoltán on 05/02/15.
// Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import "DatePickerLabel.h"


@interface DatePickerLabel ()
@property(nonatomic, strong) UIDatePicker *datePickerView;
@end

@implementation DatePickerLabel

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    self.userInteractionEnabled = YES;

    self.datePickerView = [[UIDatePicker alloc] init];
    self.datePickerView.datePickerMode = UIDatePickerModeDateAndTime;
    [self.datePickerView addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];


    return self;
}

- (void)dateChanged:(id)eChanged {
    [self.delegate datePickerLabel:self didUpdateDate:self.datePickerView.date];
}

- (UIView *)inputView {
    return self.datePickerView;
}

- (NSDate *)date {
    return self.datePickerView.date;
}

- (void)setDate:(NSDate *)date {
    [self.datePickerView setDate:date animated:YES];

    [self.delegate datePickerLabel:self didUpdateDate:self.datePickerView.date];
}


@end