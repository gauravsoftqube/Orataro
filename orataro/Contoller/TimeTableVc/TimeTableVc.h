//
//  TimeTableVc.h
//  orataro
//
//  Created by Softqube Mac IOS on 06/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeTableVc : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *PreBtn;
- (IBAction)PreBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *NextBtn;
- (IBAction)NextBtnClicked:(id)sender;
- (IBAction)MenuBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *PreImageView;
@property (weak, nonatomic) IBOutlet UIImageView *NextimageView;
@property (strong, nonatomic) IBOutlet UIView *aTableHeaderView;
@property (weak, nonatomic) IBOutlet UITableView *aTableView;

@property (weak, nonatomic) IBOutlet UILabel *lblHeaderTitle;

@property (weak, nonatomic) IBOutlet UIButton *btnNext;
- (IBAction)btnNext:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnPre;
- (IBAction)btnPre:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblDayName;

@end
