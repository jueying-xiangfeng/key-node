//
//  ViewController.m
//  MXANRMonitor
//
//  Created by wangxiangfeng on 2022/3/15.
//

#import "ViewController.h"
#import "MXANRMonitor.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    MXANRMonitorType _type;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _type = MXANRMonitorRunLoopType;
    
    [self navigationBar];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
//    UIApplicationDidBecomeActiveNotification;
//    
//    [NSNotificationCenter defaultCenter];
//    
//    [NSNotificationCenter.defaultCenter addObserver:nil selector:nil name:nil object:nil];
}

- (void)navigationBar {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:MXANRMonitor.sharedInstance.isMonitoring ? @"关闭" : @"开启"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(startAndStop)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(change)];
}

- (void)startAndStop {
    if (MXANRMonitor.sharedInstance.isMonitoring) {
        [[MXANRMonitor sharedInstance] stopMonitor];
    } else {
        [[MXANRMonitor sharedInstance] startMonitorWithType:_type];
    }
    self.navigationItem.leftBarButtonItem.title = MXANRMonitor.sharedInstance.isMonitoring ? @"关闭" : @"开启";
}

- (void)change {
    [[MXANRMonitor sharedInstance] stopMonitor];
    
    if (_type == MXANRMonitorRunLoopType) {
        _type = MXANRMonitorThreadType;
    } else {
        _type = MXANRMonitorRunLoopType;
    }
    self.navigationItem.leftBarButtonItem.title = @"开启";
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
