//
//  RegisterOtpVc.h
//  orataro
//
//  Created by MAC008 on 20/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterOtpVc : UIViewController
- (IBAction)LoginBtnClicked:(id)sender;
- (IBAction)hidePaswordBtnclicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *hideShowBtn;
@property (weak, nonatomic) IBOutlet UITextField *aPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *aOtpTextfield;
- (IBAction)BackbtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *BackBtn;
@property (strong,nonatomic)NSString *Strmobnumber;

@end
