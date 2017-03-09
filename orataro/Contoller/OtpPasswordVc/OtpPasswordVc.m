//
//  OtpPasswordVc.m
//  orataro
//
//  Created by Softqube on 20/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "OtpPasswordVc.h"
#import "Global.h"

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


#pragma mark - ApiCall

-(void)apiCallFor_CheckSentOTPData
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_login,apk_CheckSentOTPData_action];
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"WITH MOBILE"] forKey:@"ForgotMode"];
    [param setValue:[NSString stringWithFormat:@"%@",self.strMobileNumber] forKey:@"MobileNumber"];
    [param setValue:[NSString stringWithFormat:@""] forKey:@"GRNumber"];
    [param setValue:[NSString stringWithFormat:@"%@",_txtOtp.text] forKey:@"OTPPassword"];
    
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
                 if([strStatus isEqualToString:@"Enter New Password For Your Account...!!!"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                     
                     ForgotNewPwdVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ForgotNewPwdVc"];
                     vc.strMobileNumber= self.strMobileNumber;
                     vc.strOTPPassword=self.txtOtp.text;
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


- (IBAction)btnACTIVATION:(id)sender {
    if ([Utility validateBlankField:_txtOtp.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:OTPCODE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }

    [self apiCallFor_CheckSentOTPData];
}
- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
