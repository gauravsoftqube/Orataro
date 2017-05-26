//
//  ForgotPassVc.m
//  orataro
//
//  Created by harikrishna patel on 26/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ForgotPassVc.h"
#import "Global.h"

@interface ForgotPassVc ()

@end

@implementation ForgotPassVc
@synthesize aMobOuterView,BackBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    aMobOuterView.layer.cornerRadius = 1.0;
    aMobOuterView.layer.masksToBounds =  YES;
    aMobOuterView.layer.borderWidth = 2.0;
    aMobOuterView.layer.borderColor =([UIColor colorWithRed:128.0/255.0 green:163.0/255.0 blue:81.0/255.0 alpha:1.0]).CGColor;
    
    BackBtn.transform=CGAffineTransformMakeRotation(M_PI / -4);
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ApiCall

-(void)apiCallFor_ForgotPassword
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_login,apk_NewFogotPasswordCheckUserData_action];
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"WITH MOBILE"] forKey:@"ForgotMode"];
    [param setValue:[NSString stringWithFormat:@"%@",self.txtMobileNumber.text] forKey:@"MobileNumber"];
    [param setValue:[NSString stringWithFormat:@""] forKey:@"GRNumber"];
    
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
                     
                     OtpPasswordVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"OtpPasswordVc"];
                     vc.strMobileNumber=self.txtMobileNumber.text;
                     [self.navigationController pushViewController:vc animated:YES];
                     
                 }
                 else
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Enter valid number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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

- (IBAction)BackBtnClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnVerify:(id)sender {
    if ([Utility validatePhoneLength:self.txtMobileNumber.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:PHONE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    //[self.view endEditing:YES];
    [self apiCallFor_ForgotPassword];
}
@end
