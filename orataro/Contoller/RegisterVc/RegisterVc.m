//
//  RegisterVc.m
//  orataro
//
//  Created by harikrishna patel on 25/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "RegisterVc.h"
#import "AppDelegate.h"
#import "Global.h"

@interface RegisterVc ()

@end

@implementation RegisterVc
@synthesize aPhonenumOuterView,aMobTextField,BAckBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BAckBtn.transform=CGAffineTransformMakeRotation(M_PI / -4);
    
    aPhonenumOuterView.layer.cornerRadius = 1.0;
    aPhonenumOuterView.layer.masksToBounds =  YES;
    aPhonenumOuterView.layer.borderWidth = 2.0;
    aPhonenumOuterView.layer.borderColor =([UIColor colorWithRed:128.0/255.0 green:163.0/255.0 blue:81.0/255.0 alpha:1.0]).CGColor;
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
}

-(void)commonData
{
    
}

#pragma mark - ApiCall 

-(void)apiCallForRegister
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_registration,apk_CheckUserMobileNumberForRegistration_action];

    NSString *currentDeviceId=[[NSUserDefaults standardUserDefaults]objectForKey:@"currentDeviceId"];
   
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%@",self.aMobTextField.text] forKey:@"MobileNumber"];
    [param setValue:[NSString stringWithFormat:@"%@",currentDeviceId] forKey:@"DivisRegID"];
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
                    
                    
                    RegisterOtpVc *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"RegisterOtpVc"];
                    wc.Strmobnumber = self.aMobTextField.text;
                    
                    [self.navigationController pushViewController:wc animated:YES];


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

- (IBAction)VerifyBtnClicked:(id)sender
{
    if ([Utility validatePhoneLength:self.aMobTextField.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:PHONE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }

    [self.view endEditing:YES];
    [self apiCallForRegister];
}

- (IBAction)BackBtnClicked:(id)sender
{
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"LoginVC"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
