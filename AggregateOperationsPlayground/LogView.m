//
//  LogView.m
//  AggregateOperationsPlayground
//
//  Created by Xcode Developer on 9/27/22.
//

#import "LogView.h"

@implementation LogView

- (void)setLogEntry:(typeof(void (^)(char * _Nonnull, LogTextAttributes)))logEntry {
    ^(NSString *entry, LogTextAttributes logTextAttributes) {
        queue_log_entry(^{
            [((ViewController *)self.window.rootViewController.childViewControllers.firstObject) log:context entry:entry time:currentTime() textAttributes:(NSUInteger)logTextAttributes];
        });
    };
}

- (void)log:(NSString *)context entry:(NSString *)entry time:(CMTime)time textAttributes:(NSUInteger)logTextAttributes
{
    NSDictionary *attributes;
    switch (logTextAttributes) {
        case LogTextAttributes_Event:
            attributes = _eventTextAttributes;
            break;
        case LogTextAttributes_Operation:
            attributes = _operationTextAttributes;
            break;
        case LogTextAttributes_Success:
            attributes = _successTextAttributes;
            break;
        case LogTextAttributes_Error:
            attributes = _errorTextAttributes;
            break;
        default:
            attributes = _errorTextAttributes;
            break;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableAttributedString *log = [[NSMutableAttributedString alloc] initWithAttributedString:[self attributedText]];
        NSAttributedString *time_s = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n\n%@", stringFromCMTime(time)] attributes:attributes];
        NSAttributedString *context_s = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@", context] attributes:attributes];
        NSAttributedString *entry_s = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@", entry] attributes:attributes];
        [log appendAttributedString:time_s];
        [log appendAttributedString:context_s];
        [log appendAttributedString:entry_s];
        [self setAttributedText:log];
    });
}

@end
