//
//  WallCustomeCell.h
//  orataro
//
//  Created by harikrishna patel on 27/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"

@interface WallCustomeCell : UITableViewCell

//Header
@property (weak, nonatomic) IBOutlet UIImageView *imgProfilePic;
@property (weak, nonatomic) IBOutlet UILabel *lblProfileName;
@property (weak, nonatomic) IBOutlet UILabel *lblProfileDetail;
@property (weak, nonatomic) IBOutlet UILabel *lblProfile_PostType;
@property (weak, nonatomic) IBOutlet UIButton *btnEditDeletePost;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnEditDeletePost_Height;//25



//Post Detail

@property (weak, nonatomic) IBOutlet UILabel *lblPostDetail;
@property (weak, nonatomic) IBOutlet HTMLLabel *lblPostDetailHTML;
@property (weak, nonatomic) IBOutlet UIButton *btnPostDetailHTML;

@property (weak, nonatomic) IBOutlet UIImageView *imgPost;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgPost_Height;

@property (weak, nonatomic) IBOutlet UIButton *btnImageVideo_Click;


//count
@property (weak, nonatomic) IBOutlet UILabel *lblLike_Count;
@property (weak, nonatomic) IBOutlet UILabel *lblUnLike_Count;
@property (weak, nonatomic) IBOutlet UILabel *lblComment_Count;


//count height 15
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lblLike_Count_Height;



//Like
@property (weak, nonatomic) IBOutlet UIImageView *imgLike;
@property (weak, nonatomic) IBOutlet UILabel *lblLike;
@property (weak, nonatomic) IBOutlet UIButton *btnLike;
@property (weak, nonatomic) IBOutlet UIView *viewLike;

//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewLike_Width;//82.5
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewLike_Height;//30
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgLike_Height;//14
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgLike_Width;//14


//UnLike
@property (weak, nonatomic) IBOutlet UIImageView *imgUnlike;
@property (weak, nonatomic) IBOutlet UILabel *lblUnlike;
@property (weak, nonatomic) IBOutlet UIButton *btnUnlike;
@property (weak, nonatomic) IBOutlet UIView *viewDisLike;

//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewDisLike_Width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgDisLike_Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgDisLike_Width;


//Comment
@property (weak, nonatomic) IBOutlet UIImageView *imgComment;
@property (weak, nonatomic) IBOutlet UILabel *lblComment;
@property (weak, nonatomic) IBOutlet UIButton *btnComment;
@property (weak, nonatomic) IBOutlet UIView *viewComment;

//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgComment_Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgComment_Width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewComment_Width;



//Share
@property (weak, nonatomic) IBOutlet UIImageView *imgShare;
@property (weak, nonatomic) IBOutlet UILabel *lblShare;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UIView *viewShare;

//
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgShare_Width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgShare_Height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewShare_Width;

@end
