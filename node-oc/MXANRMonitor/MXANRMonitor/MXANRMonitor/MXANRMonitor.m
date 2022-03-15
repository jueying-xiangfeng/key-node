//
//  MXANRMonitor.m
//  MXANRMonitor
//
//  Created by wangxiangfeng on 2022/3/15.
//

#import "MXANRMonitor.h"
#import "MXANRMonitorRecorderInterface.h"
#import "BSBacktraceLogger.h"

@interface MXANRMonitor ()

@property (nonatomic, assign) float timeoutSecond;
@property (nonatomic, assign) NSUInteger timeoutCount;
@property (nonatomic, strong) id<MXANRMonitorRecorder> monitorRecorder;

@end

@implementation MXANRMonitor

+ (instancetype)sharedInstance {
    static MXANRMonitor *monitor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        monitor = [[MXANRMonitor alloc] init];
    });
    return monitor;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _monitorType = MXANRMonitorRunLoopType;
        _timeoutSecond = 0.2;
        _timeoutCount = 2;
    }
    return self;
}

- (BOOL)isMonitoring {
    return _monitorRecorder.isMonitoring;
}

- (id<MXANRMonitorRecorder>)monitorRecorder {
    if (!_monitorRecorder) {
        Class<MXANRMonitorRecorder> cls = NSClassFromString(@"MXANRMonitorRunLoopRecorder");
        if (_monitorType == MXANRMonitorThreadType) {
            cls = NSClassFromString(@"MXANRMonitorThreadRecorder");
        }
        _monitorRecorder = [[[cls class] alloc] initWithTimeoutSecond:_timeoutSecond timeoutCount:_timeoutCount];
        
        _monitorRecorder.callback = ^(NSDictionary *info) {
            NSLog(@"卡顿信息回调 --- : %@", info);
            BSLOG_MAIN
#import "BSBacktraceLogger.h"
        };
    }
    return _monitorRecorder;
}

- (void)startMonitorWithType:(MXANRMonitorType)monitorType {
    
    if (_monitorType != monitorType) {
        _monitorType = monitorType;
        /// 重置 monitor recorder
        if (_monitorRecorder) {
            [_monitorRecorder stopMonitorRecorder];
            _monitorRecorder = nil;
        }
    }
    _monitorType = monitorType;
    
    [self.monitorRecorder startMonitorRecorder];
}

- (void)stopMonitor {
    [_monitorRecorder stopMonitorRecorder];
    _monitorRecorder = nil;
}

@end
