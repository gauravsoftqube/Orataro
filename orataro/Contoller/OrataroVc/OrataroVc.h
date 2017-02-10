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

@property (strong, nonatomic) IBOutlet UICollectionView *aCollectionView;
@property (strong, nonatomic) IBOutlet UIView *aHeaderView;

@end
