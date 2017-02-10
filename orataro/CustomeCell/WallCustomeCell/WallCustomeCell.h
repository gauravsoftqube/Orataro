//
//  WallCustomeCell.h
//  orataro
//
//  Created by harikrishna patel on 27/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WallCustomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aFirstViewheight;
@property (weak, nonatomic) IBOutlet UIView *aThirdView;
@property (weak, nonatomic) IBOutlet UIView *aMiddleView;
@property (weak, nonatomic) IBOutlet UIView *aFirstView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aShareViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aCommentViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aUnlikeViewWidth;
@property (weak, nonatomic) IBOutlet UIView *aUnlikeView;
@property (weak, nonatomic) IBOutlet UIView *aLikeView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aLikeViewWidth;
@property (weak, nonatomic) IBOutlet UIView *aCommentView;
@property (weak, nonatomic) IBOutlet UIView *aShareView;

@end
