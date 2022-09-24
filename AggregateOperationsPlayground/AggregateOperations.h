//
//  AggregateOperations.h
//  AggregateOperationsPlayground
//
//  Created by Xcode Developer on 9/22/22.
//

#ifndef AggregateOperations_h
#define AggregateOperations_h

static unsigned long c = 1UL;

int int_val = 2;
const int (^ const __strong int_block)(int) = ^ int (int i) {
      return i;
};
   
const void * (^ const __strong retain_block)(const void * _Nonnull) = ^ (const void * _Nonnull cb) {
    return (const void *)CFBridgingRetain((__bridge id _Nullable)(cb));
};

const void * _Nonnull (^release_block)(const void * _Nonnull) = ^ (const void * _Nonnull retained_block) {
    return (__bridge const void * _Nonnull)CFBridgingRelease(retained_block);
};

void(^retain_block_test)(void) = ^{
    const void * i_block = retain_block((__bridge const void * _Nonnull)(int_block));
};

void(^release_block_test)(const void *) = ^ (const void * block) {
    int (^ const __strong i_block)(int) = (__bridge int (^)(int))(release_block(block));
    i_block(1);
};

typedef typeof(CFTypeRef * (^(^(^)(unsigned long))(void))(unsigned long)) AggregateDataStructure;
static CFTypeRef * (^(^(^aggregate_data_structure)(unsigned long))(void))(unsigned long) = ^ (unsigned long object_count) {
    typedef CFTypeRef objects[object_count];
    typeof(objects) objects_ptr[object_count];
    
    return ^ (CFTypeRef * objects_t) {
        return ^{
            return ^ CFTypeRef * (unsigned long index) {
                return ((CFTypeRef *)objects_t + index);
            };
        };
    }(objects_ptr[0]);
};

static void (^(^(^aggregate_operations)(unsigned long))(const void *))(void (^ const __strong)(CFTypeRef *)) = ^ (unsigned long object_count) {
    return ^ (const void * retained_data_structure) {
        static CFTypeRef * (^(^(^released_data_structure)(unsigned long))(void))(unsigned long);
        released_data_structure = (__bridge CFTypeRef * (^(^(^)(unsigned long))(void))(unsigned long))retained_data_structure; //(__bridge CFTypeRef * (^(^(^)(unsigned long))(void))(unsigned long))(release_block(retained_structure));
        static CFTypeRef * (^(^source)(void))(unsigned long);
        static CFTypeRef * (^stream)(unsigned long);
        stream = (source = released_data_structure(object_count))();
        
        return ^ (void (^ const __strong aggregate_operation)(CFTypeRef *)) {
            for (unsigned long index = 0; index < object_count; index++) {
                CFTypeRef * operation_ptr = stream(index);
                printf("\t(array\t\t%p)\n\n", operation_ptr);
                aggregate_operation(operation_ptr);
            }
        };
    };
};



#endif /* AggregateOperations_h */
