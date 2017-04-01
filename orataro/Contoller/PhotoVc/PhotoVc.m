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
#import "Global.h"

@interface PhotoVc ()
{
    NSMutableArray *aryPhotoGet,*aryTempGetData;
}
@end

@implementation PhotoVc
@synthesize aCollectionView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    aryPhotoGet =[[NSMutableArray alloc]init];
    aryTempGetData =[[NSMutableArray alloc]init];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [aCollectionView registerNib:[UINib nibWithNibName:@"PhototableCell" bundle:nil] forCellWithReuseIdentifier:@"PhotoCell"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    NSArray *ary = [DBOperation selectData:@"select * from PhotoList"];
    aryPhotoGet = [Utility getLocalDetail:ary columnKey:@"PhotoJsonStr"];
    
    aryTempGetData = [DBOperation selectData:@"select id,flag,PhotoImageStr from PhotoList"];
    
    NSLog(@"ary=%@",aryTempGetData);
    
    [aCollectionView reloadData];
    
    if (aryTempGetData.count == 0)
    {
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        else
        {
            [self apiCallFor_GetPhotoList:YES];
            
        }
    }
    else
    {
        [self apiCallFor_GetPhotoList:NO];
        
    }
    
    
    
}
#pragma mark - COLLECTIONVIEW DELEGATE

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return aryPhotoGet.count;
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
    
    NSDate *todayDate = [NSDate date]; //Get todays date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date.
    [dateFormatter setDateFormat:@"dd-MM-yyyy"]; //Here we can set the format which we need
    NSString *convertedDateString = [dateFormatter stringFromDate:todayDate];// Here convert date in NSString
    [cell2.btnDownload addTarget:self action:@selector(btnDownloadClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell2.btnDownload.tag = indexPath.row;
    
    cell2.lbDate.text = [NSString stringWithFormat:@"Date: %@",convertedDateString];
    
    NSLog(@"ary=%@",aryPhotoGet);
    
    if ([[[aryTempGetData objectAtIndex:indexPath.row]objectForKey:@"flag"] isEqualToString:@"0"])
    {
        if ([Utility isInterNetConnectionIsActive] == true)
        {
            NSLog(@"data=%@",[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[[aryPhotoGet objectAtIndex:indexPath.row]objectForKey:@"Photo"]]);
            
            [cell2 setContentMode:UIViewContentModeScaleAspectFit];
            
            [cell2.imgShowImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[[aryPhotoGet objectAtIndex:indexPath.row]objectForKey:@"Photo"]]] placeholderImage:[UIImage imageNamed:@"no_img"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
             {
                 [DBOperation selectData:[NSString stringWithFormat:@"update PhotoList set flag='1' where id=%@",[[aryTempGetData objectAtIndex:indexPath.row]objectForKey:@"id"]]];
                 
                 NSData *imageData = UIImagePNGRepresentation(image);
                 
                 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                 NSString *documentsDirectory = [paths objectAtIndex:0];
                 
                 NSString *setImage = [NSString stringWithFormat:@"%@",[[aryTempGetData objectAtIndex:indexPath.row]objectForKey:@"ImageStr"]];
                 
                 NSArray *ary = [setImage componentsSeparatedByString:@"/"];
                 
                 NSString *strSaveImg = [ary lastObject];
                 
                 NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
                 
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
                 
             }];
            
        }
    }
    else
    {
        //fetch from local
        NSString *documentDirectory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        NSString *setImage = [NSString stringWithFormat:@"%@",[[aryTempGetData objectAtIndex:indexPath.row]objectForKey:@"PhotoImageStr"]];
        
        NSArray *ary = [setImage componentsSeparatedByString:@"/"];
        
        NSString *strSaveImg = [ary lastObject];
        
        NSString *imagePath=[documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
        UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
        
        cell2.imgShowImage.image = image;
        
    }
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
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProfilePhotoShowVc *p7 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfilePhotoShowVc"];
    [self.navigationController pushViewController:p7 animated:YES];
}


#pragma mark - button action

-(void)btnDownloadClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    // NSLog(@"get image=%@",)
    
    NSLog(@"image=%@",[[aryPhotoGet objectAtIndex:btn.tag]objectForKey:@"Photo"]);
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        if ([[[aryPhotoGet objectAtIndex:btn.tag]objectForKey:@"Photo"]count]>0)
        {
            // from local
            
            NSString *documentDirectory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            
            NSString *setImage = [NSString stringWithFormat:@"%@",[[aryTempGetData objectAtIndex:btn.tag]objectForKey:@"ImageStr"]];
            
            NSArray *ary = [setImage componentsSeparatedByString:@"/"];
            
            NSString *strSaveImg = [ary lastObject];
            
            NSString *imagePath=[documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
            UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
            
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            
            [library writeImageToSavedPhotosAlbum:[image CGImage] orientation:(ALAssetOrientation)[image imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error)
            {
                if (error)
                {
                    // TODO: error handling
                    NSLog(@"Not handle");
                }
                else
                {
                    // TODO: success handling
                    NSLog(@"Success");
                    
                }
            }];
            
            
            //
            //        cell2.imgShowImage.image = image;
            
            
        }
        else
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"sorry no image available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            
        }
    }
    else
    {
        // direct from url
        
    }
    
}
- (IBAction)BackBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - ApiCall

-(void)apiCallFor_GetPhotoList : (BOOL)checkProgress
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
    NSLog(@"response=%@",arrResponce);
    
    [DBOperation executeSQL:@"delete from PhotoList"];
    
    for (NSMutableDictionary *dic in arrResponce)
    {
        NSString *setImage = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Photo"]];
        
        NSArray *ary = [setImage componentsSeparatedByString:@"/"];
        
        NSString *strSaveImg = [ary lastObject];
        
        NSLog(@"data=%@",setImage);
        
        //CREATE TABLE "PhotoList" ("id" INTEGER PRIMARY KEY  NOT NULL , "PhotoJsonStr" VARCHAR, "ImageStr" VARCHAR, "flag" VARCHAR)
        
        NSString *getjsonstr = [Utility Convertjsontostring:dic];
        [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO PhotoList (PhotoJsonStr,PhotoImageStr,flag) VALUES ('%@','%@','0')",getjsonstr,strSaveImg]];
    }
    NSArray *ary = [DBOperation selectData:@"select * from PhotoList"];
    aryPhotoGet = [Utility getLocalDetail:ary columnKey:@"PhotoJsonStr"];
    
    aryTempGetData = [DBOperation selectData:@"select id,flag,PhotoImageStr from PhotoList"];
    
    [aCollectionView reloadData];
    
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
