//
//  PhotoAlbumVc.m
//  orataro
//
//  Created by MAC008 on 23/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "PhotoAlbumVc.h"
#import "Global.h"


@interface PhotoAlbumVc ()
{
    NSString *str ;
    NSMutableArray *arySaveImage,*arySaveTempImage,*arySaveAlbum,*arySaveTempAlbum;
    NSString *checkImage;
    NSMutableArray *aryAlbumList,*aryAlbumTempList;
    //UIActivityIndicatorView *activityIndicator;
}
@end

@implementation PhotoAlbumVc
@synthesize addBtn,aFirstBottomView,aSecondBottomView,SecondImgeView,FirstImageView,aCollectionView,aFirstBtn,aSecondBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arySaveImage = [[NSMutableArray alloc]init];
    arySaveTempImage = [[NSMutableArray alloc]init];
    aryAlbumList = [[NSMutableArray alloc]init];
    aryAlbumTempList = [[NSMutableArray alloc]init];
    
    //PhotosCell
    //AlbumCell
    
    str = @"first";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [_collectionviewAlbum registerNib:[UINib nibWithNibName:@"AlbumPhotoCell" bundle:nil] forCellWithReuseIdentifier:@"AlbumCell"];
    
    [aCollectionView registerNib:[UINib nibWithNibName:@"PhotoalbumCell" bundle:nil] forCellWithReuseIdentifier:@"PhotosCell"];
    
   // NSLog(@"Current=%@",[Utility getCurrentUserDetail]);
    
    NSMutableDictionary *dic =[Utility getCurrentUserDetail];
    NSString *strCheckVal = [NSString stringWithFormat:@"%@",[dic objectForKey:@"IsAllowUserToPostPhoto"]];
    
    
    if([strCheckVal isEqualToString:@"1"])
    {
        _viewadd.hidden = NO;
        //[self.view bringSubviewToFront:_viewadd];
       // [_collectionviewAlbum bringSubviewToFront:_viewadd];
       // [aCollectionView bringSubviewToFront:_viewadd];
        
      //  _viewAddAlbum.hidden = NO;
      //  [aCollectionView bringSubviewToFront:_viewAddAlbum];

    }
    else
    {
        _viewadd.hidden = YES;
    }
    
   // [self.view bringSubviewToFront:_viewadd];
    
    // addBtn.layer.cornerRadius  = 30.0;
    _viewadd.layer.cornerRadius  = 20.0;
    aSecondBottomView.hidden = YES;
    aFirstBottomView.hidden = NO;
    
    _collectionviewAlbum.hidden = YES;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    //arySaveImage = [[NSMutableArray alloc]init];
    //arySaveTempImage = [[NSMutableArray alloc]init];
    
    //CREATE TABLE "PhotoAlbumList" ("id" INTEGER PRIMARY KEY  NOT NULL , "PhotoAlbumJsonStr" VARCHAR, "Flag" VARCHAR, "PhotoAlbumImageStr" VARCHAR)
    
    _lbHeaderTitle.text = [NSString stringWithFormat:@"PhotosAlbum (%@)",[Utility getCurrentUserName]];
    
    aFirstBtn.tag = 1;
    aSecondBtn.tag = 0;
    
    // AlbumPhotoVc *p7 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AlbumPhotoVc"];
    
    //  str = @"Second";
    
    
    //NSLog(@"Values of Album=%@",str);
    
    
    if ([checkImage isEqualToString:@"FromImagePicker"])
    {
        
    }
    else
    {
        if ([str isEqualToString:@"Second"])
        {
            _collectionviewAlbum.hidden =NO;
            aCollectionView.hidden = YES;
            
           // [self.view bringSubviewToFront:_collectionviewAlbum];
            
            NSArray *ary = [DBOperation selectData:@"select * from PhotoMultipleAlbumList"];
            arySaveImage = [Utility getLocalDetail:ary columnKey:@"PhotoAlbumJsonStr"];
            
            arySaveTempImage = [DBOperation selectData:@"select id,flag,PhotoAlbumImageStr from PhotoMultipleAlbumList"];
            
            //NSLog(@"ary=%@",arySaveTempImage);
            
            
            [_collectionviewAlbum reloadData];
            
            if (arySaveTempImage.count == 0)
            {
                if ([Utility isInterNetConnectionIsActive] == false)
                {
                    UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alrt show];
                    return;
                }
                else
                {
                    [self apiCallFor_GetPhotoList:YES :@"Album"];
                }
            }
            else
            {
                if ([Utility isInterNetConnectionIsActive] == true)
                {
                    [self apiCallFor_GetPhotoList:NO :@"Album"];
                }
                else
                {
                    
                }
                
            }
            
        }
        else
        {
            _collectionviewAlbum.hidden =YES;
            aCollectionView.hidden = NO;
            
         //   [self.view bringSubviewToFront:aCollectionView];
            
            NSArray *ary = [DBOperation selectData:@"select * from PhotoAlbumList"];
            arySaveImage = [Utility getLocalDetail:ary columnKey:@"PhotoJsonStr"];
            
            arySaveTempImage = [DBOperation selectData:@"select id,Flag,PhotoImageStr from PhotoAlbumList"];
            
           // NSLog(@"ary=%@",arySaveTempImage);
            
            [aCollectionView reloadData];
            
            if (arySaveTempImage.count == 0)
            {
                if ([Utility isInterNetConnectionIsActive] == false)
                {
                    UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alrt show];
                    return;
                }
                else
                {
                    [self apiCallFor_GetPhotoList:YES :@"Photo"];
                }
            }
            else
            {
                if ([Utility isInterNetConnectionIsActive] == true)
                {
                    [self apiCallFor_GetPhotoList:NO :@"Photo"];
                }
                else
                {
                    
                }
                
                
            }
            
        }
    }
    
    
}
#pragma mark - button action

- (IBAction)aFirstBtnClicked:(id)sender
{
    aFirstBottomView.hidden= NO;
    aSecondBottomView.hidden = YES;
    [FirstImageView setImage:[UIImage imageNamed:@"photo_blue"]];
    [SecondImgeView setImage:[UIImage imageNamed:@"album_grey"]];
   // aFirstBtn.tag = 1;
   // aSecondBtn.tag = 0;
    str = @"first";
    
 //   [self.view bringSubviewToFront:aCollectionView];
    _collectionviewAlbum.hidden = YES;
    aCollectionView.hidden = NO;
    
    // [arySaveImage removeAllObjects];
    // [arySaveTempImage removeAllObjects];
    
    NSArray *ary = [DBOperation selectData:@"select * from PhotoAlbumList"];
    arySaveImage = [Utility getLocalDetail:ary columnKey:@"PhotoJsonStr"];
    
    //PhotoAlbumJsonStr
    
    arySaveTempImage = [DBOperation selectData:@"select id,Flag,PhotoImageStr from PhotoAlbumList"];
    
    //NSLog(@"ary=%@",arySaveTempImage);
    
    [aCollectionView reloadData];
    
    if (arySaveTempImage.count == 0)
    {
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        else
        {
            [self apiCallFor_GetPhotoList:YES :@"Photo"];
        }
    }
    else
    {
        if ([Utility isInterNetConnectionIsActive] == true)
        {
            [self apiCallFor_GetPhotoList:NO :@"Photo"];
        }
        else
        {
            
        }
        
    }
    
    
    // [aCollectionView reloadData];
}

- (IBAction)aSecondBtnClicked:(id)sender
{
    aFirstBottomView.hidden = YES;
    aSecondBottomView.hidden = NO;
    [FirstImageView setImage:[UIImage imageNamed:@"photo_grey"]];
    [SecondImgeView setImage:[UIImage imageNamed:@"album_blue"]];
    //aFirstBtn.tag = 0;
    //aSecondBtn.tag = 1;
    str = @"Second";
    
  //  [self.view bringSubviewToFront:_collectionviewAlbum];
    _collectionviewAlbum.hidden = NO;
    aCollectionView.hidden = YES;
    
    
    // arySaveImage =
    // arySaveTempImage =
    
    //CREATE TABLE "PhotoMultipleAlbumList" ("id" INTEGER PRIMARY KEY  NOT NULL , "PhotoAlbumJsonStr" VARCHAR, "PhotoAlbumImageStr" VARCHAR, "flag" VARCHAR)
    
    //  [arySaveImage removeAllObjects];
    // [arySaveTempImage removeAllObjects];
    
    //[DBOperation executeSQL:@"delete from PhotoMultipleAlbumList"];
    
    
    NSArray *ary = [DBOperation selectData:@"select * from PhotoMultipleAlbumList"];
    arySaveImage = [Utility getLocalDetail:ary columnKey:@"PhotoAlbumJsonStr"];
    //PhotoAlbumImageStr
    
    arySaveTempImage = [DBOperation selectData:@"select id,flag,PhotoAlbumImageStr from PhotoMultipleAlbumList"];
    
  //  NSLog(@"ary=%@",arySaveTempImage);
    
    
    //[_collectionviewAlbum reloadData];
    
    if (arySaveTempImage.count == 0)
    {
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        else
        {
            [self apiCallFor_GetPhotoList:YES :@"Album"];
        }
    }
    else
    {
        if ([Utility isInterNetConnectionIsActive] == true)
        {
            [self apiCallFor_GetPhotoList:NO :@"Album"];
        }
        else
        {
            [_collectionviewAlbum reloadData];

        }
        
    }
    
    // [aCollectionView reloadData];
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
        //AddAlbumVCViewController
        AddAlbumVCViewController *p7 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddAlbumVCViewController"];
        [self.navigationController pushViewController:p7 animated:YES];
    }
}


#pragma mark - COLLECTIONVIEW DELEGATE

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //    if([str isEqualToString:@"first"])
    //    {
    //        return  arySaveImage.count;
    //    }
    //    else
    //    {
    //        return  arySaveImage.count;
    //    }
    /*
     aryAlbumList = [Utility getLocalDetail:ary columnKey:@"PhotoAlbumJsonStr"];
     
     aryAlbumTempList = [DBOperation selectData:@"select id,flag,PhotoAlbumImageStr from PhotoMultipleAlbumList"];
     */
    if (collectionView == aCollectionView)
    {
        return arySaveImage.count;
    }
    
    if (collectionView == _collectionviewAlbum)
    {
        return aryAlbumList.count;
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"tag=%ld",(long)aFirstBtn.tag);
   // NSLog(@"Secon=%ld",(long)aSecondBtn.tag);
    
    //str = @"Second";
    // str = @"first";
    //if (aFirstBtn.tag ==1)
    //{
    
    
    if (collectionView == aCollectionView)
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
        
        NSString *documentDirectory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        
        [cell2.activityIndicator startAnimating];
        
        if ([[[arySaveTempImage objectAtIndex:indexPath.row]objectForKey:@"Flag"] isEqualToString:@"0"])
        {
            if ([Utility isInterNetConnectionIsActive] == true)
            {
               // NSLog(@"data=%@",[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[[arySaveImage objectAtIndex:indexPath.row]objectForKey:@"Photo"]]);
                
                [cell2 setContentMode:UIViewContentModeScaleAspectFit];
                
                [cell2.imgPhoto sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[[arySaveImage objectAtIndex:indexPath.row]objectForKey:@"Photo"]]] placeholderImage:[UIImage imageNamed:@"no_img"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
                 {
                     //CREATE TABLE "PhotoAlbumList" ("id" INTEGER PRIMARY KEY  NOT NULL , "PhotoAlbumJsonStr" VARCHAR, "Flag" VARCHAR, "PhotoAlbumImageStr" VARCHAR)
                     
                     [cell2.activityIndicator stopAnimating];
                     cell2.activityIndicator.hidden = YES;
                     
                     @try
                     {
                         [DBOperation selectData:[NSString stringWithFormat:@"update PhotoAlbumList set Flag='1' where id=%@",[[arySaveTempImage objectAtIndex:indexPath.row]objectForKey:@"id"]]];
                         
                     } @catch (NSException *exception)
                     {
                         
                     } @finally
                     {
                         
                     }
                     
                     
                     //no_img
                     
                     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                     NSString *documentsDirectory = [paths objectAtIndex:0];
                     
                     NSString *setImage = [NSString stringWithFormat:@"%@",[[arySaveTempImage objectAtIndex:indexPath.row]objectForKey:@"PhotoAlbumImageStr"]];
                     
                     NSArray *ary = [setImage componentsSeparatedByString:@"/"];
                     
                     NSString *strSaveImg = [ary lastObject];
                     
                     NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
                     
                     //NSLog(@"image Saperator=%@",[strSaveImg componentsSeparatedByString:@"."]);
                     
                     if (strSaveImg == (id)[NSNull null] || strSaveImg.length == 0 || [strSaveImg isEqualToString:@"null"])
                     {
                         
                     }
                     else
                     {
                         // NSArray *getExtension = [strSaveImg componentsSeparatedByString:@"."];
                         
                         NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
                         [imageData writeToFile:imagePath atomically:NO];
                         
                         if (![imageData writeToFile:imagePath atomically:NO])
                         {
                            // NSLog(@"Failed to cache image data to disk");
                         }
                         else
                         {
                             [imageData writeToFile:imagePath atomically:NO];
                           //  NSLog(@"the cachedImagedPath is %@",imagePath);
                         }
                         
                     }
                     
                 }];
                
                [cell2.activityIndicator startAnimating];
            }
            
        }
        else
        {
            //CREATE TABLE "PhotoAlbumList" ("id" INTEGER PRIMARY KEY  NOT NULL , "PhotoAlbumJsonStr" VARCHAR, "Flag" VARCHAR, "PhotoAlbumImageStr" VARCHAR)
            
         //   NSLog(@"count=%lu",(unsigned long)arySaveTempImage.count);
            
            [cell2.activityIndicator stopAnimating];
            cell2.activityIndicator.hidden = YES;
            
            NSString *setImage = [NSString stringWithFormat:@"%@",[[arySaveTempImage objectAtIndex:indexPath.row]objectForKey:@"PhotoImageStr"]];
         //   NSLog(@"image=%@",setImage);
            NSArray *ary = [setImage componentsSeparatedByString:@"/"];
            NSString *strSaveImg = [ary lastObject];
            NSString *imagePath=[documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
            UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
            
            CGDataProviderRef provider = CGImageGetDataProvider(image.CGImage);
            NSData* data = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
            
            if (data.length == 0)
            {
               // NSLog(@"noooooo image");
                cell2.imgPhoto.image = [UIImage imageNamed:@"no_img"];
            }
            else
            {
                cell2.imgPhoto.image = image;
            }
            
            //NSLog(@"image=%@",arySaveImage);
            
        }
        
        return cell2;
    }
    
    if (collectionView == _collectionviewAlbum)
    {
        
        [_collectionviewAlbum registerNib:[UINib nibWithNibName:@"AlbumPhotoCell" bundle:nil] forCellWithReuseIdentifier:@"AlbumCell"];
        
        AlbumPhotoCell *cell2 = (AlbumPhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"AlbumCell" forIndexPath:indexPath];
        
        if (cell2 == nil)
        {
            NSArray *xib = [[NSBundle mainBundle] loadNibNamed:@"AlbumPhotoCell" owner:self options:nil];
            cell2 = [xib objectAtIndex:0];
        }
        cell2.aOuterView.layer.cornerRadius = 3.0;
        cell2.aOuterView.layer.borderWidth = 1.0;
        cell2.aOuterView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        
        
        ////// ********************** ////////////
        
        if (aryAlbumList.count>0)
        {
            @try
            {
                
            cell2.lbTitle.text = [[aryAlbumList objectAtIndex:indexPath.row]objectForKey:@"AlbumTitle"];
            
            cell2.lbPhotoCount.text = [NSString stringWithFormat:@"%@ Photos",[[aryAlbumList objectAtIndex:indexPath.row]objectForKey:@"Total"]];
            
            
            
            NSString *documentDirectory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            
            
            [cell2.activityIndicatorImage startAnimating];
            
            if ([[[aryAlbumTempList objectAtIndex:indexPath.row]objectForKey:@"flag"] isEqualToString:@"0"])
            {
                if ([Utility isInterNetConnectionIsActive] == true)
                {
                  //  NSLog(@"data=%@",[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[[aryAlbumList objectAtIndex:indexPath.row]objectForKey:@"Photo"]]);
                    
                    [cell2 setContentMode:UIViewContentModeScaleAspectFit];
                    
                    [cell2.imgPhoto sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[[aryAlbumList objectAtIndex:indexPath.row]objectForKey:@"Photo"]]] placeholderImage:[UIImage imageNamed:@"no_img"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
                     {
                         
                         [cell2.activityIndicatorImage stopAnimating];
                         cell2.activityIndicatorImage.hidden= YES;
                         
                        
                             [DBOperation selectData:[NSString stringWithFormat:@"update PhotoMultipleAlbumList set flag='1' where id=%@",[[arySaveTempAlbum objectAtIndex:indexPath.row]objectForKey:@"id"]]];
                             
                        
                         
                         
                         //no_img
                         
                         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                         NSString *documentsDirectory = [paths objectAtIndex:0];
                         //PhotoAlbumJsonStr
                         NSString *setImage = [NSString stringWithFormat:@"%@",[[arySaveTempAlbum objectAtIndex:indexPath.row]objectForKey:@"PhotoAlbumImageStr"]];
                         
                         NSArray *ary = [setImage componentsSeparatedByString:@"/"];
                         
                         NSString *strSaveImg = [ary lastObject];
                         
                         NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
                         
                       //  NSLog(@"image Saperator=%@",[strSaveImg componentsSeparatedByString:@"."]);
                         
                         if (strSaveImg == (id)[NSNull null] || strSaveImg.length == 0 || [strSaveImg isEqualToString:@"null"])
                         {
                             
                         }
                         else
                         {
                             NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
                             [imageData writeToFile:imagePath atomically:NO];
                             
                             if (![imageData writeToFile:imagePath atomically:NO])
                             {
                                // NSLog(@"Failed to cache image data to disk");
                             }
                             else
                             {
                                 [imageData writeToFile:imagePath atomically:NO];
                                // NSLog(@"the cachedImagedPath is %@",imagePath);
                             }
                             
                             
                         }
                }];
                    
                }
            }
            else
            {
                //NSLog(@"count=%lu",(unsigned long)arySaveTempAlbum.count);
                
                NSString *setImage = [NSString stringWithFormat:@"%@",[[arySaveTempAlbum objectAtIndex:indexPath.row]objectForKey:@"PhotoAlbumImageStr"]];
               // NSLog(@"image=%@",setImage);
                NSArray *ary = [setImage componentsSeparatedByString:@"/"];
                NSString *strSaveImg = [ary lastObject];
                NSString *imagePath=[documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
                UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
                
                CGDataProviderRef provider = CGImageGetDataProvider(image.CGImage);
                NSData* data = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
                
                if (data.length == 0)
                {
                  //  NSLog(@"noooooo image");
                    cell2.imgPhoto.image = [UIImage imageNamed:@"no_img"];
                }
                else
                {
                    cell2.imgPhoto.image = image;
                }
                
               // NSLog(@"image=%@",arySaveImage);
            }
        }
        @catch (NSException *exception)
        {
            
        }
        ////// ********************** ////////////
        return cell2;
        
    }
    
    }
    ///////////////////**************?////////////////////
    
    // NSLog(@"Str is =%@",str);
    
    /* if ([str isEqualToString:@"first"])
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
     
     NSString *documentDirectory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
     
     
     [cell2.activityIndicator startAnimating];
     
     if ([[[arySaveTempImage objectAtIndex:indexPath.row]objectForKey:@"Flag"] isEqualToString:@"0"])
     {
     if ([Utility isInterNetConnectionIsActive] == true)
     {
     NSLog(@"data=%@",[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[[arySaveImage objectAtIndex:indexPath.row]objectForKey:@"Photo"]]);
     
     [cell2 setContentMode:UIViewContentModeScaleAspectFit];
     
     [cell2.imgPhoto sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[[arySaveImage objectAtIndex:indexPath.row]objectForKey:@"Photo"]]] placeholderImage:[UIImage imageNamed:@"no_img"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
     {
     //CREATE TABLE "PhotoAlbumList" ("id" INTEGER PRIMARY KEY  NOT NULL , "PhotoAlbumJsonStr" VARCHAR, "Flag" VARCHAR, "PhotoAlbumImageStr" VARCHAR)
     
     [cell2.activityIndicator stopAnimating];
     cell2.activityIndicator.hidden = YES;
     
     @try
     {
     [DBOperation selectData:[NSString stringWithFormat:@"update PhotoAlbumList set Flag='1' where id=%@",[[arySaveTempImage objectAtIndex:indexPath.row]objectForKey:@"id"]]];
     
     } @catch (NSException *exception)
     {
     
     } @finally
     {
     
     }
     
     
     //no_img
     
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentsDirectory = [paths objectAtIndex:0];
     
     NSString *setImage = [NSString stringWithFormat:@"%@",[[arySaveTempImage objectAtIndex:indexPath.row]objectForKey:@"PhotoAlbumImageStr"]];
     
     NSArray *ary = [setImage componentsSeparatedByString:@"/"];
     
     NSString *strSaveImg = [ary lastObject];
     
     NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
     
     NSLog(@"image Saperator=%@",[strSaveImg componentsSeparatedByString:@"."]);
     
     if (strSaveImg == (id)[NSNull null] || strSaveImg.length == 0 || [strSaveImg isEqualToString:@"null"])
     {
     
     }
     else
     {
     // NSArray *getExtension = [strSaveImg componentsSeparatedByString:@"."];
     
     NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
     [imageData writeToFile:imagePath atomically:NO];
     
     if (![imageData writeToFile:imagePath atomically:NO])
     {
     NSLog(@"Failed to cache image data to disk");
     }
     else
     {
     [imageData writeToFile:imagePath atomically:NO];
     NSLog(@"the cachedImagedPath is %@",imagePath);
     }
     
     
     //                         if ([[getExtension objectAtIndex:1] isEqualToString:@"jpg"] || [[getExtension objectAtIndex:1] isEqualToString:@"JPG"] ||
     //                             [[getExtension objectAtIndex:1] isEqualToString:@"jpeg"] )
     //                         {
     //                             NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
     //                             [imageData writeToFile:imagePath atomically:NO];
     //
     //                             if (![imageData writeToFile:imagePath atomically:NO])
     //                             {
     //                                 NSLog(@"Failed to cache image data to disk");
     //                             }
     //                             else
     //                             {
     //                                 [imageData writeToFile:imagePath atomically:NO];
     //                                 NSLog(@"the cachedImagedPath is %@",imagePath);
     //                             }
     //                         }
     //                         else
     //                         {
     //                             NSData *imageData = UIImagePNGRepresentation(image);
     //                             [imageData writeToFile:imagePath atomically:NO];
     //
     //                             if (![imageData writeToFile:imagePath atomically:NO])
     //                             {
     //                                 NSLog(@"Failed to cache image data to disk");
     //                             }
     //                             else
     //                             {
     //                                 [imageData writeToFile:imagePath atomically:NO];
     //                                 NSLog(@"the cachedImagedPath is %@",imagePath);
     //                             }
     //
     //                         }
     //jpg
     
     }
     //JPG
     //png
     //jpeg
     
     
     
     }];
     
     
     [cell2.activityIndicator startAnimating];
     // [activityIndicator ];
     
     }
     }
     else
     {
     //CREATE TABLE "PhotoAlbumList" ("id" INTEGER PRIMARY KEY  NOT NULL , "PhotoAlbumJsonStr" VARCHAR, "Flag" VARCHAR, "PhotoAlbumImageStr" VARCHAR)
     
     NSLog(@"count=%lu",(unsigned long)arySaveTempImage.count);
     
     [cell2.activityIndicator stopAnimating];
     cell2.activityIndicator.hidden = YES;
     
     NSString *setImage = [NSString stringWithFormat:@"%@",[[arySaveTempImage objectAtIndex:indexPath.row]objectForKey:@"PhotoAlbumImageStr"]];
     NSLog(@"image=%@",setImage);
     NSArray *ary = [setImage componentsSeparatedByString:@"/"];
     NSString *strSaveImg = [ary lastObject];
     NSString *imagePath=[documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
     UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
     
     CGDataProviderRef provider = CGImageGetDataProvider(image.CGImage);
     NSData* data = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
     
     if (data.length == 0)
     {
     NSLog(@"noooooo image");
     cell2.imgPhoto.image = [UIImage imageNamed:@"no_img"];
     }
     else
     {
     cell2.imgPhoto.image = image;
     }
     
     NSLog(@"image=%@",arySaveImage);
     
     }
     
     
     
     return cell2;
     
     }
     else
     {
     //   if([str isEqualToString:@"Second"])
     
     
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
     
     
     
     ////// ********************** ////////////
     
     if (arySaveImage.count>0)
     {
     cell2.lbTitle.text = [[arySaveImage objectAtIndex:indexPath.row]objectForKey:@"AlbumTitle"];
     
     cell2.lbPhotoCount.text = [NSString stringWithFormat:@"%@ Photos",[[arySaveImage objectAtIndex:indexPath.row]objectForKey:@"Total"]];
     
     
     
     NSString *documentDirectory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
     
     
     NSLog(@"ary=%@",arySaveImage);
     NSLog(@"ary=%@",arySaveTempImage);
     
     [cell2.activityIndicatorImage startAnimating];
     
     if ([[[arySaveTempImage objectAtIndex:indexPath.row]objectForKey:@"flag"] isEqualToString:@"0"])
     {
     if ([Utility isInterNetConnectionIsActive] == true)
     {
     NSLog(@"data=%@",[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[[arySaveImage objectAtIndex:indexPath.row]objectForKey:@"Photo"]]);
     
     [cell2 setContentMode:UIViewContentModeScaleAspectFit];
     
     [cell2.imgPhoto sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[[arySaveImage objectAtIndex:indexPath.row]objectForKey:@"Photo"]]] placeholderImage:[UIImage imageNamed:@"no_img"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
     {
     
     [cell2.activityIndicatorImage stopAnimating];
     cell2.activityIndicatorImage.hidden= YES;
     
     // CREATE TABLE "PhotoMultipleAlbumList" ("id" INTEGER PRIMARY KEY  NOT NULL , "PhotoAlbumJsonStr" VARCHAR, "PhotoAlbumImageStr" VARCHAR, "flag" VARCHAR)
     
     @try
     {
     [DBOperation selectData:[NSString stringWithFormat:@"update PhotoMultipleAlbumList set flag='1' where id=%@",[[arySaveTempImage objectAtIndex:indexPath.row]objectForKey:@"id"]]];
     
     } @catch (NSException *exception)
     {
     
     } @finally
     {
     
     }
     
     
     //no_img
     
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentsDirectory = [paths objectAtIndex:0];
     
     NSString *setImage = [NSString stringWithFormat:@"%@",[[arySaveTempImage objectAtIndex:indexPath.row]objectForKey:@"PhotoAlbumImageStr"]];
     
     NSArray *ary = [setImage componentsSeparatedByString:@"/"];
     
     NSString *strSaveImg = [ary lastObject];
     
     NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
     
     NSLog(@"image Saperator=%@",[strSaveImg componentsSeparatedByString:@"."]);
     
     if (strSaveImg == (id)[NSNull null] || strSaveImg.length == 0 || [strSaveImg isEqualToString:@"null"])
     {
     
     }
     else
     {
     NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
     [imageData writeToFile:imagePath atomically:NO];
     
     if (![imageData writeToFile:imagePath atomically:NO])
     {
     NSLog(@"Failed to cache image data to disk");
     }
     else
     {
     [imageData writeToFile:imagePath atomically:NO];
     NSLog(@"the cachedImagedPath is %@",imagePath);
     }
     
     
     //                             NSArray *getExtension = [strSaveImg componentsSeparatedByString:@"."];
     //
     //                             if ([[getExtension objectAtIndex:1] isEqualToString:@"jpg"] || [[getExtension objectAtIndex:1] isEqualToString:@"JPG"] ||
     //                                 [[getExtension objectAtIndex:1] isEqualToString:@"jpeg"] )
     //                             {
     //                                 NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
     //                                 [imageData writeToFile:imagePath atomically:NO];
     //
     //                                 if (![imageData writeToFile:imagePath atomically:NO])
     //                                 {
     //                                     NSLog(@"Failed to cache image data to disk");
     //                                 }
     //                                 else
     //                                 {
     //                                     [imageData writeToFile:imagePath atomically:NO];
     //                                     NSLog(@"the cachedImagedPath is %@",imagePath);
     //                                 }
     //                             }
     //                             else
     //                             {
     //                                 NSData *imageData = UIImagePNGRepresentation(image);
     //                                 [imageData writeToFile:imagePath atomically:NO];
     //
     //                                 if (![imageData writeToFile:imagePath atomically:NO])
     //                                 {
     //                                     NSLog(@"Failed to cache image data to disk");
     //                                 }
     //                                 else
     //                                 {
     //                                     [imageData writeToFile:imagePath atomically:NO];
     //                                     NSLog(@"the cachedImagedPath is %@",imagePath);
     //                                 }
     //
     //                             }
     //jpg
     
     }
     //JPG
     //png
     //jpeg
     
     
     
     }];
     
     
     //  [cell2.activityIndicator startAnimating];
     // [activityIndicator ];
     
     }
     }
     else
     {
     //CREATE TABLE "PhotoAlbumList" ("id" INTEGER PRIMARY KEY  NOT NULL , "PhotoAlbumJsonStr" VARCHAR, "Flag" VARCHAR, "PhotoAlbumImageStr" VARCHAR)
     
     NSLog(@"count=%lu",(unsigned long)arySaveTempImage.count);
     
     NSString *setImage = [NSString stringWithFormat:@"%@",[[arySaveTempImage objectAtIndex:indexPath.row]objectForKey:@"PhotoAlbumImageStr"]];
     NSLog(@"image=%@",setImage);
     NSArray *ary = [setImage componentsSeparatedByString:@"/"];
     NSString *strSaveImg = [ary lastObject];
     NSString *imagePath=[documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
     UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
     
     CGDataProviderRef provider = CGImageGetDataProvider(image.CGImage);
     NSData* data = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
     
     if (data.length == 0)
     {
     NSLog(@"noooooo image");
     cell2.imgPhoto.image = [UIImage imageNamed:@"no_img"];
     }
     else
     {
     cell2.imgPhoto.image = image;
     }
     
     NSLog(@"image=%@",arySaveImage);
     
     }
     
     
     
     }
     
     ////// ********************** ////////////
     return cell2;
     
     }*/
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"tag=%ld",(long)aFirstBtn.tag);
   // NSLog(@"tag=%ld",(long)aSecondBtn.tag);
    
   // NSLog(@"str=%@",str);
    
    
    if (collectionView == aCollectionView)
    {
        NSString *documentDirectory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            if (arySaveImage.count > 0)
            {
                // from local
                
                // CREATE TABLE "PhotoMultipleAlbumList" ("id" INTEGER PRIMARY KEY  NOT NULL , "PhotoAlbumJsonStr" VARCHAR, "PhotoAlbumImageStr" VARCHAR, "flag" VARCHAR)
                
                NSString *setImage = [NSString stringWithFormat:@"%@",[[arySaveTempImage objectAtIndex:indexPath.row]objectForKey:@"PhotoAlbumImageStr"]];
             //   NSLog(@"image=%@",setImage);
                NSArray *ary = [setImage componentsSeparatedByString:@"/"];
                NSString *strSaveImg = [ary lastObject];
                NSString *imagePath=[documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
                
                aFirstBtn.tag = 1;
                aSecondBtn.tag = 0;
                ProfilePhotoShowVc *p7 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfilePhotoShowVc"];
                p7.imagename = imagePath;
                p7.strOfflineOnline = @"Offline";
                [self.navigationController pushViewController:p7 animated:YES];
                
            }
            else
            {
                UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"sorry no image available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alrt show];
                
            }
        }
        else
        {
            if ([Utility isInterNetConnectionIsActive] == false)
            {
                UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alrt show];
                return;
            }
            
            aFirstBtn.tag = 1;
            aSecondBtn.tag = 0;
            NSString *str3 = [NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[[arySaveImage objectAtIndex:indexPath.row]objectForKey:@"Photo"]];
            ProfilePhotoShowVc *p7 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfilePhotoShowVc"];
            p7.imagename = str3;
            p7.strOfflineOnline = @"Online";
            [self.navigationController pushViewController:p7 animated:YES];
            
        }

    }
    
    if (collectionView == _collectionviewAlbum)
    {
       // NSLog(@"data=%@",arySaveImage);
       // NSLog(@"temp=%@",arySaveTempImage);
        
        aFirstBtn.tag = 0;
        aSecondBtn.tag =1;
        
        //NSLog(@"Data=%@",aryAlbumList);
        
       // NSLog(@"Data=%@",[arySaveImage objectAtIndex:indexPath.row]);
        
        AlbumPhotoVc *p7 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AlbumPhotoVc"];
        p7.strAlbumId = [[aryAlbumList objectAtIndex:indexPath.row]objectForKey:@"AlbumID"];
        p7.strSetView = @"Back";
        [self.navigationController pushViewController:p7 animated:YES];
    }
   /* if ([str isEqualToString:@"first"])
    {
        NSString *documentDirectory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            if (arySaveImage.count > 0)
            {
                // from local
                
                // CREATE TABLE "PhotoMultipleAlbumList" ("id" INTEGER PRIMARY KEY  NOT NULL , "PhotoAlbumJsonStr" VARCHAR, "PhotoAlbumImageStr" VARCHAR, "flag" VARCHAR)
                
                NSString *setImage = [NSString stringWithFormat:@"%@",[[arySaveTempImage objectAtIndex:indexPath.row]objectForKey:@"PhotoAlbumImageStr"]];
                NSLog(@"image=%@",setImage);
                NSArray *ary = [setImage componentsSeparatedByString:@"/"];
                NSString *strSaveImg = [ary lastObject];
                NSString *imagePath=[documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
                
                aFirstBtn.tag = 1;
                aSecondBtn.tag = 0;
                ProfilePhotoShowVc *p7 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfilePhotoShowVc"];
                p7.imagename = imagePath;
                p7.strOfflineOnline = @"Offline";
                [self.navigationController pushViewController:p7 animated:YES];
                
            }
            else
            {
                UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"sorry no image available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alrt show];
                
            }
        }
        else
        {
            if ([Utility isInterNetConnectionIsActive] == false)
            {
                UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alrt show];
                return;
            }
            
            aFirstBtn.tag = 1;
            aSecondBtn.tag = 0;
            NSString *str3 = [NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[[arySaveImage objectAtIndex:indexPath.row]objectForKey:@"Photo"]];
            ProfilePhotoShowVc *p7 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfilePhotoShowVc"];
            p7.imagename = str3;
            p7.strOfflineOnline = @"Online";
            [self.navigationController pushViewController:p7 animated:YES];
            
        }
        
    }
    if ([str isEqualToString:@"Second"])
    {
        NSLog(@"data=%@",arySaveImage);
        NSLog(@"temp=%@",arySaveTempImage);
        
        aFirstBtn.tag = 0;
        aSecondBtn.tag =1;
        AlbumPhotoVc *p7 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AlbumPhotoVc"];
        p7.strAlbumId = [[arySaveImage objectAtIndex:indexPath.row]objectForKey:@"AlbumID"];
        p7.strSetView = @"Back";
        [self.navigationController pushViewController:p7 animated:YES];
    }*/
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
    
    //[self dismissModalViewControllerAnimated:true];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    checkImage = @"FromImagePicker";
    
    // str isEqualToString:@"first"
    //str isEqualToString:@"Second"
    
    if([str isEqualToString:@"first"])
    {
        UIImage * img = [info valueForKey:UIImagePickerControllerEditedImage];
        [self UploadPhoto:img];
    }
    else
    {
        
    }
}


- (IBAction)BackBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Call Api

-(void)apiCallFor_GetPhotoList : (BOOL)checkProgress : (NSString *)strPhotoOrAlbum
{
    //CREATE TABLE "PhotoAlbumList" ("id" INTEGER PRIMARY KEY  NOT NULL , "PhotoAlbumJsonStr" VARCHAR, "Flag" VARCHAR, "PhotoAlbumImageStr" VARCHAR)
    
    //#define apk_albums @"apk_albums.asmx"
    //#define apk_GetAlbumList_action @"GetAlbumList"
    //MemberID=f1a6d89d-37dc-499a-9476-cb83f0aba0f2
    //ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
    //InstituteID=4f4bbf0e-858a-46fa-a0a7-bf116f537653
    //BeachID=null
    
    
    // [self apiCallFor_GetPhotoList:YES :@"Photo"];
    // [self apiCallFor_GetPhotoList:NO :@"Photo"];
    
    if ([strPhotoOrAlbum isEqualToString:@"Photo"])
    {
        NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_Photos,apk_GetPhotoList_action];
        
        NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
        NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
        
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] forKey:@"WallID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
        
        if (checkProgress == YES)
        {
            [ProgressHUB showHUDAddedTo:self.view];
        }
        
        [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
         {
             [ProgressHUB hideenHUDAddedTo:self.view];
             if(!error)
             {
                 NSString *strArrd=[dicResponce objectForKey:@"d"];
                 NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
                 NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                 
                 if([arrResponce count] != 0)
                 {
                     NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                     NSString *strStatus=[dic objectForKey:@"message"];
                     if([strStatus isEqualToString:@"No Data Found"])
                     {
                         UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:PHOTOLIST delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [alrt show];
                     }
                     else
                     {
                         [self ManageCircularList:arrResponce :@"Photo"];
                         
                         
                     }
                 }
                 else
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
             }
             else
             {
                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alrt show];
             }
         }];
        
    }
    else
    {
        //#define apk_albums @"apk_albums.asmx"
        //#define apk_GetAlbumList_action @"GetAlbumList"
        //MemberID=f1a6d89d-37dc-499a-9476-cb83f0aba0f2
        //ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
        //InstituteID=4f4bbf0e-858a-46fa-a0a7-bf116f537653
        //BeachID=null
        
        NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_albums,apk_GetAlbumList_action];
        
        NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
        NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
        
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
        
        if (checkProgress == YES)
        {
            [ProgressHUB showHUDAddedTo:self.view];
        }
        
        [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
         {
             [ProgressHUB hideenHUDAddedTo:self.view];
             if(!error)
             {
                 NSString *strArrd=[dicResponce objectForKey:@"d"];
                 NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
                 NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                 
                 if([arrResponce count] != 0)
                 {
                     NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                     NSString *strStatus=[dic objectForKey:@"message"];
                     if([strStatus isEqualToString:@"No Data Found"])
                     {
                         UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:PHOTOLIST delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [alrt show];
                     }
                     else
                     {
                         [self ManageCircularList:arrResponce :@"Album"];
                         
                     }
                 }
                 else
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
             }
             else
             {
                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alrt show];
             }
         }];
        
        
    }
    
}


-(void)ManageCircularList:(NSMutableArray *)arrResponce :(NSString *)CheckAlbum
{
    
    
    if ([CheckAlbum  isEqualToString:@"Photo"])
    {
       // NSLog(@"response=%@",arrResponce);
        
        //  CREATE TABLE "PhotoAlbumList" ("id" INTEGER PRIMARY KEY  NOT NULL , "PhotoAlbumJsonStr" VARCHAR, "Flag" VARCHAR, "PhotoAlbumImageStr" VARCHAR)
        
        // arySaveImage = [[NSMutableArray alloc]init];
        // arySaveTempImage = [[NSMutableArray alloc]init];
        
        //Album
        //Photo
        
        NSMutableArray *ary1 = [[NSMutableArray alloc]initWithArray:arrResponce];
        
      //  NSLog(@"array=%@",ary1);
        
        [DBOperation executeSQL:@"delete from PhotoAlbumList"];
        
        for (NSMutableDictionary *dic in arrResponce)
        {
            NSString *setImage = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Photo"]];
            
            NSArray *ary = [setImage componentsSeparatedByString:@"/"];
            
            NSString *strSaveImg = [ary lastObject];
            
            //  NSLog(@"data=%@",setImage);
            
            // CREATE TABLE "PhotoAlbumList" ("id" INTEGER PRIMARY KEY  NOT NULL , "PhotoAlbumJsonStr" VARCHAR, "Flag" VARCHAR, "PhotoAlbumImageStr" VARCHAR)
            //PhotoJsonStr
            NSString *getjsonstr = [Utility Convertjsontostring:dic];
            [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO PhotoAlbumList (PhotoJsonStr,PhotoImageStr,Flag) VALUES ('%@','%@','0')",getjsonstr,strSaveImg]];
        }
        NSArray *ary = [DBOperation selectData:@"select * from PhotoAlbumList"];
        arySaveImage = [Utility getLocalDetail:ary columnKey:@"PhotoJsonStr"];
        
        //NSLog(@"Image ary=%@",arySaveImage);
        /*
         NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
         [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
         [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss ZZZ"];
         
         NSDate *date = [dateFormatter dateFromString:dateStr];
         
         NSComparisonResult dateSort(NSString *s1, NSString *s2, void *context) {
         NSDate *d1 = [NSDate dateWithString:s1];
         NSDate *d2 = [NSDate dateWithString:s2];
         return [d1 compare:d2];
         }
         
         NSArray *sorted = [unsorted sortedArrayUsingFunction:dateSort context:nil];
         */
        arySaveTempImage = [DBOperation selectData:@"select id,Flag,PhotoImageStr from PhotoAlbumList"];
        
        [aCollectionView reloadData];
    }
    else
    {
        //([CheckAlbum  isEqualToString:@"Album"])
        
        //NSLog(@"response=%@",arrResponce);
        
        [DBOperation executeSQL:@"delete from PhotoMultipleAlbumList"];
        
        for (NSMutableDictionary *dic in arrResponce)
        {
            NSString *setImage = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Photo"]];
            
            NSArray *ary = [setImage componentsSeparatedByString:@"/"];
            
            NSString *strSaveImg = [ary lastObject];
            
            //  NSLog(@"data=%@",setImage);
            
            // CREATE TABLE "PhotoMultipleAlbumList" ("id" INTEGER PRIMARY KEY  NOT NULL , "PhotoAlbumJsonStr" VARCHAR, "PhotoAlbumImageStr" VARCHAR, "flag" VARCHAR)
            
            NSString *getjsonstr = [Utility Convertjsontostring:dic];
            [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO PhotoMultipleAlbumList (PhotoAlbumJsonStr,PhotoAlbumImageStr,flag) VALUES ('%@','%@','0')",getjsonstr,strSaveImg]];
        }
        NSArray *ary = [DBOperation selectData:@"select * from PhotoMultipleAlbumList"];
        aryAlbumList = [Utility getLocalDetail:ary columnKey:@"PhotoAlbumJsonStr"];
        
        
        NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self"
                                                                    ascending: NO];
        NSArray *ary1 =  [aryAlbumList sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
        
      //  NSLog(@"ary=%@",ary1);
        /*
         NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: NO];
         NSArray *temp = [myArray sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
         */
        
        /* NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO selector:@selector(localizedCompare:)];
        NSArray* sortedArray = [aryAlbumList sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];*/
        
        //aryAlbumList = [sortedArray mutableCopy];
        
        
        aryAlbumTempList = [DBOperation selectData:@"select id,flag,PhotoAlbumImageStr from PhotoMultipleAlbumList"];
        
        [_collectionviewAlbum reloadData];
        
        
    }
    
}


#pragma mark - Add Photo api

-(void)api_AddPhotos1 : (NSString *)imagename
{
    //#define apk_Photos @"apk_Photos.asmx"
    //#define apk_GetPhotoList_action @"GetPhotoList"
    //#define apk_AddPhotos @"AddPhotos"
    
    //    <AddPhotos xmlns="http://tempuri.org/">
    //    <InstituteID>guid</InstituteID>
    //    <ClientID>guid</ClientID>
    //    <WallID>guid</WallID>
    //    <MemberID>guid</MemberID>
    //    <UserID>guid</UserID>
    //    <BeachID>guid</BeachID>
    
    //    <PostShareType>string</PostShareType>
    //    <ImagePath>string</ImagePath>
    //    <FileType>string</FileType>
    //    <FileMineType>string</FileMineType>
    
    //  PostImageView.image = img;
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_Photos,apk_AddPhotos];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] forKey:@"WallID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    [param setValue:@"PUBLIC" forKey:@"PostShareType"];
    [param setValue:imagename forKey:@"ImagePath"];
    [param setValue:@"IMAGE" forKey:@"FileType"];
    [param setValue:@"" forKey:@"FileMineType"];
    
    [ProgressHUB showHUDAddedTo:self.view];
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[dic objectForKey:@"message"];
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:IMEAGENOTADDALBUM delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     //UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     //[alrt show];
                     [self apiCallFor_SendPushNotification];
                 }
             }
             else
             {
                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alrt show];
             }
         }
         else
         {
             UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alrt show];
         }
     }];
}

-(void)apiCallFor_SendPushNotification
{
    if ([Utility isInterNetConnectionIsActive] == false){
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_notifications,apk_SendPushNotification_action];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    [ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error){
        [ProgressHUB hideenHUDAddedTo:self.view];
        [self apiCallFor_GetPhotoList:NO :@"Photo"];
    }];
}
#pragma mark - UploadPhoto

-(void)UploadPhoto : (UIImage *)img
{
    //[self api_AddPhotos:img];
    
    //UploadFile
    ////apk_UploadFile
    
    //apk_post
    
    //    <FileName>string</FileName>
    //    <File>base64Binary</File>
    
    //    <InstituteID>guid</InstituteID>
    //    <ClientID>guid</ClientID>
    //    <MemberID>guid</MemberID>
    
    //    <FileType>string</FileType>
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_post,apk_UploadFile];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    NSString *strFileName = [NSString stringWithFormat:@"%@.png",[Utility randomImageGenerator]];
    
    [param setValue:strFileName forKey:@"FileName"];
    NSData *data = UIImagePNGRepresentation(img);
    const unsigned char *bytes = [data bytes];
    NSUInteger length = [data length];
    NSMutableArray *byteArray = [NSMutableArray array];
    for (NSUInteger i = 0; i < length; i++)
    {
        [byteArray addObject:[NSNumber numberWithUnsignedChar:bytes[i]]];
    }
    [param setValue:byteArray forKey:@"File"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    
    [param setValue:@"IMAGE" forKey:@"FileType"];
    //IMAGE
    [ProgressHUB showHUDAddedTo:self.view];
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         // [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[dic objectForKey:@"message"];
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:NOIMAGEUPLOAD delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     //NSLog(@"Arr=%@",arrResponce);
                     
                     NSString *str2 = [[arrResponce objectAtIndex:0]objectForKey:@"message"];
                     NSArray *ary1 = [str2 componentsSeparatedByString:@" "];
                     NSString *secondObject = [ary1 objectAtIndex:1];
                     [self api_AddPhotos1 : secondObject];
                 }
             }
             else
             {
                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alrt show];
             }
         }
         else
         {
             UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alrt show];
         }
     }];
    
    
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
