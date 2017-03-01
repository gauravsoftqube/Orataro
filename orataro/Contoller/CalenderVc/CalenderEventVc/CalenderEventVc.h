//
//  CalenderEventVc.h
//  orataro
//
//  Created by Softqube on 22/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalenderEventVc : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tblCalenderEventList;
@property (weak, nonatomic) IBOutlet UIButton *btnHeaderMenu;
- (IBAction)btnHeaderMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)btnHome:(id)sender;

//popup
@property (weak, nonatomic) IBOutlet UIButton *btnPopuBack;
- (IBAction)btnPopuBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewPopup;

@property (weak, nonatomic) IBOutlet UIButton *btnSyncCalender;
- (IBAction)btnSyncCalender:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnActivity;
- (IBAction)btnActivity:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnEvent;
- (IBAction)btnEvent:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnExam;
- (IBAction)btnExam:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnHoliday;
- (IBAction)btnHoliday:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewPopupBorder;


@end
