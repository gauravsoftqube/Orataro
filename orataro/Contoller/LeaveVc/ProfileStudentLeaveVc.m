//
//  ProfileStudentLeaveVc.m
//  orataro
//
//  Created by MAC008 on 21/04/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ProfileStudentLeaveVc.h"

@interface ProfileStudentLeaveVc ()

@end

@implementation ProfileStudentLeaveVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action

- (IBAction)btnBackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnPreApplicationClicked:(id)sender
{
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
