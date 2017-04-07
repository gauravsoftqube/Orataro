//
//  CalenderEventDetailVc.m
//  orataro
//
//  Created by Softqube on 22/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "CalenderEventDetailVc.h"

@interface CalenderEventDetailVc ()

@end

@implementation CalenderEventDetailVc

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
    NSString *Title = [self.dicSelectedEventdDetail objectForKey:@"title"];
    NSString *activitydetails = [self.dicSelectedEventdDetail objectForKey:@"activitydetails"];
    
    [self.lblTitle setText:[NSString stringWithFormat:@"%@",Title]];
    [self.txtViewDetailEvent setText:[NSString stringWithFormat:@"%@",activitydetails]];
    
}

#pragma mark - UIButton Action

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
