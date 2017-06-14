//
//  NoteVc.h
//  orataro
//
//  Created by MAC008 on 21/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteVc : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *aCalenderView;
@property (weak, nonatomic) IBOutlet UIView *aView1;
- (IBAction)MenuBtnClicked:(id)sender;
- (IBAction)CellBtnClicked:(UIButton *)sender;
- (IBAction)CreateNoteBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblNote;
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
