//
//  Task.h
//  Taskmanager
//
//  Created by Páll Zoltán on 07/02/15.
//  Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TaskCategory;

@interface Task : NSManagedObject

@property (nonatomic, retain) NSData * notificationData;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * notification;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * done;
@property (nonatomic, retain) TaskCategory *category;

@end
