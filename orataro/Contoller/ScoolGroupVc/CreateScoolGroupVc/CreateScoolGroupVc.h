//
//  CreateScoolGroupVc.h
//  orataro
//
//  Created by Softqube on 22/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateScoolGroupVc : UIViewController

@property (weak, nonatomic) NSString *strEditOrCreate;
//Header
@property (weak, nonatomic) IBOutlet UIButton *btnBackHeader;
- (IBAction)btnBackHeader:(id)sender;

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

@property (weak, nonatomic) IBOutlet UIButton *btnMemberCkeckBoxMember;
- (IBAction)btnMemberCkeckBoxMember:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnMemberCkeckBoxPost;
- (IBAction)btnMemberCkeckBoxPost:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnMemberCkeckBoxAlbums;
- (IBAction)btnMemberCkeckBoxAlbums:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnMemberCkeckBoxAttachment;
- (IBAction)btnMemberCkeckBoxAttachment:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnMemberCkeckBoxPolls;
- (IBAction)btnMemberCkeckBoxPolls:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSelectEducationGroup;
- (IBAction)btnSelectEducationGroup:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSelectGroupMemberStudent;
- (IBAction)btnSelectGroupMemberStudent:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSelectGroupMemberTecher;
- (IBAction)btnSelectGroupMemberTecher:(id)sender;


@end
