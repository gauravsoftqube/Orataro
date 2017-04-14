//
//  AddPollVc.h
//  orataro
//
//  Created by MAC008 on 07/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPollVc : UIViewController

@property (strong, nonatomic) NSMutableDictionary *dicSelected_AddPage;


@property (weak, nonatomic) IBOutlet UIView *aAddOptionView;
@property (weak, nonatomic) IBOutlet UILabel *lbHeaderText;
@property(strong,nonatomic)NSString *strPoll;
- (IBAction)BackBtnClicked:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtPollName;

@property (weak, nonatomic) IBOutlet UITextField *txtStartDate;
@property (weak, nonatomic) IBOutlet UIButton *btnStartDate;
- (IBAction)btnStartDate:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtEndDate;
@property (weak, nonatomic) IBOutlet UIButton *btnEndDate;
- (IBAction)btnEndDate:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *txtIntroductiontext;

@property (weak, nonatomic) IBOutlet UIButton *btnNotifyOnly;
- (IBAction)btnNotifyOnly:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnIsPercentage;
- (IBAction)btnIsPercentage:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnIsMultiChoice;
- (IBAction)btnIsMultiChoice:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtAnswerChoices;

@property (weak, nonatomic) IBOutlet UITableView *tblMoreOptionList;

@property (weak, nonatomic) IBOutlet UIButton *btnAddMoreOption;
- (IBAction)btnAddMoreOption:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewMoreOption_Height;

@end
