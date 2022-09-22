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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    void (^number_aggregate)(AggregateOperation) = aggregate_operations(10);
    number_aggregate(^ (CFTypeRef * number_t){
        *(number_t) = CFBridgingRetain((__bridge id _Nullable)(^ CFTypeRef {
            __block NSNumber * number = [[NSNumber alloc] initWithUnsignedLong:c++];
            printf("aggregate_operations == %lu\n", [number unsignedLongValue]);
            return (__bridge CFTypeRef)(number);
        })());
    });
    
    number_aggregate(^ (CFTypeRef * number_t){
                printf("Returned number_read == %lu\n", [(__bridge NSNumber *)*(number_t) unsignedLongValue]);
            });
    
    
//    aggregate_operations(10)(^ (CFTypeRef * number_t){
//        *(number_t) = CFBridgingRetain((__bridge id _Nullable)(^ CFTypeRef {
//            __block NSNumber * number = [[NSNumber alloc] initWithUnsignedLong:c++];
//            printf("aggregate_operations == %lu\n", [number unsignedLongValue]);
//            return (__bridge CFTypeRef)(number);
//        })());
//    });
    
//    array_pointer_test(10)(^ (CFTypeRef * number_t){
//        *(number_t) = CFBridgingRetain((__bridge id _Nullable)(^ CFTypeRef {
//            __block NSNumber * number = [[NSNumber alloc] initWithUnsignedLong:c++];
//            printf("Sent number_write == %lu\n", [number unsignedLongValue]);
//            return (__bridge CFTypeRef)(number);
//        })());
//    })(^ (CFTypeRef * number_t){
//        printf("Returned number_read == %lu\n", [(__bridge NSNumber *)*(number_t) unsignedLongValue]);
//    })(^ (CFTypeRef * number_t) {
//        printf("Returned number_modifiable == %lu\n", [(__bridge NSNumber *)*(number_t) unsignedLongValue]);
//        *(number_t) = CFBridgingRetain((__bridge id _Nullable)(^ CFTypeRef {
//            __block NSNumber * number = [[NSNumber alloc] initWithUnsignedLong:c++];
//            printf("Sent number_modified == %lu\n", [number unsignedLongValue]);
//            return (__bridge CFTypeRef)(number);
//        })());
//    })(^ bool (CFTypeRef number) {
//        return ([(__bridge NSNumber *)number unsignedLongValue] % 2);
//    });

}


@end
