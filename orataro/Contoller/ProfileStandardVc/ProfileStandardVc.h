//
//  ProfileStandardVc.h
//  orataro
//
//  Created by Softqube on 23/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileStandardVc : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblStatndardList;
@property (weak, nonatomic) IBOutlet UILabel *lbHeaderTitle;

@end
