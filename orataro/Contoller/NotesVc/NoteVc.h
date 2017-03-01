//
//  NoteVc.h
//  orataro
//
//  Created by MAC008 on 21/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteVc : UIViewController
@property (weak, nonatomic) IBOutlet UIView *aCalenderView;
@property (weak, nonatomic) IBOutlet UIView *aView1;
- (IBAction)MenuBtnClicked:(id)sender;
- (IBAction)CellBtnClicked:(UIButton *)sender;
- (IBAction)CreateNoteBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblNote;

@end
