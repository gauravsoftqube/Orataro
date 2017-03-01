//
//  ProjectVc.h
//  orataro
//
//  Created by Softqube on 13/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ORGDetailViewController;

@interface ProjectVc : UIViewController

@property (strong, nonatomic) ORGDetailViewController *detailViewController;
@property (weak, nonatomic) IBOutlet UIView *AddBtn;

@property (strong, nonatomic) NSArray *sampleData;

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnBack:(id)sender;
- (IBAction)addBtnClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tblProjectList;



@end
