//
//  CreateScoolGroupVc.h
//  orataro
//
//  Created by Softqube on 22/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateScoolGroupVc : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate>

- (IBAction)btnBackStandardClicked:(id)sender;

- (IBAction)btnGroupTypeClicked:(id)sender;
@property (weak, nonatomic) NSString *strEditOrCreate;
//Header
@property (weak, nonatomic) IBOutlet UIButton *btnBackHeader;
- (IBAction)btnBackHeader:(id)sender;
- (IBAction)btnBackGroupTypeClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSubmitHeader;
- (IBAction)btnSubmitHeader:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *aHeadreTitle;
//view
@property (weak, nonatomic) IBOutlet UIButton *btnTackeImage;
- (IBAction)btnTackeImage:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtGroupTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtGroupSubject;
@property (weak, nonatomic) IBOutlet UITextField *txtEducationGroup;

@property (weak, nonatomic) IBOutlet UITextView *txtViewAbout;
@property (weak, nonatomic) IBOutlet UITextField *txtGroupMemberStudent;
@property (weak, nonatomic) IBOutlet UITextField *txtGroupMemberTecher;

@property (weak, nonatomic) IBOutlet UITableView *tblMemberList;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tblMembrList_Height;
@property (strong, nonatomic) IBOutlet UIView *viewGroupSelect;
@property (strong, nonatomic) IBOutlet UIView *viewStudentGroupSelect;
@property (weak, nonatomic) IBOutlet UITableView *tblGetGroup;
@property (weak, nonatomic) IBOutlet UITableView *tblStudentGroup;
@property (weak, nonatomic) IBOutlet UIView *viewStudentGroupStandard;

@property (weak, nonatomic) IBOutlet UIButton *btnMemberCkeckBoxMember;
- (IBAction)btnMemberCkeckBoxMember:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnMemberCkeckBoxPost;
- (IBAction)btnMemberCkeckBoxPost:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnMemberCkeckBoxAlbums;
- (IBAction)btnMemberCkeckBoxAlbums:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewStudentGroupName;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *txtStudentGroupHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *txtTeacherGroupHeight;
@property (weak, nonatomic) IBOutlet UITableView *tblStudentGradeDivision;
@property (weak, nonatomic) IBOutlet UITableView *tblStandard;
- (IBAction)btnRemoveClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewStandard;
- (IBAction)btnCancClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewGroupType;
@property (weak, nonatomic) IBOutlet UITableView *tblGroupType;
@property (weak, nonatomic) IBOutlet UILabel *lbStudentMember;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lbStudentHeight;
@property (weak, nonatomic) IBOutlet UILabel *lbTeacherMemebr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lbTeacherHeight;
@property (weak, nonatomic) IBOutlet UITextField *txtSearchStudenrMember;

@property (weak, nonatomic) IBOutlet UIButton *btnMemberCkeckBoxAttachment;
@property (weak, nonatomic) IBOutlet UITableView *tblGetGroupNameList;
- (IBAction)btnMemberCkeckBoxAttachment:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewStudentNameList;
@property (weak, nonatomic) IBOutlet UITableView *tblStudentList;
- (IBAction)btnDoneClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCancelClicked;

@property (weak, nonatomic) IBOutlet UIButton *btnMemberCkeckBoxPolls;
- (IBAction)btnMemberCkeckBoxPolls:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSelectEducationGroup;
- (IBAction)btnSelectEducationGroup:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSelectGroupMemberStudent;
- (IBAction)btnSelectGroupMemberStudent:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSelectGroupMemberTecher;
- (IBAction)btnSelectGroupMemberTecher:(id)sender;

@property(strong,nonatomic)NSMutableDictionary *dicCreateSchoolGroup;
@end
