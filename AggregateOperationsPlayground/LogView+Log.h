//
//  LogView+Log.h
//  AggregateOperationsPlayground
//
//  Created by Xcode Developer on 9/27/22.
//

#import "LogView.h"
@import CoreMedia;

NS_ASSUME_NONNULL_BEGIN

@interface LogView (Log)

- (void)log:(NSString *)context entry:(NSString *)entry time:(CMTime)time textAttributes:(NSUInteger)logTextAttributes;

@end

NS_ASSUME_NONNULL_END
