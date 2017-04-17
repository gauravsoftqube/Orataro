//
//  ResultAddPageVc.h
//  orataro
//
//  Created by Softqube on 14/04/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultAddPageVc : UIViewController

@property (strong, nonatomic) NSString *strSelectPollID;


//Header
- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
- (IBAction)btnMenu:(id)sender;


//
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDetail;

@property (weak, nonatomic) IBOutlet UITableView *tblOptionAnsList;

//view Menu
@property (weak, nonatomic) IBOutlet UIView *viewMemu;
@property (weak, nonatomic) IBOutlet UIButton *btnMenu_Cancel;
- (IBAction)btnMenu_Cancel:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewMenuBorder;

@property (weak, nonatomic) IBOutlet UIButton *btnShare;
- (IBAction)btnShare:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewShare;

@end
