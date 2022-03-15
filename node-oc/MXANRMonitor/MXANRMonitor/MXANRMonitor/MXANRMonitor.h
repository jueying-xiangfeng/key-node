//
//  MXANRMonitor.h
//  MXANRMonitor
//
//  Created by wangxiangfeng on 2022/3/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 监控类型
typedef NS_ENUM(NSInteger, MXANRMonitorType) {
    MXANRMonitorRunLoopType,
    MXANRMonitorThreadType,
};


@interface MXANRMonitor : NSObject

/// 获取 ANRMonitor 实例
+ (instancetype)sharedInstance;

/// 设置监控类型，默认为 RunLoop
@property (nonatomic, assign, readonly) MXANRMonitorType monitorType;
/// 是否开启了监控
@property (nonatomic, assign, readonly, getter=isMonitoring) BOOL monitoring;

/// 开启监控
- (void)startMonitorWithType:(MXANRMonitorType)monitorType;
/// 停止监控
- (void)stopMonitor;

@end

NS_ASSUME_NONNULL_END
