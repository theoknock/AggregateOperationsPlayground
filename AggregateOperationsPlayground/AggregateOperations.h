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
static CFTypeRef * (^(^(^aggregate_data_structure)(unsigned long))(void))(unsigned long) = ^ (unsigned long count) {
    typeof(CFTypeRef *) objects_t[count];
    return ^ (CFTypeRef * objects_ptr) {
        return ^{
            return ^ CFTypeRef * (unsigned long index) {
                return ((CFTypeRef *)objects_ptr + index);
            };
        };
    }((objects_t[0]));
};

static void (^(^(^aggregate_operations)(unsigned long))(const void *))(void(^)(CFTypeRef *)) = ^ (unsigned long object_count) {
    return ^ (const void * retained_structure) {
        CFTypeRef * (^(^(^ const __strong released_structure)(unsigned long))(void))(unsigned long) = (__bridge CFTypeRef * (^(^(^)(unsigned long))(void))(unsigned long))(release_block(retained_structure));
        static CFTypeRef * (^(^source)(void))(unsigned long);
        static CFTypeRef * (^stream)(unsigned long);
        stream = (source = released_structure(object_count))();
        
        return ^ (void(^aggregate_operation)(CFTypeRef *)) {
            for (unsigned long index = 0; index < object_count; index++) {
                aggregate_operation((stream)(index));
            }
        };
    };
};



#endif /* AggregateOperations_h */
