//
//  GlobalVc.m
//  orataro
//
//  Created by MAC008 on 15/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "GlobalVc.h"
#import "REFrostedViewController.h"

@interface GlobalVc ()

@end

@implementation GlobalVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)useColor:(UIColor *)color forImage:(UIImageView *)image1 img:(UIImage*)img
{
    image1.image = [image1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [image1 setTintColor:color];
    return image1.image;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
