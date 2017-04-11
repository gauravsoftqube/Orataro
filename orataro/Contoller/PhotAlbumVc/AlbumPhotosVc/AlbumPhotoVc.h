//
//  AlbumPhotoVc.h
//  orataro
//
//  Created by MAC008 on 07/04/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumPhotoVc : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)btnBackClicked:(id)sender;
@property (strong,nonatomic)NSString *strAlbumId;
@property(strong,nonatomic)NSString* strSetView;
@end
