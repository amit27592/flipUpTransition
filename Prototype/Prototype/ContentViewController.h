//
//  ViewController.h
//  Prototype
//
//  Created by Amit Gupta on 22/09/16.
//  Copyright © 2016 amit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController {
    
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentOffset;
@property (weak, nonatomic) IBOutlet UIView *content;

@property UIPercentDrivenInteractiveTransition *managedTransition;

@end

