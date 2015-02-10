//
//  EditTaskViewController.h
//  Taskmanager
//
//  Created by Páll Zoltán on 06/02/15.
//  Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import "AddTaskViewController.h"
#import "Task.h"

@interface EditTaskViewController : AddTaskViewController

@property(nonatomic, strong) Task *task;

@end
