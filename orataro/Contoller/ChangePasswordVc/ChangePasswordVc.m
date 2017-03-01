//
//  ChangePasswordVc.m
//  orataro
//
//  Created by Softqube on 20/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ChangePasswordVc.h"
#import "Global.h"

@interface ChangePasswordVc ()
{
    bool OldpwdHS,NewpwdHS,ConfirmpwdHS;
}
@end

@implementation ChangePasswordVc

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
    [Utility setLeftViewInTextField:self.txtOldPassword imageName:@"password" leftSpace:0 topSpace:0 size:30];
    [Utility setLeftViewInTextField:self.txtNewPassword imageName:@"password" leftSpace:0 topSpace:0 size:30];
    [Utility setLeftViewInTextField:self.txtConformPassword imageName:@"password" leftSpace:0 topSpace:0 size:30];
    {
        UIColor *color = [UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f];
        self.txtOldPassword.attributedPlaceholder =
        [[NSAttributedString alloc]
         initWithString:@"Old Password"
         attributes:@{NSForegroundColorAttributeName:color}];
    }
    {
        UIColor *color = [UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f];
        self.txtNewPassword.attributedPlaceholder =
        [[NSAttributedString alloc]
         initWithString:@"New Password"
         attributes:@{NSForegroundColorAttributeName:color}];
    }
    {
        UIColor *color = [UIColor colorWithRed:128/255.0f green:128/255.0f blue:128/255.0f alpha:1.0f];
        self.txtConformPassword.attributedPlaceholder =
        [[NSAttributedString alloc]
         initWithString:@"Confirm Password"
         attributes:@{NSForegroundColorAttributeName:color}];
    }
}

#pragma mark - UIButton Action

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnChangePassword:(id)sender {
    
}

- (IBAction)btnOldPwdShowHidden:(id)sender {
    if(OldpwdHS)
    {
        [self.btnOldPwdShowHidden setImage:[UIImage imageNamed:@"hide_pass"] forState:UIControlStateNormal];
        [self.txtOldPassword setSecureTextEntry:YES];
        OldpwdHS=NO;
    }
    else
    {
        [self.btnOldPwdShowHidden setImage:[UIImage imageNamed:@"show_pass"] forState:UIControlStateNormal];
        [self.txtOldPassword setSecureTextEntry:NO];
        OldpwdHS=YES;
    }
}

- (IBAction)btnNewPwdShowHidden:(id)sender {
    if(NewpwdHS)
    {
        [self.btnNewPwdShowHidden setImage:[UIImage imageNamed:@"hide_pass"] forState:UIControlStateNormal];
        [self.txtNewPassword setSecureTextEntry:YES];
        NewpwdHS=NO;
    }
    else
    {
        [self.btnNewPwdShowHidden setImage:[UIImage imageNamed:@"show_pass"] forState:UIControlStateNormal];
        [self.txtNewPassword setSecureTextEntry:NO];
        NewpwdHS=YES;
    }

}

- (IBAction)btnConfirmPwdShowHidden:(id)sender {
    if(ConfirmpwdHS)
    {
        [self.btnConfirmPwdShowHidden setImage:[UIImage imageNamed:@"hide_pass"] forState:UIControlStateNormal];
        [self.txtConformPassword setSecureTextEntry:YES];
        ConfirmpwdHS=NO;
    }
    else
    {
        [self.btnConfirmPwdShowHidden setImage:[UIImage imageNamed:@"show_pass"] forState:UIControlStateNormal];
        [self.txtConformPassword setSecureTextEntry:NO];
        ConfirmpwdHS=YES;
    }
}
@end
