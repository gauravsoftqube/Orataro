//
//  DisplayTitleVc.h
//  orataro
//
//  Created by MAC008 on 23/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayTitleVc : UIViewController<UIWebViewDelegate>

- (IBAction)BackBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UILabel *lbNavTitle;
@property (strong,nonatomic) NSMutableDictionary *dicPageDetail;
@property(strong,nonatomic)NSMutableDictionary *dicBlogDatail;
@property(strong,nonatomic)NSString *strCheckBlogPage;
@end
