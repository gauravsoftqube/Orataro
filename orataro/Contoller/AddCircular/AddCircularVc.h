//
//  AddCircularVc.h
//  orataro
//
//  Created by Softqube Mac IOS on 30/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAMTextView.h"

@interface AddCircularVc : UIViewController<UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIButton *PhotoBtn;
- (IBAction)addPhotoBtnClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *aScrollview;
@property (weak, nonatomic) IBOutlet UITextField *endDateTextfield;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aViewHeight;
- (IBAction)BackBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *aDescTextView;
@property (weak, nonatomic) IBOutlet UITextField *standardTextfield;
@property (weak, nonatomic) IBOutlet UILabel *aDescLb;
@property (weak, nonatomic) IBOutlet UITextField *aTitleTextfield;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aViewwidth;
@property (weak, nonatomic) IBOutlet UITextField *selectTypeTextfield;

@end
