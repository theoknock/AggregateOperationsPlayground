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
    __block unsigned long toggle_bit = 0UL; // declare and initialize global variable
    
    unsigned long (^ _Nonnull (^ _Nonnull (^ _Nonnull aggregate_operations_1)(unsigned long))(const void * _Nonnull))(void (^ _Nonnull const __strong)(CFTypeRef _Nonnull * _Nonnull)) = [aggregate_operations copy];
    CFTypeRef * (^(^(^data_structure_1)(unsigned long))(void))(unsigned long) = [aggregate_data_structure copy];
    __block unsigned long (^aggregate_operation)(void (^ const __strong)(CFTypeRef *)) = [(aggregate_operations_1(10)((__bridge const void * _Nonnull)(data_structure_1))) copy];//(aggregate_data_structure); // [(aggregate_operations(10)(retain_block((__bridge const void * _Nonnull)(aggregate_data_structure)))) copy];
    
    // Aggregate
    void(^aggregate)(CFTypeRef *) = ^ (CFTypeRef * element_ptr) {
        unsigned long (^block)(void) = ^{
            printf("\taggregate (block)\t%lu\n\n", (toggle_bit ^= 1UL));
            return toggle_bit;
        };
        *(element_ptr) = Block_copy(retain_block((__bridge const void * _Nonnull)(block))); //
        printf("\taggregate\t%p\n\n", *(element_ptr));
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
            (!predicate(0UL)) ?: ^{
                Block_release((__bridge const void * _Nonnull)(__bridge typeof(CFTypeRef(^)(void)))(release_block(*(element_ptr))));
                *(element_ptr) = NULL;
            }();
            printf("\tfilter\t%p\t\t%d\n\n", *(element_ptr),  predicate(block()));
        };
    }(^ bool (unsigned long conditional) {
        return (toggle_bit ^= 1);
    });
    
    // Reduce
    void(^reduce)(CFTypeRef *) = ^ (CFTypeRef * element_ptr) {
        static unsigned long count = 0;
        static unsigned long iterations = 0;
        unsigned long (^block)(void) = (__bridge unsigned long (^)(void))(*(element_ptr)); //(__bridge typeof(CFTypeRef(^)(void)))(release_block(*(element_ptr)));
        (!*(element_ptr)) ?: count++;
        if (iterations++ == 9) ^ void (unsigned long new_object_count) {
            printf("new_object_count == %lu\n\n", new_object_count);
//            release_block((__bridge const void * _Nonnull)(aggregate_data_structure));
            unsigned long (^ _Nonnull (^ _Nonnull (^ _Nonnull aggregate_operations_1)(unsigned long))(const void * _Nonnull))(void (^ _Nonnull const __strong)(CFTypeRef _Nonnull * _Nonnull)) = [aggregate_operations copy];
            CFTypeRef * (^(^(^data_structure_1)(unsigned long))(void))(unsigned long) = [aggregate_data_structure copy];
            aggregate_operation = [(aggregate_operations_1(new_object_count)((__bridge const void * _Nonnull)(data_structure_1))) copy];//(aggregate_data_structure); // [(aggregate_operations(10)(retain_block((__bridge const void * _Nonnull)(aggregate_data_structure)))) copy];
            
        }(count);
        printf("\treduce (%lu)\t%p\n\n", count, *(element_ptr));
    };
    
    // To-Do:
    //       The aggregate_operation(s) should be able to plug into each other
    //       The aggregate_operation(s) should be divided by read and/or write
    //       The aggregate_operation(s) and all other components should be divided by source --> stream --> pipeline
    //       The aggregate_operation(s) that are part of the pipeline should be divided into intermediate and terminal operations
    //              // intermediate operations can begin with a stream component (the for-loop or recursive construct)
    //              // intermediate operations always plug into each other (although they should remain separate blocks so that they can be executed in any number, in any order)
    //              // a terminal operation is one that produces either a new source or overwrites the existing one (regardless, it creates a new source)
    
    // Add these to a collection
    unsigned long (^ _Nonnull (^ _Nonnull (^ _Nonnull aggregate_operations_2)(unsigned long))(const void * _Nonnull))(void (^ _Nonnull const __strong)(CFTypeRef _Nonnull * _Nonnull)) = [aggregate_operations copy];
    CFTypeRef * (^(^(^data_structure_2)(unsigned long))(void))(unsigned long) = aggregate_data_structure;
    __block unsigned long (^aggregate_operation_composition)(void (^ const __strong)(CFTypeRef *)) = ((aggregate_operations_2(6))((__bridge const void * _Nonnull)(data_structure_2)));//(aggregate_data_structure);
    
    
    static unsigned long aggregate_operation_index = 0;
    void(^aggregate__)(CFTypeRef *) = ^ (CFTypeRef * element_ptr) {
        __block void(^aggregate_[6])(CFTypeRef *) = {[aggregate copy], [traverse copy], [filter copy], [reduce copy], [aggregate copy], [traverse copy]};
        //        aggregate_operation(aggregate_[aggregate_operation_index]);
        //        aggregate_operation(aggregate_[aggregate_operation_index]);
        *(element_ptr) = (__bridge CFTypeRef)(aggregate_[aggregate_operation_index]); //Block_copy(retain_block((__bridge const void * _Nonnull)(block)));
        printf("\t-----------------------------aggregate_[%lu]\t%p\n\n", aggregate_operation_index++, *(element_ptr));
    };
    
    void(^traverse__)(CFTypeRef *) = ^ (CFTypeRef * element_ptr) {
        //        void(^block_)(CFTypeRef *) = (__bridge void (^)(CFTypeRef *))(*(element_ptr)); //(__bridge typeof(CFTypeRef(^)(void)))(release_block(*(element_ptr)));
        aggregate_operation((__bridge void (^)(CFTypeRef *))(*(element_ptr)));
        printf("\t-----------------------------traverse__[%lu]\t%p\n\n", --aggregate_operation_index, *(element_ptr));
    };
    aggregate_operation_composition(aggregate__);
    aggregate_operation_composition(traverse__);
    
    //    aggregate_operation(traverse);
    //    aggregate_operation(filter);
    //
    //    ^ void (unsigned long new_object_count) {
    //        printf("new_object_count == %lu\n\n", new_object_count);
    //        release_block((__bridge const void * _Nonnull)(aggregate_data_structure));
    //        aggregate_operation = aggregate_operations(new_object_count)(retain_block((__bridge const void * _Nonnull)(aggregate_data_structure)));
    //        aggregate_operation(aggregate);
    //        aggregate_operation(traverse);
    //    }((aggregate_operation(reduce)));
}

@end

