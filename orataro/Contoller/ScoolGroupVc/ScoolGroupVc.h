//
//  ScoolGroupVc.h
//  orataro
//
//  Created by Softqube on 22/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoolGroupVc : UIViewController
@property (strong, nonatomic) IBOutlet UIView *viewDeletePopup;
@property (weak, nonatomic) IBOutlet UIView *imgCancelicon;
- (IBAction)btnSaveClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgCancel;
- (IBAction)btnSave1Clicked:(id)sender;

- (IBAction)btnCancelClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnBackHeader;
- (IBAction)btnBackHeader:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewSave;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIView *viewInnerSave;

@property (weak, nonatomic) IBOutlet UITableView *tblScoolGroupList;
@property (weak, nonatomic) IBOutlet UIImageView *DeleteImageview;

@property (weak, nonatomic) IBOutlet UIButton *btnCreateGroup;
- (IBAction)btnCreateGroup:(id)sender;
- (IBAction)AddBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *DeleteBtn;
@property (weak, nonatomic) IBOutlet UIView *AddBtn;

@end
