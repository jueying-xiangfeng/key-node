//
//  ViewController.m
//  MXOCDemo1
//
//  Created by wangxiangfeng on 2022/3/15.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchDataSource];
}

- (void)fetchDataSource {
    
    NSArray *source = @[
        @{
            @"title" : @"ANR Monitor",
            @"controller" : @"MXANRMonitorController",
        },
        @{
            @"title" : @"async 2 sync",
            @"controller" : @"MXAsync2SyncController",
        },
    ];
    
    
    [self.dataSource addObjectsFromArray:source];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSDictionary *map = self.dataSource.count > indexPath.row ? self.dataSource[indexPath.row] : nil;
    cell.textLabel.text = map[@"title"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

#pragma mark - UITableViewDelegate
- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *map = self.dataSource.count > indexPath.row ? self.dataSource[indexPath.row] : nil;
    Class controllerCls = NSClassFromString(map[@"controller"]);
    if (!controllerCls) {
        return;
    }
    UIViewController *controller = [[controllerCls alloc] init];
    controller.title = map[@"title"];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
