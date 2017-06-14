//
//  ReminderVc.h
//  orataro
//
//  Created by MAC008 on 09/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReminderVc : UIViewController
@property (strong, nonatomic) NSMutableDictionary *dicSelected;


@property (weak, nonatomic) IBOutlet UITableView *tblCancelled;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleHeader;
@property (weak, nonatomic) IBOutlet UITextField *aTitleTextfield;
@property (weak, nonatomic) IBOutlet UITextView *aDescriptionTextview;
@property (weak, nonatomic) IBOutlet UITextField *aImportantTextField;
@property (weak, nonatomic) IBOutlet UITextField *aCancelTextField;
@property (weak, nonatomic) IBOutlet UITextField *aSatrtDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *aEnddateTextfield;
- (IBAction)BackBtnClicked:(id)sender;
- (IBAction)SaveBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderTitle;

@property (weak, nonatomic) IBOutlet UIButton *btnImportant;
- (IBAction)btnImportant:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCancelled;
- (IBAction)btnCancelled:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnStartDate;
- (IBAction)btnStartDate:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnEndDate;
- (IBAction)btnEndDate:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

//Popup
@property (weak, nonatomic) IBOutlet UIView *viewPopup;
@property (weak, nonatomic) IBOutlet UIButton *btnHiddenPopup;
- (IBAction)btnHiddenPopup:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblPopup;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tblPopup_Height;


@end
