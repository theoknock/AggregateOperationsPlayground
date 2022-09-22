//
//  AggregateOperations.h
//  AggregateOperationsPlayground
//
//  Created by Xcode Developer on 9/22/22.
//

#ifndef AggregateOperations_h
#define AggregateOperations_h

static unsigned long c = 1UL;
typedef typeof(void(^)(CFTypeRef *)) AggregateOperation;
static void (^(^aggregate_operations)(unsigned int))(AggregateOperation) = ^ (unsigned int object_count) {
    typedef CFTypeRef objects[object_count];
    typeof(objects) objects_t[object_count];
   
    return ^ (CFTypeRef * objects_ptr) {
        return ^ (AggregateOperation aggregate_operation) {
            for (unsigned int index = 0; index < object_count; index++) {
                aggregate_operation(((CFTypeRef *)objects_ptr + index));
            }
        };
    }(objects_t);
};

#endif /* AggregateOperations_h */
