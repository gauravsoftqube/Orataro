//
//  ProfileVideoDetailVc.h
//  orataro
//
//  Created by Softqube on 23/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <AVKit/AVKit.h>
//#import <AVFoundation/AVFoundation.h>

@import AVFoundation;
@import AVKit;


@interface ProfileVideoDetailVc : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lbHeaderTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnBackHeader;
- (IBAction)btnBackHeader:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnMenuHeader;
- (IBAction)btnMenuHeader:(id)sender;

//popup
@property (weak, nonatomic) IBOutlet UIButton *btnPopuBack;
- (IBAction)btnPopuBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewPopup;

@property (weak, nonatomic) IBOutlet UIView *viewPopupBorder;


@property (weak, nonatomic) IBOutlet UIButton *btnSaveMenu;
- (IBAction)btnSaveMenu:(id)sender;

@property(strong,nonatomic)NSMutableDictionary *dicVideo;
@end
