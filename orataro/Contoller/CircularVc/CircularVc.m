//
//  CircularVc.m
//  orataro
//
//  Created by MAC008 on 20/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "CircularVc.h"
#import "SWRevealViewController.h"

@interface CircularVc ()

@end

@implementation CircularVc
@synthesize aView1;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    aView1.layer.cornerRadius =50.;
    aView1.layer.borderWidth = 2.0;
    aView1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    //CircularVc
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action

- (IBAction)MenuBtnClicked:(id)sender
{
    [self.revealViewController rightRevealToggle:nil];
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
