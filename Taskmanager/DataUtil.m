//
// Created by Páll Zoltán on 05/02/15.
// Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import "DataUtil.h"
#import "UIColor+HexString.h"
#import "TaskCategory.h"
#import "MagicalRecord.h"
#import "MagicalRecord+Actions.h"
#import "NSManagedObject+MagicalRecord.h"
#import "Task.h"
#import "YOLO.h"
#import "tgmath.h"


@implementation DataUtil {

}
+ (void)createDefaultCategories {

    NSArray *categories;
    categories = @[
            @{
                    @"name" : @"Red",
                    @"color" : [UIColor colorWithHexString:@"DB3340"]
            },
            @{
                    @"name" : @"Green",
                    @"color" : [UIColor colorWithHexString:@"1FDA9A"]
            },
            @{
                    @"name" : @"Blue",
                    @"color" : [UIColor colorWithHexString:@"28ABE3"]
            },
            @{
                    @"name" : @"Yellow",
                    @"color" : [UIColor colorWithHexString:@"E8B71A"]
            }
    ];

    for (NSDictionary *categoryDefinition in categories) {
        [DataUtil createCategoryWithName:categoryDefinition[@"name"] color:categoryDefinition[@"color"]];
    }

}

+ (void)createCategoryWithName:(NSString *)name color:(UIColor *)color {
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        TaskCategory *localTaskCategory;
        localTaskCategory = [TaskCategory MR_createInContext:localContext];
        localTaskCategory.name = name;
        localTaskCategory.color = [NSKeyedArchiver archivedDataWithRootObject:color];
        localTaskCategory.creationDate = [NSDate date];
    }];
}

+ (void)createTaskWithName:(NSString *)name category:(Task *)category date:(NSDate *)date notification:(BOOL)notificationOn {
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        Task *localTask;
        localTask = [Task MR_createInContext:localContext];
        localTask.name = name;
        localTask.date = [DataUtil floorMinutes:date];
        localTask.notification = @(notificationOn);
        localTask.category = [category MR_inContext:localContext];
        localTask.creationDate = [NSDate date];
        localTask.done = @(NO);

        if (notificationOn && [DataUtil notificationsEnabled]) {
            UILocalNotification *localNotification;
            NSData *localNotificationData;

            localNotification = [DataUtil addNotificationForTask:localTask];
            localNotificationData = [NSKeyedArchiver archivedDataWithRootObject:localNotification];
            localTask.notificationData = localNotificationData;
        };
    }];
}

+ (UILocalNotification *)addNotificationForTask:(Task *)task {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = task.name;
    notification.alertAction = @"Check it out";
    notification.fireDate = task.date;

    [[UIApplication sharedApplication] scheduleLocalNotification:notification];

    return notification;
}

+ (void)removeNotificationForTask:(Task *)task {

    // on iOS 8, UIApplication's scheduledLocalNotifications sometimes returns an empty array, so we're pretty much forced to store the notifications
    // otherwise, we could have looped through the scheduledLocalNotifications and filtered out the ones to be removed

    UILocalNotification *localNotification;

    localNotification = [NSKeyedUnarchiver unarchiveObjectWithData:task.notificationData];
    [[UIApplication sharedApplication] cancelLocalNotification:localNotification];
}

+ (void)updateTask:(Task *)task withName:(NSString *)name category:(TaskCategory *)category date:(NSDate *)date notification:(BOOL)notification {
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        Task *localTask;
        TaskCategory *localTaskCategory;

        localTaskCategory = [category MR_inContext:localContext];
        localTask = [task MR_inContext:localContext];
        localTask.name = name;
        localTask.date = [DataUtil floorMinutes:date];
        localTask.notification = @(notification);
        localTask.category = localTaskCategory;

        [DataUtil removeNotificationForTask:localTask];
        localTask.notificationData = nil;

        if (notification) {
            UILocalNotification *localNotification;
            NSData *localNotificationData;

            localNotification = [DataUtil addNotificationForTask:localTask];
            localNotificationData = [NSKeyedArchiver archivedDataWithRootObject:localNotification];
            localTask.notificationData = localNotificationData;
        }
    }];
}

+ (NSDate *)floorMinutes:(NSDate *)date {
    double interval;
    double newInterval;
    double minuteInSeconds;

    interval = date.timeIntervalSince1970;
    minuteInSeconds = 60;

    NSLog(@"%f", fmod(interval, minuteInSeconds));

    newInterval = interval - fmod(interval, minuteInSeconds);

    return [NSDate dateWithTimeIntervalSince1970:newInterval];
}

+ (void)deleteTask:(Task *)task {
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        Task *localTask;
        localTask = [task MR_inContext:localContext];

        [localTask MR_deleteEntity];
    }];
}

+ (void)markDoneState:(BOOL)state forTask:(Task *)task {
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        Task *localTask;
        localTask = [task MR_inContext:localContext];
        localTask.done = @(state);
    }];

}

+ (int)sortType {
    return [[[NSUserDefaults standardUserDefaults] valueForKey:kSortType] intValue];
}

+ (void)setSortType:(int)type {
    [[NSUserDefaults standardUserDefaults] setValue:@(type) forKey:kSortType];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)notificationsEnabled {
    return [[[NSUserDefaults standardUserDefaults] valueForKey:kEnableNotifications] boolValue];
}

+ (void)setNotificationsEnabled:(BOOL)state {
    [[NSUserDefaults standardUserDefaults] setValue:@(state) forKey:kEnableNotifications];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end