//
//  PTCommuniVc.h
//  orataro
//
//  Created by Softqube Mac IOS on 06/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTCommuniVc : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *aAddBtnouterView;

@property (weak, nonatomic) IBOutlet UILabel *noPtCommunLb;
- (IBAction)BackBntClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *aSearchTextField;
@end
