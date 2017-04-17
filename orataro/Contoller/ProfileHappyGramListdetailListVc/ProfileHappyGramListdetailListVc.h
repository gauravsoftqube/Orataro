//
//  ProfileHappyGramListdetailListVc.h
//  orataro
//
//  Created by Softqube on 24/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileHappyGramListdetailListVc : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *lblTitleHeader;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnBack:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tblDetailList;
@property (weak, nonatomic) IBOutlet UIButton *btnAddNew;
- (IBAction)btnAddNew:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *addView;
@property(strong,nonatomic)NSMutableDictionary *dicHappyGrameList;
@end
