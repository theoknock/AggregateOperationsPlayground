//
//  AggregateOperations.h
//  AggregateOperationsPlayground
//
//  Created by Xcode Developer on 9/22/22.
//

#ifndef AggregateOperations_h
#define AggregateOperations_h

static unsigned long c = 1UL;

static CFTypeRef * (^(^pointer_generator)(unsigned int, CFTypeRef *))(unsigned int) = ^ (unsigned int stride, CFTypeRef * start) {
    return ^ CFTypeRef * (unsigned int index) {
        printf("pointer == %p\n", ((CFTypeRef *)start + (index * stride)));
        return ((CFTypeRef *)start + (index * stride));
    };
};

typedef typeof(void(^)(CFTypeRef *)) AggregateOperation;

static void (^(^aggregate_operations)(unsigned int))(AggregateOperation) = ^ (unsigned int object_count) {
    typedef CFTypeRef objects[object_count];
    typeof(objects) objects_t[object_count];
    
    return ^ (CFTypeRef * objects_ptr) {
        CFTypeRef * (^generate_pointer)(unsigned int) = pointer_generator(object_count, objects_ptr);
        return ^ (AggregateOperation aggregate_operation) {
            for (unsigned int index = 0; index < object_count; index++) {
                aggregate_operation(generate_pointer(index * sizeof(CFTypeRef *))); // replace for loop with conditional to call either object_ptr_generator or return nil
            }
        };
    }((&objects_t)[0]);
};



#endif /* AggregateOperations_h */
