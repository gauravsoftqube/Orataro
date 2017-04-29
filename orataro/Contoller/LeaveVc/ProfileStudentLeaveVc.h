//
//  ProfileStudentLeaveVc.h
//  orataro
//
//  Created by MAC008 on 21/04/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileStudentLeaveVc : UIViewController
- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnPreApplicationClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtStartDate;
@property (weak, nonatomic) IBOutlet UITextField *txtFullName;

@end
