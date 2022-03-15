//
//  MXANRMonitorRunLoopRecorder.m
//  MXANRMonitor
//
//  Created by wangxiangfeng on 2022/3/15.
//

#import "MXANRMonitorRunLoopRecorder.h"

@interface MXANRMonitorRunLoopRecorder ()

@property (nonatomic, assign) CFRunLoopObserverRef observer;
@property (nonatomic, assign) CFRunLoopActivity runLoopActivity;
/// 监控队列 - 串行
@property (nonatomic, strong) dispatch_queue_t monitorQueue;
/// 超时次数限制
@property (nonatomic, assign) NSUInteger innerTimeoutCount;
/// 重置间隔 - 防止同一个 runloop 的多条卡顿记录连续上报
@property (nonatomic, assign) NSUInteger restoreInterval;

@end

@implementation MXANRMonitorRunLoopRecorder

- (void)startMonitorRecorder {
    
    if (self.isMonitoring) {
        return;
    }
    self.monitoring = YES;
    
    __weak typeof(self) weakSelf = self;
    self.observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        /// 更新 runloop 状态
        /// 在这里可以记录一下 kCFRunLoopAfterWaiting 的时间，然后在下面监听卡顿时候用时间来控制
        strongSelf.runLoopActivity = activity;
        [strongSelf dispatch_semaphore_signal];
    });
    CFRunLoopAddObserver(CFRunLoopGetMain(), self.observer, kCFRunLoopCommonModes);
    
    /// 创建子线程开启监控
    dispatch_async(self.monitorQueue, ^{
        
        while (self.isMonitoring) {
            
            /// 📢：关于卡顿的时间间隔，这里其实可以动态调整，每次有小到大递增
            long waitTime = [self dispatch_semaphore_wait];
            if (waitTime != self.semaphoreSuccess) {
                /// observer 为空时置空相关状态
                if (!self.observer) {
                    self.runLoopActivity = 0;
                    self.innerTimeoutCount = 0;
                    [self stopMonitorRecorder];
                    return;
                }
                /// 出现卡顿的两个关键点: kCFRunLoopBeforeSources | kCFRunLoopAfterWaiting
                if (self.runLoopActivity == kCFRunLoopBeforeSources || self.runLoopActivity == kCFRunLoopAfterWaiting) {
                    
                    if (++self.innerTimeoutCount < self.timeoutCount) {
                        continue;
                    }
                    /// 上报
                    [self reportANRInfo];
                    /// 防止多条记录重复上报
                    [NSThread sleepForTimeInterval:self.restoreInterval];
                }
            }
            self.innerTimeoutCount = 0;
        }
    });
}

- (void)stopMonitorRecorder {
    if (self.isMonitoring == NO) {
        return;
    }
    self.monitoring = NO;
    
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), self.observer, kCFRunLoopCommonModes);
    CFRelease(self.observer);
    self.observer = nil;
}

- (dispatch_queue_t)monitorQueue {
    if (!_monitorQueue) {
        _monitorQueue = dispatch_queue_create("runloop_monitor_queue", DISPATCH_QUEUE_SERIAL);
    }
    return _monitorQueue;
}

- (NSUInteger)restoreInterval {
    return 1;
}

@end
