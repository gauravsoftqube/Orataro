//
//  CreateProjectVc.h
//  orataro
//
//  Created by Softqube on 13/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateProjectVc : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
- (IBAction)btnBackGroupMember:(id)sender;
- (IBAction)btnBackStandardClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtSearchTextfield;

- (IBAction)btnBackDivisionClicked:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LbSelectTeacherHeight;

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *aHeaderTitleLb;
- (IBAction)btnSelectStudentMember:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LbProjectMemberTeacher;
@property (weak, nonatomic) IBOutlet UIView *viewSelectStandard;
- (IBAction)btnSelectTeacherMember:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *viewSelect;
- (IBAction)btnDoneClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbSelectTeacher;
- (IBAction)btnEndDateClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbSelectStudent;
- (IBAction)btnStartDateClicked:(id)sender;
- (IBAction)btnCancelClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewSelectDivision;
@property (weak, nonatomic) IBOutlet UIView *viewStudentGroupMember;
@property (weak, nonatomic) IBOutlet UILabel *lbStudentGroupHeader;
@property (weak, nonatomic) IBOutlet UITableView *tblStandard;
@property (weak, nonatomic) IBOutlet UITableView *tblDivision;
@property (weak, nonatomic) IBOutlet UITableView *tblStudentGroupMember;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LbProjectStudentHeight;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
- (IBAction)btnSumbit:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtProjectTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtStartDate;
@property (weak, nonatomic) IBOutlet UITextField *txtEndDate;
@property (weak, nonatomic) IBOutlet UITextView *txtProjectDefination;
@property (weak, nonatomic) IBOutlet UITextField *txtSelectProjectStudents;
@property (weak, nonatomic) IBOutlet UITextField *txtProjectMemberTeacher;

@property (weak, nonatomic) IBOutlet UITableView *tblEditProjectMemberList;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tblEditProjectMemberList_Height;//105
@property(strong,nonatomic)NSString *projectvar;
@property (strong,nonatomic)NSMutableDictionary *dicCreateProject;

@end
