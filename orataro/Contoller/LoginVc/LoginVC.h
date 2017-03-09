//
//  LoginVC.h
//  orataro
//
//  Created by harikrishna patel on 25/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController

- (IBAction)btnRegisterClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *aPasswordTextField;
- (IBAction)hideShowBtnClicked:(UIButton *)sender;
- (IBAction)btnLoginClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *aPhonenumberTextField;
- (IBAction)RememberClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *aMobOuterView;
@property (weak, nonatomic) IBOutlet UIView *aPasswordOuterView;
@property (weak, nonatomic) IBOutlet UIButton *aCheckBtn;
@property (weak, nonatomic) IBOutlet UIButton *PasswordBtn;
@property (weak, nonatomic) IBOutlet UILabel *OrLb;

@property (weak, nonatomic) IBOutlet UIButton *btnForgotPassword;
- (IBAction)btnForgotPassword:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
- (IBAction)btnRegister:(id)sender;

@end
