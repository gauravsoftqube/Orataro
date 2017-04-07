//
//  PhototableCell.h
//  orataro
//
//  Created by MAC008 on 23/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhototableCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *DownloadImageView;
@property (weak, nonatomic) IBOutlet UIView *aOuteView;
@property (weak, nonatomic) IBOutlet UILabel *lbDate;
@property (weak, nonatomic) IBOutlet UIButton *btnDownload;
@property (weak, nonatomic) IBOutlet UIImageView *imgShowImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
