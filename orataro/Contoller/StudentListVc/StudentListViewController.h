//
//  StudentListViewController.h
//  orataro
//
//  Created by Softqube Mac IOS on 06/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableDictionary *dicSelectedList;
@property (weak, nonatomic) IBOutlet UIButton *btnHome;
- (IBAction)btnHome:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
- (IBAction)btnMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderTitle;

@property (weak, nonatomic) IBOutlet UITableView *aStudentTable;
- (IBAction)BackBtnClicked:(id)sender;
- (IBAction)BackClicked:(id)sender;

@end
