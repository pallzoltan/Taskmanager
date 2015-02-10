//
//  TaskCategory.h
//  Taskmanager
//
//  Created by Páll Zoltán on 07/02/15.
//  Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Task;

@interface TaskCategory : NSManagedObject

@property (nonatomic, retain) NSData * color;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *tasks;
@end

@interface TaskCategory (CoreDataGeneratedAccessors)

- (void)addTasksObject:(Task *)value;
- (void)removeTasksObject:(Task *)value;
- (void)addTasks:(NSSet *)values;
- (void)removeTasks:(NSSet *)values;

@end
