//
//  ProfileVideoVc.m
//  orataro
//
//  Created by Softqube on 23/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ProfileVideoVc.h"
#import "ProfileVideoDetailVc.h"
#import "Global.h"

@interface ProfileVideoVc ()
{
    NSMutableArray *aryVideoData,*aryTempVideo;
}
@end

@implementation ProfileVideoVc
int videocount = 1;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    aryVideoData = [[NSMutableArray alloc]init];
    aryTempVideo = [[NSMutableArray alloc]init];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.triggerVerticalOffset = 100.;
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    _collectionVideolist.bottomRefreshControl = refreshControl;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    //  CREATE TABLE "VideoList" ("id" INTEGER PRIMARY KEY  NOT NULL , "VideoJsonStr" VARCHAR, "flag" VARCHAR, "VideoThumbStr" VARCHAR, "VideoNameStr" VARCHAR)
    //select id,flag,VideoNameStr from VideoList
    
    NSArray *ary = [DBOperation selectData:@"select * from VideoList"];
    aryVideoData = [Utility getLocalDetail:ary columnKey:@"VideoJsonStr"];
    
    aryTempVideo = [DBOperation selectData:@"select id,flag,VideoNameStr from VideoList"];
    
    NSLog(@"ary=%@",aryTempVideo);
    
    [_collectionVideolist reloadData];
    
    if (aryTempVideo.count == 0)
    {
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        else
        {
            [self apiCallFor_GetVideoList:YES];
            
        }
    }
    else
    {
        if ([Utility isInterNetConnectionIsActive] == true)
        {
            [self apiCallFor_GetVideoList:NO];
        }
        else
        {
            
        }
        
        
    }
    
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


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
     return aryVideoData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellRow" forIndexPath:indexPath];
    
    
    UIView *view=(UIView *)[cell.contentView viewWithTag:0];
    [view.layer setBorderColor:[UIColor colorWithRed:84/255.0f green:84/255.0f blue:84/255.0f alpha:1.0f].CGColor];
    [view.layer setBorderWidth:1];
    [view.layer setCornerRadius:4];
    view.clipsToBounds=YES;
    
    NSDate *todayDate = [NSDate date]; //Get todays date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; // here we create NSDateFormatter object for change the Format of date.
    [dateFormatter setDateFormat:@"dd-MM-yyyy"]; //Here we can set the format which we need
    NSString *convertedDateString = [dateFormatter stringFromDate:todayDate];// Here convert date in NSString
    UILabel *lb = (UILabel *)[cell.contentView viewWithTag:1];
    lb.text = [NSString stringWithFormat:@"Date: %@",convertedDateString];
    
    NSLog(@"indexpath row=%ld",(long)indexPath.row);
    
    // UIButton *btn = (UIButton *)[cell.contentView viewWithTag:3];
    // [btn addTarget:self action:@selector(btnDownloadClicked:) forControlEvents:UIControlEventTouchUpInside];
    // btn.tag = indexPath.row;
    
    UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:2];
    
    
    NSString *documentDirectory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    //CREATE TABLE "VideoList" ("id" INTEGER PRIMARY KEY  NOT NULL , "VideoJsonStr" VARCHAR, "flag" VARCHAR, "VideoThumbStr" VARCHAR, "VideoNameStr" VARCHAR)
    
    if ([[[aryTempVideo objectAtIndex:indexPath.row]objectForKey:@"flag"] isEqualToString:@"0"])
    {
        if ([Utility isInterNetConnectionIsActive] == true)
        {
            NSLog(@"data=%@",[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[[aryVideoData objectAtIndex:indexPath.row]objectForKey:@"Photo"]]);
            
            //  [cell2 setContentMode:UIViewContentModeScaleAspectFit];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
               
                
                [DBOperation selectData:[NSString stringWithFormat:@"update VideoList set flag='1' where id=%@",[[aryTempVideo objectAtIndex:indexPath.row]objectForKey:@"id"]]];
                
                
                //no_img
                
                NSLog(@"Downloading Started");
                NSString *urlToDownload = [NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[[aryVideoData objectAtIndex:indexPath.row]objectForKey:@"Photo"]];
                
                NSURL  *url = [NSURL URLWithString:urlToDownload];
                NSData *urlData = [NSData dataWithContentsOfURL:url];
                
                img.image = [[UIImage alloc]initWithData:urlData];
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                
                NSString *setImage = [NSString stringWithFormat:@"%@",[[aryTempVideo objectAtIndex:indexPath.row]objectForKey:@"VideoNameStr"]];
                
                NSArray *ary = [setImage componentsSeparatedByString:@"/"];
                
                NSString *strSaveImg = [ary lastObject];
                
                NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
                //saving is done on main thread
                dispatch_async(dispatch_get_main_queue(), ^{
                    [urlData writeToFile:imagePath atomically:YES];
                    NSLog(@"File Saved !");
                });
                
                
            });
        }
    }
    else
    {
        //CREATE TABLE "VideoList" ("id" INTEGER PRIMARY KEY  NOT NULL , "VideoJsonStr" VARCHAR, "flag" VARCHAR, "VideoThumbStr" VARCHAR, "VideoNameStr" VARCHAR)
        
        NSLog(@"count=%lu",(unsigned long)aryTempVideo.count);
        
        NSString *setImage = [NSString stringWithFormat:@"%@",[[aryTempVideo objectAtIndex:indexPath.row]objectForKey:@"VideoNameStr"]];
        NSLog(@"image=%@",setImage);
        NSArray *ary = [setImage componentsSeparatedByString:@"/"];
        NSString *strSaveImg = [ary lastObject];
        NSString *imagePath=[documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
        UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
        
        CGDataProviderRef provider = CGImageGetDataProvider(image.CGImage);
        NSData* data = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
        
        if (data.length == 0)
        {
            
        }
        else
        {
            img.image = image;
        }
        
        
    }
    
    
    /* //  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[[aryVideoData objectAtIndex:indexPath.row]objectForKey:@"Photo"]]];
     
     //NSLog(@"data=%@",[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[[aryPhotoGet objectAtIndex:indexPath.row]objectForKey:@"Photo"]]);
     
     
     //#define apk_ImageUrl @"http://orataro.com/DataFiles"
     
     //    NSString *str = [[self.vedioArray objectAtIndex:i] valueForKey:@"vName"];
     //    NSURL *videoURL = [NSURL URLWithString:str] ;
     //    MPMoviePlayerController *player = [[[MPMoviePlayerController alloc] initWithContentURL:videoURL]autorelease];
     //    UIImage  *thumbnail = [player thumbnailImageAtTime:1.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
     //    player = nil;
     
     
     
     //CREATE TABLE "VideoList" ("id" INTEGER PRIMARY KEY  NOT NULL , "VideoJsonStr" VARCHAR, "flag" VARCHAR, "VideoThumbStr" VARCHAR, "VideoNameStr" VARCHAR)
     
     
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     NSLog(@"Downloading Started");
     NSString *urlToDownload = [NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[[aryVideoData objectAtIndex:indexPath.row]objectForKey:@"Photo"]];
     
     NSURL  *url = [NSURL URLWithString:urlToDownload];
     NSData *urlData = [NSData dataWithContentsOfURL:url];
     
     /*
     NSString *setImage = [NSString stringWithFormat:@"%@",[[aryTempGetData objectAtIndex:indexPath.row]objectForKey:@"PhotoImageStr"]];
     
     
     NSArray *ary = [setImage componentsSeparatedByString:@"/"];
     
     NSString *strSaveImg = [ary lastObject];
     
     NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
     
     NSLog(@"image Saperator=%@",[strSaveImg componentsSeparatedByString:@"."]);
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
     
     
     
     if ( urlData )
     {
     
     [DBOperation selectData:[NSString stringWithFormat:@"update VideoList set flag='1' where id=%@",[[aryVideoData objectAtIndex:indexPath.row]objectForKey:@"id"]]];
     
     NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString  *documentsDirectory = [paths objectAtIndex:0];
     
     NSString *setImage = [NSString stringWithFormat:@"%@",[[aryVideoData objectAtIndex:indexPath.row]objectForKey:@"id"]];
     
     
     NSArray *ary = [setImage componentsSeparatedByString:@"/"];
     
     NSString *strSaveImg = [ary lastObject];
     
     NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
     
     NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"thefile.mp4"];
     
     //saving is done on main thread
     dispatch_async(dispatch_get_main_queue(), ^{
     [urlData writeToFile:filePath atomically:YES];
     NSLog(@"File Saved !");
     });
     }
     
     });*/
    
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

#pragma mark - call api for get video list

-(void) apiCallFor_GetVideoList :(BOOL)checkvalue
{
    //CREATE TABLE "VideoList" ("id" INTEGER PRIMARY KEY  NOT NULL , "VideoJsonStr" VARCHAR, "flag" VARCHAR, "VideoThumbStr" VARCHAR)
    
    //#define apk_apk_Post @"apk_Post.asmx"
    // #define apk_GetPosted_FileImgaeVideos @"GetPosted_FileImgaeVideos"
    
    //WallID=3f553bdf-a302-410f-ab2f-a82bd5aca7b5
    //MemberID=f1a6d89d-37dc-499a-9476-cb83f0aba0f2
    //Count=1
    //PostFilterType=VIDEO
    
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_apk_Post,apk_GetPosted_FileImgaeVideos];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    //pagecount
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] forKey:@"WallID"];
    [param setValue:[NSString stringWithFormat:@"%d",videocount] forKey:@"Count"];
    [param setValue:@"VIDEO" forKey:@"PostFilterType"];
    
    if (checkvalue == YES)
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
                     
                     
                     //                     NSLog(@"get =%@",aryPhotoGet);
                     //
                     //                     if (isloadMore == YES)
                     //                     {
                     //                         NSMutableArray *allMyObjects = [NSMutableArray arrayWithArray: arrResponce];
                     //                         [aryPhotoGet addObjectsFromArray: allMyObjects];
                     //                         [self ManageCircularList:aryPhotoGet];
                     //                     }
                     //                     else
                     //                     {
                     //                         [self ManageCircularList:arrResponce];
                     //                     }
                     //                     [aCollectionView.bottomRefreshControl endRefreshing];
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
    
    ///Photo
    
    // CREATE TABLE "VideoList" ("id" INTEGER PRIMARY KEY  NOT NULL , "VideoJsonStr" VARCHAR, "flag" VARCHAR, "VideoThumbStr" VARCHAR, "VideoNameStr" VARCHAR)
    
    NSLog(@"response=%@",arrResponce);
    
    NSMutableArray *ary1 = [[NSMutableArray alloc]initWithArray:arrResponce];
    
    NSLog(@"array=%@",ary1);
    
    [DBOperation executeSQL:@"delete from VideoList"];
    
    for (NSMutableDictionary *dic in arrResponce)
    {
        
        NSString *setImage = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Photo"]];
        
        NSArray *ary = [setImage componentsSeparatedByString:@"/"];
        
        NSString *strSaveImg = [ary lastObject];
        
        NSLog(@"data=%@",setImage);
        
        NSString *getjsonstr = [Utility Convertjsontostring:dic];
        [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO VideoList (VideoJsonStr,VideoNameStr,flag) VALUES ('%@','%@','0')",getjsonstr,strSaveImg]];
    }
    NSArray *ary = [DBOperation selectData:@"select * from VideoList"];
    aryVideoData = [Utility getLocalDetail:ary columnKey:@"VideoJsonStr"];
    
    aryTempVideo = [DBOperation selectData:@"select id,flag,VideoNameStr from VideoList"];
    
    [_collectionVideolist reloadData];
    
}

@end
