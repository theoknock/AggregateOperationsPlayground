//
//  ViewController.m
//  AggregateOperationsPlayground
//
//  Created by Xcode Developer on 9/22/22.
//

#import "ViewController.h"
#import "AggregateOperations.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create a collecrion
    void (^number_aggregate)(AggregateOperation) = aggregate_operations(10);
    
    // Aggregate
    number_aggregate(^ (CFTypeRef * number_t){
        *(number_t) = CFBridgingRetain((__bridge id _Nullable)(^ CFTypeRef {
            __block NSNumber * number = [[NSNumber alloc] initWithUnsignedLong:c++];
            printf("aggregate_operations == %lu\n", [number unsignedLongValue]);
            return (__bridge CFTypeRef)(number);
        })());
    });
    
    // Iterate
    number_aggregate(^ (CFTypeRef * number_t){
        printf("Returned number_read == %lu\n", [(__bridge NSNumber *)*(number_t) unsignedLongValue]);
    });
}


@end
