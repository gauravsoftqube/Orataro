//
//  RegisterVc.h
//  orataro
//
//  Created by harikrishna patel on 25/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterVc : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *aPhonenumOuterView;
@property (weak, nonatomic) IBOutlet UITextField *aMobTextField;
- (IBAction)VerifyBtnClicked:(id)sender;

@end
