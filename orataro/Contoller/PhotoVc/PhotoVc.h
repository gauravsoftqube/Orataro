//
//  PhotoVc.h
//  orataro
//
//  Created by MAC008 on 23/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoVc : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *aCollectionView;
- (IBAction)BackBtnClicked:(id)sender;

@end
