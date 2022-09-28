//
//  ViewController.h
//  AggregateOperationsPlayground
//
//  Created by Xcode Developer on 9/22/22.
//

#import <UIKit/UIKit.h>
@import CoreMedia;

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *logContainerView;
@property (weak, nonatomic) IBOutlet UITextView *logTextView;
@property (strong, nonatomic) CAGradientLayer *gradient;
@property (strong, nonatomic) CADisplayLink *displayLink;
@property (assign, nonatomic) BOOL order;
@property (assign, nonatomic) BOOL initLayout;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

