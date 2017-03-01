//
//  PhotoVc.m
//  orataro
//
//  Created by MAC008 on 23/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "PhotoVc.h"
#import "PhototableCell.h"
#import "ProfilePhotoShowVc.h"

@interface PhotoVc ()

@end

@implementation PhotoVc
@synthesize aCollectionView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
     [aCollectionView registerNib:[UINib nibWithNibName:@"PhototableCell" bundle:nil] forCellWithReuseIdentifier:@"PhotoCell"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - COLLECTIONVIEW DELEGATE

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"PhotoCell";
    
    PhototableCell *cell2 = (PhototableCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (cell2 == nil)
    {
        NSArray *xib = [[NSBundle mainBundle] loadNibNamed:@"PhototableCell" owner:self options:nil];
        cell2 = [xib objectAtIndex:0];
    }
    cell2.aOuteView.layer.cornerRadius = 3.0;
    cell2.aOuteView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell2.aOuteView.layer.borderWidth = 1.0;
    
    cell2.DownloadImageView.image = [cell2.DownloadImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [cell2.DownloadImageView setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    cell2.DownloadImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    return cell2;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionVie
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float f = collectionView.bounds.size.width/2;
    return CGSizeMake(f-5, f+20);
}
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5,5, 5, 5);
}

#pragma mark - button action

- (IBAction)BackBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProfilePhotoShowVc *p7 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfilePhotoShowVc"];
    [self.navigationController pushViewController:p7 animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
