//
//  ListSelectionVc.h
//  orataro
//
//  Created by Softqube Mac IOS on 31/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListSelectionVc : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *aListTableView;
- (IBAction)BackBtnClicked:(id)sender;
- (IBAction)MenuBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *HomeBtn;
- (IBAction)HomeBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *NavigationTitle;
@property (weak, nonatomic) IBOutlet UIButton *aMenuBtn;

@end
