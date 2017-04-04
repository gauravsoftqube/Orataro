//
//  NoteDecsVc.h
//  orataro
//
//  Created by MAC008 on 22/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteDecsVc : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblUserName;

- (IBAction)BackBtnClicked:(UIButton *)sender;

@property (strong, nonatomic) NSMutableDictionary *dicSelectNotes;

@property (weak, nonatomic) IBOutlet UIImageView *imgUser;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblDressCode;
@property (weak, nonatomic) IBOutlet UILabel *lblStartDate;
@property (weak, nonatomic) IBOutlet UILabel *lblEndDate;
@property (weak, nonatomic) IBOutlet UIView *viewUserImgBorder;

@end
