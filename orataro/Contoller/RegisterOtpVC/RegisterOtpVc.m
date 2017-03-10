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
}
@end

@implementation RegisterOtpVc
@synthesize hideShowBtn,aOtpTextfield,aPasswordTextField,BackBtn;
int show =0;

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
                if([strStatus isEqualToString:@"User Activated Successfully...!!!"])
                {
                    UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alrt show];
                    
                    
//                    WallVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WallVc"];
//                    vc.checkscreen = @"FromLogin";
//                    app.checkview = 0;
                    
                    [[NSUserDefaults standardUserDefaults]setObject:@"Login" forKey:@"CheckUser"];
                     [[NSUserDefaults standardUserDefaults]setObject:aPasswordTextField.text forKey:@"Password"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                    [self performSegueWithIdentifier:@"ShowWall" sender:self];
                    
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
