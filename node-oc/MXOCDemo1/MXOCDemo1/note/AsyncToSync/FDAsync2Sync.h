//
//  FDAsync2Sync.h
//  AsyncToSync
//
//  Created by wangxiangfeng on 2022/3/13.
//  Copyright © 2022 Key. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 任务回调
typedef void (^fd_async_task_callback)(id observer, ...);
/// 异步任务
typedef void (^fd_async_task)(id observer, fd_async_task_callback callback);
/// 在适当的位置调用可打断异步转同步的卡顿拦截
typedef void (^fd_async_task_interrupt_handler)(void);
/// 带有打断器的异步任务
typedef void (^fd_async_task_interruptable)(id observer, fd_async_task_interrupt_handler interrupt_handler, fd_async_task_callback callback);


/// 任务回调的空执行
fd_async_task_callback fd_async_task_callback_null(void);

/// GCD
void fd_async_2_sync(fd_async_task task, fd_async_task_callback callback);
void fd_async_2_sync_interruptable(fd_async_task_interruptable task, fd_async_task_callback callback);


/// RunLoop
void fd_async_2_sync_nonblocking(fd_async_task task, fd_async_task_callback callback);
void fd_async_2_sync_nonblocking_interruptable(fd_async_task_interruptable task, fd_async_task_callback callback);

NS_ASSUME_NONNULL_END
