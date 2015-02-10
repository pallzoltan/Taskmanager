//
// Created by Páll Zoltán on 05/02/15.
// Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSortType @"com.pallzoltan.demos.cleevio.kSortType"
#define kEnableNotifications @"com.pallzoltan.demos.cleevio.kEnableNotifications"

@class Task;
@class TaskCategory;
@class UILocalNotification;
@class UIColor;


@interface DataUtil : NSObject
+ (void)createDefaultCategories;

+ (void)createCategoryWithName:(NSString *)name color:(UIColor *)color;

+ (void)createTaskWithName:(NSString *)name category:(Task *)category date:(NSDate *)date notification:(BOOL)notificationOn;

+ (UILocalNotification *)addNotificationForTask:(Task *)task;

+ (void)removeNotificationForTask:(Task *)task;

+ (void)updateTask:(Task *)task withName:(NSString *)name category:(TaskCategory *)category date:(NSDate *)date notification:(BOOL)notification;

+ (NSDate *)floorMinutes:(NSDate *)date;

+ (void)deleteTask:(Task *)task;

+ (void)markDoneState:(BOOL)state forTask:(Task *)task;

+ (int)sortType;

+ (void)setSortType:(int)type;

+ (BOOL)notificationsEnabled;

+ (void)setNotificationsEnabled:(BOOL)state;

+ (void)updateCategory:(TaskCategory *)category withName:(NSString *)name withColor:(UIColor *)color;
@end