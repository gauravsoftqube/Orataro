//
//  CalenderEventDetailVc.h
//  orataro
//
//  Created by Softqube on 22/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalenderEventDetailVc : UIViewController

@property (strong, nonatomic) NSMutableDictionary *dicSelectedEventdDetail;

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnBack:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UITextView *txtViewDetailEvent;

@end
