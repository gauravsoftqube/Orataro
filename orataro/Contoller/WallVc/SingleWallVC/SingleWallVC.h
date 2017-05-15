//
//  SingleWallVC.h
//  orataro
//
//  Created by Softqube on 11/05/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleWallVC : UIViewController

@property (strong, nonatomic) NSMutableDictionary *dicSelectedPost_Comment;
@property(strong,nonatomic)NSString *checkscreen;
@property(strong,nonatomic)NSMutableDictionary *dicSelect_std_divi_sub;
@property(strong,nonatomic)NSMutableArray *arrDynamicWall_Setting;
//Like unLike Comment Share


//Header
- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderTitle;

@property (weak, nonatomic) IBOutlet UITableView *tblPostAndCommentList;

//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewCommentPost_Bottom;
@property (weak, nonatomic) IBOutlet UILabel *lblNOComment;

//Like
@property (weak, nonatomic) IBOutlet UIImageView *imgLike;
@property (weak, nonatomic) IBOutlet UILabel *lblLike;
@property (weak, nonatomic) IBOutlet UIButton *btnLike;
- (IBAction)btnLike:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewLike;

//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewLike_Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgLike_Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewLike_Width;//99.67
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgLike_Width;//14


//UnLike
@property (weak, nonatomic) IBOutlet UIImageView *imgUnlike;
@property (weak, nonatomic) IBOutlet UILabel *lblUnlike;
@property (weak, nonatomic) IBOutlet UIButton *btnUnlike;
- (IBAction)btnUnlike:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewDisLike;

//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewDisLike_Width;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgDisLike_Width;

//Comment
@property (weak, nonatomic) IBOutlet UIImageView *imgComment;
@property (weak, nonatomic) IBOutlet UILabel *lblComment;
@property (weak, nonatomic) IBOutlet UIButton *btnComment;
- (IBAction)btnComment:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewComment;

//

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgComment_Width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewComment_Width;


//Share
@property (weak, nonatomic) IBOutlet UIImageView *imgShare;
@property (weak, nonatomic) IBOutlet UILabel *lblShare;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
- (IBAction)btnShare:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewShare;

//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgShare_Width; 
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewShare_Width;

//share
@property (strong, nonatomic) IBOutlet UIView *viewShare_popup;

@property (weak, nonatomic) IBOutlet UIButton *btnPublic;
- (IBAction)btnPublic:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnOnlyMe;
- (IBAction)btnOnlyMe:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnFriend;
- (IBAction)btnFriend:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSpecialFriend;
- (IBAction)btnSpecialFriend:(id)sender;


//view SpecialFriends Pop up
@property (weak, nonatomic) IBOutlet UIView *viewSpecialFriends_Popup;
@property (weak, nonatomic) IBOutlet UIButton *btnBack_SpecialFriends;
- (IBAction)btnBack_SpecialFriends:(id)sender;
- (IBAction)btnDone_SpecialFriends:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewSearch_SpecialFriends;
@property (weak, nonatomic) IBOutlet UITextField *txtSearch_SpecialFriends;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckAll_SpecialFriends;
- (IBAction)btnCheckAll_SpecialFriends:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblSpecialFriendsList;


@end
