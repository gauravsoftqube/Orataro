//
//  SchoolVc.m
//  orataro
//
//  Created by MAC008 on 28/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "SchoolVc.h"

@interface SchoolVc ()

@end

@implementation SchoolVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action

- (IBAction)BackBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
