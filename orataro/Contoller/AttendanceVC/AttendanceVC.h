//
//  AttendanceVC.h
//  orataro
//
//  Created by Softqube Mac IOS on 06/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttendanceVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

- (IBAction)ClassBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *AttendanceTableView;
@property (weak, nonatomic) IBOutlet UITableView *aClasstableView;
@property (weak, nonatomic) IBOutlet UIView *aClassMAinView;

@end
