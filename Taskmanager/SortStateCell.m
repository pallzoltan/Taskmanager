//
//  SortStateCell.m
//  Taskmanager
//
//  Created by Páll Zoltán on 09/02/15.
//  Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import "SortStateCell.h"
#import "SettingsViewController.h"

@interface SortStateCell ()

@property(weak, nonatomic) IBOutlet UILabel *sortValueLabel;

@end

@implementation SortStateCell

- (void)setType:(int)type {
    _type = type;

    if (type == 0) {
        self.sortValueLabel.text = @"Date";
    } else {
        self.sortValueLabel.text = @"Name";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (selected) {
        self.type = !self.type;
        [self.delegate sortTypeDidChangeTo:self.type];
    }
}

- (void)setSelected:(BOOL)selected {
    if (selected) {
        self.type = !self.type;
        [self.delegate sortTypeDidChangeTo:self.type];
    }
}


@end
