//
//  ClassworkVC.h
//  orataro
//
//  Created by MAC008 on 21/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassworkVC : UIViewController
@property (weak, nonatomic) IBOutlet UIView *aCalenderView;
- (IBAction)MenuBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *aView1;
@property (weak, nonatomic) IBOutlet UITableView *tblClassworkList;
- (IBAction)btnAddClicked:(id)sender;

@end
