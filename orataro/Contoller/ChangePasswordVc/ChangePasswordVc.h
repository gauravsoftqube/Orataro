//
//  ChangePasswordVc.h
//  orataro
//
//  Created by Softqube on 20/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordVc : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UITextField *txtOldPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtNewPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConformPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnChangePassword;
- (IBAction)btnChangePassword:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnOldPwdShowHidden;
- (IBAction)btnOldPwdShowHidden:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnNewPwdShowHidden;
- (IBAction)btnNewPwdShowHidden:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnConfirmPwdShowHidden;
- (IBAction)btnConfirmPwdShowHidden:(id)sender;

@end
