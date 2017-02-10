//
//  ReminderVc.h
//  orataro
//
//  Created by MAC008 on 09/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReminderVc : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *aTitleTextfield;
@property (weak, nonatomic) IBOutlet UITextView *aDescriptionTextview;
@property (weak, nonatomic) IBOutlet UITextField *aImportantTextField;
@property (weak, nonatomic) IBOutlet UITextField *aCancelTextField;
@property (weak, nonatomic) IBOutlet UITextField *aSatrtDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *aEnddateTextfield;

@end
