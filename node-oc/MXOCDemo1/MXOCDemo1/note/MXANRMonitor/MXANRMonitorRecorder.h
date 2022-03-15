//
//  MXANRMonitorRecorder.h
//  MXANRMonitor
//
//  Created by wangxiangfeng on 2022/3/15.
//

#import <Foundation/Foundation.h>
#import "MXANRMonitorRecorderInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface MXANRMonitorRecorder : NSObject <MXANRMonitorRecorder>

/// 是否已经执行了 monitor
@property (nonatomic, assign, getter=isMonitoring) BOOL monitoring;
/// 等待的信号量 - 0
@property (nonatomic, strong, readonly) dispatch_semaphore_t waitSemaphore;

/// 超时时间
@property (nonatomic, assign) float timeoutSecond;
/// 超时次数
@property (nonatomic, assign) NSUInteger timeoutCount;

/// 卡顿回调 - protocol MXANRMonitorRecorder
@property (nonatomic, copy) MXANRMonitorRecorderCallback callback;



/// ********************************************
/// 子类调用

/// semaphore wait 在时间内是否执行成功 - 0
@property (nonatomic, assign, readonly) long semaphoreSuccess;

/// dispatch_semaphore_wait
- (long)dispatch_semaphore_wait;
/// dispatch_semaphore_signal
- (void)dispatch_semaphore_signal;

/// 上报卡顿信息
- (void)reportANRInfo;

@end

NS_ASSUME_NONNULL_END
