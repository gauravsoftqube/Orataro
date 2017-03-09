//
//  ForgotNewPwdVc.h
//  orataro
//
//  Created by Softqube on 09/03/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotNewPwdVc : UIViewController
@property (strong, nonatomic) NSString *strMobileNumber;
@property (strong, nonatomic) NSString *strOTPPassword;

@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPassword;

@property (weak, nonatomic) IBOutlet UIButton *btnPasswordShowHidden;
- (IBAction)btnPasswordShowHidden:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewPassword;
@property (weak, nonatomic) IBOutlet UIView *viewConfirmPassword;

@property (weak, nonatomic) IBOutlet UIButton *btnConfPassword;
- (IBAction)btnConfPassword:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnFinish;
- (IBAction)btnFinish:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnBack:(id)sender;

@end
