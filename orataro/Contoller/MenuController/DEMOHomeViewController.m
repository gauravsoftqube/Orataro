//
//  DEMOHomeViewController.m
//  REFrostedViewControllerStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOHomeViewController.h"

@interface DEMOHomeViewController ()

@end

@implementation DEMOHomeViewController
int c= 0;

- (IBAction)showMenu
{
   
}

- (IBAction)MenuClicked:(id)sender
{
    
    NSLog(@"data=%@",self.presentingViewController);
    
        self.frostedViewController.direction = REFrostedViewControllerDirectionRight;
       // self.frostedViewController.panGestureEnabled = NO;
        [self.frostedViewController presentMenuViewController];
    
//    if ([self.frostedViewController presentingViewController])
//    {
//        [self.frostedViewController hideMenuViewController];
//    }
}

@end
