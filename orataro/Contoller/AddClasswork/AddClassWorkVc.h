//
//  AddClassWorkVc.h
//  orataro
//
//  Created by Softqube Mac IOS on 31/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddClassWorkVc : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

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

@end
