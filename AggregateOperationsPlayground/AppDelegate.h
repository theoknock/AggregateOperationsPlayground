//
//  AppDelegate.h
//  AggregateOperationsPlayground
//
//  Created by Xcode Developer on 9/22/22.
//

@import UIKit;
@import CoreMedia;

#import "ViewController.h"

#define AppServices ((AppDelegate *)[[UIApplication sharedApplication] delegate])


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

