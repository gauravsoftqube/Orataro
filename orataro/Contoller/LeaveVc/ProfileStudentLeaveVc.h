//
//  ProfileStudentLeaveVc.h
//  orataro
//
//  Created by MAC008 on 21/04/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileStudentLeaveVc : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *btnStart;
@property (weak, nonatomic) IBOutlet UIButton *btnEnddate;
@property (weak, nonatomic) IBOutlet UIView *viewPreapplication;
@property (weak, nonatomic) IBOutlet UIView *viewSave;

@property (weak, nonatomic) IBOutlet UILabel *lbHeaderTitle;
@property (weak, nonatomic) IBOutlet UITableView *tblStudentList;
@property (weak, nonatomic) IBOutlet UITextField *txtEndDate;
@property (weak, nonatomic) IBOutlet UIButton *btnFullname;
- (IBAction)btnBackClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewStudentFullnameList;
- (IBAction)btnSelectFullname:(id)sender;
- (IBAction)btnPreApplicationClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtStartDate;
@property (weak, nonatomic) IBOutlet UITextField *txtFullName;
- (IBAction)btnSaveClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *txtDescription;
- (IBAction)btnEndDateClicked:(id)sender;
- (IBAction)btnStartDateClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnPreApplication;
@property(strong,nonatomic)NSMutableDictionary *dicStudentLeaveData;
@property(strong,nonatomic)NSString *strAddEdit;
@end
