//
//  AddPollVc.h
//  orataro
//
//  Created by MAC008 on 07/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPollVc : UIViewController
@property (weak, nonatomic) IBOutlet UIView *aAddOptionView;
@property (weak, nonatomic) IBOutlet UILabel *lbHeaderText;
@property(strong,nonatomic)NSString *strPoll;
- (IBAction)BackBtnClicked:(UIButton *)sender;

@end
