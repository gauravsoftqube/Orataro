//
//  ForgotNewPwdVc.m
//  orataro
//
//  Created by Softqube on 09/03/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ForgotNewPwdVc.h"
#import "Global.h"

@interface ForgotNewPwdVc ()
    {
        int PasswordShowHidden,PasswordConfShowHidden;
    }
    @end

@implementation ForgotNewPwdVc
    
- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonData];
    // Do any additional setup after loading the view.
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
-(void)commonData
    {
        self.viewPassword.layer.cornerRadius = 1.0;
        self.viewPassword.layer.masksToBounds =  YES;
        self.viewPassword.layer.borderWidth = 2.0;
        self.viewPassword.layer.borderColor =([UIColor colorWithRed:180.0/255.0 green:13.0/255.0 blue:53.0/255.0 alpha:1.0]).CGColor;
        
        self.viewConfirmPassword.layer.cornerRadius = 1.0;
        self.viewConfirmPassword.layer.masksToBounds =  YES;
        self.viewConfirmPassword.layer.borderWidth = 2.0;
        self.viewConfirmPassword.layer.borderColor =([UIColor colorWithRed:31.0/255.0 green:205.0/255.0 blue:72.0/255.0 alpha:1.0]).CGColor;
        
        PasswordShowHidden=0;
        PasswordConfShowHidden=0;
    }
    
#pragma mark - ApiCall
    
-(void)apiCallFor_UpdateUserPassword
    {
        if ([Utility isInterNetConnectionIsActive] == false) {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        
        NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_login,apk_UpdateUserPassword_action];
        
        NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
        [param setValue:[NSString stringWithFormat:@"WITH MOBILE"] forKey:@"ForgotMode"];
        [param setValue:[NSString stringWithFormat:@"%@",self.strMobileNumber] forKey:@"MobileNumber"];
        [param setValue:[NSString stringWithFormat:@""] forKey:@"GRNumber"];
        [param setValue:[NSString stringWithFormat:@"%@",self.strOTPPassword] forKey:@"OTPPassword"];
        [param setValue:_txtConfirmPassword.text forKey:@"NewPassword"];
        
        //  [param setValue:[NSString stringWithFormat:@"%@",self.strOTPPassword] forKey:@"OTPPassword"];
        //  [param setValue:[NSString stringWithFormat:@"%@",self.strOTPPassword] forKey:@"NewPassword"];
        
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
                     if([strStatus isEqualToString:@"Password Updated Successfully...!!!"])
                     {
                         UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [alrt show];
                         
                         UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"LoginVC"];
                         [self.navigationController pushViewController:vc animated:YES];
                         
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
    
    
    
    
#pragma mark - button action
    
- (IBAction)btnPasswordShowHidden:(id)sender {
    if (PasswordShowHidden == 0)
    {
        [_btnPasswordShowHidden setBackgroundImage:[UIImage imageNamed:@"show_pass"] forState:UIControlStateNormal];
        _txtPassword.secureTextEntry = NO;
        PasswordShowHidden=1;
    }
    else
    {
        [_btnPasswordShowHidden setBackgroundImage:[UIImage imageNamed:@"hide_pass"] forState:UIControlStateNormal];
        _txtPassword.secureTextEntry = YES;
        PasswordShowHidden=0;
    }
    
}
    
- (IBAction)btnConfPassword:(id)sender {
    if (PasswordConfShowHidden == 0)
    {
        [_btnConfPassword setBackgroundImage:[UIImage imageNamed:@"show_pass"] forState:UIControlStateNormal];
        _txtConfirmPassword.secureTextEntry = NO;
        PasswordConfShowHidden=1;
    }
    else
    {
        [_btnConfPassword setBackgroundImage:[UIImage imageNamed:@"hide_pass"] forState:UIControlStateNormal];
        _txtConfirmPassword.secureTextEntry = YES;
        PasswordConfShowHidden=0;
    }
    
}
    
- (IBAction)btnFinish:(id)sender {
    if ([Utility validateBlankField:_txtPassword.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:PASSWORD_EMPTY delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    if ([Utility validateBlankField:_txtConfirmPassword.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Password_Conf_Empty delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    if (![self.txtPassword.text isEqualToString:self.txtConfirmPassword.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Password_Conf_Not_Match delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
        
    }
    
    [self apiCallFor_UpdateUserPassword];
}
    
- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
    @end
