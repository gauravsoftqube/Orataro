//
//  CircularDetailVc.h
//  orataro
//
//  Created by Softqube Mac IOS on 31/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularDetailVc : UIViewController
@property (strong, nonatomic) NSMutableDictionary *dicSelect_Circular;


- (IBAction)BackbtnClicked:(id)sender;

- (IBAction)BackBtnClicked:(id)sender;
- (IBAction)BackClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *BackBtn1Clicked;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDetail;
@property (weak, nonatomic) IBOutlet UIImageView *imgCircular;

@property (weak, nonatomic) IBOutlet UIView *viewUserBorder;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;



@end
