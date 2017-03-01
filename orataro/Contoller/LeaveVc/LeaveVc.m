//
//  LeaveVc.m
//  orataro
//
//  Created by Softqube on 13/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "LeaveVc.h"

@interface LeaveVc ()

@end

@implementation LeaveVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    
}



- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)btnPreApplication:(id)sender {
}
- (IBAction)btnSubmit:(id)sender {
}
@end
