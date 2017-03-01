//
//  SubjectVc.h
//  orataro
//
//  Created by Softqube Mac IOS on 31/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubjectVc : UIViewController

- (IBAction)BackBtn1Clicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *BackBtnClicked;
@property(strong,nonatomic)NSString *passVal;
@end
