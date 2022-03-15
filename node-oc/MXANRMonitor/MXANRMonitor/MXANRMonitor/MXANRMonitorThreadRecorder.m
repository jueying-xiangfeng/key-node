//
//  MXANRMonitorThreadRecorder.m
//  MXANRMonitor
//
//  Created by wangxiangfeng on 2022/3/15.
//

#import "MXANRMonitorThreadRecorder.h"
#import <UIKit/UIKit.h>

@interface MXANRMonitorThreadRecorder ()

@property (nonatomic, strong) NSThread *monitorThread;
/// 主线程是否有阻塞
@property (nonatomic, assign, getter=isMainThreadBlock) BOOL mainThreadBlock;
/// app 是否活跃
@property (nonatomic, assign) BOOL isApplicationInActive;

@end

@implementation MXANRMonitorThreadRecorder

- (instancetype)initWithTimeoutSecond:(float)second timeoutCount:(NSUInteger)count {
    self = [super initWithTimeoutSecond:second timeoutCount:count];
    
    self.isApplicationInActive = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidEnterBackground)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    return self;
}

- (void)dealloc {
    self.monitorThread = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)startMonitorRecorder {
    if (self.isMonitoring) {
        return;
    }
    self.monitoring = YES;
    
    self.monitorThread = [[NSThread alloc] initWithTarget:self selector:@selector(checkTimeout) object:nil];
    [self.monitorThread start];
}

- (void)stopMonitorRecorder {
    if (self.isMonitoring == NO) {
        return;
    }
    self.monitoring = NO;
    [self.monitorThread cancel];
}


- (void)checkTimeout {
    @autoreleasepool {
        while (self.monitorThread.isCancelled == NO) {
            if (self.isApplicationInActive) {
                /// 标记位 - 是否卡顿
                self.mainThreadBlock = YES;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    /// 如果在 timeout 时间内主线程能收到任务，则设置标记位为不卡顿
                    self.mainThreadBlock = NO;
                    [self dispatch_semaphore_signal];
                });
                [NSThread sleepForTimeInterval:self.timeoutSecond];
                
                /// 表示 timeout second 已经走过但是还没有收到主线程的标记，表示主线程卡顿
                if (self.isMainThreadBlock) {
                    /// 上报
                    [self reportANRInfo];
                }
                [self dispatch_semaphore_wait];
            } else {
                [NSThread sleepForTimeInterval:self.timeoutSecond];
            }
        }
    }
}

- (void)applicationDidBecomeActive {
    _isApplicationInActive = YES;
}

- (void)applicationDidEnterBackground {
    _isApplicationInActive = NO;
}

- (long)dispatch_semaphore_wait {
    /// 设置超时时间 5s
    return dispatch_semaphore_wait(self.waitSemaphore, dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC));
}

@end
