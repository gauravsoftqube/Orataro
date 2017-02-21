//
//  MessageVc.h
//  orataro
//
//  Created by MAC008 on 16/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageVc : UIViewController<UIWebViewDelegate>

- (IBAction)steprChanged:(UIStepper *)sender;
@property (weak, nonatomic) IBOutlet UIWebView *aWebview;
@property (weak, nonatomic) IBOutlet UIStepper *Steper;
- (IBAction)MenuBtnClicked:(id)sender;

@end
