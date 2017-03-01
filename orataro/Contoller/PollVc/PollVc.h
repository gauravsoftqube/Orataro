//
//  PollVc.h
//  orataro
//
//  Created by MAC008 on 08/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PollVc : UIViewController<UITableViewDelegate,UITableViewDataSource>

- (IBAction)aFirstBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *aFirstImage;
@property (weak, nonatomic) IBOutlet UIView *aBottomView1;
@property (weak, nonatomic) IBOutlet UIImageView *aSecondImage;
@property (weak, nonatomic) IBOutlet UIView *aBottomView2;
@property (weak, nonatomic) IBOutlet UILabel *lbNopoll;
@property (weak, nonatomic) IBOutlet UIView *viewAdd;
- (IBAction)aSeconBtnClicked:(id)sender;
- (IBAction)MenuBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblPoll;
- (IBAction)btnAddClicked:(UIButton *)sender;

@end
