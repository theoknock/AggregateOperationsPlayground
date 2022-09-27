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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
}

- (void)test {
    __block unsigned long (^aggregate_operation)(void (^ const __strong)(CFTypeRef *)) = aggregate_operations(10)(retain_block((__bridge const void * _Nonnull)(aggregate_data_structure)));
   
    // Aggregate
    c = 0;
    void(^aggregate)(CFTypeRef *) = ^ (CFTypeRef * element_ptr) {
        unsigned long (^block)(void) = ^{
            return c;
        };
        *(element_ptr) = (__bridge CFTypeRef)([block copy]); //Block_copy(retain_block((__bridge const void * _Nonnull)(block)));
        printf("\telement_ptr recv\t%p\n\n", *(element_ptr));
    };
    
    // Traversal
    void(^traverse)(CFTypeRef *) = ^ (CFTypeRef * element_ptr) {
        unsigned long (^block)(void) = (__bridge unsigned long (^)(void))(*(element_ptr)); //(__bridge typeof(CFTypeRef(^)(void)))(release_block(*(element_ptr)));
        (!block) ?: block();
        printf("\ttraverse\t%p\n\n", *(element_ptr));
    };
    
    // Filter
    void(^filter)(CFTypeRef *) = ^ (bool(^predicate)(unsigned long)) {
        return ^ (CFTypeRef * element_ptr) {
            unsigned long (^block)(void) = (__bridge unsigned long (^)(void))(*(element_ptr));
            printf("predicate == %d", predicate(block()));
            
            if (predicate(block())) {
                Block_release((__bridge const void * _Nonnull)(__bridge typeof(CFTypeRef(^)(void)))(release_block(*(element_ptr))));
                *(element_ptr) = nil;
            }
            printf("\tfilter\t%p\n\n", *(element_ptr));
        };
    }(^ bool (unsigned long conditional) {
        return c % 2;
    });
    
    // Reduce
    void(^reduce)(CFTypeRef *) = ^ (CFTypeRef * element_ptr) {
        static unsigned long count = 0;
        unsigned long (^block)(void) = (__bridge unsigned long (^)(void))(*(element_ptr)); //(__bridge typeof(CFTypeRef(^)(void)))(release_block(*(element_ptr)));
        (!block) ?: count++;
        c = count;
        printf("\tcount == (%lu %lu)\tfilter\t%p\n\n", c, count, *(element_ptr));
    };
    
    // To-Do:
    //       The aggregate_operation(s) should be able to plug into each other
    //       The aggregate_operation(s) should be divided by read and/or write
    //       The aggregate_operation(s) and all other components should be divided by source --> stream --> pipeline
    //       The aggregate_operation(s) that are part of the pipeline should be divided into intermediate and terminal operations
    //              // intermediate operations can begin with a stream component (the for-loop or recursive construct)
    //              // intermediate operations always plug into each other (although they should remain separate blocks so that they can be executed in any number, in any order)
    //              // a terminal operation is one that produces either a new source or overwrites the existing one (regardless, it creates a new source)
    aggregate_operation(aggregate);
    aggregate_operation(traverse);
    aggregate_operation(filter);
    aggregate_operation(traverse);
    ^ void (unsigned long new_object_count) {
        printf("new_object_count == %d\n\n", new_object_count);
        release_block((__bridge const void * _Nonnull)(aggregate_data_structure));
        aggregate_operation = aggregate_operations(new_object_count)(retain_block((__bridge const void * _Nonnull)(aggregate_data_structure)));
        aggregate_operation(aggregate);
    }(aggregate_operation(reduce));
    aggregate_operation(traverse);
}

@end
