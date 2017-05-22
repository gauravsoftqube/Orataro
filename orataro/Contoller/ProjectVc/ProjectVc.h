//
//  ProjectVc.h
//  orataro
//
//  Created by Softqube on 13/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ORGDetailViewController;

@interface ProjectVc : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lbHeaderTitle;
@property (strong, nonatomic) ORGDetailViewController *detailViewController;
@property (weak, nonatomic) IBOutlet UIView *AddBtn;
@property (weak, nonatomic) IBOutlet UIView *viewDeletePopup;
- (IBAction)btnSaveClicked:(id)sender;
- (IBAction)btnCancelClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIImageView *imgCancel;
@property (weak, nonatomic) IBOutlet UIView *viewSave;
@property (weak, nonatomic) IBOutlet UIView *viewInnerSave;

@property (strong, nonatomic) NSArray *sampleData;

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnBack:(id)sender;
- (IBAction)addBtnClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tblProjectList;



@end
