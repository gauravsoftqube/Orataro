//
//  HealthRecordVc.h
//  orataro
//
//  Created by MAC008 on 04/05/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthRecordVc : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnBackClicked;

@property (weak, nonatomic) IBOutlet UITableView *tblHealthView;

@property (weak, nonatomic) IBOutlet UITextView *txtheigthConstant;
- (IBAction)btnBackClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *txtFifth;
@property (weak, nonatomic) IBOutlet UITextView *txteleven;
- (IBAction)btnSaveClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *txtfirst;
@property (weak, nonatomic) IBOutlet UITextView *txtsecond;
@property (weak, nonatomic) IBOutlet UITextField *txtten;
@property (weak, nonatomic) IBOutlet UITextView *txtthird;
@property (weak, nonatomic) IBOutlet UITextView *txtnine;
@property (weak, nonatomic) IBOutlet UITextField *txtseven;
@property (weak, nonatomic) IBOutlet UITextView *txtforth;
@property (weak, nonatomic) IBOutlet UITextView *txteight;

@property (weak, nonatomic) IBOutlet UITextField *txtsix;

@end
