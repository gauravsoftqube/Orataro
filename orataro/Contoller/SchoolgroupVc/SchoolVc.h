//
//  SchoolVc.h
//  orataro
//
//  Created by MAC008 on 28/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchoolVc : UIViewController<UIWebViewDelegate>

- (IBAction)BackBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end
