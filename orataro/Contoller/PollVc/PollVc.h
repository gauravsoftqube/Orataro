//
//  PollVc.h
//  orataro
//
//  Created by MAC008 on 08/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PollVc : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)	id				currentPopTipViewTarget;

- (IBAction)aFirstBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *aFirstImage;
@property (weak, nonatomic) IBOutlet UIView *aBottomView1;
@property (weak, nonatomic) IBOutlet UIImageView *aSecondImage;
@property (weak, nonatomic) IBOutlet UIView *aBottomView2;
@property (weak, nonatomic) IBOutlet UILabel *lbNopoll;
@property (weak, nonatomic) IBOutlet UIView *viewAdd;
- (IBAction)aSeconBtnClicked:(id)sender;
- (IBAction)MenuBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblPoll;
- (IBAction)btnAddClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnadd;
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderTitle;

//popup AddPage
@property (strong, nonatomic) IBOutlet UIView *viewAddPage;
@property (weak, nonatomic) IBOutlet UIButton *btnResult_AddPage_popup;
- (IBAction)btnResult_AddPage_popup:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete_AddPage_popup;
- (IBAction)btnDelete_AddPage_popup:(id)sender;

//popup Participaint
@property (strong, nonatomic) IBOutlet UIView *viewParticipaint_Popup;
@property (weak, nonatomic) IBOutlet UIButton *btnVote_Participaint_popup;
- (IBAction)btnVote_Participaint_popup:(id)sender;

//vote popup view
@property (weak, nonatomic) IBOutlet UIView *viewVote_Popup;
- (IBAction)btnVote_Cancel:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblVote_TItle;
@property (weak, nonatomic) IBOutlet UITableView *tblVoteList;
@property (weak, nonatomic) IBOutlet UIButton *btnVote_Ok;
- (IBAction)btnVote_Ok:(id)sender;

@end
