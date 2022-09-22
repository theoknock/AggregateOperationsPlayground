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
    
    // Initialize a data structure (i.e., source and stream)
    __block void (^aggregate_operation)(void(^)(CFTypeRef *)) = aggregate_operations(10)(retain_block((__bridge const void * _Nonnull)(aggregate_data_structure)));
    
    // Add aggregate operations to the pipeline
    
    // Aggregate
    aggregate_operation(^ (CFTypeRef * number_t){
        *(number_t) = CFBridgingRetain((__bridge id _Nullable)(^ CFTypeRef {
            __block NSNumber * number = [[NSNumber alloc] initWithUnsignedLong:c++];
            printf("\t(aggregate %lu)\n", [number unsignedLongValue]);
            return (__bridge CFTypeRef)(number);
        })());
    });
    
    // Filter
    aggregate_operation(^ (CFTypeRef * number_t){
       *(number_t) = ([(__bridge NSNumber *)*(number_t) unsignedLongValue] % 2) ? *(number_t) : nil;
        printf("Filtered number == %lu\n", [(__bridge NSNumber *)*(number_t) unsignedLongValue]);
    });
    
    // Reduce
    aggregate_operation(^ (CFTypeRef * number_t){
        if (*(number_t)) printf("\t(iterate %lu)\n", [(__bridge NSNumber *)*(number_t) unsignedLongValue]);
    });
}

@end
