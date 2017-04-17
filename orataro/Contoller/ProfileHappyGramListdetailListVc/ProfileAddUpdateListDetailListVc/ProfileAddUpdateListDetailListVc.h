//
//  ProfileAddUpdateListDetailListVc.h
//  orataro
//
//  Created by Softqube on 27/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileAddUpdateListDetailListVc : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) NSString *strVctoNavigate;
@property (weak, nonatomic) IBOutlet UIView *viewEmogination;
@property (weak, nonatomic) IBOutlet UICollectionView *collEmogination;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collViewHeight;

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
- (IBAction)btnSubmit:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbNavigationTitle;

@property (weak, nonatomic) IBOutlet UITableView *tblAddUpdateList;

@property (weak, nonatomic) IBOutlet UIView *viewUpdate;

@property (weak, nonatomic) IBOutlet UITextField *txtUpdateAppreciation;
@property (weak, nonatomic) IBOutlet UITextView *txtViewNote;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdateSmileadd;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdateSmileRemove;
@property (strong,nonatomic) NSMutableDictionary *dicHappygramDetails;
@end
