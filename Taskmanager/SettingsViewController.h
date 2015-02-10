//
//  SettingsViewController.h
//  Taskmanager
//
//  Created by Páll Zoltán on 07/02/15.
//  Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationsStateCell.h"
#import "SortStateCell.h"

@interface SettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NotificationsStateCellDelegate, SortStateCellDelegate>

@end
