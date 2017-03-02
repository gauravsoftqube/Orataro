//
//  WallVc.h
//  orataro
//
//  Created by harikrishna patel on 27/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface WallVc : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)MenuBtnClicked:(id)sender;
- (IBAction)WhatsyourmindBtnClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *aTableHeaderView;

@property (weak, nonatomic) IBOutlet UITableView *aWallTableView;
- (IBAction)HomeBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *HomeBtn;
@property (weak, nonatomic) IBOutlet UIButton *DisplayPopupView;
@property(strong,nonatomic)NSString *checkscreen;
@property (weak, nonatomic) IBOutlet UIButton *MenuBtn;

@end
