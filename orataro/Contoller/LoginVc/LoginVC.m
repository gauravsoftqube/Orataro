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
#import "Global.h"

@interface LoginVC ()
{
    BOOL isValid;
    AppDelegate *app;
    NSString *currentDeviceId;
    NSString *strCheckUserSwitch;
    
}
@end

@implementation LoginVC
@synthesize aCheckBtn,aMobOuterView,aPasswordOuterView,PasswordBtn,OrLb;
int cnt = 0;
int cnt1 = 0;
int multipleUser = 0;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    app =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    
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

-(void)viewWillAppear:(BOOL)animated
{
    
    NSString *getPhoneNumber = [[NSUserDefaults standardUserDefaults]valueForKey:@"MobileNumber"];
    NSString *getPassword = [[NSUserDefaults standardUserDefaults]valueForKey:@"Password"];
    
    NSLog(@"Data=%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"RememberMe"]);
    
    if (getPhoneNumber.length != 0 && getPassword.length != 0)
    {
        _aPhonenumberTextField.text = getPhoneNumber;
        _aPasswordTextField.text = getPassword;
    }
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"RememberMe"]length] == 0)
    {
        [aCheckBtn setBackgroundImage:[UIImage imageNamed:@"tick_mark"] forState:UIControlStateNormal];
    }
    else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"RememberMe"] isEqualToString:@"0"])
    {
        [aCheckBtn setBackgroundImage:[UIImage imageNamed:@"tick_mark"] forState:UIControlStateNormal];
       
    }
    else
    {
        [aCheckBtn setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    }
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
    
     NSMutableArray *arrSelectInstiUser = [[NSMutableArray alloc]init];
    
   currentDeviceId =[[NSUserDefaults standardUserDefaults]objectForKey:@"currentDeviceId"];
    
    if ([Utility validateBlankField:_aPhonenumberTextField.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:PHONE_EMPTY delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    if ([Utility validatePhoneLength:_aPhonenumberTextField.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:PHONE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    if ([Utility validateBlankField:_aPasswordTextField.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:PASSWORD_EMPTY delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"RememberMe"] isEqualToString:@"0"])
        {
            NSArray *ary = [DBOperation selectData:@"select * from Login"];
            NSMutableArray *arrResponce = [[NSMutableArray alloc]init];
            
            arrResponce = [Utility getLocalDetail:ary columnKey:@"dic_json_string"];
            
            [DBOperation executeSQL:[NSString stringWithFormat:@"delete from Login"]];
            
                if (arrResponce.count ==1)
                {
                    [self checkMultipleUser:arrResponce];
                }
                else
                {
                    for (NSMutableDictionary *dic in arrResponce)
                    {
                        if ([[dic objectForKey:@"DeviceIdentity"] isEqualToString:currentDeviceId])
                        {
                            multipleUser++;
                        }
                        else
                        {
                            
                        }
                    }
                    if (multipleUser == 0)
                    {
                        [WToast showWithText:@"User not found"];
                    }
                    else if (multipleUser == 1)
                    {
                        [self checkMultipleUser:arrResponce];
                        
                    }
                    else
                    {
                        if ([BypassLogin isEqualToString:@"YES"])
                        {
                            NSArray *instituteID = @[
                                                     @"4F4BBF0E-858A-46FA-A0A7-BF116F537653",
                                                     @"4f4bbf0e-858a-46fa-a0a7-bf116f537653",
                                                     @"3ccb88d9-f4bf-465d-b85a-5402871a0144",
                                                     @"3CCB88D9-F4BF-465D-B85A-5402871A0144",
                                                     ];
                            
                            for (NSMutableDictionary *dic in arrResponce)
                            {
                                
                                if ([instituteID containsObject:[dic objectForKey:@"InstituteID"]])
                                {
                                    [arrSelectInstiUser addObject:dic];
                                    
                                }
                                else if([[dic objectForKey:@"DeviceIdentity"] isEqualToString:currentDeviceId])
                                {
                                    [arrSelectInstiUser addObject:dic];
                                }
                                
                            }
                            if (arrSelectInstiUser.count == 0)
                            {
                                [WToast showWithText:@"User not found"];
                            }
                            else
                            {
                                for (NSMutableDictionary *dic in arrSelectInstiUser)
                                {
                                    NSString *getjsonstr = [Utility Convertjsontostring:dic];
                                    
                                    [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO Login (dic_json_string,ActiveUser) VALUES ('%@','%@')",getjsonstr,@"0"]];
                                }
                                [[NSUserDefaults standardUserDefaults]setObject:_aPhonenumberTextField.text forKey:@"MobileNumber"];
                                [[NSUserDefaults standardUserDefaults]setObject:_aPasswordTextField.text forKey:@"Password"];
                                [[NSUserDefaults standardUserDefaults]setObject:@"Login" forKey:@"CheckUser"];
                                [[NSUserDefaults standardUserDefaults]synchronize];
                                
                                UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SwitchAcoountVC"];
                                [self.navigationController pushViewController:wc animated:YES];
                            }
                            
                        }
                        else
                        {
                            for (NSMutableDictionary *dic in arrResponce)
                            {
                                NSString *getjsonstr = [Utility Convertjsontostring:dic];
                                
                                [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO Login (dic_json_string,ActiveUser) VALUES ('%@','%@')",getjsonstr,@"0"]];
                            }
                            [[NSUserDefaults standardUserDefaults]setObject:_aPhonenumberTextField.text forKey:@"MobileNumber"];
                            [[NSUserDefaults standardUserDefaults]setObject:_aPasswordTextField.text forKey:@"Password"];
                            [[NSUserDefaults standardUserDefaults]setObject:@"Login" forKey:@"CheckUser"];
                            [[NSUserDefaults standardUserDefaults]synchronize];
                            
                            UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SwitchAcoountVC"];
                            [self.navigationController pushViewController:wc animated:YES];
                        }
                }
            }
        }
        else
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
        }
    }
    else
    {
         [self apiCallLogin];
    }
    
    
    
    
}

- (IBAction)RememberClicked:(UIButton *)sender
{
    if (cnt == 0)
    {
        [aCheckBtn setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        cnt = 1;
    }
    else
    {
        [aCheckBtn setBackgroundImage:[UIImage imageNamed:@"tick_mark"] forState:UIControlStateNormal];
        cnt = 0;
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",cnt] forKey:@"RememberMe"];
    [[NSUserDefaults standardUserDefaults]synchronize];
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
    NSMutableArray *arrSelectInstiUser = [[NSMutableArray alloc]init];
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
                UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_login,apk_LoginWithGCM_action];
    
    currentDeviceId =[[NSUserDefaults standardUserDefaults]objectForKey:@"currentDeviceId"];
    
    //[[NSUserDefaults standardUserDefaults]setObject:@"8d103a40eb95a3b95335ee64d2a5bf7a958fdffd3d029d6d3c0cc3dc6eca8298" forKey:@"DeviceToken"];
    //[[NSUserDefaults standardUserDefaults]synchronize];
    
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"DeviceToken"];
    
 //  NSLog(@"token **********************=%@",token);
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",self.aPhonenumberTextField.text] forKey:@"UserName"];
    
    [param setValue:[NSString stringWithFormat:@"%@",self.aPasswordTextField.text] forKey:@"Password"];                                                                      
   // [param setValue:@"" forKey:@"GCMID"];
    [param setValue:@"" forKey:@"GCMID"];
    [param setValue:[NSString stringWithFormat:@"%@",currentDeviceId] forKey:@"DivRegistID"];
    
    NSLog(@"Param=%@",param);
    
    [ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
        // [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            // NSLog(@"%@",arrResponce);
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 
                 NSString *strStatus=[dic objectForKey:@"message"];
                 
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Userid or password wrong" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     [DBOperation executeSQL:[NSString stringWithFormat:@"delete from Login"]];
                     
                     if (arrResponce.count ==1)
                     {
                         [self checkMultipleUser:arrResponce];
                     }
                     else
                     {
                         for (NSMutableDictionary *dic in arrResponce)
                         {
                             if ([[dic objectForKey:@"DeviceIdentity"] isEqualToString:currentDeviceId])
                             {
                                 multipleUser++;
                             }
                             else
                             {
                                 
                             }
                         }
                         if (multipleUser == 0)
                         {
                             if ([BypassLogin isEqualToString:@"NO"])
                             {
                                 NSArray *instituteID = @[
                                                          @"4F4BBF0E-858A-46FA-A0A7-BF116F537653",
                                                          @"4f4bbf0e-858a-46fa-a0a7-bf116f537653",
                                                          @"3ccb88d9-f4bf-465d-b85a-5402871a0144",
                                                          @"3CCB88D9-F4BF-465D-B85A-5402871A0144",
                                                          ];
                                 
                                 for (NSMutableDictionary *dic in arrResponce)
                                 {
                                     
                                     if ([instituteID containsObject:[dic objectForKey:@"InstituteID"]])
                                     {
                                         [arrSelectInstiUser addObject:dic];
                                         
                                     }
                                     else if([[dic objectForKey:@"DeviceIdentity"] isEqualToString:currentDeviceId])
                                     {
                                         [arrSelectInstiUser addObject:dic];
                                     }
                                     
                                 }
                                 if (arrSelectInstiUser.count == 0)
                                 {
                                     [WToast showWithText:@"User not found"];
                                 }
                                 else
                                 {
                                     for (NSMutableDictionary *dic in arrSelectInstiUser)
                                     {
                                         NSString *getjsonstr = [Utility Convertjsontostring:dic];
                                         
                                         [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO Login (dic_json_string,ActiveUser) VALUES ('%@','%@')",getjsonstr,@"0"]];
                                     }
                                     [[NSUserDefaults standardUserDefaults]setObject:_aPhonenumberTextField.text forKey:@"MobileNumber"];
                                     [[NSUserDefaults standardUserDefaults]setObject:_aPasswordTextField.text forKey:@"Password"];
                                     [[NSUserDefaults standardUserDefaults]setObject:@"Login" forKey:@"CheckUser"];
                                     [[NSUserDefaults standardUserDefaults]synchronize];
                                     
                                     strCheckUserSwitch = @"SwitchAccount";
                                //     [self api_changeGCMID];
                                     UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SwitchAcoountVC"];
                                     [self.navigationController pushViewController:wc animated:YES];
                                 }

                             }
                             else
                             {
                                   [WToast showWithText:@"User not found"];
                             }
                         }
                         else if (multipleUser == 1)
                         {
                             [self checkMultipleUser:arrResponce];
                         }
                         else
                         {
                             if ([BypassLogin isEqualToString:@"NO"])
                             {
                                 NSArray *instituteID = @[
                                                          @"4F4BBF0E-858A-46FA-A0A7-BF116F537653",
                                                          @"4f4bbf0e-858a-46fa-a0a7-bf116f537653",
                                                          @"3ccb88d9-f4bf-465d-b85a-5402871a0144",
                                                          @"3CCB88D9-F4BF-465D-B85A-5402871A0144",
                                                          ];
                                 
                                 for (NSMutableDictionary *dic in arrResponce)
                                 {
                                     
                                     if ([instituteID containsObject:[dic objectForKey:@"InstituteID"]])
                                     {
                                         [arrSelectInstiUser addObject:dic];
                                         
                                     }
                                     else if([[dic objectForKey:@"DeviceIdentity"] isEqualToString:currentDeviceId])
                                     {
                                         [arrSelectInstiUser addObject:dic];
                                     }
                                     
                                 }
                                 if (arrSelectInstiUser.count == 0)
                                 {
                                     [WToast showWithText:@"User not found"];
                                 }
                                 else
                                 {
                                     for (NSMutableDictionary *dic in arrSelectInstiUser)
                                     {
                                         NSString *getjsonstr = [Utility Convertjsontostring:dic];
                                         
                                         [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO Login (dic_json_string,ActiveUser) VALUES ('%@','%@')",getjsonstr,@"0"]];
                                     }
                                     [[NSUserDefaults standardUserDefaults]setObject:_aPhonenumberTextField.text forKey:@"MobileNumber"];
                                     [[NSUserDefaults standardUserDefaults]setObject:_aPasswordTextField.text forKey:@"Password"];
                                     [[NSUserDefaults standardUserDefaults]setObject:@"Login" forKey:@"CheckUser"];
                                     [[NSUserDefaults standardUserDefaults]synchronize];
                                     
                                      strCheckUserSwitch = @"SwitchAccount";
                                     
                                   //  [self api_changeGCMID];

                                     UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SwitchAcoountVC"];
                                     [self.navigationController pushViewController:wc animated:YES];
                                 }
                                
                                 
                             }
                             else
                             {
                                 for (NSMutableDictionary *dic in arrResponce)
                                 {
                                     NSString *getjsonstr = [Utility Convertjsontostring:dic];
                                     
                                     [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO Login (dic_json_string,ActiveUser) VALUES ('%@','%@')",getjsonstr,@"0"]];
                                 }
                                 [[NSUserDefaults standardUserDefaults]setObject:_aPhonenumberTextField.text forKey:@"MobileNumber"];
                                 [[NSUserDefaults standardUserDefaults]setObject:_aPasswordTextField.text forKey:@"Password"];
                                 [[NSUserDefaults standardUserDefaults]setObject:@"Login" forKey:@"CheckUser"];
                                 [[NSUserDefaults standardUserDefaults]synchronize];
                                 
                                  strCheckUserSwitch = @"SwitchAccount";
                                // [self api_changeGCMID];

                                 UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SwitchAcoountVC"];
                                 [self.navigationController pushViewController:wc animated:YES];
                             }
                            
                         }
                     }
                     [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",cnt] forKey:@"RememberMe"];
                     [[NSUserDefaults standardUserDefaults]synchronize];
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
- (IBAction)btnRegisterClicked:(id)sender
{
    UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"RegisterVc"];
    [self.navigationController pushViewController:wc animated:YES];
}

-(void)checkMultipleUser : (NSMutableArray *)ary
{
    NSMutableDictionary *getDic = [ary objectAtIndex:0];
    
    NSArray *instituteID = @[
                             @"4F4BBF0E-858A-46FA-A0A7-BF116F537653",
                             @"4f4bbf0e-858a-46fa-a0a7-bf116f537653",
                             @"3ccb88d9-f4bf-465d-b85a-5402871a0144",
                             @"3CCB88D9-F4BF-465D-B85A-5402871A0144",
                             ];
    
    if ([BypassLogin isEqualToString:@"NO"])
    {
        if ([instituteID containsObject:[getDic objectForKey:@"InstituteID"]])
        {
            for (NSMutableDictionary *dic in ary)
            {
                
                NSString *getjsonstr = [Utility Convertjsontostring:dic];
                [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO Login (dic_json_string,ActiveUser) VALUES ('%@','%@')",getjsonstr,@"0"]];
                
                
                [DBOperation executeSQL:@"delete from CurrentActiveUser"];
                NSString *strJSon = [Utility Convertjsontostring:dic];
                
                [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO CurrentActiveUser (JsonStr) VALUES ('%@')",strJSon]];
                
            }
            
            [[NSUserDefaults standardUserDefaults]setObject:_aPhonenumberTextField.text forKey:@"MobileNumber"];
            [[NSUserDefaults standardUserDefaults]setObject:_aPasswordTextField.text forKey:@"Password"];
            [[NSUserDefaults standardUserDefaults]setObject:@"Login" forKey:@"CheckUser"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            strCheckUserSwitch = @"Wall";
        //    [self api_changeGCMID];

            WallVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WallVc"];
            vc.checkscreen = @"";
            app.checkview = 0;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            if ([[getDic objectForKey:@"DeviceIdentity"] isEqualToString:currentDeviceId])
            {
                for (NSMutableDictionary *dic in ary)
                {
                    
                    NSString *getjsonstr = [Utility Convertjsontostring:dic];
                    [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO Login (dic_json_string,ActiveUser) VALUES ('%@','%@')",getjsonstr,@"0"]];
                    [DBOperation executeSQL:@"delete from CurrentActiveUser"];
                    NSString *strJSon = [Utility Convertjsontostring:dic];
                    
                    [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO CurrentActiveUser (JsonStr) VALUES ('%@')",strJSon]];
                    
                }
                
                [[NSUserDefaults standardUserDefaults]setObject:_aPhonenumberTextField.text forKey:@"MobileNumber"];
                [[NSUserDefaults standardUserDefaults]setObject:_aPasswordTextField.text forKey:@"Password"];
                [[NSUserDefaults standardUserDefaults]setObject:@"Login" forKey:@"CheckUser"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                strCheckUserSwitch = @"Wall";

               // [self api_changeGCMID];

                WallVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WallVc"];
                vc.checkscreen = @"";
                app.checkview = 0;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                // show toast
                [WToast showWithText:@"User not found"];
            }
        }
    }
    else
    {
        for (NSMutableDictionary *dic in ary)
        {
            
            NSString *getjsonstr = [Utility Convertjsontostring:dic];
            [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO Login (dic_json_string,ActiveUser) VALUES ('%@','%@')",getjsonstr,@"0"]];
            [DBOperation executeSQL:@"delete from CurrentActiveUser"];
            NSString *strJSon = [Utility Convertjsontostring:dic];
            
            [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO CurrentActiveUser (JsonStr) VALUES ('%@')",strJSon]];
        }
        
        [[NSUserDefaults standardUserDefaults]setObject:_aPhonenumberTextField.text forKey:@"MobileNumber"];
        [[NSUserDefaults standardUserDefaults]setObject:_aPasswordTextField.text forKey:@"Password"];
        [[NSUserDefaults standardUserDefaults]setObject:@"Login" forKey:@"CheckUser"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        strCheckUserSwitch = @"Wall";
     //   [self api_changeGCMID];

        
        WallVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WallVc"];
        vc.checkscreen = @"";
        app.checkview = 0;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


@end
