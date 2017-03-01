//
//  CreateProjectVc.h
//  orataro
//
//  Created by Softqube on 13/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateProjectVc : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *aHeaderTitleLb;

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


@end
