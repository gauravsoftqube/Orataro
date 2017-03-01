//
//  OtpPasswordVc.m
//  orataro
//
//  Created by Softqube on 20/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "OtpPasswordVc.h"

@interface OtpPasswordVc ()

@end

@implementation OtpPasswordVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    self.btnBack.transform=CGAffineTransformMakeRotation(M_PI / -4);
    
    UIColor *color = [UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f];
    self.txtOtp.attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:@"Otp Code"
     attributes:@{NSForegroundColorAttributeName:color}];

    [self.txtOtp.layer setBorderWidth:1];
    [self.txtOtp.layer setBorderColor:[UIColor colorWithRed:173/255.0f green:217/255.0f blue:89/255.0f alpha:1.0f].CGColor];
}//173 217  89

#pragma mark - UIButton Action

- (IBAction)btnACTIVATION:(id)sender {
}
- (IBAction)btnBack:(id)sender {
    
}
@end
