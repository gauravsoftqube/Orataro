//
//  AddHomeworkVc.h
//  orataro
//
//  Created by Softqube on 28/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddHomeworkVc : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnbAck;
- (IBAction)btnBack:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtViewDescription;
@property (weak, nonatomic) IBOutlet UITextField *txtEndDate;
@property (weak, nonatomic) IBOutlet UIButton *btnEndDate;
- (IBAction)btnEndDate:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnAttachment;
- (IBAction)btnAttachment:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSave;
- (IBAction)btnSave:(id)sender;

@end
