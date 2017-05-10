//
//  ProfilePhoneChainVc.h
//  orataro
//
//  Created by MAC008 on 02/05/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfilePhoneChainVc : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgCancel;
@property (weak, nonatomic) IBOutlet UIView *viewSelect;
@property (weak, nonatomic) IBOutlet UITableView *tblPhoneList;
@property (weak, nonatomic) IBOutlet UIView *viewCreatePhoneContact;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tblSelectTypeHeight;
@property (weak, nonatomic) IBOutlet UIView *viewAdd;
@property (weak, nonatomic) IBOutlet UIView *viewSelectOuterLayer;
@property (weak, nonatomic) IBOutlet UIView *viewTypeOuterLayer;
@property (weak, nonatomic) IBOutlet UILabel *lbNoContact;
@property (weak, nonatomic) IBOutlet UITableView *tblPriority;
@property (weak, nonatomic) IBOutlet UILabel *lbCreatePopupHeaderTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgDeletePopupCancel;
@property (weak, nonatomic) IBOutlet UIView *viewDelete;
@property (weak, nonatomic) IBOutlet UIView *viewDeleteOuter;
@property (weak, nonatomic) IBOutlet UIImageView *imgDeleteView;
- (IBAction)btnDeletePopupCancelClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewDeleteInner;
- (IBAction)btnDeletePopupClicked:(id)sender;
- (IBAction)btnBackClicked:(id)sender;

- (IBAction)btnPriorityClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgEditImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tblPriorityHeight;
@property (weak, nonatomic) IBOutlet UILabel *lbPriority;
- (IBAction)btnAddPhoneListClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbSelectType;
@property (weak, nonatomic) IBOutlet UITableView *tblSelectType;
- (IBAction)btnSelectTypeClicked:(id)sender;
- (IBAction)btnCancelClicked:(id)sender;
- (IBAction)btnAddClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewname;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UIView *viewRelation;
@property (weak, nonatomic) IBOutlet UITextField *txtRelation;
@property (weak, nonatomic) IBOutlet UIView *viewPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtPhoneNumber;
@property (weak, nonatomic) IBOutlet UIView *viewInnerAdd;
@property (weak, nonatomic) IBOutlet UIView *viewOuterAdd;

@end
