//
//  AlbumPhotoVc.m
//  orataro
//
//  Created by MAC008 on 07/04/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "AlbumPhotoVc.h"
#import "Global.h"

@interface AlbumPhotoVc ()
{
    NSMutableArray *aryImg,*aryTemp;
}
@end

@implementation AlbumPhotoVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    aryImg = [[NSMutableArray alloc]init];
    aryTemp = [[NSMutableArray alloc]init];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"str=%@",_strAlbumId);
    
     //CREATE TABLE "PhotoAlbumSaveMultipleImage" ("id" INTEGER PRIMARY KEY  NOT NULL , "AlbumJsonStr" VARCHAR, "AlbumImageStr" VARCHAR, "flag" VARCHAR)
    
    NSArray *ary = [DBOperation selectData:@"select * from PhotoAlbumSaveMultipleImage"];
    
    aryImg = [Utility getLocalDetail:ary columnKey:@"AlbumJsonStr"];
    
    aryTemp = [DBOperation selectData:@"select id,flag,AlbumImageStr from PhotoAlbumSaveMultipleImage"];
    
   // [_collectionView reloadData];
    
    if (aryTemp.count == 0)
    {
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        else
        {
           // [self apiCallFor_GetPhotoList:YES];
            
        }
    }
    else
    {
        if ([Utility isInterNetConnectionIsActive] == true)
        {
            //[self apiCallFor_GetPhotoList:NO];
        }
        else
        {
            
        }
        
        
    }
    
}


#pragma mark - collectionview delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   // return aryImg.count;
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AlbumCell" forIndexPath:indexPath];
    
    UIView *view=(UIView *)[cell.contentView viewWithTag:1];
    [view.layer setBorderColor:[UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1.0f].CGColor];
    [view.layer setBorderWidth:1];
    [view.layer setCornerRadius:4];
    view.clipsToBounds=YES;
    
    
    /*[cell2.activityIndicator startAnimating];
    
    //fetch from local
    NSString *documentDirectory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    if ([[[aryTemp objectAtIndex:indexPath.row]objectForKey:@"flag"] isEqualToString:@"0"])
    {
        if ([Utility isInterNetConnectionIsActive] == true)
        {
            
            
            NSLog(@"data=%@",[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[[aryPhotoGet objectAtIndex:indexPath.row]objectForKey:@"Photo"]]);
            
            [cell2 setContentMode:UIViewContentModeScaleAspectFit];
            
            [cell2.imgShowImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[[aryPhotoGet objectAtIndex:indexPath.row]objectForKey:@"Photo"]]] placeholderImage:[UIImage imageNamed:@"no_img"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
             {
                 [cell2.activityIndicator stopAnimating];
                 [cell2.activityIndicator removeFromSuperview];
                 
                 [DBOperation selectData:[NSString stringWithFormat:@"update PhotoList set flag='1' where id=%@",[[aryTempGetData objectAtIndex:indexPath.row]objectForKey:@"id"]]];
                 
                 
                 //no_img
                 
                 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                 NSString *documentsDirectory = [paths objectAtIndex:0];
                 
                 NSString *setImage = [NSString stringWithFormat:@"%@",[[aryTempGetData objectAtIndex:indexPath.row]objectForKey:@"PhotoImageStr"]];
                 
                 
                 NSArray *ary = [setImage componentsSeparatedByString:@"/"];
                 
                 NSString *strSaveImg = [ary lastObject];
                 
                 NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
                 
                 NSLog(@"image Saperator=%@",[strSaveImg componentsSeparatedByString:@"."]);
                 
                 NSArray *getExtension = [strSaveImg componentsSeparatedByString:@"."];
                 
                 if ([[getExtension objectAtIndex:1] isEqualToString:@"jpg"] || [[getExtension objectAtIndex:1] isEqualToString:@"JPG"] ||
                     [[getExtension objectAtIndex:1] isEqualToString:@"jpeg"] )
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
                 }
                 else
                 {
                     NSData *imageData = UIImagePNGRepresentation(image);
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
                     
                 }
                 //jpg
                 //JPG
                 //png
                 //jpeg
                 
                 
                 
             }];
            
            
            
        }
        
    }
    else
    {
        NSLog(@"count=%lu",(unsigned long)aryTempGetData.count);
        
        NSString *setImage = [NSString stringWithFormat:@"%@",[[aryTempGetData objectAtIndex:indexPath.row]objectForKey:@"PhotoImageStr"]];
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
            cell2.imgShowImage.image = [UIImage imageNamed:@"no_img"];
        }
        else
        {
            cell2.imgShowImage.image = image;
        }
        
        
    }*/
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionVie
{
    return 1;
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   // float f = collectionView.bounds.size.width/2;
     float f = ([UIScreen mainScreen].bounds.size.width/2)-15;
    NSLog(@"data=%f",f);
    return CGSizeMake(f, f+20);
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,-5, -20, -5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - API CALL


-(void)apiCallFor_GetPhotoList : (BOOL)checkProgress
{
    //CREATE TABLE "PhotoAlbumSaveMultipleImage" ("id" INTEGER PRIMARY KEY  NOT NULL , "AlbumJsonStr" VARCHAR, "AlbumImageStr" VARCHAR, "flag" VARCHAR)
    
    //#define apk_GetAllPhotosByAlbum_action @"GetAllPhotosByAlbum"
    //AlbumID

//#define apk_albums @"apk_albums.asmx"
//#define apk_GetAlbumList_action @"GetAlbumList"
//#define apk_GetAllPhotosByAlbum_action @"GetAllPhotosByAlbum"
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_albums,apk_GetAllPhotosByAlbum_action];
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    [param setValue:_strAlbumId forKey:@"AlbumID"];
    
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
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                      [self ManageCircularList:arrResponce];
                    
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
-(void)ManageCircularList:(NSMutableArray *)arrResponce
{
    //CREATE TABLE "PhotoAlbumSaveMultipleImage" ("id" INTEGER PRIMARY KEY  NOT NULL , "AlbumJsonStr" VARCHAR, "AlbumImageStr" VARCHAR, "flag" VARCHAR)
    
    NSLog(@"response=%@",arrResponce);
    
    NSMutableArray *ary1 = [[NSMutableArray alloc]initWithArray:arrResponce];
    
    NSLog(@"array=%@",ary1);
    
    [DBOperation executeSQL:@"delete from PhotoAlbumSaveMultipleImage"];
    
    for (NSMutableDictionary *dic in arrResponce)
    {
        NSString *setImage = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Photo"]];
        
        NSArray *ary = [setImage componentsSeparatedByString:@"/"];
        
        NSString *strSaveImg = [ary lastObject];
        
        NSLog(@"data=%@",setImage);
        
        //CREATE TABLE "PhotoAlbumSaveMultipleImage" ("id" INTEGER PRIMARY KEY  NOT NULL , "AlbumJsonStr" VARCHAR, "AlbumImageStr" VARCHAR, "flag" VARCHAR)
        
        NSString *getjsonstr = [Utility Convertjsontostring:dic];
        [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO PhotoAlbumSaveMultipleImage (AlbumJsonStr,AlbumImageStr,flag) VALUES ('%@','%@','0')",getjsonstr,strSaveImg]];
    }
    NSArray *ary = [DBOperation selectData:@"select * from PhotoAlbumSaveMultipleImage"];
    aryImg = [Utility getLocalDetail:ary columnKey:@"AlbumJsonStr"];
    
    aryTemp = [DBOperation selectData:@"select id,flag,AlbumImageStr from PhotoAlbumSaveMultipleImage"];
    
    [_collectionView reloadData];
    
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
