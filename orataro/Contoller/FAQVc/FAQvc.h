//
//  FAQvc.h
//  orataro
//
//  Created by MAC008 on 13/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAQvc : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *aTabelView;
@property (weak, nonatomic) IBOutlet UIImageView *aImageView;
- (IBAction)MenuBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderTitle;

@end
