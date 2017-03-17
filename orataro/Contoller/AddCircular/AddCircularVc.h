//
//  AddCircularVc.h
//  orataro
//
//  Created by Softqube Mac IOS on 30/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAMTextView.h"

@interface AddCircularVc : UIViewController<UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *txtStandardHeight;

- (IBAction)btnSaveClicked:(id)sender;
- (IBAction)btnEndDateClicked:(id)sender;
- (IBAction)btnStandardClicked:(id)sender;
- (IBAction)btnCircularClicked:(id)sender;
- (IBAction)btnDoneClciked:(id)sender;
- (IBAction)btnCancelClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tblSubject;
@property (weak, nonatomic) IBOutlet UITableView *tblCircularType;
@property (weak, nonatomic) IBOutlet UIView *viewSubjectandDiv;
@property (weak, nonatomic) IBOutlet UIButton *PhotoBtn;

- (IBAction)BackBtnClicked:(id)sender;
- (IBAction)addPhotoBtnClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewCircularType;

@property (weak, nonatomic) IBOutlet UIScrollView *aScrollview;
@property (weak, nonatomic) IBOutlet UITextField *endDateTextfield;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aViewHeight;
- (IBAction)BackBtnClicked1:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *aDescTextView;
@property (weak, nonatomic) IBOutlet UITextField *standardTextfield;
@property (weak, nonatomic) IBOutlet UILabel *aDescLb;
@property (weak, nonatomic) IBOutlet UITextField *aTitleTextfield;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aViewwidth;
@property (weak, nonatomic) IBOutlet UITextField *selectTypeTextfield;

@end
