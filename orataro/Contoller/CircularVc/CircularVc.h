//
//  CircularVc.h
//  orataro
//
//  Created by MAC008 on 20/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularVc : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *lblCircularHeaderTitle;

@property (weak, nonatomic) IBOutlet UIView *aView1;
- (IBAction)MenuBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *AddBtn;
- (IBAction)AddBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *CircularDetailBtnClicked;
- (IBAction)CircularBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *CircularTableView;

//popup AddPage
@property (strong, nonatomic) IBOutlet UIView *viewAddPage;

//popup Delete Conf
@property (weak, nonatomic) IBOutlet UIView *viewDelete_Conf;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteConf_Cancel;
- (IBAction)btnDeleteConf_Cancel:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblDeleteConf_Detail;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteConf_Yes;
- (IBAction)btnDeleteConf_Yes:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewSave;
@property (weak, nonatomic) IBOutlet UIView *viewInnerSave;
@property (weak, nonatomic) IBOutlet UIImageView *imgCancel;
@end
