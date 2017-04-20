//
//  AttendanceVC.h
//  orataro
//
//  Created by Softqube Mac IOS on 06/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttendanceVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
- (IBAction)btnSaveClicked:(id)sender;
- (IBAction)btnGenerateReportClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblHeaderTitle;
- (IBAction)ClassBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbSubDivision;
@property (weak, nonatomic) IBOutlet UITableView *AttendanceTableView;
@property (weak, nonatomic) IBOutlet UITextField *aTextfield3;
- (IBAction)DateSelectClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *aTextField2;
@property (weak, nonatomic) IBOutlet UILabel *lbDate;
@property (weak, nonatomic) IBOutlet UITableView *aClasstableView;
@property (weak, nonatomic) IBOutlet UIView *aClassMAinView;
- (IBAction)MenuBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *NormalBtn;
@property (weak, nonatomic) IBOutlet UITextField *aTextfield1;
- (IBAction)NormalBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *DateBtnClicked;
- (IBAction)isWorkingClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *workBtn;

@end
