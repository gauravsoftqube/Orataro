//
//  AlbumPhotoVc.h
//  orataro
//
//  Created by MAC008 on 07/04/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumPhotoVc : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic)NSString *strAlbumId;
@end
