//
//  LoginVC.m
//  orataro
//
//  Created by harikrishna patel on 25/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@end

@implementation LoginVC
@synthesize aCheckBtn,aMobOuterView,aPasswordOuterView,PasswordBtn,OrLb;
int cnt = 0;
int cnt1 = 0;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    aMobOuterView.layer.cornerRadius = 1.0;
    aMobOuterView.layer.masksToBounds =  YES;
    aMobOuterView.layer.borderWidth = 2.0;
    aMobOuterView.layer.borderColor =([UIColor colorWithRed:128.0/255.0 green:163.0/255.0 blue:81.0/255.0 alpha:1.0]).CGColor;
    
    aPasswordOuterView.layer.cornerRadius = 1.0;
    aPasswordOuterView.layer.masksToBounds =  YES;
    aPasswordOuterView.layer.borderWidth = 2.0;
    aPasswordOuterView.layer.borderColor =([UIColor colorWithRed:45.0/255.0 green:161.0/255.0 blue:70.0/255.0 alpha:1.0]).CGColor;
    
    OrLb.layer.cornerRadius = 15.0;
    OrLb.layer.masksToBounds = YES;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action

- (IBAction)hideShowBtnClicked:(UIButton *)sender
{
    if (cnt1 == 0)
    {
        [PasswordBtn setBackgroundImage:[UIImage imageNamed:@"show_pass"] forState:UIControlStateNormal];
        _aPasswordTextField.secureTextEntry = NO;
         cnt1=1;
    }
    else
    {
        [PasswordBtn setBackgroundImage:[UIImage imageNamed:@"hide_pass"] forState:UIControlStateNormal];
        _aPasswordTextField.secureTextEntry = YES;
        cnt1=0;
    }
}

- (IBAction)RememberClicked:(UIButton *)sender
{
    if (cnt == 0)
    {
        [aCheckBtn setBackgroundImage:[UIImage imageNamed:@"tick_mark"] forState:UIControlStateNormal];
        cnt = 1;
    }
    else
    {
        [aCheckBtn setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        cnt = 0;
    }

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
