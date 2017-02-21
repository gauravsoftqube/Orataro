//
//  ClassworkVC.m
//  orataro
//
//  Created by MAC008 on 21/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ClassworkVC.h"
#import "SWRevealViewController.h"

@interface ClassworkVC ()

@end

@implementation ClassworkVC
@synthesize aCalenderView,aView1;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    aCalenderView.layer.cornerRadius = 50.0;
    aCalenderView.layer.borderWidth =2.0;
    aCalenderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    aView1.layer.cornerRadius = 30.0;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action

- (IBAction)MenuBtnClicked:(UIButton *)sender
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
