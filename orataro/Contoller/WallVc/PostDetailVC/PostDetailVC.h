//
//  PostDetailVC.h
//  orataro
//
//  Created by Softqube on 08/05/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@import AVFoundation;
@import AVKit;

@interface PostDetailVC : UIViewController

@property (strong, nonatomic) NSString *strOpenView;
@property (strong, nonatomic) NSMutableDictionary *dicPostDetail;


//Header
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnBack:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
- (IBAction)btnMenu:(id)sender;


//
@property (weak, nonatomic) IBOutlet UITableView *tblImageList;


//
@property (weak, nonatomic) IBOutlet UIView *viewVideomain;
@property (weak, nonatomic) IBOutlet UIView *viewVideoPlay;

//
@property (strong, nonatomic) IBOutlet UIView *viewSave_Popup;
- (IBAction)btnSave:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

//single image view
@property (weak, nonatomic) IBOutlet UIView *viewSingleImage;
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderTitle_SingleImage;
@property (weak, nonatomic) IBOutlet UIButton *btnBack_SingleImage;
- (IBAction)btnBack_SingleImage:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll_SingleImage;
@property (weak, nonatomic) IBOutlet UIImageView *img_singleimage;



@end
