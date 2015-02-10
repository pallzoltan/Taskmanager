//
//  SortStateCell.h
//  Taskmanager
//
//  Created by Páll Zoltán on 09/02/15.
//  Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingsViewController;

@protocol SortStateCellDelegate

@optional
- (void) sortTypeDidChangeTo:(int)type;

@end

@interface SortStateCell : UITableViewCell

@property(nonatomic, strong) id<SortStateCellDelegate> delegate;
@property(nonatomic) int type;
@end
