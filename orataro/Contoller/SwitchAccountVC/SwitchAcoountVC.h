//
//  SwitchAcoountVC.h
//  orataro
//
//  Created by MAC008 on 07/03/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchAcoountVC : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tblSwitchAccount;
- (IBAction)HomeBtnClicked:(id)sender;
- (IBAction)btnMenuClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewForNotSelection;
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnHome;

@end
