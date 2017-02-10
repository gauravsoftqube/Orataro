//
//  AddPollVc.m
//  orataro
//
//  Created by MAC008 on 07/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "AddPollVc.h"

@interface AddPollVc ()

@end

@implementation AddPollVc
@synthesize aAddOptionView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    aAddOptionView.layer.cornerRadius = 12.5;
    aAddOptionView.layer.masksToBounds =YES;
    
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
