//
//  AddAlbumVCViewController.h
//  orataro
//
//  Created by MAC008 on 27/05/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAlbumVCViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgFriend;
@property (weak, nonatomic) IBOutlet UIView *viewAddOuter;
- (IBAction)btnAddClicked:(id)sender;
- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnSaveClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtAlbumName;

@end
