//
//  AddpostVc.h
//  orataro
//
//  Created by Softqube Mac IOS on 30/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddpostVc : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aView1Width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aView2Width;
@property (weak, nonatomic) IBOutlet UIImageView *PostImageView;
- (IBAction)BackBtnClicked:(UIButton*)sender;
- (IBAction)SaveBtnClicked:(UIButton *)sender;
- (IBAction)AddPhotoBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aView3Width;

@end
