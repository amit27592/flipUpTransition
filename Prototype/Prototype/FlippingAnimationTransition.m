//
//  FlippingAnimationTransition.m
//  Prototype
//
//  Created by Amit Gupta on 22/09/16.
//  Copyright © 2016 amit. All rights reserved.
//

#import "FlippingAnimationTransition.h"
#import "ContentViewController.h"
static NSInteger offset = 30;

@implementation FlippingAnimationTransition {
    
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.8;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    if (_opName == UINavigationControllerOperationPop) {
        NSTimeInterval duration = [self transitionDuration:transitionContext];
        ContentViewController *source = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        ContentViewController *destination = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIView *containerView = [transitionContext containerView];
        
        source.contentHeight.constant = 0;
        source.contentWidth.constant = 0;
        
        [source.view layoutIfNeeded];
        
        [containerView addSubview:source.view];
        [containerView addSubview:destination.view];
        
        //destination.view.alpha = 0.0f;
        
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction animations:^{
            
            source.view.alpha = 0.0f;
            source.contentHeight.constant = offset;
            source.contentWidth.constant = -(source.view.frame.size.width / source.view.frame.size.height) * offset ;
            [destination.view layoutIfNeeded];
            
            [source.view layoutIfNeeded];
            
            
        } completion:^(BOOL finished){
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    } else if (_opName == UINavigationControllerOperationPush){
        NSTimeInterval duration = [self transitionDuration:transitionContext];
        ContentViewController *source = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        ContentViewController *destination = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIView *containerView = [transitionContext containerView];
        
        destination.contentHeight.constant = -offset;
        destination.contentWidth.constant = -(source.view.frame.size.width / source.view.frame.size.height) * offset ;
        
        destination.view.alpha = 0.1f;
        [destination.view layoutIfNeeded];
        
        
        
        
        [containerView addSubview:destination.view];
        [containerView addSubview:source.view];
        
        //destination.view.alpha = 0.0f;
        
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionAllowUserInteraction animations:^{
            
            destination.view.alpha = 1;
            destination.contentHeight.constant = 00;
            destination.contentWidth.constant = 00;
            [destination.view layoutIfNeeded];
            
            
            source.contentOffset.constant = -source.view.frame.size.height;
            [source.view layoutIfNeeded];
            
            
        } completion:^(BOOL finished){
            BOOL flag = ![transitionContext transitionWasCancelled];
            [transitionContext completeTransition:flag];
            source.contentOffset.constant = 0;
        }];
    }else{
        //TODO
    }
}


@end
