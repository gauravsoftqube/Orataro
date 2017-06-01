//
//  ScoolGroupVc.m
//  orataro
//
//  Created by Softqube on 22/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ScoolGroupVc.h"
#import "CreateScoolGroupVc.h"
#import "AppDelegate.h"
#import "Global.h"

@interface ScoolGroupVc ()
{
    AppDelegate *p;
    NSMutableArray *aryFetchData,*aryTempStoreData;
    NSMutableDictionary *DicDeleteData;
}
@end

@implementation ScoolGroupVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _viewDeletePopup.hidden = YES;
    
    _imgCancel.image = [_imgCancel.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_imgCancelicon setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    p = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    _AddBtn.layer.cornerRadius = 20.0;
    
    _DeleteImageview.image = [_DeleteImageview.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_DeleteImageview setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    _DeleteImageview.contentMode = UIViewContentModeScaleAspectFit;
    
    _tblScoolGroupList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    _tblScoolGroupList.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _viewSave.layer.cornerRadius = 30.0;
    _viewInnerSave.layer.cornerRadius = 25.0;
    
    //_btnSave.layer.masksToBounds = YES;
    
    // Do any additional setup after loading the view.
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    _lbHeaderTitle.text =  [NSString stringWithFormat:@"School Group (%@)",[Utility getCurrentUserName]];
    
    //CREATE TABLE "SchoolGroupList" ("id" INTEGER PRIMARY KEY  NOT NULL , "jsonStr" VARCHAR, "ImageJsonstr" VARCHAR, "flag" VARCHAR)
    
    NSArray *ary = [DBOperation selectData:@"select * from SchoolGroupList"];
    aryFetchData = [Utility getLocalDetail:ary columnKey:@"jsonStr"];
    
    aryTempStoreData = [DBOperation selectData:@"select id,flag,ImageJsonstr from SchoolGroupList"];
    
    NSLog(@"ary=%@",aryTempStoreData);
    
    //[_tblScoolGroupList reloadData];
    
    if (aryTempStoreData.count == 0)
    {
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        else
        {
            [self apiCallFor_GetGroupList:YES];
            
        }
    }
    else
    {
        if ([Utility isInterNetConnectionIsActive] == true)
        {
            [self apiCallFor_GetGroupList:YES];
        }
        else
        {
            
        }
        
    }
    
}


#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (aryFetchData.count > 0)
    {
         return aryFetchData.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellRow"];
   
    UIView *viewBackgroundCell=(UIView *)[cell.contentView viewWithTag:11];
    
    if(indexPath.row % 2 == 0)
    {
        [viewBackgroundCell setBackgroundColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f]];
     //  [cell setBackgroundColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f]];
        
    }
    else
    {
       // [cell setBackgroundColor:[UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f]];

        
        [viewBackgroundCell setBackgroundColor:[UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f]];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    UIImageView *img1 = (UIImageView *)[cell.contentView viewWithTag:12];
    img1.image = [img1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [img1 setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    img1.contentMode = UIViewContentModeScaleAspectFit;
    
   // img1.layer.cornerRadius = 30.0;
   
    
    //UIButton *btn =(UIButton *)[cell.contentView viewWithTag:10];
    _btnSave.tag = indexPath.row;
    
   // btn.tag = indexPath.row;
    
    UIImageView *img2 = (UIImageView *)[cell.contentView viewWithTag:5];
   
    img2.layer.masksToBounds = YES;
    
    
    UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:1];
    img.contentMode = UIViewContentModeScaleAspectFit;
    img.layer.cornerRadius = 30.0;
    img.layer.masksToBounds = YES;
    img.layer.borderWidth = 2.0;
    img.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    if (aryFetchData.count > 0)
    {
        UILabel *lb= (UILabel *)[cell.contentView viewWithTag:2];
        lb.text = [[aryFetchData objectAtIndex:indexPath.row]objectForKey:@"GroupTitle"];
        
        
        UILabel *lb1= (UILabel *)[cell.contentView viewWithTag:3];
        lb1.text = [[aryFetchData objectAtIndex:indexPath.row]objectForKey:@"AboutGroup"];
        
        NSLog(@"ary=%@",aryFetchData);
        NSLog(@"ary1=%@",aryTempStoreData);
        
        // CREATE TABLE "SchoolGroupList" ("id" INTEGER PRIMARY KEY  NOT NULL , "jsonStr" VARCHAR, "ImageJsonstr" VARCHAR, "flag" VARCHAR)
        
        //UserID=30032284-31d1-4ba6-8ef4-54edb8e223aa
        //ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
        //InstituteID=4f4bbf0e-858a-46fa-a0a7-bf116f537653
        
        //#define apk_group @"apk_group.asmx"
        //#define apk_Group_List_action @"Group_List"
        
        NSString *documentDirectory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        if ([[[aryTempStoreData objectAtIndex:indexPath.row]objectForKey:@"flag"] isEqualToString:@"0"])
        {
            if ([Utility isInterNetConnectionIsActive] == true)
            {
               // NSLog(@"data=%@",[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[[aryFetchData objectAtIndex:indexPath.row]objectForKey:@"GroupImage"]]);
                
                // [cell2 setContentMode:UIViewContentModeScaleAspectFit];
                
               // NSLog(@"url=%@",[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[[aryFetchData objectAtIndex:indexPath.row]objectForKey:@"GroupImage"]]]);
                
                [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[[aryFetchData objectAtIndex:indexPath.row]objectForKey:@"GroupImage"]]] placeholderImage:[UIImage imageNamed:@"no_img"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
                 {
                     // CREATE TABLE "SchoolGroupList" ("id" INTEGER PRIMARY KEY  NOT NULL , "jsonStr" VARCHAR, "ImageJsonstr" VARCHAR, "flag" VARCHAR)
                     img.image = image;
                     
                     [DBOperation selectData:[NSString stringWithFormat:@"update SchoolGroupList set flag='1' where id=%@",[[aryTempStoreData objectAtIndex:indexPath.row]objectForKey:@"id"]]];
                     
                     //no_img
                     
                     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                     NSString *documentsDirectory = [paths objectAtIndex:0];
                     
                     NSString *setImage = [NSString stringWithFormat:@"%@",[[aryTempStoreData objectAtIndex:indexPath.row]objectForKey:@"ImageJsonstr"]];
                     
                     NSArray *ary = [setImage componentsSeparatedByString:@"/"];
                     
                     NSString *strSaveImg = [ary lastObject];
                     
                     NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
                     
                     NSLog(@"image Saperator=%@",[strSaveImg componentsSeparatedByString:@"."]);
                     
                     if (strSaveImg == (id)[NSNull null] || strSaveImg.length == 0 || [strSaveImg isEqualToString:@"<null>"])
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

                         
                        /* NSArray *getExtension = [strSaveImg componentsSeparatedByString:@"."];
                         
                         if ([[getExtension objectAtIndex:1] isEqualToString:@"jpg"] || [[getExtension objectAtIndex:1] isEqualToString:@"JPG"] ||
                             [[getExtension objectAtIndex:1] isEqualToString:@"jpeg"] || [[getExtension objectAtIndex:1] isEqualToString:@"png"] )
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
                             
                         }*/
                         //jpg
                         
                     }
                     //JPG
                     //png
                     //jpeg
                     
                     
                     
                 }];
                
                
                //[cell2.activityIndicator startAnimating];
                // [activityIndicator ];
                
            }
        }
        else
        {
            //CREATE TABLE "SchoolGroupList" ("id" INTEGER PRIMARY KEY  NOT NULL , "jsonStr" VARCHAR, "ImageJsonstr" VARCHAR, "flag" VARCHAR)
            
            NSLog(@"count=%lu",(unsigned long)aryTempStoreData.count);
            
            //  [cell2.activityIndicator stopAnimating];
            // cell2.activityIndicator.hidden = YES;
            
            NSString *setImage = [NSString stringWithFormat:@"%@",[[aryTempStoreData objectAtIndex:indexPath.row]objectForKey:@"ImageJsonstr"]];
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
                img.image = [UIImage imageNamed:@"no_img"];
            }
            else
            {
                img.image = image;
            }
            
            NSLog(@"image=%@",aryFetchData);
            
        }

    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"])
    {
        if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
            {
                if([[Utility getUserRoleRightList:@"Group" settingType:@"IsEdit"] integerValue] == 1)
                {
                    if ([Utility isInterNetConnectionIsActive] == false)
                    {
                        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alrt show];
                        return;
                    }
                    p.scoolgroup = 2;
                    CreateScoolGroupVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateScoolGroupVc"];
                    vc.dicCreateSchoolGroup = [aryFetchData objectAtIndex:indexPath.row];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else
                {
                    [WToast showWithText:You_dont_have_permission];
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
                p.scoolgroup = 2;
                CreateScoolGroupVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateScoolGroupVc"];
                vc.dicCreateSchoolGroup = [aryFetchData objectAtIndex:indexPath.row];
                [self.navigationController pushViewController:vc animated:YES];
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
            p.scoolgroup = 2;
            CreateScoolGroupVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateScoolGroupVc"];
            vc.dicCreateSchoolGroup = [aryFetchData objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
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
        p.scoolgroup = 2;
        CreateScoolGroupVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateScoolGroupVc"];
        vc.dicCreateSchoolGroup = [aryFetchData objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)btnDeleteGroup:(id)sender
{
    //CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblScoolGroupList];
    //NSIndexPath *indexPath = [self.tblScoolGroupList indexPathForRowAtPoint:buttonPosition];
    
    _viewDeletePopup.hidden = NO;
    [self.view bringSubviewToFront:_viewDeletePopup];
}


#pragma mark - UIButton Action

- (IBAction)btnSaveClicked:(id)sender
{
}

- (IBAction)btnSave1Clicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblScoolGroupList];
    NSIndexPath *indexPath = [self.tblScoolGroupList indexPathForRowAtPoint:buttonPosition];
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    else
    {
          _viewDeletePopup.hidden = YES;
        

        
        NSLog(@"Data=%@",DicDeleteData);
        
      //  NSLog(@"Data=%@",[aryFetchData objectAtIndex:indexPath.row]);
        
       // NSLog(@"Fetch=%@",[[aryFetchData objectAtIndex:indexPath.row]objectForKey:@"GropuID"]);
        
        [self apiCallFor_DeleteGroupList:[DicDeleteData objectForKey:@"GropuID"] row:[[NSString stringWithFormat:@"%ld",btn.tag] intValue]];

        [self apiCallFor_DeleteGroupList:[[aryFetchData objectAtIndex:indexPath.row]objectForKey:@"GropuID"] row:[[NSString stringWithFormat:@"%ld",(long)btn.tag] intValue]];
    }

}

- (IBAction)btnCancelClicked:(id)sender
{
    _viewDeletePopup.hidden = YES;
}

- (IBAction)DeleteBtnClicked:(id)sender
{

    _viewDeletePopup.hidden = NO;
    [self.view bringSubviewToFront:_viewDeletePopup];
    
   // UIButton *btn = (UIButton *)sender;
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblScoolGroupList];
    NSIndexPath *indexPath = [self.tblScoolGroupList indexPathForRowAtPoint:buttonPosition];
    
    
    DicDeleteData = [aryFetchData objectAtIndex:indexPath.row];
    //DicDeleteData
    

    if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"])
    {
        if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
            {
                if([[Utility getUserRoleRightList:@"Group" settingType:@"IsDelete"] integerValue] == 1)
                {
                    _viewDeletePopup.hidden = NO;
                    [self.view bringSubviewToFront:_viewDeletePopup];
                }
                else
                {
                    [WToast showWithText:You_dont_have_permission];
                }
            }
            else
            {
                _viewDeletePopup.hidden = NO;
                [self.view bringSubviewToFront:_viewDeletePopup];
            }
        }
        else
        {
            _viewDeletePopup.hidden = NO;
            [self.view bringSubviewToFront:_viewDeletePopup];
        }
    }
    else
    {
        _viewDeletePopup.hidden = NO;
        [self.view bringSubviewToFront:_viewDeletePopup];
    }

}

- (IBAction)btnBackHeader:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnCreateGroup:(id)sender {
}

- (IBAction)AddBtnClicked:(UIButton *)sender
{
    if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"])
    {
        if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
            {
                if([[Utility getUserRoleRightList:@"Group" settingType:@"IsCreate"] integerValue] == 1)
                {
                    if ([Utility isInterNetConnectionIsActive] == false)
                    {
                        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alrt show];
                        return;
                    }
                    p.scoolgroup = 1;
                    CreateScoolGroupVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateScoolGroupVc"];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else
                {
                    [WToast showWithText:You_dont_have_permission];
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
                p.scoolgroup = 1;
                CreateScoolGroupVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateScoolGroupVc"];
                [self.navigationController pushViewController:vc animated:YES];
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
            p.scoolgroup = 1;
            CreateScoolGroupVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateScoolGroupVc"];
            [self.navigationController pushViewController:vc animated:YES];
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
        p.scoolgroup = 1;
        CreateScoolGroupVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateScoolGroupVc"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -API Call Get Group data


-(void)apiCallFor_GetGroupList : (BOOL)CheckValue
{
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_group,apk_Group_List_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    // CREATE TABLE "SchoolGroupList" ("id" INTEGER PRIMARY KEY  NOT NULL , "jsonStr" VARCHAR, "ImageJsonstr" VARCHAR, "flag" VARCHAR)
    
    //UserID=30032284-31d1-4ba6-8ef4-54edb8e223aa
    //ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
    //InstituteID=4f4bbf0e-858a-46fa-a0a7-bf116f537653
    
    //#define apk_group @"apk_group.asmx"
    //#define apk_Group_List_action @"Group_List"
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    // [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    
    if (CheckValue == YES)
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
                     
                    [aryFetchData removeAllObjects];
                      [aryTempStoreData removeAllObjects];
                      [_tblScoolGroupList reloadData];
                     
                     //[self ManageCircularList:arrResponce];
                     
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
    aryFetchData = [[NSMutableArray alloc]init];
    aryTempStoreData = [[NSMutableArray alloc]init];
    
    NSLog(@"response=%@",arrResponce);
    
    //UserID=30032284-31d1-4ba6-8ef4-54edb8e223aa
    //ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
    //InstituteID=4f4bbf0e-858a-46fa-a0a7-bf116f537653
    
    // CREATE TABLE "SchoolGroupList" ("id" INTEGER PRIMARY KEY  NOT NULL , "jsonStr" VARCHAR, "ImageJsonstr" VARCHAR, "flag" VARCHAR)
    
    //UserID=30032284-31d1-4ba6-8ef4-54edb8e223aa
    //ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
    //InstituteID=4f4bbf0e-858a-46fa-a0a7-bf116f537653
    
    //#define apk_group @"apk_group.asmx"
    //#define apk_Group_List_action @"Group_List"
    
    NSMutableArray *ary1 = [[NSMutableArray alloc]initWithArray:arrResponce];
    
    NSLog(@"array=%@",ary1);
    
    [DBOperation executeSQL:@"delete from SchoolGroupList"];
    
    for (NSMutableDictionary *dic in arrResponce)
    {
        NSString *setImage = [NSString stringWithFormat:@"%@",[dic objectForKey:@"GroupImage"]];
        
        NSArray *ary = [setImage componentsSeparatedByString:@"/"];
        
        NSString *strSaveImg = [ary lastObject];
        
        // CREATE TABLE "SchoolGroupList" ("id" INTEGER PRIMARY KEY  NOT NULL , "jsonStr" VARCHAR, "ImageJsonstr" VARCHAR, "flag" VARCHAR)
        
        NSString *getjsonstr = [Utility Convertjsontostring:dic];
        
        [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO SchoolGroupList (jsonStr,ImageJsonstr,flag) VALUES ('%@','%@','0')",getjsonstr,strSaveImg]];
    }
    NSArray *ary = [DBOperation selectData:@"select * from SchoolGroupList"];
    aryFetchData = [Utility getLocalDetail:ary columnKey:@"jsonStr"];
    
    aryTempStoreData = [DBOperation selectData:@"select id,flag,ImageJsonstr from SchoolGroupList"];
    

    [_tblScoolGroupList reloadData];
}

#pragma mark - Delete Group API
-(void)apiCallFor_DeleteGroupList : (NSString *)groupId  row:(int)row
{
    //#define apk_group @"apk_group.asmx"
    //#define apk_Group_List_action @"Group_List"
    //#define apk_Remove_Group_action @"Remove_Group"
    
    //UserID=30032284-31d1-4ba6-8ef4-54edb8e223aa
    //ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
    //InstituteID=4f4bbf0e-858a-46fa-a0a7-bf116f537653
    //GroupID=4321a357-1c4a-429e-b803-fe4989abf59c
    
    NSLog(@"Row=%d",row);
    NSLog(@"Group id=%@",groupId);
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_group,apk_Remove_Group_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:groupId forKey:@"GroupID"];
    
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
                 if([strStatus isEqualToString:@"Group Removed"])
                 {
                        [self apiCallFor_GetGroupList:YES];
                     
                 }
                 else
                 {
                     
                     
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
@end
