//
//  MXANRMonitorRecorder.m
//  MXANRMonitor
//
//  Created by wangxiangfeng on 2022/3/15.
//

#import "MXANRMonitorRecorder.h"

@interface MXANRMonitorRecorder ()
@property (nonatomic, strong) dispatch_semaphore_t waitSemaphore;
@property (nonatomic, assign) long semaphoreSuccess;
@end

@implementation MXANRMonitorRecorder

- (instancetype)initWithTimeoutSecond:(float)second timeoutCount:(NSUInteger)count {
    self = [super init];
    if (self) {
        _timeoutSecond = second;
        _timeoutCount = count;
    }
    return self;
}

- (void)startMonitorRecorder {
    
}

- (void)stopMonitorRecorder {
    
}

- (dispatch_semaphore_t)waitSemaphore {
    if (!_waitSemaphore) {
        _waitSemaphore = dispatch_semaphore_create(0);
    }
    return _waitSemaphore;
}

- (long)semaphoreSuccess {
    return 0;
}

- (BOOL)isMonitoring {
    return _monitoring;
}

/**
 PER   每
 SEC   秒
 MSEC 毫秒
 USEC 微秒
 NSEC 纳秒
 */

- (long)dispatch_semaphore_wait {
    return dispatch_semaphore_wait(self.waitSemaphore, dispatch_time(DISPATCH_TIME_NOW, self.timeoutSecond * NSEC_PER_SEC));
}

- (void)dispatch_semaphore_signal {
    dispatch_semaphore_signal(self.waitSemaphore);
}

- (void)reportANRInfo {
    !self.callback ? : self.callback(@{@"key" : @"value"});
}

@end
