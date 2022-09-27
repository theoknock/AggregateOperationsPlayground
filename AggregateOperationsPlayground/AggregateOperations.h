//
//  AggregateOperations.h
//  AggregateOperationsPlayground
//
//  Created by Xcode Developer on 9/22/22.
//

#ifndef AggregateOperations_h
#define AggregateOperations_h

//static unsigned long c = 1UL;

int int_val = 2;
const int (^ const __strong int_block)(int) = ^ int (int i) {
      return i;
};
   
const void * _Nonnull (^ _Nonnull const __strong retain_block)(const void * _Nonnull) = ^ (const void * _Nonnull cb) {
    return (const void *)CFBridgingRetain((__bridge id _Nullable)(cb));
};

const void * _Nonnull (^ _Nonnull release_block)(const void * _Nonnull) = ^ (const void * _Nonnull retained_block) {
    return (__bridge const void * _Nonnull)CFBridgingRelease(retained_block);
};

void(^retain_block_test)(void) = ^{
    const void * i_block = retain_block((__bridge const void * _Nonnull)(int_block));
};

void(^release_block_test)(const void *) = ^ (const void * block) {
    int (^ const __strong i_block)(int) = (__bridge int (^)(int))(release_block(block));
    i_block(1);
};

static CFTypeRef _Nonnull * _Nonnull (^_Nonnull (^ _Nonnull (^ _Nonnull aggregate_data_structure)(unsigned long))(void))(unsigned long) = ^ (unsigned long object_count) {
    typedef CFTypeRef objects[object_count * sizeof(CFTypeRef *)];
    typeof(objects) objects_ptr[object_count * sizeof(CFTypeRef *)];
    printf("\nobjects_ptr[0]\t%p\n", objects_ptr[0]);
    return ^ (CFTypeRef * objects_t) {
        printf("objects_t\t\t%p\n", objects_t);
        return ^{
            return ^ CFTypeRef * (unsigned long index) {
//                printf("stream[%lu]\t\t%p\n", index, ((CFTypeRef *)objects_t + (index * sizeof(CFTypeRef *))));
                printf("\tstream\t%lu (%lu)\n", index, object_count);
                return ((CFTypeRef *)objects_t + (index * sizeof(CFTypeRef *)));
            };
        };
    }(objects_ptr[0]);
};

static unsigned long (^ _Nonnull (^ _Nonnull (^ _Nonnull aggregate_operations)(unsigned long))(const void * _Nonnull))(void (^ _Nonnull const __strong)(CFTypeRef _Nonnull * _Nonnull)) = ^ (unsigned long object_count) {
    return ^ (const void * data_structure) {
        static CFTypeRef * (^(^(^retained_data_structure)(unsigned long))(void))(unsigned long);
        retained_data_structure = [(__bridge CFTypeRef * (^(^(^)(unsigned long))(void))(unsigned long))data_structure copy]; //(__bridge CFTypeRef * (^(^(^)(unsigned long))(void))(unsigned long))(release_block(retained_structure));
        CFTypeRef * (^(^source)(void))(unsigned long) = retained_data_structure(object_count);
        CFTypeRef * (^stream)(unsigned long) = source();
        stream = (source = retained_data_structure(object_count))();
        
        static unsigned long counter = 0;
        
        return ^ unsigned long (void (^ const __strong aggregate_operation)(CFTypeRef *)) {
            printf("\n---------------------------------------------------------\n");
            counter = 0;
            for (unsigned long i = 0; i < object_count; i++) {
                counter++;
                printf("\taggregate_operation\t%lu (%lu)\n", i, object_count);
                aggregate_operation(stream(i));
            }
            return counter;
        };
    };
};



#endif /* AggregateOperations_h */
