//
//  WallVc.h
//  orataro
//
//  Created by harikrishna patel on 27/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WallVc : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)MenuBtnClicked:(id)sender;
- (IBAction)WhatsyourmindBtnClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *aTableHeaderView;

@property (weak, nonatomic) IBOutlet UITableView *aWallTableView;

@end
