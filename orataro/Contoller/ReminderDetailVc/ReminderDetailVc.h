//
//  ReminderDetailVc.h
//  orataro
//
//  Created by Softqube on 19/04/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReminderDetailVc : UIViewController

@property (strong, nonatomic) NSMutableDictionary *dicSelected;


@property (weak, nonatomic) IBOutlet UILabel *lbltitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblType;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblStartDate;
@property (weak, nonatomic) IBOutlet UILabel *lblEndDate;


- (IBAction)btnBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@end
