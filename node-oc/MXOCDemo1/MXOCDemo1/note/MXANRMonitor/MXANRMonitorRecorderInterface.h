//
//  MXANRMonitorRecorderInterface.h
//  MXANRMonitor
//
//  Created by wangxiangfeng on 2022/3/15.
//

#ifndef MXANRMonitorRecorderInterface_h
#define MXANRMonitorRecorderInterface_h

#import <Foundation/Foundation.h>

/// 卡顿回调
typedef void (^MXANRMonitorRecorderCallback)(NSDictionary *info);

/// recorder interface
@protocol MXANRMonitorRecorder <NSObject>

@required

/// 初始化
/// timeoutCount 只对 runloop 方式有效
- (instancetype)initWithTimeoutSecond:(float)second timeoutCount:(NSUInteger)count;

/// 卡顿回调
@property (nonatomic, copy) MXANRMonitorRecorderCallback callback;

/// 是否开启了监控
@property (nonatomic, assign, readonly, getter=isMonitoring) BOOL monitoring;


/// 开启监控
- (void)startMonitorRecorder;
/// 关闭监控
- (void)stopMonitorRecorder;

@end

#endif /* MXANRMonitorRecorderInterface_h */
