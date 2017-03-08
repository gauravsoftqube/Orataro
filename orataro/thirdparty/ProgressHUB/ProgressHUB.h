//
//  ProgressHUB.h
//  ProgressHUB
//
//  Created by Softqube on 07/03/17.
//  Copyright © 2017 me. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

//#import <UIKit/UIKit.h>

@interface ProgressHUB : UIViewController

+(UIView *)showHUDAddedTo:(UIView *)view;
+(UIView *)hideenHUDAddedTo:(UIView *)view;
@end
