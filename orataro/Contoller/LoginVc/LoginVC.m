//
//  LoginVC.m
//  orataro
//
//  Created by harikrishna patel on 25/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "LoginVC.h"
#import "Utility.h"
#import "AppDelegate.h"

@interface LoginVC ()
{

}
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

- (IBAction)btnLoginClicked:(UIButton *)sender
{
    NSLog(@"Remember Values=%d",cnt);
   
    if ([Utility validateBlankField:_aPhonenumberTextField.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:PHONE_EMPTY delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    if ([Utility validateBlankField:_aPasswordTextField.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:PASSWORD_EMPTY delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    [self apiCallLogin];
    
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

- (IBAction)btnForgotPassword:(id)sender {
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ForgotPassVc"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)btnRegister:(id)sender {
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"RegisterVc"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ApiCall

-(void)apiCallLogin
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_login,apk_LoginWithGCM_action];
    
    NSString *currentDeviceId=[[NSUserDefaults standardUserDefaults]objectForKey:@"currentDeviceId"];
    
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"DeviceToken"];
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",self.aPhonenumberTextField.text] forKey:@"UserName"];
    
    [param setValue:[NSString stringWithFormat:@"%@",self.aPasswordTextField.text] forKey:@"Password"];
    [param setValue:[NSString stringWithFormat:@"%@",token] forKey:@"GCMID"];
    [param setValue:[NSString stringWithFormat:@"%@",currentDeviceId] forKey:@"DivRegistID"];
    
    [ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             NSLog(@"%@",arrResponce);
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[dic objectForKey:@"message"];
                 if([strStatus isEqualToString:@"OTP Send On Your Mobile Number...!!!"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                     
                 }
                 else
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                     
                 }
             }
             else
             {
                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alrt show];
             }
         }
         else
         {
             UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alrt show];
         }
     }];
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
