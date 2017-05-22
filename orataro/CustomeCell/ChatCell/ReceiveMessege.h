//
//  ReceiveMessege.h
//  ChatDemoOwnCreated
//
//  Created by MAC008 on 19/05/17.
//  Copyright © 2017 MAC008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiveMessege : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbReceiverMessage;
@property (weak, nonatomic) IBOutlet UILabel *lbReceiverTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingSpace;
@property (weak, nonatomic) IBOutlet UIView *aView;

@end
