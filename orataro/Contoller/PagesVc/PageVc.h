//
//  PageVc.h
//  orataro
//
//  Created by MAC008 on 16/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageVc : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *aPageTableview;
- (IBAction)BAckBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *viewSearch;
- (IBAction)btnSearchClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtSearch;
@property (weak, nonatomic) IBOutlet UILabel *lbHeaderTitle;

@end
