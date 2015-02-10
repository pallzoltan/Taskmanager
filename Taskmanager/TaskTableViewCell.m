//
//  TaskTableViewCell.m
//  Taskmanager
//
//  Created by Páll Zoltán on 05/02/15.
//  Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import "TaskTableViewCell.h"
#import "Task.h"
#import "TaskCategory.h"
#import "UIColor+Interpolation.h"

@interface TaskTableViewCell ()
@property(weak, nonatomic) IBOutlet UILabel *dateLabel;
@property(weak, nonatomic) IBOutlet UILabel *nameLabel;
@property(nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation TaskTableViewCell

- (void)setTask:(Task *)task {
    _task = task;

    self.nameLabel.text = task.name;
    self.dateLabel.text = [self.dateFormatter stringFromDate:task.date];
    self.accessoryType = task.done.boolValue ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;

    UIColor *color;
    color = [NSKeyedUnarchiver unarchiveObjectWithData:task.category.color];
    self.backgroundColor = color;

    if (task.done.boolValue) {
        self.backgroundColor = [self.backgroundColor colorWithAlphaComponent:.5];
    }

    self.contentOffset = CGPointZero;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm aa"];
    }

    return _dateFormatter;
}

- (void)setContentOffset:(CGPoint)contentOffset {
    _contentOffset = contentOffset;

    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGRect frame;
    frame = self.contentView.frame;
    frame.origin.x = self.contentOffset.x;
    self.contentView.frame = frame;

    self.contentView.alpha = 1 - self.contentOffset.x / 100;
}

@end
