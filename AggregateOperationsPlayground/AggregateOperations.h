//
//  AggregateOperations.h
//  AggregateOperationsPlayground
//
//  Created by Xcode Developer on 9/22/22.
//

#ifndef AggregateOperations_h
#define AggregateOperations_h

static unsigned long c = 1UL;

static CFTypeRef * (^(^pointer_generator)(unsigned long, CFTypeRef *))(unsigned long) = ^ (unsigned long count, CFTypeRef * start) {
    typedef typeof(CFTypeRef) objects[count];
    typeof(CFTypeRef *) objects_t[count];
    
    return ^ (CFTypeRef * objects_ptr) {
        return ^ CFTypeRef * (unsigned long index) {
            CFTypeRef * element_ptr = ((CFTypeRef *)objects_ptr + (index * sizeof(typeof(CFTypeRef *))));
            printf("element_ptr == %p", element_ptr);
            return element_ptr;
        };
    }((&objects_t)[0]);
};

typedef typeof(void(^)(CFTypeRef *)) AggregateOperation;

static void (^(^aggregate_operations)(unsigned long))(AggregateOperation) = ^ (unsigned long object_count) {
    typedef CFTypeRef objects[object_count];
    typeof(objects) objects_t[object_count];
    
    return ^ (CFTypeRef * objects_ptr) {
        CFTypeRef * (^generate_pointer)(unsigned long) = pointer_generator(object_count, objects_ptr);
        
        return ^ (AggregateOperation aggregate_operation) {
            for (unsigned long index = 0; (index & ~object_count) | ((index | object_count) & (index - object_count)); (index = -~index)) {
                aggregate_operation(generate_pointer(index));
            }
        };
        
        
    }((&objects_t)[0]);
};



#endif /* AggregateOperations_h */
