//
// Created by Páll Zoltán on 05/02/15.
// Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PickerLabel.h"

@class DatePickerLabel;

@protocol DatePickerLabelDelegate <PickerLabelDelegate>

@optional
- (void)datePickerLabel:(DatePickerLabel *)label didUpdateDate:(NSDate *)date;

@end

@interface DatePickerLabel : PickerLabel

@property(nonatomic, strong) id <DatePickerLabelDelegate> delegate;

@property(nonatomic, strong) NSDate *date;
@end