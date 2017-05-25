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
   // NSLog(@"ViewController=%@",[self.navigationController viewControllers]);
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

#pragma mark - alerview delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

#pragma mark - UIButton Action

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnChangePassword:(id)sender
{
    
    NSString *stroldPassword = [[NSUserDefaults standardUserDefaults]valueForKey:@"Password"];
    
    if([Utility validateBlankField:_txtOldPassword.text])
    {
        [WToast showWithText:@"Please enter oldpassword"];
        return;
    }
    if([Utility validateBlankField:_txtNewPassword.text])
    {
        [WToast showWithText:@"Please enter newpassword"];
        return;
    }
    if([Utility validateBlankField:_txtConformPassword.text])
    {
        [WToast showWithText:@"Please enter confirmpassword"];
        return;
    }
    if (![stroldPassword isEqualToString:self.txtOldPassword.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Old password wrong" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;

    }
    if (![self.txtNewPassword.text isEqualToString:self.txtConformPassword.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Password_Conf_Not_Match delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
        
    }
    
    [self api_ChangePassword];
    
}

- (IBAction)btnOldPwdShowHidden:(id)sender
    {
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

- (IBAction)btnConfirmPwdShowHidden:(id)sender
{
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
-(void)api_ChangePassword
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_login,apk_ChangePassword_action];
    
    //#define apk_login  @"apk_login.asmx"
    //apk_ChangePassword_action
    
    //    <RoleName>string</RoleName>
    //    <ClientID>guid</ClientID>
    //    <InstituteID>guid</InstituteID>
    //    <StudentCode>string</StudentCode>
    //    <NewPass>string</NewPass>
    //    <OldPass>string</OldPass>
    //    <MobileNumber>string</MobileNumber>
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"RoleName "]] forKey:@"RoleName"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:@"" forKey:@"StudentCode"];
    [param setValue:_txtNewPassword.text forKey:@"NewPass"];
    [param setValue:_txtOldPassword.text forKey:@"OldPass"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MobileNumber"]] forKey:@"MobileNumber"];
    
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
                 if([strStatus isEqualToString:@"Data updated successfully."])
                 {
//                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                     [alrt show];
                     
                     WallVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WallVc"];
                    // vc.checkscreen = @"FromLogin";
                     //app.checkview = 0;
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


@end
