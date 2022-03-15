//
//  MXAsync2SyncController.m
//  MXOCDemo1
//
//  Created by wangxiangfeng on 2022/3/15.
//

#import "MXAsync2SyncController.h"
#import "FDAsync2Sync.h"

@interface MXAsync2SyncController ()

@end

@implementation MXAsync2SyncController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"测试"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(test)];
}

- (void)test {
    NSArray *array = [self getDataSource];
    NSLog(@"-- array = %@", array);
}

- (NSArray *)getDataSource {
    
    __block NSArray *targetData = nil;
//    [self asyncGetDataSource:^(NSArray *array) {
//        targetData = array;
//    }];
    fd_async_task task = ^(id obj, fd_async_task_callback callback) {

        [self asyncGetDataSource:^(NSArray *array) {
            targetData = array;
            callback(obj, array);
        }];
    };
    fd_async_2_sync(task, fd_async_task_callback_null());
//    fd_async_2_sync_nonblocking(task, fd_async_task_callback_null());
    return targetData;
}

- (void)asyncGetDataSource:(void (^)(NSArray *array))completion {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        /// 耗时操作
        /// xxx
        sleep(5);
        
        !completion ? : completion(@[@"123"]);
    });
}

@end
