//
//  profileSearchFriend.h
//  orataro
//
//  Created by MAC008 on 27/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface profileSearchFriend : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *aSerchview;
@property (weak, nonatomic) IBOutlet UITableView *aTableView;
- (IBAction)BackBtnClicked:(UIButton *)sender;

@end
