//
//  AddNoteVc.h
//  orataro
//
//  Created by Softqube Mac IOS on 06/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNoteVc : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
- (IBAction)BackBtnClicked:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aViewHeight;
@property (weak, nonatomic) IBOutlet UITextField *aTitleTextfield;
@property (weak, nonatomic) IBOutlet UIScrollView *aScrollview;
@property (weak, nonatomic) IBOutlet UITextView *aDescTextview;

@property (weak, nonatomic) IBOutlet UITextField *aStandardTextfield;
@property (weak, nonatomic) IBOutlet UIButton *btnStandardDevision;
- (IBAction)btnStandardDevision:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *aShortDescTextfield;
@property (weak, nonatomic) IBOutlet UIButton *btnShortDescText;
- (IBAction)btnShortDescText:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *aStartdateTextfield;
@property (weak, nonatomic) IBOutlet UIButton *btnStartDate;
- (IBAction)btnStartDate:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *aEnddateTextfield;
@property (weak, nonatomic) IBOutlet UIButton *btnEndDate;
- (IBAction)btnEndDate:(id)sender;


- (IBAction)SelectPhotoBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *aPhoto;

//Standard and Division Po - pup
@property (weak, nonatomic) IBOutlet UIView *viewStandardANdDevision_popup;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel_StdandDiv;
@property (weak, nonatomic) IBOutlet UIButton *btnDone_StdandDiv;

- (IBAction)btnCancel_StdandDiv:(id)sender;
- (IBAction)btnDone_StdandDiv:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tblStd_Div;

//view Short Desc

@property (weak, nonatomic) IBOutlet UIView *viewShortDesc_Popup;
@property (weak, nonatomic) IBOutlet UITableView *tblShortDesc_popup;


@end
