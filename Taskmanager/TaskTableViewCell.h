//
//  TaskTableViewCell.h
//  Taskmanager
//
//  Created by Páll Zoltán on 05/02/15.
//  Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Task;
@class TaskTableViewCell;

@interface TaskTableViewCell : UITableViewCell

@property(nonatomic, strong) Task *task;
@property(nonatomic) CGPoint contentOffset;
@end
