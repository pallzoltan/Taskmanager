//
//  MainViewController.m
//  Taskmanager
//
//  Created by Páll Zoltán on 05/02/15.
//  Copyright (c) 2015 Páll Zoltán. All rights reserved.
//

#import"MainViewController.h"
#import "TaskTableViewCell.h"
#import "AddTaskViewController.h"
#import "Task.h"
#import "NSManagedObject+MagicalFinders.h"
#import "EditTaskViewController.h"
#import "DataUtil.h"
#import "HeaderView.h"
#import "SettingsViewController.h"

@interface MainViewController ()
@property(weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@property(nonatomic, strong) NSArray *undoneTasks;
@property(nonatomic, strong) NSArray *doneTasks;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //
    UINib *nib;

    nib = [UINib nibWithNibName:@"TaskTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"taskCell"];
    nib = [UINib nibWithNibName:@"HeaderView" bundle:nil];
    [self.tableView registerNib:nib forHeaderFooterViewReuseIdentifier:@"header"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizer:)];
    self.panGestureRecognizer.delegate = self;
    [self.tableView addGestureRecognizer:self.panGestureRecognizer];


//    Seriously, this is ugly, I'd put the buttons to the left and right
//    self.navigationItem.rightBarButtonItems = @[
//            [[UIBarButtonItem alloc] initWithTitle:@"+"
//                                             style:UIBarButtonItemStylePlain target:self action:@selector(handleAddTaskButton:)],
//            [[UIBarButtonItem alloc] initWithTitle:@"\u2699"
//                                             style:UIBarButtonItemStylePlain target:self action:@selector(handleSettingsButton:)]
//    ];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
                                                                              style:UIBarButtonItemStylePlain target:self action:@selector(handleSettingsButton:)];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add task"
                                                                              style:UIBarButtonItemStylePlain target:self action:@selector(handleAddTaskButton:)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self reloadData];
}

- (void)reloadData {

    NSString *sortType;
    sortType = [DataUtil sortType] == 0 ? @"date" : @"name";

    self.undoneTasks = [Task MR_findAllSortedBy:sortType ascending:YES withPredicate:[NSPredicate predicateWithFormat:@"done == 0"]];
    self.doneTasks = [Task MR_findAllSortedBy:sortType ascending:YES withPredicate:[NSPredicate predicateWithFormat:@"done == 1"]];
    [self.tableView reloadData];
}

- (void)handleSettingsButton:(UIBarButtonItem *)barButtonItem {
    SettingsViewController *settingsViewController;
    settingsViewController = [[SettingsViewController alloc] init];

    [self.navigationController pushViewController:settingsViewController animated:YES];
}

- (void)handleAddTaskButton:(UIBarButtonItem *)barButtonItem {
    AddTaskViewController *addTaskViewController;
    addTaskViewController = [[AddTaskViewController alloc] init];

    [self.navigationController pushViewController:addTaskViewController animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.undoneTasks.count;
        case 1:
            return self.doneTasks.count;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TaskTableViewCell *taskTableViewCell;

    taskTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"taskCell"];
    taskTableViewCell.task = [self dataSourceForSection:indexPath.section][(NSUInteger) indexPath.row];

    return taskTableViewCell;
}

- (NSArray *)dataSourceForSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.undoneTasks;
        case 1:
            return self.doneTasks;
        default:
            return @[];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 67;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    EditTaskViewController *editTaskViewController;
    editTaskViewController = [[EditTaskViewController alloc] init];
    editTaskViewController.task = [self dataSourceForSection:indexPath.section][indexPath.row];

    [self.navigationController pushViewController:editTaskViewController animated:YES];
}

- (void)removeCell:(TaskTableViewCell *)cell {
    NSIndexPath *indexPath;
    indexPath = [self.tableView indexPathForCell:cell];

    [DataUtil deleteTask:cell.task];
    self.undoneTasks = [Task MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"done == 0"]];
    self.doneTasks = [Task MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"done == 1"]];

    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {

    CGPoint swipeLocation;
    NSIndexPath *swipedIndexPath;
    TaskTableViewCell* swipedCell;

    swipeLocation = [panGestureRecognizer locationInView:self.tableView];
    swipedIndexPath = [self.tableView indexPathForRowAtPoint:swipeLocation];
    swipedCell = (TaskTableViewCell *) [self.tableView cellForRowAtIndexPath:swipedIndexPath];

    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateChanged: {
            NSLog(@"UIGestureRecognizerStateChanged");
            CGPoint offset;
            offset = [panGestureRecognizer translationInView:self.view];

            swipedCell.contentOffset = offset;

            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled: {

            NSLog(@"UIGestureRecognizerStateCancelled");

            // 1/4th offset will result in deletion
            if (fabsf(swipedCell.contentView.frame.origin.x) > swipedCell.frame.size.width / 5) {
                [self removeCell:swipedCell];
            } else {
                swipedCell.contentOffset = CGPointZero;
                [UIView animateWithDuration:.5 animations:^{
                    CGRect frame;
                    frame = swipedCell.contentView.frame;
                    frame.origin.x = 0;
                    swipedCell.contentView.frame = frame;
                    swipedCell.contentView.alpha = 1;
                }];
            }

            break;
        };
        case UIGestureRecognizerStatePossible:
            NSLog(@"UIGestureRecognizerStatePossible");
            break;
        case UIGestureRecognizerStateBegan:
            NSLog(@"UIGestureRecognizerStateBegan");
            break;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HeaderView *headerView;
    headerView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    headerView.label.text = section == 0 ? @"Tasks to do:" : @"Done tasks";

    return headerView;
}

@end
