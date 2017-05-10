//
//  ParentProfileVc.h
//  orataro
//
//  Created by MAC008 on 05/05/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParentProfileVc : UIViewController<UIScrollViewDelegate>

- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnStudentProfileClicked:(id)sender;
- (IBAction)btnFatherProfileClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnFather;
@property (strong, nonatomic) IBOutlet UIView *viewSecond;
@property (strong, nonatomic) IBOutlet UIView *viewThird;
@property (weak, nonatomic) IBOutlet UIScrollView *scrAddFourView;
@property (strong, nonatomic) IBOutlet UIView *viewFirst;
@property (weak, nonatomic) IBOutlet UIButton *btnGurdian;
- (IBAction)btnMotherProfileClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *viewFourth;
@property (weak, nonatomic) IBOutlet UIButton *btnProfile;
- (IBAction)btnGuardianClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewIndicator;
@property (weak, nonatomic) IBOutlet UIButton *btnMother;

@end
