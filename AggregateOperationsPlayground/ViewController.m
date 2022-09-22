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

//static void (^aggregate)(CFTypeRef *) = ^ (const void * retained_aggregate_operation_pointer) {
//    ^ (CFTypeRef * aggregate_operation_pointer) {
//    *(aggregate_operation_pointer) = ^ CFTypeRef {
//        __block NSNumber * number = [[NSNumber alloc] initWithUnsignedLong:c++];
//        return (__bridge CFTypeRef)(number);
//    };
//};
//
//
//    static void(^aggregate_test)(void) = ^{
//        // Initialize a data structure (i.e., source and stream)
//        void (^aggregate_operation)(const void *) = aggregate_operations(10)(retain_block((__bridge const void * _Nonnull)(aggregate_data_structure)));
//
//        // Add aggregate operations to the pipeline
//
//        // Aggregate
//        aggregate_operation((aggregate));
//    });
//
//    aggregate_operation((__bridge const void *)(^ (CFTypeRef * number_t) {
//        *(number_t) = retain_block((__bridge const void * _Nonnull)(^ CFTypeRef {
//            __block NSNumber * number = [[NSNumber alloc] initWithUnsignedLong:c++];
//            printf("\t(aggregate\t%p)\n\n", number_t);
//            return (__bridge CFTypeRef)(number);
//        }));
//    }));
//
////    // Filter
////    aggregate_operation(^ (CFTypeRef * number_t){
////       *(number_t) = ([(__bridge NSNumber *)*(number_t) unsignedLongValue] % 2) ? *(number_t) : nil;
////        printf("\t(filter\t\t%p)\n\n", number_t);
////    });
////
////    // Reduce
////    aggregate_operation(^ (CFTypeRef * number_t){
////        printf("\t(reduce\t\t%p)\n\n", number_t);
////    });
//};

- (void)test_blk {
    }

- (void)viewDidLoad {
    [super viewDidLoad];
    static const void * retained_structure;
    void (^aggregate_operation)(void (^ const __strong)(CFTypeRef *)) = aggregate_operations(10)(retain_block((__bridge const void * _Nonnull)(aggregate_data_structure)));
    
    // Aggregate
    aggregate_operation(^ (CFTypeRef * element_ptr) {
//        printf("\t(Writing:Aggregate\t\t%p)\n\n", element_ptr);
        typeof(^{}) block = ^{
            printf("\t(element_ptr\t%p)\n\n", element_ptr);
        };
        *(element_ptr) = retain_block((__bridge const void * _Nonnull)(block));
    });
    
    // Traversal
    aggregate_operation(^ (CFTypeRef * element_ptr) {
//        printf("\t(Reading:Traversal\t\t%p)\n\n", element_ptr);
        typeof(^{}) block = (__bridge typeof(^{}))(release_block(*(element_ptr)));
        block();
    });

    
//    aggregate_test();
    
    // app crashes when viewDidLoad returns (add sleep(1) to demonstrate)
    // sleep(1); // app will crash after sleep executes
}

@end
