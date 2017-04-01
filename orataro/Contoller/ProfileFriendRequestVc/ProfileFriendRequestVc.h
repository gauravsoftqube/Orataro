//
//  ProfileFriendRequestVc.h
//  orataro
//
//  Created by Softqube on 24/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileFriendRequestVc : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblFriendList;
@property (weak, nonatomic) IBOutlet UIView *viewSearch;
- (IBAction)btnSearchClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtSearchText;

@end
