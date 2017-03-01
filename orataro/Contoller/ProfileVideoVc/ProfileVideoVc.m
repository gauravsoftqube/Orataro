//
//  ProfileVideoVc.m
//  orataro
//
//  Created by Softqube on 23/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ProfileVideoVc.h"
#import "ProfileVideoDetailVc.h"

@interface ProfileVideoVc ()

@end

@implementation ProfileVideoVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- UICollectionView

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width-20;
    float cellWidth = screenWidth / 2.0;
    CGSize size =CGSizeMake(cellWidth, 150);
    
    return size;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellRow" forIndexPath:indexPath];
    
    
    UIView *view=(UIView *)[cell.contentView viewWithTag:1];
    [view.layer setBorderColor:[UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1.0f].CGColor];
    [view.layer setBorderWidth:1];
    [view.layer setCornerRadius:4];
    view.clipsToBounds=YES;
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
}

#pragma mark - UIButton Action

- (IBAction)btnVideoClickCell:(id)sender
{
  //  ProfileVideoDetailVc
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_collectionVideolist];
    NSIndexPath *indexPath = [_collectionVideolist indexPathForItemAtPoint:buttonPosition];
    
    ProfileVideoDetailVc *p4 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfileVideoDetailVc"];
    [self.navigationController pushViewController:p4 animated:YES];
    
    NSLog(@"row=%ld",(long)indexPath.row);
    
}
- (IBAction)btnDownloadVideo:(id)sender
{
    
}

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
