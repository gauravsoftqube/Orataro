//
//  MyProfileVc.h
//  orataro
//
//  Created by MAC008 on 15/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyProfileVc : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *aProfileTable;
@property (strong, nonatomic) IBOutlet UIView *aHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *aProfileNameLb;
@property (weak, nonatomic) IBOutlet UIImageView *aProfileimageview;
- (IBAction)MenuBtnClicked:(id)sender;

@end
