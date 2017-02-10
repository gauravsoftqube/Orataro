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
@property (weak, nonatomic) IBOutlet UITextField *aStartdateTextfield;
@property (weak, nonatomic) IBOutlet UITextField *aEnddateTextfield;
@property (weak, nonatomic) IBOutlet UITextField *aShortDescTextfield;
- (IBAction)SelectPhotoBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *aPhoto;

@end
