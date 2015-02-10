//
//  NotificationsStateCell.h
//  Taskmanager
//
//  Created by Páll Zoltán on 09/02/15.
//  Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingsViewController;

@protocol NotificationsStateCellDelegate

@optional
- (void) setNotificationsState:(BOOL)enabled;
@end

@interface NotificationsStateCell : UITableViewCell

@property(nonatomic, strong) id<NotificationsStateCellDelegate> delegate;
@property(nonatomic) BOOL enabled;
@end
