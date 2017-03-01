//
//  ProfilePhotoShowVc.h
//  orataro
//
//  Created by MAC008 on 27/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfilePhotoShowVc : UIViewController
- (IBAction)BackBtnClicked:(UIButton *)sender;
- (IBAction)SaveBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *aOuterView;
@property (weak, nonatomic) IBOutlet UIView *aInnerView;
- (IBAction)OnSaveClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end
