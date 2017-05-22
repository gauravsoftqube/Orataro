//
//  ChatVc.h
//  orataro
//
//  Created by MAC008 on 22/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatVc : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

- (IBAction)BackBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbHeaderTitle;
@property (weak, nonatomic) IBOutlet UITableView *tblChatMessage;
@property (weak, nonatomic) IBOutlet UITextField *txtMessageText;
- (IBAction)btnSendClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewChatMessage;
@property (strong,nonatomic)NSMutableDictionary *dicChatData;
@end
