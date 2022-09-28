//
//  DeveloperLog.h
//  AggregateOperationsPlayground
//
//  Created by Xcode Developer on 9/27/22.
//

#ifndef DeveloperLog_h
#define DeveloperLog_h

typedef NS_ENUM(NSUInteger, LogTextAttributes) {
    LogTextAttributes_Error,
    LogTextAttributes_Success,
    LogTextAttributes_Operation,
    LogTextAttributes_Event
};

static  void(^LogEvent)(UITextView **, NSString *context, NSString *entry, LogTextAttributes logTextAttributes, dispatch_block_t block);

@property (strong, nonatomic) dispatch_queue_t loggerQueue;
@property (strong, nonatomic) dispatch_queue_t taskQueue;




#endif /* DeveloperLog_h */
