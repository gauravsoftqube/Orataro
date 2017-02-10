//
//  ResultVc.h
//  orataro
//
//  Created by MAC008 on 07/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultVc : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *aTableHeaderView;

@property (weak, nonatomic) IBOutlet UITableView *aTableView;

@end
