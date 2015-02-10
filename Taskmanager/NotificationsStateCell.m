//
//  NotificationsStateCell.m
//  Taskmanager
//
//  Created by Páll Zoltán on 09/02/15.
//  Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import "NotificationsStateCell.h"
#import "SettingsViewController.h"

@interface NotificationsStateCell ()
@property (weak, nonatomic) IBOutlet UISwitch *notificationsSwitch;

@end

@implementation NotificationsStateCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        [self.notificationsSwitch setOn:!self.notificationsSwitch.on animated:YES];
    }
}
- (IBAction)handleSwitch:(UISwitch *)sender {
    [self.delegate setNotificationsState:self.notificationsSwitch.on];
}

- (void)setEnabled:(BOOL)enabled {
    [self.notificationsSwitch setOn:enabled animated:YES];
}

@end
