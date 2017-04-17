//
//  HomeWrokVc.h
//  orataro
//
//  Created by MAC008 on 21/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeWrokVc : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderTitle;

- (IBAction)MenuBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *aView1;
@property (weak, nonatomic) IBOutlet UIView *aCalenderView;
@property (weak, nonatomic) IBOutlet UIButton *CellClicked;
@property (weak, nonatomic) IBOutlet UIButton *AddBtnClicked;
- (IBAction)CellBtnClicked:(id)sender;
- (IBAction)AddBtn1Clicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *HomeworkTableView;

//popup AddPage
@property (strong, nonatomic) IBOutlet UIView *viewAddPage;

@end
