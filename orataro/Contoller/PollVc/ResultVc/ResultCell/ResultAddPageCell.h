//
//  ResultAddPageCell.h
//  orataro
//
//  Created by Softqube on 14/04/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"

@interface ResultAddPageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet FBProgressView *viewProgress;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPerVote;

@end
