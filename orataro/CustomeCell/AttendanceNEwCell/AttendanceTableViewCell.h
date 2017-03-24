//
//  AttendanceTableViewCell.h
//  orataro
//
//  Created by Softqube Mac IOS on 06/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttendanceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnSecond;

@property (weak, nonatomic) IBOutlet UIButton *btnThird;
@property (weak, nonatomic) IBOutlet UIButton *btnFourth;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property(strong,nonatomic)IBOutlet UIButton *btnFirst;
@end
