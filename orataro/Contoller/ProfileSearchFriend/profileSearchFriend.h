//
//  profileSearchFriend.h
//  orataro
//
//  Created by MAC008 on 27/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface profileSearchFriend : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *aSerchview;
@property (weak, nonatomic) IBOutlet UITableView *aTableView;
- (IBAction)BackBtnClicked:(UIButton *)sender;
- (IBAction)btnSearchClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtSearchTextfield;

@end
