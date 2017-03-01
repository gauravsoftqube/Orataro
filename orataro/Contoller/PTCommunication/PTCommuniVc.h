//
//  PTCommuniVc.h
//  orataro
//
//  Created by Softqube Mac IOS on 06/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTCommuniVc : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *aPopupMainView;
- (IBAction)CloseBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *aAddBtnouterView;
@property (weak, nonatomic) IBOutlet UIView *aSaveOuterView;
@property (weak, nonatomic) IBOutlet UITextField *aTextField;
@property (weak, nonatomic) IBOutlet UIView *aSaveInnerView;
@property (weak, nonatomic) IBOutlet UIImageView *ACloseImageView;

@property (weak, nonatomic) IBOutlet UILabel *noPtCommunLb;
- (IBAction)AddBtnClicked:(id)sender;
- (IBAction)BackBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *aTableView;
@property (weak, nonatomic) IBOutlet UITextField *aSearchTextField;
@end
