//
//  PostDetailVC.m
//  orataro
//
//  Created by Softqube on 08/05/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "PostDetailVC.h"
#import "Global.h"


@interface PostDetailVC ()
{
    NSMutableArray *arrImagelist;
    AVPlayerViewController *playerViewController;
    
    //
    NSMutableArray *arrPopup;
}
@end

@implementation PostDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    //alloc
    arrImagelist=[[NSMutableArray alloc]init];
    playerViewController = [[AVPlayerViewController alloc] init];
    
    [self.viewVideomain setHidden:YES];
    [self.tblImageList setHidden:YES];
    [self.btnMenu setHidden:YES];
    self.tblImageList.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    NSString *FileType=[self.dicPostDetail objectForKey:@"FileType"];
    if([FileType isEqualToString:@"IMAGE"])
    {
        [self.tblImageList setHidden:NO];
        //set Header Title
        NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
        if (arr.count != 0) {
            self.lblHeaderTitle.text=[NSString stringWithFormat:@"Post Images (%@)",[arr objectAtIndex:0]];
        }
        else
        {
            self.lblHeaderTitle.text=[NSString stringWithFormat:@"Post Images"];
        }
        
        if ([Utility isInterNetConnectionIsActive] == true)
        {
            [self apiCallFor_GetPostedPics:@"1"];
        }
        else
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
    }
    else if ([FileType isEqualToString:@"VIDEO"])
    {
        [self.btnMenu setHidden:NO];
        [self.viewVideomain setHidden:NO];
        //set Header Title
        NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
        NSString *PostedOn=[self.dicPostDetail objectForKey:@"PostedOn"];
        if (arr.count != 0) {
            self.lblHeaderTitle.text=[NSString stringWithFormat:@"%@ (%@)",PostedOn,[arr objectAtIndex:0]];
        }
        else
        {
            self.lblHeaderTitle.text=[NSString stringWithFormat:@"Post"];
        }
        
        NSString *strPhoto_url=[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[self.dicPostDetail objectForKey:@"Photo"]];
        if([strPhoto_url length] != 0)
        {
            NSURL *url = [NSURL URLWithString:strPhoto_url];
            AVURLAsset *asset = [AVURLAsset assetWithURL: url];
            AVPlayerItem *item = [AVPlayerItem playerItemWithAsset: asset];
            AVPlayer * player = [[AVPlayer alloc] initWithPlayerItem: item];
            playerViewController.player = player;
            [playerViewController.view setFrame:CGRectMake(0, 0, self.viewVideoPlay.bounds.size.width, self.viewVideoPlay.bounds.size.height)];
            playerViewController.showsPlaybackControls = YES;
            [self.viewVideoPlay addSubview:playerViewController.view];
            [player play];
        }
    }
    
}

#pragma mark - apiCall

-(void)apiCallFor_GetPostedPics:(NSString *)strInternet
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_post,apk_GetPostedPics_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[self.dicPostDetail objectForKey:@"AssociationType"]] forKey:@"AssoType"];
    [param setValue:[NSString stringWithFormat:@"%@",[self.dicPostDetail objectForKey:@"AssociationID"]] forKey:@"AssoID"];
    
    if([strInternet isEqualToString:@"1"])
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
                     arrImagelist=[arrResponce mutableCopy];
                     [self.tblImageList reloadData];
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


#pragma mark - UITableview Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrImagelist count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellpostdetail"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellpostdetail"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableDictionary *dicResponce=[arrImagelist objectAtIndex:indexPath.row];
    
    UIImageView *img=(UIImageView*)[cell.contentView viewWithTag:2];
    NSString *strPost_Photo=[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[dicResponce objectForKey:@"Photo"]];
    if([[dicResponce objectForKey:@"Photo"] length] != 0)
    {
        [img sd_setImageWithURL:[NSURL URLWithString:strPost_Photo] placeholderImage:[UIImage imageNamed:@"no_img.png"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UITableViewCell* theCell = (UITableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
                UIImageView *img=(UIImageView*)[theCell.contentView viewWithTag:2];
                img.image=image;
            });
        }];
    }
    
    return cell;
}

#pragma mark - CMPopTipViewDelegate methods

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
    [arrPopup removeObject:popTipView];
}


#pragma mark - UIButton Action
- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnMenu:(id)sender
{
    [arrPopup addObject:[Utility addCell_PopupView:self.viewSave_Popup ParentView:self.view sender:sender]];
}

- (IBAction)btnSave:(id)sender
{
    [Utility dismissAllPopTipViews:arrPopup];
    NSString *strPhoto_url=[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[self.dicPostDetail objectForKey:@"Photo"]];
    if([strPhoto_url length] != 0)
    {
        [WToast showWithText:@"Start Downloding"];
        //
        NSURL *url = [NSURL URLWithString:strPhoto_url];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        // Write it to cache directory
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"file.mov"];
        [data writeToFile:path atomically:YES];
        
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library writeVideoAtPathToSavedPhotosAlbum:[NSURL fileURLWithPath:path] completionBlock:^(NSURL *assetURL, NSError *error) {
            
            if (error) {
                NSLog(@"%@", error.description);
            }else {
                NSLog(@"Done :)");
            }
            
        }];
    }
}
- (NSURL*)grabFileURL:(NSString *)fileName
{
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    documentsURL = [documentsURL URLByAppendingPathComponent:fileName];
    return documentsURL;
}
@end
