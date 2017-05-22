//
//  SenderMessage.h
//  ChatDemoOwnCreated
//
//  Created by MAC008 on 19/05/17.
//  Copyright © 2017 MAC008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SenderMessage : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbSenderMessage;
@property (weak, nonatomic) IBOutlet UILabel *lbSenderTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingSpace;
@property (weak, nonatomic) IBOutlet UIView *aView;

@end
