//
//  PhotoalbumCell.h
//  orataro
//
//  Created by MAC008 on 23/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoalbumCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *aOuterView;
@property (weak, nonatomic) IBOutlet UIImageView *imgPhoto;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
