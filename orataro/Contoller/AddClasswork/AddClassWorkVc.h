//
//  AddClassWorkVc.h
//  orataro
//
//  Created by Softqube Mac IOS on 31/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddClassWorkVc : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) NSMutableDictionary *dicSelectListSelection;
- (IBAction)btnSaveClicked:(id)sender;
- (IBAction)btnStartTimeClicked:(id)sender;
- (IBAction)btnEndTimeClicked:(id)sender;
- (IBAction)btnEndDateClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnStartTime;
@property (weak, nonatomic) IBOutlet UIButton *btnEndTime;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aViewHeight;
@property (weak, nonatomic) IBOutlet UITextView *aDescriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *aTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *aStartTextField;
@property (weak, nonatomic) IBOutlet UITextField *aEnddaTextfield;
@property (weak, nonatomic) IBOutlet UIButton *aSelectBtn;
- (IBAction)BackBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *aEndTextField;
@property (weak, nonatomic) IBOutlet UITextField *aReferenceLinkTextField;
- (IBAction)selectPhotoBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderTitle;

@end
