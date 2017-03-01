//
//  HolidayVc.h
//  orataro
//
//  Created by MAC008 on 07/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HolidayVc : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *aTableView;
@property (strong, nonatomic) IBOutlet UIView *aTableHeaderView;
- (IBAction)MenuBtnClicked:(id)sender;

@end
