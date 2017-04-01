//
//  HelpDeskVc.m
//  orataro
//
//  Created by MAC008 on 09/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "HelpDeskVc.h"

@interface HelpDeskVc ()

@end

@implementation HelpDeskVc

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)btnPhoneNo:(id)sender {
    NSString *phoneNumber = [NSString stringWithFormat:@"tel://8530974227"];
    NSURL *phoneURL = [NSURL URLWithString:phoneNumber];
    [[UIApplication sharedApplication] openURL:phoneURL];

}
- (IBAction)btnSupportURL:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://support@orataro.com"]];
}
@end
