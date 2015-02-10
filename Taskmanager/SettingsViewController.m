//
//  SettingsViewController.m
//  Taskmanager
//
//  Created by Páll Zoltán on 07/02/15.
//  Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import <MagicalRecord/NSManagedObject+MagicalFinders.h>
#import "SettingsViewController.h"
#import "TaskCategory.h"
#import "NotificationsStateCell.h"
#import "DataUtil.h"
#import "SortStateCell.h"
#import "Task.h"
#import "AddCategoryViewController.h"

@interface SettingsViewController ()

@property(weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong) NSArray *categories;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add category" style:UIBarButtonItemStylePlain target:self action:@selector(handleAddButton)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"simpleCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NotificationsStateCell" bundle:nil] forCellReuseIdentifier:@"notificationsStateCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SortStateCell" bundle:nil] forCellReuseIdentifier:@"sortStateCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.categories = [TaskCategory MR_findAll];
    [self.tableView reloadData];
}

- (void)handleAddButton {
    AddCategoryViewController *addCategoryViewController;
    addCategoryViewController = [[AddCategoryViewController alloc] init];

    [self.navigationController pushViewController:addCategoryViewController animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
        case 1:
            return self.categories.count;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: {
                    NotificationsStateCell *notificationsStateCell;
                    notificationsStateCell = (NotificationsStateCell *) [self.tableView dequeueReusableCellWithIdentifier:@"notificationsStateCell"];
                    notificationsStateCell.enabled = [DataUtil notificationsEnabled];
                    notificationsStateCell.delegate = self;

                    return notificationsStateCell;
                }
                case 1: {
                    SortStateCell *sortStateCell;
                    sortStateCell = [self.tableView dequeueReusableCellWithIdentifier:@"sortStateCell"];
                    sortStateCell.type = [DataUtil sortType];
                    sortStateCell.delegate = self;

                    return sortStateCell;
                }
                default: {
                    return [[UITableViewCell alloc] init];
                }
            }
        }
        case 1: {
            UITableViewCell *cell;
            TaskCategory *category;
            UIColor *color;
            category = self.categories[indexPath.row];

            color = [NSKeyedUnarchiver unarchiveObjectWithData:category.color];

            cell = [self.tableView dequeueReusableCellWithIdentifier:@"simpleCell"];
            cell.textLabel.text = category.name;
            cell.contentView.backgroundColor = color;

            return cell;
        }
        default: {
            return [[UITableViewCell alloc] init];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)setNotificationsState:(BOOL)enabled {
    NSArray *tasks;
    tasks = [Task MR_findAll];

    if (enabled) {
        // add notifications to tasks that require it
        for (Task *task in tasks) {
            if (task.notification.boolValue) {
                [DataUtil addNotificationForTask:task];
            }
        }
    } else {
        for (Task *task in tasks) {
            [DataUtil removeNotificationForTask:task];
        }
    }

    [DataUtil setNotificationsEnabled:enabled];
}

- (void)sortTypeDidChangeTo:(int)type {
    [DataUtil setSortType:type];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"General";
        case 1:
            return @"Categories";
        default:
            return @"";
    }
}

@end
