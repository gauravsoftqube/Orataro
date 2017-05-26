//
//  RegisterOtpVc.m
//  orataro
//
//  Created by MAC008 on 20/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "RegisterOtpVc.h"
#import "Global.h"
#import "WallVc.h"
#import "AppDelegate.h"

@interface RegisterOtpVc ()
{
    AppDelegate *app;
    NSString *strCheckUser;
}
@end

@implementation RegisterOtpVc
@synthesize hideShowBtn,aOtpTextfield,aPasswordTextField,BackBtn;
int show =0;
int multipleUser1 = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    BackBtn.transform=CGAffineTransformMakeRotation(M_PI / -4);
    
    //show_pass
    
    //UserMobileNumberRegistration
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action

- (IBAction)LoginBtnClicked:(id)sender
{
    if ([Utility validateBlankField:aOtpTextfield.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:OTPCODE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    if ([Utility validateBlankField:aPasswordTextField.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:PASSWORD_EMPTY delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    if ([Utility validatePassword1:aPasswordTextField.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:PASSWORD delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    [self apiCallForLogin];
    
}

- (IBAction)hidePaswordBtnclicked:(id)sender
{
    if (show == 0)
    {
        [hideShowBtn setBackgroundImage:[UIImage imageNamed:@"show_pass"] forState:UIControlStateNormal];
        aPasswordTextField.secureTextEntry = NO;
        show =1;
    }
    else
    {
        [hideShowBtn setBackgroundImage:[UIImage imageNamed:@"hide_pass"] forState:UIControlStateNormal];
        aPasswordTextField.secureTextEntry = YES;
        show =0;
    }
}
- (IBAction)BackbtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ApiCall

-(void)apiCallForLogin
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_registration,apk_CheckOTPForRegistration_action];
    
    NSString *currentDeviceId=[[NSUserDefaults standardUserDefaults]objectForKey:@"currentDeviceId"];
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",_Strmobnumber] forKey:@"MobileNumber"];
    [param setValue:[NSString stringWithFormat:@"%@",self.aOtpTextfield.text] forKey:@"OTPNumber"];
    [param setValue:currentDeviceId forKey:@"DivisRegID"];
    [param setValue:[NSString stringWithFormat:@"%@",self.aPasswordTextField.text] forKey:@"Password"];
    [param setValue:[NSString stringWithFormat:@"ios"] forKey:@"DiviType"];
    
    
    [ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error) {
       // [ProgressHUB hideenHUDAddedTo:self.view];
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
                if([strStatus isEqualToString:@"User Activated Successfully...!!!"])
                {
                    UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alrt show];
                    
                    [[NSUserDefaults standardUserDefaults]setObject:@"Login" forKey:@"CheckUser"];
                    [[NSUserDefaults standardUserDefaults]setObject:aPasswordTextField.text forKey:@"Password"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                    [self apiCallLogin];
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

#pragma mark - Member Count

-(void)api_getMemberCount
{
    //#define apk_Notification @"apk_Notification.asmx"
    //#define apk_MemberAllTypeOfCounts_action @"MemberAllTypeOfCounts"
    
    //    <MemberID>guid</MemberID>
    //    <ClientID>guid</ClientID>
    //    <InstituteID>guid</InstituteID>
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_Notification,apk_MemberAllTypeOfCounts_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    
    
    //[ProgressHUB showHUDAddedTo:self.view];
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
        // [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableDictionary *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             if([arrResponce count] != 0)
             {
                 NSLog(@"arr=%@",arrResponce);
                 
              //   [[NSUserDefaults standardUserDefaults]setObject:arrResponce forKey:@"TotalCountofMember"];
               //  [[NSUserDefaults standardUserDefaults]synchronize];
                 
                 // strCheckUser =@"SwitchAccount";
                 //  strCheckUser =@"WallVc";
                 
                // NSLog(@"Strcheck=%@",strCheckUser);
                 
                 [self api_changeGCMID];
                 
                 
                 //                 WallVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WallVc"];
                 //                 vc.checkscreen = @"FromLogin";
                 //                 app.checkview = 0;
                 //
                 //                 [self.navigationController pushViewController:vc animated:YES];
                 
                 
                 
                 //api_getMemberCount
                 // [self performSegueWithIdentifier:@"ShowWall" sender:self];
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
    
    // currentDeviceId =[[NSUserDefaults standardUserDefaults]objectForKey:@"currentDeviceId"];
    
    //[[NSUserDefaults standardUserDefaults]setObject:@"8d103a40eb95a3b95335ee64d2a5bf7a958fdffd3d029d6d3c0cc3dc6eca8298" forKey:@"DeviceToken"];
    //[[NSUserDefaults standardUserDefaults]synchronize];
    
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"DeviceToken"];
    
    NSLog(@"token **********************=%@",token);
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"MobileNumber"]] forKey:@"UserName"];
    
    NSString *currentDeviceId =[[NSUserDefaults standardUserDefaults]objectForKey:@"currentDeviceId"];
    
    [param setValue:[NSString stringWithFormat:@"%@",self.aPasswordTextField.text] forKey:@"Password"];
    [param setValue:[NSString stringWithFormat:@"%@",token] forKey:@"GCMID"];
    [param setValue:[NSString stringWithFormat:@"%@",currentDeviceId] forKey:@"DivRegistID"];
    
    NSLog(@"Param=%@",param);
    
    //[ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         //[ProgressHUB hideenHUDAddedTo:self.view];
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
                                 multipleUser1++;
                             }
                             else
                             {
                                 
                             }
                         }
                         if (multipleUser1 == 0)
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
                                     [[NSUserDefaults standardUserDefaults]setObject:[[NSUserDefaults standardUserDefaults]valueForKey:@"MobileNumber"] forKey:@"MobileNumber"];
                                     [[NSUserDefaults standardUserDefaults]setObject:aPasswordTextField.text forKey:@"Password"];
                                     [[NSUserDefaults standardUserDefaults]setObject:@"Login" forKey:@"CheckUser"];
                                     [[NSUserDefaults standardUserDefaults]synchronize];
                                     
                                     strCheckUser =@"SwitchAccount";
                                     
                                     [self api_getMemberCount];
                                     
                                     //api_getMemberCount
                                     // [self performSegueWithIdentifier:@"ShowWall" sender:self];
                                     
                                     //                                     UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SwitchAcoountVC"];
                                     //                                     [self.navigationController pushViewController:wc animated:YES];
                                 }
                                 
                             }
                             else
                             {
                                 [WToast showWithText:@"User not found"];
                             }
                         }
                         else if (multipleUser1 == 1)
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
                                     [[NSUserDefaults standardUserDefaults]setObject:[[NSUserDefaults standardUserDefaults]valueForKey:@"MobileNumber"] forKey:@"MobileNumber"];
                                     [[NSUserDefaults standardUserDefaults]setObject:aPasswordTextField.text forKey:@"Password"];
                                     [[NSUserDefaults standardUserDefaults]setObject:@"Login" forKey:@"CheckUser"];
                                     [[NSUserDefaults standardUserDefaults]synchronize];
                                     
                                     strCheckUser =@"SwitchAccount";
                                     
                                     [self api_getMemberCount];
                                     //
                                     //                                     UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SwitchAcoountVC"];
                                     //                                     [self.navigationController pushViewController:wc animated:YES];
                                 }
                                 
                                 
                             }
                             else
                             {
                                 for (NSMutableDictionary *dic in arrResponce)
                                 {
                                     NSString *getjsonstr = [Utility Convertjsontostring:dic];
                                     
                                     [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO Login (dic_json_string,ActiveUser) VALUES ('%@','%@')",getjsonstr,@"0"]];
                                 }
                                 [[NSUserDefaults standardUserDefaults]setObject:[[NSUserDefaults standardUserDefaults]valueForKey:@"MobileNumber"] forKey:@"MobileNumber"];
                                 [[NSUserDefaults standardUserDefaults]setObject:aPasswordTextField.text forKey:@"Password"];
                                 [[NSUserDefaults standardUserDefaults]setObject:@"Login" forKey:@"CheckUser"];
                                 [[NSUserDefaults standardUserDefaults]synchronize];
                                 
                                 strCheckUser =@"SwitchAccount";
                                 
                                 [self api_getMemberCount];
                                 //                                 UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SwitchAcoountVC"];
                                 //                                 [self.navigationController pushViewController:wc animated:YES];
                             }
                             
                         }
                     }
                     // [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",cnt] forKey:@"RememberMe"];
                     //  [[NSUserDefaults standardUserDefaults]synchronize];
                     
                     [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"RememberMe"];
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
            
            [[NSUserDefaults standardUserDefaults]setObject:[[NSUserDefaults standardUserDefaults]valueForKey:@"MobileNumber"] forKey:@"MobileNumber"];
            [[NSUserDefaults standardUserDefaults]setObject:aPasswordTextField.text forKey:@"Password"];
            [[NSUserDefaults standardUserDefaults]setObject:@"Login" forKey:@"CheckUser"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            strCheckUser =@"WallVc";
            
            [self api_getMemberCount];
            
            //            WallVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WallVc"];
            //            vc.checkscreen = @"FromLogin";
            //            app.checkview = 0;
            //
            //            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            NSString *currentDeviceId =[[NSUserDefaults standardUserDefaults]objectForKey:@"currentDeviceId"];
            
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
                
                [[NSUserDefaults standardUserDefaults]setObject:[[NSUserDefaults standardUserDefaults]valueForKey:@"MobileNumber"] forKey:@"MobileNumber"];
                [[NSUserDefaults standardUserDefaults]setObject:aPasswordTextField.text forKey:@"Password"];
                [[NSUserDefaults standardUserDefaults]setObject:@"Login" forKey:@"CheckUser"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                strCheckUser =@"WallVc";
                
                [self api_getMemberCount];
                //                WallVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WallVc"];
                //                vc.checkscreen = @"FromLogin";
                //                app.checkview = 0;
                //                [self.navigationController pushViewController:vc animated:YES];
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
        
        [[NSUserDefaults standardUserDefaults]setObject:[[NSUserDefaults standardUserDefaults]valueForKey:@"MobileNumber"] forKey:@"MobileNumber"];
        [[NSUserDefaults standardUserDefaults]setObject:aPasswordTextField.text forKey:@"Password"];
        [[NSUserDefaults standardUserDefaults]setObject:@"Login" forKey:@"CheckUser"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        strCheckUser =@"WallVc";
        [self api_getMemberCount];
        //
        //        WallVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WallVc"];
        //        vc.checkscreen = @"FromLogin";
        //        app.checkview = 0;
        //        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - Change GCMID

-(void)api_changeGCMID
{
    //apk_ChangeGCMID
    //apk_login
    
    //<UserID>guid</UserID>
    //<GCMID>string</GCMID>
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    //#define apk_InstitutePage @"apk_cmspage.asmx"
    //#define apk_GetCmsPages_action @"GetCmsPages"
    //InstituteID=4f4bbf0e-858a-46fa-a0a7-bf116f537653
    //ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
    //UserID=30032284-31d1-4ba6-8ef4-54edb8e223aa
    //BeachID=null
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_login,apk_ChangeGCMID];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"DeviceToken"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    
    if (token.length == 0)
    {
        [param setValue:@"" forKey:@"GCMID"];
        
    }
    else
    {
        [param setValue:token forKey:@"GCMID"];
        
    }
    // [param setValue:token forKey:@"GCMID"];
    
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[dic objectForKey:@"message"];
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     
                     // strCheckUserSwitch = @"SwitchAccount";
                     // strCheckUserSwitch = @"Wall";
                     
                     if ([strCheckUser isEqualToString:@"SwitchAccount"])
                     {
                         UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SwitchAcoountVC"];
                         [self.navigationController pushViewController:wc animated:YES];
                     }
                     else
                     {
                         [self performSegueWithIdentifier:@"ShowWall" sender:self];
                     }                     // NSLog(@"arr response=%@",arrResponce);
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
