//
//  PollVc.h
//  orataro
//
//  Created by MAC008 on 08/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PollVc : UIViewController
- (IBAction)aFirstBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *aFirstImage;
@property (weak, nonatomic) IBOutlet UIView *aBottomView1;
@property (weak, nonatomic) IBOutlet UIImageView *aSecondImage;
@property (weak, nonatomic) IBOutlet UIView *aBottomView2;
- (IBAction)aSeconBtnClicked:(id)sender;

@end
