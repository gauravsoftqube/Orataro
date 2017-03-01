//
//  PageVc.h
//  orataro
//
//  Created by MAC008 on 16/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageVc : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *aPageTableview;
- (IBAction)BAckBtnClicked:(UIButton *)sender;

@end
