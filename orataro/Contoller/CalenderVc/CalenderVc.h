//
//  CalenderVc.h
//  orataro
//
//  Created by MAC008 on 07/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalenderVc : UIViewController 
//@property (strong, nonatomic) IBOutlet UIView *calenderView;
- (IBAction)MenuBtnClicked:(id)sender;
//@property (strong, nonatomic) IBOutlet UIView *aNavigationView;

@property (weak, nonatomic) IBOutlet UIButton *btnMonthPre;
- (IBAction)btnMonthPre:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblMonth;
@property (weak, nonatomic) IBOutlet UIButton *btnMonthNext;
- (IBAction)btnMonthNext:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnYearPre;
- (IBAction)btnYearPre:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblYear;
@property (weak, nonatomic) IBOutlet UIButton *btnYearNext;
- (IBAction)btnYearNext:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblEventCount;
@property (weak, nonatomic) IBOutlet UIButton *btnEventDetailLIst;
- (IBAction)btnEventDetailLIst:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderTitle;
@property (weak, nonatomic) IBOutlet UIView *viewEventTotal;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ViewMoreEvent;

@end
