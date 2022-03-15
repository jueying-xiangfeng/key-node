//
//  MXANRMonitorController.m
//  MXOCDemo1
//
//  Created by wangxiangfeng on 2022/3/15.
//

#import "MXANRMonitorController.h"
#import "MXANRMonitor.h"

@interface MXANRMonitorController () {
    MXANRMonitorType _type;
}

@end

@implementation MXANRMonitorController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _type = MXANRMonitorRunLoopType;
    
    [self navigationBar];
}

- (void)navigationBar {
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithTitle:MXANRMonitor.sharedInstance.isMonitoring ? @"关闭" : @"开启"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(startAndStop)];
    UIBarButtonItem *rightItem2 = [[UIBarButtonItem alloc] initWithTitle:@"切换"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(change)];
    self.navigationItem.rightBarButtonItems = @[rightItem1, rightItem2];
}

- (void)startAndStop {
    if (MXANRMonitor.sharedInstance.isMonitoring) {
        [[MXANRMonitor sharedInstance] stopMonitor];
    } else {
        [[MXANRMonitor sharedInstance] startMonitorWithType:_type];
    }
    self.navigationItem.rightBarButtonItems.firstObject.title = MXANRMonitor.sharedInstance.isMonitoring ? @"关闭" : @"开启";
}

- (void)change {
    [[MXANRMonitor sharedInstance] stopMonitor];
    
    if (_type == MXANRMonitorRunLoopType) {
        _type = MXANRMonitorThreadType;
    } else {
        _type = MXANRMonitorRunLoopType;
    }
    self.navigationItem.rightBarButtonItems.firstObject.title = @"开启";
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
    return 1000;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat: @"%lu", indexPath.row];
    if (indexPath.row > 0 && indexPath.row % 30 == 0) {
        sleep(2.0);
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    sleep(2.0);
}

@end
