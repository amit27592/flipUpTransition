//
//  ContentManagerViewController.m
//  Prototype
//
//  Created by Amit Gupta on 28/09/16.
//  Copyright © 2016 amit. All rights reserved.
//

#import "ContentManagerViewController.h"
#import "FlippingAnimationTransition.h"
#import "ContentViewController.h"

@interface ContentManagerViewController () {
    UINavigationController *controller;
    UIPercentDrivenInteractiveTransition *managedTransition;
}

@end

@implementation ContentManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"ContentEmbeddingSegue"]) {
        controller = (UINavigationController *)segue.destinationViewController;
        controller.delegate = self;
    }
}


- (IBAction)didPan:(UIPanGestureRecognizer *)gesture {
    
    CGPoint translation = [gesture translationInView:gesture.view.superview];
    CGFloat progress;
    
    if (translation.y < 0) {
        progress = -(translation.y/self.view.frame.size.height);
    } else {
        progress = (translation.y/self.view.frame.size.height);
    }
    
    progress /= 3.0;    //Arbitrary Scale of Animation [Suited for iPhone 6]
    progress = fminf(fmaxf(progress, 0.0), 1.0);
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            managedTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            if (translation.y <= 0) {
               
                UIViewController *dest = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
                [controller pushViewController:dest animated:YES];
                
                NSLog(@"Pushing Complete!");
            } else {
                [controller popViewControllerAnimated:true];
            }
            
            break;
        case UIGestureRecognizerStateChanged:
            
            [managedTransition updateInteractiveTransition:progress];
            break;
        case UIGestureRecognizerStateCancelled:
            [managedTransition cancelInteractiveTransition];
            break;
        case UIGestureRecognizerStateEnded: {
            CGPoint v = [gesture velocityInView:gesture.view.superview];
            if(progress > 0.1 || v.y < 0)
                [managedTransition finishInteractiveTransition];
            else
                [managedTransition cancelInteractiveTransition];
            managedTransition = nil;
            break;
        }
        default:
            NSLog(@"Unhandled");
            
            
    }
}


- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)nc
                                            animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(nonnull UIViewController *)fromVC toViewController:(nonnull UIViewController *)toVC {
    
    if([fromVC class] != [toVC class]) {
        return nil;
    }
    
    FlippingAnimationTransition *transition = [FlippingAnimationTransition new];
    if (operation == UINavigationControllerOperationPop) {
        
        transition.opName = UINavigationControllerOperationPop;
    } else if (operation == UINavigationControllerOperationPush){
        transition.opName = UINavigationControllerOperationPush;
    }else{
        transition.opName = UINavigationControllerOperationNone;
    }
    
    transition.fromController = (ContentViewController *)fromVC;
    transition.toController = (ContentViewController *)toVC;
    return transition;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    
    if([animationController class] == [FlippingAnimationTransition class]) {
        
        return managedTransition;
    }
    
    NSLog(@"Interaction controller Missing");
    return nil;
}
@end
