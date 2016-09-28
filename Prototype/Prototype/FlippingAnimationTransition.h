//
//  FlippingAnimationTransition.h
//  Prototype
//
//  Created by Amit Gupta on 22/09/16.
//  Copyright © 2016 amit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContentViewController;
@interface FlippingAnimationTransition : NSObject <UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning>

@property ContentViewController *fromController;
@property ContentViewController *toController;
@property UINavigationControllerOperation opName;
@end
