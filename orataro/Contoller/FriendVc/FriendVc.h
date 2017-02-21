//
//  FriendVc.h
//  orataro
//
//  Created by MAC008 on 17/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendVc : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *aNoFriendLabel;
@property (weak, nonatomic) IBOutlet UITableView *friendTableView;
@property (weak, nonatomic) IBOutlet UIImageView *aPopupAddFriendImg;
@property (weak, nonatomic) IBOutlet UIImageView *aPopupFriendRequestImg;
@property (weak, nonatomic) IBOutlet UIView *aAddFriendView;
@property (weak, nonatomic) IBOutlet UIView *aFriendRequestView;

@end
