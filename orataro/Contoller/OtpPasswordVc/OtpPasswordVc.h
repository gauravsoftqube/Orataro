//
//  OtpPasswordVc.h
//  orataro
//
//  Created by Softqube on 20/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtpPasswordVc : UIViewController
@property (strong, nonatomic) NSString *strMobileNumber;

@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UITextField *txtOtp;
@property (weak, nonatomic) IBOutlet UIButton *btnACTIVATION;
- (IBAction)btnACTIVATION:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnBack:(id)sender;

@end
