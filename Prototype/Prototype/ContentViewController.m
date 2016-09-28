//
//  ViewController.m
//  Prototype
//
//  Created by Amit Gupta on 22/09/16.
//  Copyright © 2016 amit. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController {
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.content.layer.masksToBounds = NO;
    self.content.layer.shadowOffset = CGSizeMake(0, 1);
    self.content.layer.shadowOpacity = 0.5;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
