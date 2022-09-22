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
    
    // Filter
    number_aggregate(^ (CFTypeRef * number_t){
        
        // TO-DO: Create a temporary collection for storing CFTypeRef * types that match a given boolean condition
        //        Replace the existing collection by passing the temporary collection to the Reduce operation
        *(number_t) = ([(__bridge NSNumber *)*(number_t) unsignedLongValue] % 2) ? *(number_t) : nil;
        printf("Filtered number == %lu\n", [(__bridge NSNumber *)*(number_t) unsignedLongValue]);
    });
    
    // Reduce (replace current collection with filtered aggregate by passing it to the Aggregate filter
    
    // Accumulate (Fold or Compose)
    
    // Iterate (Traverse or Map)
    number_aggregate(^ (CFTypeRef * number_t){
        printf("Returned number_read == %lu\n", [(__bridge NSNumber *)*(number_t) unsignedLongValue]);
    });
}

// TO-DO: Add one-by-one variant of Aggregate operation (for function graphs)
//        - Replace for loop with generator
//        - Use Filter to create a subgraph of functions from the source graph using a given conditional
//        - Use Reduce to optionally:
//              1. replace the function graph source with the subgraph created by Filter (retains Filter conditional for predicate branching during execution of the filtered function elements)
//              2. create a new collection with the subgraph created by Filter
//        - Invoke each function using either 1) Iterate (individually) or 2) Accumulate (composition) and then Iterate


@end
