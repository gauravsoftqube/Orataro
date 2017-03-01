//
//  PhotoAlbumVc.m
//  orataro
//
//  Created by MAC008 on 23/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "PhotoAlbumVc.h"
#import "AlbumPhotoCell.h"
#import "PhotoalbumCell.h"
#import "ProfilePhotoShowVc.h"

@interface PhotoAlbumVc ()
{
    NSString *str ;
}
@end

@implementation PhotoAlbumVc
@synthesize addBtn,aFirstBottomView,aSecondBottomView,SecondImgeView,FirstImageView,aCollectionView,aFirstBtn,aSecondBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    addBtn.layer.cornerRadius  = 30.0;
    
    aSecondBottomView.hidden = YES;
    aFirstBottomView.hidden = NO;

    aFirstBtn.tag = 1;
    aSecondBtn.tag = 1;
    
    //PhotosCell
    //AlbumCell
    
    str = @"first";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [aCollectionView registerNib:[UINib nibWithNibName:@"AlbumPhotoCell" bundle:nil] forCellWithReuseIdentifier:@"AlbumCell"];
    
    [aCollectionView registerNib:[UINib nibWithNibName:@"PhotoalbumCell" bundle:nil] forCellWithReuseIdentifier:@"PhotosCell"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - button action

- (IBAction)aFirstBtnClicked:(id)sender
{
    aFirstBottomView.hidden= NO;
    aSecondBottomView.hidden = YES;
    [FirstImageView setImage:[UIImage imageNamed:@"photo_blue"]];
    [SecondImgeView setImage:[UIImage imageNamed:@"album_grey"]];
    aFirstBtn.tag = 1;
    aSecondBtn.tag = 0;
    str = @"first";
    [aCollectionView reloadData];
}

- (IBAction)aSecondBtnClicked:(id)sender
{
    aFirstBottomView.hidden = YES;
    aSecondBottomView.hidden = NO;
    [FirstImageView setImage:[UIImage imageNamed:@"photo_grey"]];
    [SecondImgeView setImage:[UIImage imageNamed:@"album_blue"]];
    aFirstBtn.tag = 0;
    aSecondBtn.tag = 1;
    str = @"Second";
    [aCollectionView reloadData];
}
- (IBAction)addBtnClicked:(id)sender
{
    if ([str isEqualToString:@"first"])
    {
            UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Add Photo!" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose from Liabrary", nil];
            
            [action showInView:self.view];
        }
    if ([str isEqualToString:@"Second"])
    {
    }
}

        
#pragma mark - COLLECTIONVIEW DELEGATE

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (aFirstBtn.tag ==1)
    {
        [aCollectionView registerNib:[UINib nibWithNibName:@"PhotoalbumCell" bundle:nil] forCellWithReuseIdentifier:@"PhotosCell"];
        
        PhotoalbumCell *cell2 = (PhotoalbumCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotosCell" forIndexPath:indexPath];
        
        if (cell2 == nil)
        {
            NSArray *xib = [[NSBundle mainBundle] loadNibNamed:@"PhotoalbumCell" owner:self options:nil];
            cell2 = [xib objectAtIndex:0];
        }
        cell2.aOuterView.layer.cornerRadius = 3.0;
        cell2.aOuterView.layer.borderWidth = 1.0;
        cell2.aOuterView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        return cell2;

    }
  if(aSecondBtn.tag ==1)
    {
        [aCollectionView registerNib:[UINib nibWithNibName:@"AlbumPhotoCell" bundle:nil] forCellWithReuseIdentifier:@"AlbumCell"];
        
        AlbumPhotoCell *cell2 = (AlbumPhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"AlbumCell" forIndexPath:indexPath];
        
        if (cell2 == nil)
        {
            NSArray *xib = [[NSBundle mainBundle] loadNibNamed:@"AlbumPhotoCell" owner:self options:nil];
            cell2 = [xib objectAtIndex:0];
        }
        cell2.aOuterView.layer.cornerRadius = 3.0;
        cell2.aOuterView.layer.borderWidth = 1.0;
        cell2.aOuterView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        return cell2;

    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tag=%ld",(long)aFirstBtn.tag);
    NSLog(@"tag=%ld",(long)aSecondBtn.tag);
    
    NSLog(@"str=%@",str);
    
    if ([str isEqualToString:@"first"])
    {
        ProfilePhotoShowVc *p7 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfilePhotoShowVc"];
        [self.navigationController pushViewController:p7 animated:YES];
    }
    if ([str isEqualToString:@"Second"])
    {
        
    }

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
    return CGSizeMake(f, f);
}
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0, 0, 0);
}



#pragma mark - ActionSheet delegates

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( buttonIndex == 0 )
    {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *pickerView =[[UIImagePickerController alloc]init];
            pickerView.allowsEditing = YES;
            pickerView.delegate = self;
            pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentModalViewController:pickerView animated:true];
        }
        
    }
    else if( buttonIndex == 1)
    {
        
        UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
        pickerView.allowsEditing = YES;
        pickerView.delegate = self;
        [pickerView setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentModalViewController:pickerView animated:YES];
        
    }
}

#pragma mark - PickerDelegates

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    //  [self dismissModalViewControllerAnimated:true];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage * img = [info valueForKey:UIImagePickerControllerEditedImage];
    
  //  PostImageView.image = img;
}


- (IBAction)BackBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
