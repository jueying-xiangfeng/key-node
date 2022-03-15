//
//  FDAsync2Sync.m
//  AsyncToSync
//
//  Created by wangxiangfeng on 2022/3/13.
//  Copyright © 2022 Key. All rights reserved.
//

#import "FDAsync2Sync.h"

@interface FDAsync2SyncObserver : NSObject
@property (nonatomic, copy) fd_async_task_interrupt_handler interrupt_handler;
@end

@implementation FDAsync2SyncObserver

- (instancetype)initWithInterruptHandler:(fd_async_task_interrupt_handler)interruptHandler {
    self = [super init];
    if (self) {
        _interrupt_handler = [interruptHandler copy];
    }
    return self;
}

- (void)dealloc {
    if (_interrupt_handler) {
        _interrupt_handler();
        _interrupt_handler = nil;
    }
}

@end



void _fd_async_2_sync_wait_until_interrupt(fd_async_task_interruptable task, fd_async_task_callback callback, fd_async_task_interrupt_handler interrupt_handler, dispatch_block_t wait_until_interrupt) {
    
    @autoreleasepool {
        id observer = [[FDAsync2SyncObserver alloc] initWithInterruptHandler:interrupt_handler];
        task(observer, interrupt_handler, callback);
    }
    !wait_until_interrupt ? : wait_until_interrupt();
}


fd_async_task_callback fd_async_task_callback_null(void) {
    return ^(id observer, ...) {};
}

/// GCD
void fd_async_2_sync(fd_async_task task, fd_async_task_callback callback) {
    
    fd_async_task_interruptable interruptable = ^(id observer, fd_async_task_interrupt_handler interrupt_handler, fd_async_task_callback callback) {
        task(observer, callback);
    };
    fd_async_2_sync_interruptable(interruptable, callback);
}

void fd_async_2_sync_interruptable(fd_async_task_interruptable task, fd_async_task_callback callback) {
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    fd_async_task_interrupt_handler interrupt_handler = ^{
        dispatch_semaphore_signal(semaphore);
    };
    _fd_async_2_sync_wait_until_interrupt(task, callback, interrupt_handler, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
}


/// RunLoop
void fd_async_2_sync_nonblocking(fd_async_task task, fd_async_task_callback callback) {
    
    fd_async_task_interruptable interruptable = ^(id observer, fd_async_task_interrupt_handler interrupt_handler, fd_async_task_callback callback) {
        task(observer, callback);
    };
    fd_async_2_sync_nonblocking_interruptable(interruptable, callback);
}

void fd_async_2_sync_nonblocking_interruptable(fd_async_task_interruptable task, fd_async_task_callback callback) {
    
    CFRunLoopSourceContext context = {0};
    CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    CFRunLoopAddSource(runloop, source, kCFRunLoopDefaultMode);
    
    /// 打断标识
    __block BOOL interrupt_finished = NO;
    
    fd_async_task_interrupt_handler interrupt_handler = ^{
        /// 标识打断为 true
        interrupt_finished = YES;
        /// 标记 source 为待处理
        CFRunLoopSourceSignal(source);
        /// 唤醒 runloop
        CFRunLoopWakeUp(runloop);
    };
    
    _fd_async_2_sync_wait_until_interrupt(task, callback, interrupt_handler, ^{
        do {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        } while (!interrupt_finished);
    });
    
    CFRunLoopRemoveSource(runloop, source, kCFRunLoopDefaultMode);
    CFRelease(source);
}
