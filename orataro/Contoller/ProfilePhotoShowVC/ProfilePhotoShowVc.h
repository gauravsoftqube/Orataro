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
@property (weak, nonatomic) IBOutlet UILabel *lbHeaderTitle;
- (IBAction)SaveBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *aOuterView;
@property (weak, nonatomic) IBOutlet UIView *aInnerView;
- (IBAction)OnSaveClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (strong,nonatomic)NSString *imagename;
@property(strong,nonatomic)NSString *strOfflineOnline;
@end
