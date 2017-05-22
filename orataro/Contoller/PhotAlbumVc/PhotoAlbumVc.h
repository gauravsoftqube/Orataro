//
//  PhotoAlbumVc.h
//  orataro
//
//  Created by MAC008 on 23/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoAlbumVc : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *aCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *aFirstBtn;
@property (weak, nonatomic) IBOutlet UILabel *lbHeaderTitle;
@property (weak, nonatomic) IBOutlet UIButton *AddBtn;
- (IBAction)aFirstBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *aSecondBtn;
- (IBAction)aSecondBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *SecondImgeView;
@property (weak, nonatomic) IBOutlet UIImageView *FirstImageView;
@property (weak, nonatomic) IBOutlet UIView *aFirstBottomView;
@property (weak, nonatomic) IBOutlet UIView *aSecondBottomView;
@property (weak, nonatomic) IBOutlet UIView *addBtn;
- (IBAction)addBtnClicked:(id)sender;
- (IBAction)BackBtnClicked:(UIButton *)sender;

@end
