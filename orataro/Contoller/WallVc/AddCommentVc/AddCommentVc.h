//
//  AddCommentVc.h
//  orataro
//
//  Created by Softqube on 25/04/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCommentVc : UIViewController

@property(strong,nonatomic)NSString *checkscreen;

@property (strong, nonatomic) NSMutableDictionary *dicSelectedPost_Comment;
@property (weak, nonatomic) IBOutlet UILabel *lblNoCommentYet;

- (IBAction)btnBack:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblLikeCount;
@property (weak, nonatomic) IBOutlet UITableView *tblCommentList;

@property (weak, nonatomic) IBOutlet UIView *viewCommentPost;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewCommentPost_Bottom;
@property (weak, nonatomic) IBOutlet UITextField *txtPostComment;

@property (weak, nonatomic) IBOutlet UIButton *btnPostComment;
- (IBAction)btnPostComment:(id)sender;

@end
