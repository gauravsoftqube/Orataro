//
//  ProfileAddUpdateListDetailListVc.h
//  orataro
//
//  Created by Softqube on 27/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileAddUpdateListDetailListVc : UIViewController

@property (weak, nonatomic) NSString *strVctoNavigate;

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
- (IBAction)btnSubmit:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tblAddUpdateList;

@property (weak, nonatomic) IBOutlet UIView *viewUpdate;

@property (weak, nonatomic) IBOutlet UITextField *txtUpdateAppreciation;
@property (weak, nonatomic) IBOutlet UITextView *txtViewNote;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdateSmileadd;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdateSmileRemove;

@end
