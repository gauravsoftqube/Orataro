//
//  ORGContainerCellView.m
//  HorizontalCollectionViews
//
//  Created by James Clark on 4/22/13.
//  Copyright (c) 2013 OrgSync, LLC. All rights reserved.
//

#import "ORGContainerCellView.h"
#import "ORGArticleCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface ORGContainerCellView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *collectionData;
@end

@implementation ORGContainerCellView

- (void)awakeFromNib {
    
    self.collectionView.backgroundColor = [UIColor colorWithRed:39.0/255.0 green:48.0/255.0 blue:48.0/255.0 alpha:1.0];
     // cell.contentView.backgroundColor = [UIColor colorWithRed:39.0/255.0 green:48.0/255.0 blue:48.0/255.0 alpha:1.0];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(70.0, 70.0);
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    // Register the colleciton cell
    [_collectionView registerNib:[UINib nibWithNibName:@"ORGArticleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ORGArticleCollectionViewCell"];
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

#pragma mark - Getter/Setter overrides
- (void)setCollectionData:(NSArray *)collectionData {
    _collectionData = collectionData;
    [_collectionView setContentOffset:CGPointZero animated:NO];
    [_collectionView reloadData];
}


#pragma mark - UICollectionViewDataSource methods
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.collectionData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ORGArticleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ORGArticleCollectionViewCell" forIndexPath:indexPath];
    
    NSLog(@"Cell =%@",[self.collectionData objectAtIndex:[indexPath row]]);
    
    NSDictionary *cellData = [self.collectionData objectAtIndex:[indexPath row]];
    
    NSLog(@"Cell =%@",cellData);
    NSString *str=[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[cellData objectForKey:@"Images"]];
    str= [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [cell.articleImage sd_setImageWithURL:[NSURL URLWithString:str] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             
             ORGArticleCollectionViewCell* theCell = (ORGArticleCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
             theCell.articleImage.image=image;
         });
     }];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellData = [self.collectionData objectAtIndex:[indexPath row]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectItemFromCollectionView" object:cellData];
}

@end
