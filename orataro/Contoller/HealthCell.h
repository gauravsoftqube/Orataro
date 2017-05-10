//
//  HealthCell.h
//  orataro
//
//  Created by MAC008 on 04/05/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *txtDetail;
@property (weak, nonatomic) IBOutlet UILabel *lbDetails;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *txtDetailHeightConstant;

@end
