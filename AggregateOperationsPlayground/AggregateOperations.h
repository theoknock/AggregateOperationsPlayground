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

static void (^(^(^(^(^array_pointer_test)(unsigned int))(void(^)(CFTypeRef *)))(void(^)(CFTypeRef *)))(void(^)(CFTypeRef *)))(bool(^)(CFTypeRef)) = ^ (unsigned int object_count) {
    typedef CFTypeRef objects[object_count];
    typeof(objects) objects_ptr[object_count];
    return ^ (CFTypeRef * objects_t) {
        
        __block void (^recurse)(void(^__strong)(CFTypeRef)) = ^{
            __block unsigned long (^recursive_block)(unsigned long);
            return ^ (void(^block)(CFTypeRef)) {
                (recursive_block = ^ unsigned long (unsigned long index) {
                    printf("index == %lu\t", index);
                    block((objects_t + (index * sizeof(CFTypeRef))));
                    return (unsigned long)(index ^ 0UL) && (unsigned long)recursive_block(~-index);
                })(~-object_count);
            };
        }();
        
        return ^ (void(^write_object)(CFTypeRef *)) {
            for (unsigned int index = 0; index < object_count; index++) {
                write_object(((CFTypeRef *)objects_t + index));
//                *((CFTypeRef *)objects_t + index) = CFBridgingRetain((__bridge id _Nullable)(write_object()));
                printf("Stored number_write = %lu\n", [(NSNumber *)((__bridge id)(*((CFTypeRef *)objects_t + index))) unsignedLongValue]);
            }
            return ^ (void(^read_object)(CFTypeRef *)) {
                for (unsigned int index = 0; index < object_count; index++) {
                    read_object((((CFTypeRef *)objects_t + index)));
                    printf("Stored number_read = %lu\n", [(NSNumber *)((__bridge id)(*((CFTypeRef *)objects_t + index))) unsignedLongValue]);
                }
                return ^ (void(^modify_object)(CFTypeRef *)) {
                    for (unsigned int index = 0; index < object_count; index++) {
                        modify_object(((CFTypeRef *)objects_t + index));// = CFBridgingRetain((__bridge id _Nullable)(modify_object((*((CFTypeRef *)objects_t + index)))));
                        printf("modified_number = %lu\n", [(NSNumber *)((__bridge id)(*((CFTypeRef *)objects_t + index))) unsignedLongValue]);
                    }
                    return ^ (bool(^filter_object)(CFTypeRef)) {
                        unsigned long unfiltered_object_count = object_count;
                        for (unsigned int index = 0; index < unfiltered_object_count; index++) {
                            CFTypeRef subject_object = (*((CFTypeRef *)objects_t + index));
                            (filter_object(subject_object)) ? ^{ printf("number %lu is odd\n", [(__bridge NSNumber *)subject_object unsignedLongValue]); (*((CFTypeRef *)objects_t + index) = CFBridgingRetain((__bridge id _Nullable)(subject_object))); }()
                            : ^ (unsigned int * object_count_t){ *object_count_t -= 1; }(&object_count);
                        }
//                        array_pointer_test(object_count)(^ CFTypeRef {
//                            __block NSNumber * number = [[NSNumber alloc] initWithUnsignedLong:c++];
//                            printf("Sent number_write == %lu\n", [number unsignedLongValue]);
//                            return (__bridge CFTypeRef)(number);
//                        });
                        printf("modified object_count == %lu\n", object_count);
                    };
                };
            };
        };
    }(objects_ptr);
};


#endif /* AggregateOperations_h */
