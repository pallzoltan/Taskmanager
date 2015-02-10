//
//  EditCategoryViewController.h
//  Taskmanager
//
//  Created by Páll Zoltán on 10/02/15.
//  Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import "AddCategoryViewController.h"

@class TaskCategory;

@interface EditCategoryViewController : AddCategoryViewController

@property(nonatomic, strong) TaskCategory *category;
@end
