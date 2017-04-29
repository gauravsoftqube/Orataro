//
//  BlogVc.h
//  orataro
//
//  Created by MAC008 on 17/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlogVc : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *aBlogTable;
- (IBAction)BackBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewSearch;
- (IBAction)btnSearchClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtSearchTextfield;

@end
