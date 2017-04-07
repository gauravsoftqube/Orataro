//
//  ProfileVideoVc.h
//  orataro
//
//  Created by Softqube on 23/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileVideoVc : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
- (IBAction)btnBack:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionVideolist;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *ActivityIndicator;


@end
