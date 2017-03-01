//
//  SettingVcViewController.h
//  orataro
//
//  Created by MAC008 on 13/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingVcViewController : UIViewController
- (IBAction)MenuBtnClicked:(id)sender;
- (IBAction)aSoundCheckClicked:(UIButton *)sender;
- (IBAction)aVibrateClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *aViratBtn;
@property (weak, nonatomic) IBOutlet UIButton *aSoundBtn;

@end
