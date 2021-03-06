//
//  ClassworkVC.h
//  orataro
//
//  Created by MAC008 on 21/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassworkVC : UIViewController
@property (weak, nonatomic) IBOutlet UIView *aCalenderView;
- (IBAction)MenuBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *aView1;
@property (weak, nonatomic) IBOutlet UITableView *tblClassworkList;
- (IBAction)btnAddClicked:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *lblHeaderTitle;

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
