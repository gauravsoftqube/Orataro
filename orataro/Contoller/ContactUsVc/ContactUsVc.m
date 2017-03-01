//
//  ContactUsVc.m
//  orataro
//
//  Created by MAC008 on 22/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ContactUsVc.h"

@interface ContactUsVc ()

@end

@implementation ContactUsVc
@synthesize LocationImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LocationImageView.image = [LocationImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [LocationImageView setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    LocationImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - button action

- (IBAction)BackBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
