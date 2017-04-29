//
//  LeaveVc.h
//  orataro
//
//  Created by Softqube on 13/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaveVc : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnPendingClicked;

- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblLeaveStatus;
- (IBAction)btnpendClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewLeaveStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblFullName;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTitleName;
@property (weak, nonatomic) IBOutlet UILabel *lblApplicationBy;
@property (weak, nonatomic) IBOutlet UILabel *lblApprovedOn;
@property (weak, nonatomic) IBOutlet UILabel *lblStartDate;
@property (weak, nonatomic) IBOutlet UILabel *lblEndDate;
@property (weak, nonatomic) IBOutlet UILabel *lblTeacherName;
@property (weak, nonatomic) IBOutlet UILabel *lblApplicationDate;
@property (weak, nonatomic) IBOutlet UIButton *btnPreApplication;
- (IBAction)btnPreApplication:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblLeaveStatus;
@property (weak, nonatomic) IBOutlet UITextView *txtViewNote;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
- (IBAction)btnSubmit:(id)sender;
@property(strong,nonatomic)NSMutableDictionary *dicAddLeave;
@property (strong,nonatomic)NSMutableDictionary *dicLeaveDetails;
@end
