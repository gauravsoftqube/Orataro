//
//  AboutUsVc.h
//  orataro
//
//  Created by MAC008 on 10/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUsVc : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *aTextview;
@property (strong, nonatomic) IBOutlet UIView *aTableHeaderView;
@property (weak, nonatomic) IBOutlet UITableView *aTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aTextviewHeight;
@property (weak, nonatomic) IBOutlet UIView *aVideoView;
- (IBAction)BackBtnClicked:(id)sender;

@end
