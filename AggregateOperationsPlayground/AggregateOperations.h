//
//  AggregateOperations.h
//  AggregateOperationsPlayground
//
//  Created by Xcode Developer on 9/22/22.
//

#ifndef AggregateOperations_h
#define AggregateOperations_h

static unsigned long c = 1UL;

//static CFTypeRef * (^(^pointer_generator)(unsigned long))(unsigned long) = ^ (unsigned long count) {
//    CFTypeRef objects[count];
//    static typeof(objects) objects_t;
//    *objects_t = ((CFTypeRef *)objects)[0];
//
//    return ^ (CFTypeRef * objects_ptr) {
//        return ^ CFTypeRef * (unsigned long index) {
////            CFTypeRef * element_ptr = ((CFTypeRef *)objects_ptr + index);
////            printf("element_ptr == %p", element_ptr);
//            return ((CFTypeRef *)objects_ptr + index);
//        };
//    }(objects_t);
//}; CFTypeRef * (^generate_pointer)(unsigned long) = pointer_generator(object_count);

typedef typeof(void(^)(CFTypeRef *)) AggregateOperation;

static void (^(^aggregate_operations)(unsigned long))(AggregateOperation) = ^ (unsigned long object_count) {
    typedef CFTypeRef objects[object_count];
    typeof(objects) objects_t[object_count];
    
    return ^ (CFTypeRef * objects_ptr) {
        return ^ (AggregateOperation aggregate_operation) {
            for (unsigned long index = 0; index < object_count; index++) {
                aggregate_operation(^ CFTypeRef * (unsigned long index) {
                    return ((CFTypeRef *)objects_ptr + index);
                }(index));
            }
        };
    }((&objects_t)[0]);
};



#endif /* AggregateOperations_h */
