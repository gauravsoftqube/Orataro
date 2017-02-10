//
//  ForgotPassVc.m
//  orataro
//
//  Created by harikrishna patel on 26/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ForgotPassVc.h"

@interface ForgotPassVc ()

@end

@implementation ForgotPassVc
@synthesize aMobOuterView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    aMobOuterView.layer.cornerRadius = 1.0;
    aMobOuterView.layer.masksToBounds =  YES;
    aMobOuterView.layer.borderWidth = 2.0;
    aMobOuterView.layer.borderColor =([UIColor colorWithRed:128.0/255.0 green:163.0/255.0 blue:81.0/255.0 alpha:1.0]).CGColor;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
