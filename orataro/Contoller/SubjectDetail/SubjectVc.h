//
//  SubjectVc.h
//  orataro
//
//  Created by Softqube Mac IOS on 31/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubjectVc : UIViewController

@property (strong, nonatomic) NSMutableDictionary *dicSelect_detail;


- (IBAction)BackBtn1Clicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *BackBtnClicked;
@property(strong,nonatomic)NSString *passVal;

@property (weak, nonatomic) IBOutlet UILabel *lblTitleHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UILabel *lblGradeDivision;
@property (weak, nonatomic) IBOutlet UILabel *lblDetail;

@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UIView *vewUserImage;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UIImageView *imgHomework;

@end
