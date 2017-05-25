//
//  FriendVc.h
//  orataro
//
//  Created by MAC008 on 17/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendVc : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

- (IBAction)BackBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbNoFriendList;
- (IBAction)TxtValueChanged:(UITextField *)sender;
- (IBAction)FriendRequestBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *aFirstBtn;
@property (weak, nonatomic) IBOutlet UIButton *aSecondBtn;
@property (weak, nonatomic) IBOutlet UIView *viewSearch;
- (IBAction)btnSearchClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtSearchFriend;
- (IBAction)txtValueChange:(id)sender;

- (IBAction)AddFrinedBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *aPopupView;
@property (weak, nonatomic) IBOutlet UILabel *aNoFriendLabel;
@property (weak, nonatomic) IBOutlet UITableView *friendTableView;
@property (weak, nonatomic) IBOutlet UIImageView *aPopupAddFriendImg;
@property (weak, nonatomic) IBOutlet UIImageView *aPopupFriendRequestImg;
- (IBAction)AddFriendBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *aAddFriendView;
@property (weak, nonatomic) IBOutlet UIView *aFriendRequestView;

@end
