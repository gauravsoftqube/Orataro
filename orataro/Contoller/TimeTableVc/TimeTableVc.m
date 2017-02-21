//
//  TimeTableVc.m
//  orataro
//
//  Created by Softqube Mac IOS on 06/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "TimeTableVc.h"
#import "SWRevealViewController.h"

@interface TimeTableVc ()

@end

@implementation TimeTableVc
@synthesize PreBtn,NextBtn,NextimageView,PreImageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NextimageView.image = [NextimageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
     [NextimageView setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    PreImageView.image = [PreImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [PreImageView setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    
    // Do any additional setup after loading the view.
}

#pragma mark - button action


- (IBAction)PreBtnClicked:(id)sender {
}
- (IBAction)NextBtnClicked:(id)sender {
}

- (IBAction)MenuBtnClicked:(id)sender
{
    [self.revealViewController rightRevealToggle:nil];
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
