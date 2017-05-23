//
//  WallVc.h
//  orataro
//
//  Created by harikrishna patel on 27/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"

@interface WallVc : UIViewController<UITableViewDelegate,UITableViewDataSource>

- (IBAction)MenuBtnClicked:(id)sender;

- (IBAction)HomeBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *HomeBtn;

@property(strong,nonatomic)NSString *checkscreen;
@property(strong,nonatomic)NSMutableDictionary *dicSelect_std_divi_sub;

@property (weak, nonatomic) IBOutlet UILabel *lblNoWallDataAvailable;
@property (weak, nonatomic) IBOutlet UIButton *MenuBtn;
@property (weak, nonatomic) IBOutlet UILabel *lblheaderTitle;

@property (weak, nonatomic) IBOutlet UITableView *aWallTableView;
@property (weak, nonatomic) IBOutlet UIButton *btnWallMember;
- (IBAction)btnWallMember:(id)sender;

//view Post Edit Delete
@property (strong, nonatomic) IBOutlet UIView *viewEdit_Delete_Post;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit_Post;
- (IBAction)btnEdit_Post:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete_Post;
- (IBAction)btnDelete_Post:(id)sender;



// tbl Header view
@property (strong, nonatomic) IBOutlet UIView *aTableHeaderView;
- (IBAction)WhatsyourmindBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgUser_Tbl_HeaderView;

//viewShare Pop up
@property (strong, nonatomic) IBOutlet UIView *viewshare_Popup;
- (IBAction)btnPublic_SharePopup:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnPublic_SharePopup;
- (IBAction)btnOnlyMe_SharePopup:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnOnlyMe_SharePopup;
- (IBAction)btnFriends_SharePopup:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnFriends_SharePopup;
- (IBAction)btnSpecialFriend_SharePopup:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSpecialFriend_SharePopup;


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


//view Wall Member
@property (weak, nonatomic) IBOutlet UIView *viewWallMember;
@property (weak, nonatomic) IBOutlet UIButton *btnBack_WallMember;
- (IBAction)btnBack_WallMember:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblWallMemberList;
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderTitle_WallMember;

//popup Delete Conf
@property (weak, nonatomic) IBOutlet UIView *viewDelete_Conf;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteConf_Cancel;
- (IBAction)btnDeleteConf_Cancel:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteConf_Yes;
- (IBAction)btnDeleteConf_Yes:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewSave;
@property (weak, nonatomic) IBOutlet UIView *viewInnerSave;
@property (weak, nonatomic) IBOutlet UIImageView *imgCancel;


//viewDynamicWallMenu List
@property (weak, nonatomic) IBOutlet UITableView *viewDynamicWallMenuList;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewDynamicWallMenu_Height;
@property (weak, nonatomic) IBOutlet UIButton *btnHeaderTitle;
- (IBAction)btnHeaderTitle:(id)sender;

@end
