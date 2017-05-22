//
//  OrataroVc.h
//  orataro
//
//  Created by MAC008 on 08/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParallaxViewController.h"

@interface OrataroVc : ParallaxViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
- (IBAction)LogoutBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *viewSaveOuter;
@property (weak, nonatomic) IBOutlet UIView *viewSaveInner;

- (IBAction)btnSaveClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewLogout;
@property (strong, nonatomic) IBOutlet UICollectionView *aCollectionView;
@property (strong, nonatomic) IBOutlet UIView *aHeaderView;
- (IBAction)backtoLanguageBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgClose;
- (IBAction)btnCancelClicked:(id)sender;

@end
