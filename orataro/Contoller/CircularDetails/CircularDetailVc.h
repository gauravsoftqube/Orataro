//
//  CircularDetailVc.h
//  orataro
//
//  Created by Softqube Mac IOS on 31/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularDetailVc : UIViewController
- (IBAction)BackbtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *aDetailTextview;
@property (weak, nonatomic) IBOutlet UIImageView *aImagView;
@property (weak, nonatomic) IBOutlet UILabel *aNameLb;

@end
