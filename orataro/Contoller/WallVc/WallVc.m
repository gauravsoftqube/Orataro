//
//  WallVc.m
//  orataro
//
//  Created by harikrishna patel on 27/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "WallVc.h"
#import "WallCustomeCell.h"
#import "AddpostVc.h"
#import "OrataroVc.h"
#import "AppDelegate.h"
#import "Global.h"

@interface WallVc ()
{
    AppDelegate *app;
    NSMutableArray *arrGeneralWall;
    NSMutableArray *arrSpecialFriendList,*arrSelected_SpecialFriendList,*arrSpecialFriendListMain;
    long totalCountView,countResponce;
    
    NSMutableArray *arrPopup;
    NSMutableDictionary *dicSelect_SharePopup;
    NSTimer *timerLocalPostDB;
    
    NSMutableArray *arrPostLocalDB_ResponceImagePath;
    
    NSMutableArray *arrWallMemberList;
}
@end

@implementation WallVc
@synthesize aWallTableView,aTableHeaderView;
static NSString *CellIdentifier = @"WallCustomeCell";
int c2= 0;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* // Set vertical effect
     UIInterpolatingMotionEffect *verticalMotionEffect =
     [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.y"
     type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
     verticalMotionEffect.minimumRelativeValue = @(-10);
     verticalMotionEffect.maximumRelativeValue = @(10);
     
     // Set horizontal effect
     UIInterpolatingMotionEffect *horizontalMotionEffect =
     [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.x"
     type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
     horizontalMotionEffect.minimumRelativeValue = @(-10);
     horizontalMotionEffect.maximumRelativeValue = @(10);*/
    
    // Create group to combine both
    // UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    // group.motionEffects = @[verticalMotionEffect];
    
    // Add both effects to your view
    // [aWallTableView addMotionEffect:group];
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //self.automaticallyAdjustsScrollViewInsets = NO;
    [aWallTableView registerNib:[UINib nibWithNibName:@"WallCustomeCell" bundle:nil] forCellReuseIdentifier:@"WallCustomeCell"];
    aWallTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    aWallTableView.tableHeaderView = aTableHeaderView;
    //aWallTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    //ShowWall
    [self commonData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)commonData
{
    //alloc array
    // arrGeneralWall = [[NSMutableArray alloc] init];
    totalCountView=1;
    
    
    [self.viewSpecialFriends_Popup setHidden:YES];
    [self.viewWallMember setHidden:YES];
    [self.lblNoWallDataAvailable setHidden:YES];
    self.tblSpecialFriendsList.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tblWallMemberList.separatorStyle=UITableViewCellSeparatorStyleNone;

    //set search
    //[Utility SearchTextView:self.viewSearch_SpecialFriends];
    [self SearchTextView:self.viewSearch_SpecialFriends];
    
    //Pull Refresh
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    UITableViewController *tableViewController = [[UITableViewController alloc] init];
    tableViewController.tableView = self.aWallTableView;
    tableViewController.refreshControl = refreshControl;
    [refreshControl endRefreshing];
    
    //
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    spinner.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 44);
    self.aWallTableView.tableFooterView = spinner;
    
    [self.aWallTableView.refreshControl endRefreshing];
    [self.aWallTableView.tableFooterView setHidden:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    // downarrow
    if ([_checkscreen isEqualToString:@"Institute"])
    {
        [_MenuBtn setBackgroundImage:[UIImage imageNamed:@"downarrow"] forState:UIControlStateNormal];
        [_HomeBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        self.btnWallMember.hidden =YES;
        
        //set Header Title
        self.lblheaderTitle.text=[NSString stringWithFormat:@"Institute"];
    }
    else if([_checkscreen isEqualToString:@"Standard"])
    {
        [_MenuBtn setBackgroundImage:[UIImage imageNamed:@"downarrow"] forState:UIControlStateNormal];
        [_HomeBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        self.btnWallMember.hidden =YES;
       
        NSString *strWallName=[self.dicSelect_std_divi_sub objectForKey:@"WallName"];
        //set Header Title
        if ([strWallName length] != 0)
        {
            self.lblheaderTitle.text=[NSString stringWithFormat:@"Standard (%@)",strWallName];
        }
        else
        {
            self.lblheaderTitle.text=[NSString stringWithFormat:@"Standard"];
        }

    }
    else if ([_checkscreen isEqualToString:@"Division"])
    {
        [_MenuBtn setBackgroundImage:[UIImage imageNamed:@"downarrow"] forState:UIControlStateNormal];
        [_HomeBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        self.btnWallMember.hidden =YES;
        NSString *strWallName=[self.dicSelect_std_divi_sub objectForKey:@"WallName"];
        //set Header Title
        if ([strWallName length] != 0)
        {
            self.lblheaderTitle.text=[NSString stringWithFormat:@"Division (%@)",strWallName];
        }
        else
        {
            self.lblheaderTitle.text=[NSString stringWithFormat:@"Division"];
        }
    }
    else if ([_checkscreen isEqualToString:@"Subject"])
    {
        [_MenuBtn setBackgroundImage:[UIImage imageNamed:@"downarrow"] forState:UIControlStateNormal];
        [_HomeBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        self.btnWallMember.hidden =YES;
       
        NSString *strWallName=[self.dicSelect_std_divi_sub objectForKey:@"WallName"];
        //set Header Title
        if ([strWallName length] != 0)
        {
            self.lblheaderTitle.text=[NSString stringWithFormat:@"Subject (%@)",strWallName];
        }
        else
        {
            self.lblheaderTitle.text=[NSString stringWithFormat:@"Subject"];
        }
    }
    else
    {
        [_MenuBtn setBackgroundImage:[UIImage imageNamed:@"ic_sort_white"] forState:UIControlStateNormal];
        [_HomeBtn setBackgroundImage:[UIImage imageNamed:@"dash_home"] forState:UIControlStateNormal];
        self.btnWallMember.hidden =NO;
        
        //set Header Title
        NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
        if (arr.count != 0)
        {
            self.lblheaderTitle.text=[NSString stringWithFormat:@"Wall (%@)",[arr objectAtIndex:0]];
        }
        else
        {
            self.lblheaderTitle.text=[NSString stringWithFormat:@"Wall"];
        }
    }
    [self getCurrentUserImage:[Utility getCurrentUserDetail]];
    //set timer post through local db
    timerLocalPostDB = [NSTimer scheduledTimerWithTimeInterval:40 target:self selector:@selector(timerCalled_localPostDB) userInfo:nil repeats:NO];
    arrPostLocalDB_ResponceImagePath = [[NSMutableArray alloc]init];
    
    [self apiCallMethod];
}

-(void)refreshData
{
    [self apiCallMethod];
}

-(void)apiCallMethod
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        arrGeneralWall = [[NSMutableArray alloc]init];
        if ([_checkscreen isEqualToString:@"Institute"])
        {
            arrGeneralWall = [DBOperation selectData:@"select * from InstituteWall"];
            countResponce = [arrGeneralWall count];
        }
        else if ([_checkscreen isEqualToString:@"Standard"])
        {
            NSString *strWallId=[NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]];
            
            arrGeneralWall = [DBOperation selectData:[NSString stringWithFormat:@"select * from StandardWall where WallID ='%@'",strWallId]];
            countResponce = [arrGeneralWall count];
        }
        else if ([_checkscreen isEqualToString:@"Division"])
        {
            NSString *strWallId=[NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]];
            arrGeneralWall = [DBOperation selectData:[NSString stringWithFormat:@"select * from DivisionWall where WallID ='%@'",strWallId]];
            countResponce = [arrGeneralWall count];
        }
        else if ([_checkscreen isEqualToString:@"Subject"])
        {
            NSString *strWallId=[NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]];
            arrGeneralWall = [DBOperation selectData:[NSString stringWithFormat:@"select * from SubjectWall where WallID ='%@'",strWallId]];
            countResponce = [arrGeneralWall count];
        }
        else
        {
            arrGeneralWall = [DBOperation selectData:@"select * from GeneralWall"];
            countResponce = [arrGeneralWall count];
        }
        
        NSSortDescriptor *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"TempDate" ascending:NO];
        NSArray *sortedArray3 = [arrGeneralWall sortedArrayUsingDescriptors:@[brandDescriptor]];
        arrGeneralWall=[[NSMutableArray alloc]init];
        arrGeneralWall=[sortedArray3 mutableCopy];
        
        [self.aWallTableView reloadData];
        
        if(arrGeneralWall.count == 0)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
    }
    else
    {
        arrGeneralWall = [[NSMutableArray alloc]init];
        if ([_checkscreen isEqualToString:@"Institute"])
        {
            arrGeneralWall = [DBOperation selectData:@"select * from InstituteWall"];
            countResponce = [arrGeneralWall count];
        }
        else if ([_checkscreen isEqualToString:@"Standard"])
        {
            NSString *strWallId=[NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]];
            
            arrGeneralWall = [DBOperation selectData:[NSString stringWithFormat:@"select * from StandardWall where WallID ='%@'",strWallId]];
            countResponce = [arrGeneralWall count];
        }
        else if ([_checkscreen isEqualToString:@"Division"])
        {
            NSString *strWallId=[NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]];
            arrGeneralWall = [DBOperation selectData:[NSString stringWithFormat:@"select * from DivisionWall where WallID ='%@'",strWallId]];
            countResponce = [arrGeneralWall count];
        }
        else if ([_checkscreen isEqualToString:@"Subject"])
        {
            NSString *strWallId=[NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]];
            arrGeneralWall = [DBOperation selectData:[NSString stringWithFormat:@"select * from SubjectWall where WallID ='%@'",strWallId]];
            countResponce = [arrGeneralWall count];
        }
        else
        {
            arrGeneralWall = [DBOperation selectData:@"select * from GeneralWall"];
            countResponce = [arrGeneralWall count];
        }
        NSSortDescriptor *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"TempDate" ascending:NO];
        NSArray *sortedArray3 = [arrGeneralWall sortedArrayUsingDescriptors:@[brandDescriptor]];
        arrGeneralWall=[[NSMutableArray alloc]init];
        arrGeneralWall=[sortedArray3 mutableCopy];
        
        [self.aWallTableView reloadData];
        
        if(arrGeneralWall.count == 0)
        {
            [self apiCallFor_GetGeneralWallData:@"1"];
        }
        else
        {
            [self apiCallFor_GetGeneralWallData:@"0"];
        }
    }
}

-(void)SearchTextView: (UIView *)viewSearch
{
    //Bottom border self.view.frame.size.width
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, viewSearch.frame.size.height - 1, [UIScreen mainScreen].bounds.size.width - 66, 1.0f);
    bottomBorder.shadowColor = [UIColor grayColor].CGColor;
    bottomBorder.shadowOffset = CGSizeMake(1, 1);
    bottomBorder.shadowOpacity = 1;
    bottomBorder.shadowRadius = 1.0;
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [viewSearch.layer addSublayer:bottomBorder];
    
    //left border
    CALayer *leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(0.0f, 30.0f, 1.0f, viewSearch.frame.size.height-30);
    leftBorder.shadowColor = [UIColor grayColor].CGColor;
    leftBorder.shadowOffset = CGSizeMake(1, 1);
    leftBorder.shadowOpacity = 1;
    leftBorder.shadowRadius = 1.0;
    leftBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [viewSearch.layer addSublayer:leftBorder];
    
    //right border
    CALayer *rightBorder = [CALayer layer];
    rightBorder.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-66, 30.0f, 1.0f, viewSearch.frame.size.height-30);
    rightBorder.shadowColor = [UIColor grayColor].CGColor;
    rightBorder.shadowOffset = CGSizeMake(1, 1);
    rightBorder.shadowOpacity = 1;
    rightBorder.shadowRadius = 1.0;
    rightBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [viewSearch.layer addSublayer:rightBorder];
}

-(void)getCurrentUserImage :(NSMutableDictionary *)dic
{
    if ([Utility isInterNetConnectionIsActive] == true)
    {
        NSString *strURLForTeacherProfilePicture=[NSString stringWithFormat:@"%@",[dic objectForKey:@"ProfilePicture"]];
        if(![strURLForTeacherProfilePicture isKindOfClass:[NSNull class]])
        {
            strURLForTeacherProfilePicture=[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[dic objectForKey:@"ProfilePicture"]];
            NSURL *imageURL = [NSURL URLWithString:strURLForTeacherProfilePicture];
            [self.imgUser_Tbl_HeaderView sd_setImageWithURL:imageURL];
            //[ProgressHUB showHUDAddedTo:self.view];
           /* dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                           ^{
                               dispatch_sync(dispatch_get_main_queue(), ^{
                                //   [ProgressHUB hideenHUDAddedTo:self.view];
                                   NSURL *imageURL = [NSURL URLWithString:strURLForTeacherProfilePicture];
                                   NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                                   
                                   UIImage *img = [UIImage imageWithData:imageData];
                                   if (img != nil)
                                   {
                                       self.imgUser_Tbl_HeaderView.image = [UIImage imageWithData:imageData];
                                   }
                                   else
                                   {
                                       self.imgUser_Tbl_HeaderView.image = [UIImage imageNamed:@"user"];
                                   }
                                   
                               });
                           });*/
        }
    }
}

#pragma mark - timer post background through localdb

-(void)timerCalled_localPostDB
{
    if ([Utility isInterNetConnectionIsActive] == true)
    {
        [timerLocalPostDB invalidate];
        timerLocalPostDB=nil;
        NSMutableArray *arrPost_LocalDB=[DBOperation selectData:[NSString stringWithFormat:@"select * from newPost"]];
        for (NSMutableDictionary *dic in arrPost_LocalDB)
        {
            NSString *FileType=[dic objectForKey:@"FileType"];
            if([FileType isEqualToString:@"IMAGE"])
            {
                [self get_ImageIn_LocalDB:dic];
            }
            else if([FileType isEqualToString:@"VIDEO"])
            {
                [self get_VideoIn_LocalDB:dic];
            }
            else if([FileType isEqualToString:@"Text"])
            {
                [self get_TextIn_LocalDB:dic];
            }
        }
    }
}

-(void)get_ImageIn_LocalDB : (NSMutableDictionary *)dicPost_LocalDB
{
    NSString *ImagePath=[dicPost_LocalDB objectForKey:@"ImagePath"];
    NSArray *arrImagePath=[ImagePath componentsSeparatedByString:@","];
    NSMutableArray *arrPost_LocalDB=[[NSMutableArray alloc]init];
    for (NSString *strImgName in arrImagePath)
    {
        NSString *fileName = [NSString stringWithFormat:@"%@",strImgName];
        NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *path = [arrayPaths objectAtIndex:0];
        NSString *pdfFileName = [path stringByAppendingPathComponent:fileName];
        UIImage *image1=[UIImage imageWithContentsOfFile:pdfFileName];
        [arrPost_LocalDB addObject:image1];
    }
    
    for (UIImage *img in arrPost_LocalDB)
    {
        [self apiCallFor_UploadFile:@"1" FileType:@"IMAGE" FileName:[NSString stringWithFormat:@"%@.png",[Utility randomImageGenerator]] imageSelect:img arrPost_LocalDB:arrPost_LocalDB dicPost_LocalDB:dicPost_LocalDB videoURL:nil];
    }
    
}

-(void)get_VideoIn_LocalDB : (NSMutableDictionary *)dicPost_LocalDB
{
    NSString *ImagePath=[dicPost_LocalDB objectForKey:@"ImagePath"];
    NSArray *arrImagePath=[ImagePath componentsSeparatedByString:@","];
    NSMutableArray *arrPost_LocalDB=[[NSMutableArray alloc]init];
    for (NSString *strImgName in arrImagePath)
    {
        NSString *fileName = [NSString stringWithFormat:@"%@",strImgName];
       
        [arrPost_LocalDB addObject:fileName];
    }
    
    for (NSString *strVideoName in arrPost_LocalDB)
    {
        [self apiCallFor_UploadFile:@"1" FileType:@"VIDEO" FileName:[NSString stringWithFormat:@"%@.mp4",[Utility randomImageGenerator]] imageSelect:nil arrPost_LocalDB:arrPost_LocalDB dicPost_LocalDB:dicPost_LocalDB videoURL:strVideoName];
    }

}

-(void)get_TextIn_LocalDB : (NSMutableDictionary *)dicPost_LocalDB
{
      [self apiCallFor_newPost:@"1" FileType:@"Text" dicPost_LocalDB:dicPost_LocalDB];
}

-(void)apiCallFor_UploadFile:(NSString *)strInternet FileType:(NSString *)FileType FileName:(NSString *)FileName imageSelect:(UIImage*)imageSelect arrPost_LocalDB:(NSMutableArray *)arrPost_LocalDB dicPost_LocalDB:(NSMutableDictionary*)dicPost_LocalDB videoURL:(NSString *)strvideoURL
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_post,apk_UploadFile_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",FileName] forKey:@"FileName"];
    
    if([FileType isEqualToString:@"IMAGE"])
    {
        NSData *data = UIImagePNGRepresentation(imageSelect);
        const unsigned char *bytes = [data bytes];
        NSUInteger length = [data length];
        NSMutableArray *byteArray = [NSMutableArray array];
        for (NSUInteger i = 0; i < length; i++)
        {
            [byteArray addObject:[NSNumber numberWithUnsignedChar:bytes[i]]];
        }
        [param setValue:byteArray forKey:@"File"];
    }
    if([FileType isEqualToString:@"VIDEO"])
    {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectoryPath = [paths objectAtIndex:0];
        
        NSURL *videoNSURL = [NSURL fileURLWithPath:[documentsDirectoryPath stringByAppendingPathComponent:strvideoURL]];
        NSData *data = [NSData dataWithContentsOfURL:videoNSURL];
        
        const unsigned char *bytes = [data bytes];
        NSUInteger length = [data length];
        NSMutableArray *byteArray = [NSMutableArray array];
        for (NSUInteger i = 0; i < length; i++)
        {
            [byteArray addObject:[NSNumber numberWithUnsignedChar:bytes[i]]];
        }
        [param setValue:byteArray forKey:@"File"];
    }
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",FileType] forKey:@"FileType"];
    
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
                     //                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     //                     [alrt show];
                 }
                 else
                 {
                     NSString *message=[dic objectForKey:@"message"];
                     NSArray *arrMessage=[message componentsSeparatedByString:@" "];
                     if([arrMessage count] > 0)
                     {
                         message=[arrMessage objectAtIndex:1];
                     }
                     [arrPostLocalDB_ResponceImagePath addObject:message];
                     
                     if([FileType isEqualToString:@"IMAGE"])
                     {
                         if([arrPost_LocalDB count] == [arrPostLocalDB_ResponceImagePath count])
                         {
                             [self apiCallFor_newPost:@"1" FileType:@"IMAGE" dicPost_LocalDB:dicPost_LocalDB];
                         }
                     }
                     else if([FileType isEqualToString:@"VIDEO"])
                     {
                         if([arrPost_LocalDB count] == [arrPostLocalDB_ResponceImagePath count])
                         {
                             [self apiCallFor_newPost:@"1" FileType:@"VIDEO" dicPost_LocalDB:dicPost_LocalDB];
                         }
                     }
                     
                 }
             }
             else
             {
                 //                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 //                 [alrt show];
             }
         }
         else
         {
             //             UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             //             [alrt show];
         }
     }];
    
}

-(void)apiCallFor_newPost:(NSString *)strInternet FileType:(NSString *)FileType dicPost_LocalDB:(NSMutableDictionary*)dicPost_LocalDB
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    NSString *strTO=[dicPost_LocalDB objectForKey:@"PostShareType"];
    NSString *strPostCommentNote=[dicPost_LocalDB objectForKey:@"PostCommentNote"];
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_post,apk_Post_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] forKey:@"WallID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@""] forKey:@"BeachID"];
    
    if([strTO isEqualToString:@"Friends"])
    {
        [param setValue:[NSString stringWithFormat:@"Friend"] forKey:@"PostShareType"];
    }
    else if([strTO isEqualToString:@"Public"])
    {
        [param setValue:[NSString stringWithFormat:@"Public"] forKey:@"PostShareType"];
    }
    else if([strTO isEqualToString:@"Only Me"])
    {
        [param setValue:[NSString stringWithFormat:@"Only Me"] forKey:@"PostShareType"];
    }
    
    [param setValue:[NSString stringWithFormat:@"%@",strPostCommentNote] forKey:@"PostCommentNote"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"PostByType"]] forKey:@"PostByType"];
    
    if([FileType isEqualToString:@"Text"])
    {
        [param setValue:[NSString stringWithFormat:@""] forKey:@"ImagePath"];
    }
    else
    {
        NSString *ImagePath=[arrPostLocalDB_ResponceImagePath componentsJoinedByString:@","];
        [param setValue:[NSString stringWithFormat:@"%@",ImagePath] forKey:@"ImagePath"];
    }
    
    
    [param setValue:[NSString stringWithFormat:@"%@",FileType] forKey:@"FileType"];
    
    [param setValue:[NSString stringWithFormat:@"%@",FileType] forKey:@"FileMineType"];
    
    [param setValue:[NSString stringWithFormat:@"true"] forKey:@"approved"];
    
    
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
                     //                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     //                     [alrt show];
                 }
                 else if([strStatus isEqualToString:@"Post Added successfully."])
                 {
                     NSString *strID=[dicPost_LocalDB objectForKey:@"id"];
                     [DBOperation executeSQL:[NSString stringWithFormat:@"delete from newPost where id='%@'",strID]];
                     [self apiCallMethod];
                     //                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     //                     [alrt show];
                 }
             }
             else
             {
                 //                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 //                 [alrt show];
             }
         }
         else
         {
             //             UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             //             [alrt show];
         }
     }];
    
}

#pragma mark - apiCall GetWallMember

-(void)apiCallFor_GetWallMember:(NSString *)strInternet
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_generalwall,apk_GetWallMember_action];;
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
  
    if ([_checkscreen isEqualToString:@"Institute"])
    {
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstitutionWallID"]] forKey:@"WallID"];
    }
    else if ([_checkscreen isEqualToString:@"Standard"])
    {
        [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]] forKey:@"WallID"];
    }
    else if ([_checkscreen isEqualToString:@"Division"])
    {
        [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]] forKey:@"WallID"];
    }
    else if ([_checkscreen isEqualToString:@"Subject"])
    {
        [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]] forKey:@"WallID"];
    }
    else
    {
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] forKey:@"WallID"];
    }
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    
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
                     arrWallMemberList=[[NSMutableArray alloc]init];
                     arrWallMemberList = [arrResponce mutableCopy];
                     [self.tblWallMemberList reloadData];
                     [self.viewWallMember setHidden:NO];
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


#pragma mark - apiCall

-(void)apiCallFor_GetGeneralWallData:(NSString *)strInternet
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL;
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%ld",totalCountView] forKey:@"rowno"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    
    if ([_checkscreen isEqualToString:@"Institute"])
    {
        strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_generalwall,apk_GetDynamicWallData_action];
        
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstitutionWallID"]] forKey:@"WallID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    }
    else if ([_checkscreen isEqualToString:@"Standard"])
    {
        strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_generalwall,apk_GetDynamicWallData_action];
        
        [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]] forKey:@"WallID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    }
    else if ([_checkscreen isEqualToString:@"Division"])
    {
        strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_generalwall,apk_GetDynamicWallData_action];
        
        [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]] forKey:@"WallID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    }
    else if ([_checkscreen isEqualToString:@"Subject"])
    {
        strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_generalwall,apk_GetDynamicWallData_action];
        
        [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]] forKey:@"WallID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    }
    else
    {
        strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_generalwall,apk_GetGeneralWallData_action];
        
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] forKey:@"WallID"];
    }
    
//    if([strInternet isEqualToString:@"1"])
//    {
//        [ProgressHUB showHUDAddedTo:self.view];
//    }
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [self.aWallTableView.refreshControl endRefreshing];
         [self.aWallTableView.tableFooterView setHidden:YES];
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
            
             if ([_checkscreen isEqualToString:@"Institute"])
             {
                 NSMutableDictionary  *dicResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                 if(dicResponce != nil)
                 {
                     NSMutableArray *arrResponce=[dicResponce objectForKey:@"PostData"];
                     NSString *strStatus=[dicResponce objectForKey:@"message"];
                     if([strStatus isEqualToString:@"No Data Found"])
                     {
                         UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dicResponce objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [alrt show];
                     }
                     else
                     {
                         countResponce = [arrResponce count];
                         NSArray *arrPostCommentID=[arrGeneralWall valueForKey:@"PostCommentID"];
                         for (NSMutableDictionary *dicWallID in arrResponce)
                         {
                             NSString *strPostCommentID=[dicWallID objectForKey:@"PostCommentID"];
                             if ([arrPostCommentID containsObject:strPostCommentID])
                             {
                                 NSInteger anIndex=[arrPostCommentID indexOfObject:strPostCommentID];
                                 [arrGeneralWall removeObjectAtIndex:anIndex];
                                 [arrGeneralWall insertObject:dicWallID atIndex:anIndex];
                                 //update insert localdb
                                 [self updateInstituteWall_localDB:dicWallID];
                             }
                             else
                             {
                                 [arrGeneralWall addObject:dicWallID];
                                 //insert localdb
                                 [self insertInstituteWall_localDB:dicWallID];
                             }
                         }
                         NSSortDescriptor *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"TempDate" ascending:NO];
                         NSArray *sortedArray3 = [arrGeneralWall sortedArrayUsingDescriptors:@[brandDescriptor]];
                         arrGeneralWall=[[NSMutableArray alloc]init];
                         arrGeneralWall=[sortedArray3 mutableCopy];
                         [self.aWallTableView reloadData];
                     }
                 }
                 else
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
             }
             else if ([_checkscreen isEqualToString:@"Standard"] ||
                      [_checkscreen isEqualToString:@"Division"] ||
                      [_checkscreen isEqualToString:@"Subject"])
             {
                 NSMutableDictionary  *dicResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                 if(dicResponce != nil)
                 {
                     NSMutableArray *arrResponce=[dicResponce objectForKey:@"PostData"];
                     NSString *strStatus=[dicResponce objectForKey:@"message"];
                     if([strStatus isEqualToString:@"No Data Found"])
                     {
                         UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dicResponce objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [alrt show];
                     }
                     else
                     {
                         countResponce = [arrResponce count];
                         NSArray *arrPostCommentID=[arrGeneralWall valueForKey:@"PostCommentID"];
                         for (NSMutableDictionary *dicWallID in arrResponce)
                         {
                             NSString *strPostCommentID=[dicWallID objectForKey:@"PostCommentID"];
                             if ([arrPostCommentID containsObject:strPostCommentID])
                             {
                                 NSInteger anIndex=[arrPostCommentID indexOfObject:strPostCommentID];
                                 [arrGeneralWall removeObjectAtIndex:anIndex];
                                 [arrGeneralWall insertObject:dicWallID atIndex:anIndex];
                                 //update insert localdb
                                 [self update_std_Divi_Subj_Wall_localDB:dicWallID];
                             }
                             else
                             {
                                 [arrGeneralWall addObject:dicWallID];
                                 //insert localdb
                                 [self insert_std_Divi_Subj_Wall_localDB:dicWallID];
                             }
                         }
                         NSSortDescriptor *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"TempDate" ascending:NO];
                         NSArray *sortedArray3 = [arrGeneralWall sortedArrayUsingDescriptors:@[brandDescriptor]];
                         arrGeneralWall=[[NSMutableArray alloc]init];
                         arrGeneralWall=[sortedArray3 mutableCopy];
                         [self.aWallTableView reloadData];
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
                         countResponce = [arrResponce count];
                         NSArray *arrPostCommentID=[arrGeneralWall valueForKey:@"PostCommentID"];
                         for (NSMutableDictionary *dicWallID in arrResponce)
                         {
                             NSString *strPostCommentID=[dicWallID objectForKey:@"PostCommentID"];
                             if ([arrPostCommentID containsObject:strPostCommentID])
                             {
                                 NSInteger anIndex=[arrPostCommentID indexOfObject:strPostCommentID];
                                 [arrGeneralWall removeObjectAtIndex:anIndex];
                                 [arrGeneralWall insertObject:dicWallID atIndex:anIndex];
                                 
                                 //update insert localdb
                                 [self updateGeneralWall_localDB:dicWallID];
                             }
                             else
                             {
                                 [arrGeneralWall addObject:dicWallID];
                                 //insert localdb
                                 [self insertGeneralWall_localDB:dicWallID];
                             }
                         }
                         NSSortDescriptor *brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"TempDate" ascending:NO];
                         NSArray *sortedArray3 = [arrGeneralWall sortedArrayUsingDescriptors:@[brandDescriptor]];
                         arrGeneralWall=[[NSMutableArray alloc]init];
                         arrGeneralWall=[sortedArray3 mutableCopy];
                         [self.aWallTableView reloadData];
                     }
                 }
                 else
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
             }
             
            if([arrGeneralWall count] == 0)
            {
                [self.lblNoWallDataAvailable setHidden:NO];
            }
             
         }
         else
         {
             UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alrt show];
         }
     }];
}

-(void)apiCallFor_LikePost:(NSString *)strInternet dicselectedWall:(NSMutableDictionary *)dicSelectedWall indexPath:(NSIndexPath *)indexPath
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_post,apk_LikePost_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicSelectedWall objectForKey:@"PostCommentID"]] forKey:@"pdataID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicSelectedWall objectForKey:@"AssociationType"]] forKey:@"ptype"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicSelectedWall objectForKey:@"MemberID"]] forKey:@"SendToMemberID"];
    
    if([[dicSelectedWall objectForKey:@"IsLike"] integerValue] == 1)
    {
        [param setValue:[NSString stringWithFormat:@"false"] forKey:@"IsLike"];
    }
    else
    {
        [param setValue:[NSString stringWithFormat:@"true"] forKey:@"IsLike"];
    }
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicSelectedWall objectForKey:@"WallID"]] forKey:@"WallID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    
    
    if([strInternet isEqualToString:@"1"])
    {
        [ProgressHUB showHUDAddedTo:self.view];
    }
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         //
         WallCustomeCell *cell = (WallCustomeCell*)[self.aWallTableView cellForRowAtIndexPath:indexPath];
         [cell.btnLike setUserInteractionEnabled:YES];
         [cell.btnUnlike setUserInteractionEnabled:YES];
         [cell.btnComment setUserInteractionEnabled:YES];
         [cell.btnShare setUserInteractionEnabled:YES];
         //
         
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
                 }
                 else
                 {
                     NSString *TotalLikes=[dic objectForKey:@"TotalLikes"];
                     NSString *PostCommentID=[dic objectForKey:@"PostCommentID"];
                    
                     if ([_checkscreen isEqualToString:@"Institute"])
                     {
                         //update
                         [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE InstituteWall SET TotalLikes = '%@' WHERE PostCommentID = '%@'",TotalLikes,PostCommentID]];
                     }
                     else
                     {
                         //update
                         [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE GeneralWall SET TotalLikes = '%@' WHERE PostCommentID = '%@'",TotalLikes,PostCommentID]];
                     }
                     
                     //set total count
                     NSString *TotalDislike = [dic objectForKey:@"TotalDislike"];
                     NSString *TotalComments = [dic objectForKey:@"TotalComments"];
                     if([TotalLikes integerValue]  == 0   &&
                        [TotalDislike integerValue]  == 0 &&
                        [TotalComments integerValue]  == 0)
                     {
                         cell.lblLike_Count_Height.constant=0;
                         [cell layoutIfNeeded];
                     }
                     else
                     {
                         cell.lblLike_Count_Height.constant=15;
                         
                         //Like
                         if([TotalLikes integerValue] <= 0)
                         {
                             [cell.lblLike_Count setText:[NSString stringWithFormat:@""]];
                         }
                         else
                         {
                             if([TotalLikes integerValue] > 1)
                             {
                                 [cell.lblLike_Count setText:[NSString stringWithFormat:@"%@ Likes",TotalLikes]];
                             }
                             else
                             {
                                 [cell.lblLike_Count setText:[NSString stringWithFormat:@"%@ Like",TotalLikes]];
                             }
                         }
                     }
                     
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

-(void)apiCallFor_UnLikePost:(NSString *)strInternet dicselectedWall:(NSMutableDictionary *)dicSelectedWall indexPath:(NSIndexPath *)indexPath
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_post,apk_DisLikePost_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicSelectedWall objectForKey:@"PostCommentID"]] forKey:@"pdataID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicSelectedWall objectForKey:@"AssociationType"]] forKey:@"ptype"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicSelectedWall objectForKey:@"MemberID"]] forKey:@"SendToMemberID"];
    
    if([[dicSelectedWall objectForKey:@"IsDislike"] integerValue] == 1)
    {
        [param setValue:[NSString stringWithFormat:@"false"] forKey:@"IsDislike"];
    }
    else
    {
        [param setValue:[NSString stringWithFormat:@"true"] forKey:@"IsDislike"];
    }
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicSelectedWall objectForKey:@"WallID"]] forKey:@"WallID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    
    
    if([strInternet isEqualToString:@"1"])
    {
        [ProgressHUB showHUDAddedTo:self.view];
    }
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         //
         WallCustomeCell *cell = (WallCustomeCell*)[self.aWallTableView cellForRowAtIndexPath:indexPath];
         [cell.btnLike setUserInteractionEnabled:YES];
         [cell.btnUnlike setUserInteractionEnabled:YES];
         [cell.btnComment setUserInteractionEnabled:YES];
         [cell.btnShare setUserInteractionEnabled:YES];
         //
         
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
                 }
                 else
                 {
                     NSString *TotalDislike=[dic objectForKey:@"TotalDislike"];
                     NSString *PostCommentID=[dic objectForKey:@"PostCommentID"];
                     if ([_checkscreen isEqualToString:@"Institute"])
                     {
                         //update
                         [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE InstituteWall SET TotalDislike = '%@' WHERE PostCommentID = '%@'",TotalDislike,PostCommentID]];
                     }
                     else
                     {
                         //update
                         [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE GeneralWall SET TotalDislike = '%@' WHERE PostCommentID = '%@'",TotalDislike,PostCommentID]];
                     }
                     
                     
                     //set total count
                     NSString *TotalLikes = [dic objectForKey:@"TotalLikes"];
                     NSString *TotalComments = [dic objectForKey:@"TotalComments"];
                     if([TotalLikes integerValue]  == 0   &&
                        [TotalDislike integerValue]  == 0 &&
                        [TotalComments integerValue]  == 0)
                     {
                         cell.lblLike_Count_Height.constant=0;
                         [cell layoutIfNeeded];
                     }
                     else
                     {
                         cell.lblLike_Count_Height.constant=15;
                         
                         //UnLike
                         if([TotalDislike integerValue] <= 0)
                         {
                             [cell.lblUnLike_Count setText:[NSString stringWithFormat:@""]];
                         }
                         else
                         {
                             if([TotalDislike integerValue] > 1)
                             {
                                 [cell.lblUnLike_Count setText:[NSString stringWithFormat:@" %@ Unlikes",TotalDislike]];
                             }
                             else
                             {
                                 [cell.lblUnLike_Count setText:[NSString stringWithFormat:@" %@ Unlike",TotalDislike]];
                             }
                         }
                     }
                     
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

#pragma mark - Insert Update Wall Data In LocalDB

-(void)insertGeneralWall_localDB:(NSMutableDictionary *)dicWallID
{
    //insert loacl db
    NSString *AssociationID=[dicWallID objectForKey:@"AssociationID"];
    NSString *AssociationType=[dicWallID objectForKey:@"AssociationType"];
    
    NSString *DateOfPost=[dicWallID objectForKey:@"DateOfPost"];
    NSString *FileMimeType=[dicWallID objectForKey:@"FileMimeType"];
    NSString *FileType=[dicWallID objectForKey:@"FileType"];
    NSString *FullName=[dicWallID objectForKey:@"FullName"];
    NSString *IsAllowPeoplePostCommentWall=[dicWallID objectForKey:@"IsAllowPeoplePostCommentWall"];
    
    NSString *IsAllowPeopleToLikeAndDislikeCommentWall=[dicWallID objectForKey:@"IsAllowPeopleToLikeAndDislikeCommentWall"];
    NSString *IsAllowPeopleToLikeOrDislikeOnYourPost=[dicWallID objectForKey:@"IsAllowPeopleToLikeOrDislikeOnYourPost"];
    NSString *IsAllowPeopleToPostMessageOnYourWall=[dicWallID objectForKey:@"IsAllowPeopleToPostMessageOnYourWall"];
    NSString *IsAllowPeopleToShareCommentWall=[dicWallID objectForKey:@"IsAllowPeopleToShareCommentWall"];
    NSString *IsAllowPeopleToShareYourPost=[dicWallID objectForKey:@"IsAllowPeopleToShareYourPost"];
    
    NSString *IsDislike=[dicWallID objectForKey:@"IsDislike"];
    NSString *IsLike=[dicWallID objectForKey:@"IsLike"];
    NSString *MemberID=[dicWallID objectForKey:@"MemberID"];
    NSString *Photo=[dicWallID objectForKey:@"Photo"];
    NSString *PostCommentID=[dicWallID objectForKey:@"PostCommentID"];
    
    NSString *PostCommentNote=[dicWallID objectForKey:@"PostCommentNote"];
    NSString *PostCommentTypesTerm=[dicWallID objectForKey:@"PostCommentTypesTerm"];
    NSString *PostedOn=[dicWallID objectForKey:@"PostedOn"];
    NSString *ProfilePicture=[dicWallID objectForKey:@"ProfilePicture"];
    NSString *RowNo=[dicWallID objectForKey:@"RowNo"];
    
    NSString *TempDate=[dicWallID objectForKey:@"TempDate"];
    NSString *TotalComments=[dicWallID objectForKey:@"TotalComments"];
    NSString *TotalDislike=[dicWallID objectForKey:@"TotalDislike"];
    NSString *TotalLikes=[dicWallID objectForKey:@"TotalLikes"];
    
    NSString *WallID=[dicWallID objectForKey:@"WallID"];
    NSString *WallTypeTerm=[dicWallID objectForKey:@"WallTypeTerm"];
    
    
    [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO GeneralWall (AssociationID,AssociationType,DateOfPost,FileMimeType,FileType,FullName,IsAllowPeoplePostCommentWall,IsAllowPeopleToLikeAndDislikeCommentWall,IsAllowPeopleToLikeOrDislikeOnYourPost,IsAllowPeopleToPostMessageOnYourWall,IsAllowPeopleToShareCommentWall,IsAllowPeopleToShareYourPost,IsDislike,IsLike,MemberID,Photo,PostCommentID,PostCommentNote,PostCommentTypesTerm,PostedOn,ProfilePicture,RowNo,TempDate,TotalComments,TotalDislike,TotalLikes,WallID,WallTypeTerm) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",AssociationID,AssociationType,DateOfPost,FileMimeType,FileType,FullName,IsAllowPeoplePostCommentWall,IsAllowPeopleToLikeAndDislikeCommentWall,IsAllowPeopleToLikeOrDislikeOnYourPost,IsAllowPeopleToPostMessageOnYourWall,IsAllowPeopleToShareCommentWall,IsAllowPeopleToShareYourPost,IsDislike,IsLike,MemberID,Photo,PostCommentID,PostCommentNote,PostCommentTypesTerm,PostedOn,ProfilePicture,RowNo,TempDate,TotalComments,TotalDislike,TotalLikes,WallID,WallTypeTerm]];
}

-(void)updateGeneralWall_localDB:(NSMutableDictionary *)dicWallID
{
    //insert loacl db
    NSString *AssociationID=[dicWallID objectForKey:@"AssociationID"];
    NSString *AssociationType=[dicWallID objectForKey:@"AssociationType"];
    
    NSString *DateOfPost=[dicWallID objectForKey:@"DateOfPost"];
    NSString *FileMimeType=[dicWallID objectForKey:@"FileMimeType"];
    NSString *FileType=[dicWallID objectForKey:@"FileType"];
    NSString *FullName=[dicWallID objectForKey:@"FullName"];
    NSString *IsAllowPeoplePostCommentWall=[dicWallID objectForKey:@"IsAllowPeoplePostCommentWall"];
    
    NSString *IsAllowPeopleToLikeAndDislikeCommentWall=[dicWallID objectForKey:@"IsAllowPeopleToLikeAndDislikeCommentWall"];
    NSString *IsAllowPeopleToLikeOrDislikeOnYourPost=[dicWallID objectForKey:@"IsAllowPeopleToLikeOrDislikeOnYourPost"];
    NSString *IsAllowPeopleToPostMessageOnYourWall=[dicWallID objectForKey:@"IsAllowPeopleToPostMessageOnYourWall"];
    NSString *IsAllowPeopleToShareCommentWall=[dicWallID objectForKey:@"IsAllowPeopleToShareCommentWall"];
    NSString *IsAllowPeopleToShareYourPost=[dicWallID objectForKey:@"IsAllowPeopleToShareYourPost"];
    
    NSString *IsDislike=[dicWallID objectForKey:@"IsDislike"];
    NSString *IsLike=[dicWallID objectForKey:@"IsLike"];
    NSString *MemberID=[dicWallID objectForKey:@"MemberID"];
    NSString *Photo=[dicWallID objectForKey:@"Photo"];
    NSString *PostCommentID=[dicWallID objectForKey:@"PostCommentID"];
    
    NSString *PostCommentNote=[dicWallID objectForKey:@"PostCommentNote"];
    NSString *PostCommentTypesTerm=[dicWallID objectForKey:@"PostCommentTypesTerm"];
    NSString *PostedOn=[dicWallID objectForKey:@"PostedOn"];
    NSString *ProfilePicture=[dicWallID objectForKey:@"ProfilePicture"];
    NSString *RowNo=[dicWallID objectForKey:@"RowNo"];
    
    NSString *TempDate=[dicWallID objectForKey:@"TempDate"];
    NSString *TotalComments=[dicWallID objectForKey:@"TotalComments"];
    NSString *TotalDislike=[dicWallID objectForKey:@"TotalDislike"];
    NSString *TotalLikes=[dicWallID objectForKey:@"TotalLikes"];
    
    NSString *WallID=[dicWallID objectForKey:@"WallID"];
    NSString *WallTypeTerm=[dicWallID objectForKey:@"WallTypeTerm"];
    
    
    [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE GeneralWall SET AssociationID ='%@',AssociationType= '%@',DateOfPost='%@',FileMimeType= '%@',FileType= '%@',FullName= '%@',IsAllowPeoplePostCommentWall= '%@',IsAllowPeopleToLikeAndDislikeCommentWall= '%@',IsAllowPeopleToLikeOrDislikeOnYourPost= '%@',IsAllowPeopleToPostMessageOnYourWall= '%@',IsAllowPeopleToShareCommentWall= '%@',IsAllowPeopleToShareYourPost= '%@',IsDislike= '%@',IsLike= '%@',MemberID= '%@',Photo= '%@',PostCommentID= '%@',PostCommentNote= '%@',PostCommentTypesTerm= '%@',PostedOn= '%@',ProfilePicture= '%@',RowNo= '%@',TempDate= '%@',TotalComments= '%@',TotalDislike= '%@',TotalLikes= '%@',WallID= '%@',WallTypeTerm= '%@' WHERE PostCommentID= '%@'",AssociationID,AssociationType,DateOfPost,FileMimeType,FileType,FullName,IsAllowPeoplePostCommentWall,IsAllowPeopleToLikeAndDislikeCommentWall,IsAllowPeopleToLikeOrDislikeOnYourPost,IsAllowPeopleToPostMessageOnYourWall,IsAllowPeopleToShareCommentWall,IsAllowPeopleToShareYourPost,IsDislike,IsLike,MemberID,Photo,PostCommentID,PostCommentNote,PostCommentTypesTerm,PostedOn,ProfilePicture,RowNo,TempDate,TotalComments,TotalDislike,TotalLikes,WallID,WallTypeTerm,PostCommentID]];
}

-(void)insertInstituteWall_localDB:(NSMutableDictionary *)dicWallID
{
    //insert loacl db
    NSString *AssociationID=[dicWallID objectForKey:@"AssociationID"];
    NSString *AssociationType=[dicWallID objectForKey:@"AssociationType"];
    
    NSString *DateOfPost=[dicWallID objectForKey:@"DateOfPost"];
    NSString *FileMimeType=[dicWallID objectForKey:@"FileMimeType"];
    NSString *FileType=[dicWallID objectForKey:@"FileType"];
    NSString *FullName=[dicWallID objectForKey:@"FullName"];
    NSString *IsAllowPeoplePostCommentWall=[dicWallID objectForKey:@"IsAllowPeoplePostCommentWall"];
    
    NSString *IsAllowPeopleToLikeAndDislikeCommentWall=[dicWallID objectForKey:@"IsAllowPeopleToLikeAndDislikeCommentWall"];
    NSString *IsAllowPeopleToLikeOrDislikeOnYourPost=[dicWallID objectForKey:@"IsAllowPeopleToLikeOrDislikeOnYourPost"];
    NSString *IsAllowPeopleToPostMessageOnYourWall=[dicWallID objectForKey:@"IsAllowPeopleToPostMessageOnYourWall"];
    NSString *IsAllowPeopleToShareCommentWall=[dicWallID objectForKey:@"IsAllowPeopleToShareCommentWall"];
    NSString *IsAllowPeopleToShareYourPost=[dicWallID objectForKey:@"IsAllowPeopleToShareYourPost"];
    
    NSString *IsDislike=[dicWallID objectForKey:@"IsDislike"];
    NSString *IsLike=[dicWallID objectForKey:@"IsLike"];
    NSString *MemberID=[dicWallID objectForKey:@"MemberID"];
    NSString *Photo=[dicWallID objectForKey:@"Photo"];
    NSString *PostCommentID=[dicWallID objectForKey:@"PostCommentID"];
    
    NSString *PostCommentNote=[dicWallID objectForKey:@"PostCommentNote"];
    NSString *PostCommentTypesTerm=[dicWallID objectForKey:@"PostCommentTypesTerm"];
    NSString *PostedOn=[dicWallID objectForKey:@"PostedOn"];
    NSString *ProfilePicture=[dicWallID objectForKey:@"ProfilePicture"];
    NSString *RowNo=[dicWallID objectForKey:@"RowNo"];
    
    NSString *TempDate=[dicWallID objectForKey:@"TempDate"];
    NSString *TotalComments=[dicWallID objectForKey:@"TotalComments"];
    NSString *TotalDislike=[dicWallID objectForKey:@"TotalDislike"];
    NSString *TotalLikes=[dicWallID objectForKey:@"TotalLikes"];
    
    NSString *WallID=[dicWallID objectForKey:@"WallID"];
    NSString *WallTypeTerm=[dicWallID objectForKey:@"WallTypeTerm"];
    
    
    [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO InstituteWall (AssociationID,AssociationType,DateOfPost,FileMimeType,FileType,FullName,IsAllowPeoplePostCommentWall,IsAllowPeopleToLikeAndDislikeCommentWall,IsAllowPeopleToLikeOrDislikeOnYourPost,IsAllowPeopleToPostMessageOnYourWall,IsAllowPeopleToShareCommentWall,IsAllowPeopleToShareYourPost,IsDislike,IsLike,MemberID,Photo,PostCommentID,PostCommentNote,PostCommentTypesTerm,PostedOn,ProfilePicture,RowNo,TempDate,TotalComments,TotalDislike,TotalLikes,WallID,WallTypeTerm) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",AssociationID,AssociationType,DateOfPost,FileMimeType,FileType,FullName,IsAllowPeoplePostCommentWall,IsAllowPeopleToLikeAndDislikeCommentWall,IsAllowPeopleToLikeOrDislikeOnYourPost,IsAllowPeopleToPostMessageOnYourWall,IsAllowPeopleToShareCommentWall,IsAllowPeopleToShareYourPost,IsDislike,IsLike,MemberID,Photo,PostCommentID,PostCommentNote,PostCommentTypesTerm,PostedOn,ProfilePicture,RowNo,TempDate,TotalComments,TotalDislike,TotalLikes,WallID,WallTypeTerm]];
}

-(void)updateInstituteWall_localDB:(NSMutableDictionary *)dicWallID
{
    //insert loacl db
    NSString *AssociationID=[dicWallID objectForKey:@"AssociationID"];
    NSString *AssociationType=[dicWallID objectForKey:@"AssociationType"];
    
    NSString *DateOfPost=[dicWallID objectForKey:@"DateOfPost"];
    NSString *FileMimeType=[dicWallID objectForKey:@"FileMimeType"];
    NSString *FileType=[dicWallID objectForKey:@"FileType"];
    NSString *FullName=[dicWallID objectForKey:@"FullName"];
    NSString *IsAllowPeoplePostCommentWall=[dicWallID objectForKey:@"IsAllowPeoplePostCommentWall"];
    
    NSString *IsAllowPeopleToLikeAndDislikeCommentWall=[dicWallID objectForKey:@"IsAllowPeopleToLikeAndDislikeCommentWall"];
    NSString *IsAllowPeopleToLikeOrDislikeOnYourPost=[dicWallID objectForKey:@"IsAllowPeopleToLikeOrDislikeOnYourPost"];
    NSString *IsAllowPeopleToPostMessageOnYourWall=[dicWallID objectForKey:@"IsAllowPeopleToPostMessageOnYourWall"];
    NSString *IsAllowPeopleToShareCommentWall=[dicWallID objectForKey:@"IsAllowPeopleToShareCommentWall"];
    NSString *IsAllowPeopleToShareYourPost=[dicWallID objectForKey:@"IsAllowPeopleToShareYourPost"];
    
    NSString *IsDislike=[dicWallID objectForKey:@"IsDislike"];
    NSString *IsLike=[dicWallID objectForKey:@"IsLike"];
    NSString *MemberID=[dicWallID objectForKey:@"MemberID"];
    NSString *Photo=[dicWallID objectForKey:@"Photo"];
    NSString *PostCommentID=[dicWallID objectForKey:@"PostCommentID"];
    
    NSString *PostCommentNote=[dicWallID objectForKey:@"PostCommentNote"];
    NSString *PostCommentTypesTerm=[dicWallID objectForKey:@"PostCommentTypesTerm"];
    NSString *PostedOn=[dicWallID objectForKey:@"PostedOn"];
    NSString *ProfilePicture=[dicWallID objectForKey:@"ProfilePicture"];
    NSString *RowNo=[dicWallID objectForKey:@"RowNo"];
    
    NSString *TempDate=[dicWallID objectForKey:@"TempDate"];
    NSString *TotalComments=[dicWallID objectForKey:@"TotalComments"];
    NSString *TotalDislike=[dicWallID objectForKey:@"TotalDislike"];
    NSString *TotalLikes=[dicWallID objectForKey:@"TotalLikes"];
    
    NSString *WallID=[dicWallID objectForKey:@"WallID"];
    NSString *WallTypeTerm=[dicWallID objectForKey:@"WallTypeTerm"];
    
    
    [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE InstituteWall SET AssociationID ='%@',AssociationType= '%@',DateOfPost='%@',FileMimeType= '%@',FileType= '%@',FullName= '%@',IsAllowPeoplePostCommentWall= '%@',IsAllowPeopleToLikeAndDislikeCommentWall= '%@',IsAllowPeopleToLikeOrDislikeOnYourPost= '%@',IsAllowPeopleToPostMessageOnYourWall= '%@',IsAllowPeopleToShareCommentWall= '%@',IsAllowPeopleToShareYourPost= '%@',IsDislike= '%@',IsLike= '%@',MemberID= '%@',Photo= '%@',PostCommentID= '%@',PostCommentNote= '%@',PostCommentTypesTerm= '%@',PostedOn= '%@',ProfilePicture= '%@',RowNo= '%@',TempDate= '%@',TotalComments= '%@',TotalDislike= '%@',TotalLikes= '%@',WallID= '%@',WallTypeTerm= '%@' WHERE PostCommentID= '%@'",AssociationID,AssociationType,DateOfPost,FileMimeType,FileType,FullName,IsAllowPeoplePostCommentWall,IsAllowPeopleToLikeAndDislikeCommentWall,IsAllowPeopleToLikeOrDislikeOnYourPost,IsAllowPeopleToPostMessageOnYourWall,IsAllowPeopleToShareCommentWall,IsAllowPeopleToShareYourPost,IsDislike,IsLike,MemberID,Photo,PostCommentID,PostCommentNote,PostCommentTypesTerm,PostedOn,ProfilePicture,RowNo,TempDate,TotalComments,TotalDislike,TotalLikes,WallID,WallTypeTerm,PostCommentID]];
}


-(void)insert_std_Divi_Subj_Wall_localDB:(NSMutableDictionary *)dicWallID
{
    //insert loacl db
    NSString *AssociationID=[dicWallID objectForKey:@"AssociationID"];
    NSString *AssociationType=[dicWallID objectForKey:@"AssociationType"];
    
    NSString *DateOfPost=[dicWallID objectForKey:@"DateOfPost"];
    NSString *FileMimeType=[dicWallID objectForKey:@"FileMimeType"];
    NSString *FileType=[dicWallID objectForKey:@"FileType"];
    NSString *FullName=[dicWallID objectForKey:@"FullName"];
    NSString *IsAllowPeoplePostCommentWall=[dicWallID objectForKey:@"IsAllowPeoplePostCommentWall"];
    
    NSString *IsAllowPeopleToLikeAndDislikeCommentWall=[dicWallID objectForKey:@"IsAllowPeopleToLikeAndDislikeCommentWall"];
    NSString *IsAllowPeopleToLikeOrDislikeOnYourPost=[dicWallID objectForKey:@"IsAllowPeopleToLikeOrDislikeOnYourPost"];
    NSString *IsAllowPeopleToPostMessageOnYourWall=[dicWallID objectForKey:@"IsAllowPeopleToPostMessageOnYourWall"];
    NSString *IsAllowPeopleToShareCommentWall=[dicWallID objectForKey:@"IsAllowPeopleToShareCommentWall"];
    NSString *IsAllowPeopleToShareYourPost=[dicWallID objectForKey:@"IsAllowPeopleToShareYourPost"];
    
    NSString *IsDislike=[dicWallID objectForKey:@"IsDislike"];
    NSString *IsLike=[dicWallID objectForKey:@"IsLike"];
    NSString *MemberID=[dicWallID objectForKey:@"MemberID"];
    NSString *Photo=[dicWallID objectForKey:@"Photo"];
    NSString *PostCommentID=[dicWallID objectForKey:@"PostCommentID"];
    
    NSString *PostCommentNote=[dicWallID objectForKey:@"PostCommentNote"];
    NSString *PostCommentTypesTerm=[dicWallID objectForKey:@"PostCommentTypesTerm"];
    NSString *PostedOn=[dicWallID objectForKey:@"PostedOn"];
    NSString *ProfilePicture=[dicWallID objectForKey:@"ProfilePicture"];
    NSString *RowNo=[dicWallID objectForKey:@"RowNo"];
    
    NSString *TempDate=[dicWallID objectForKey:@"TempDate"];
    NSString *TotalComments=[dicWallID objectForKey:@"TotalComments"];
    NSString *TotalDislike=[dicWallID objectForKey:@"TotalDislike"];
    NSString *TotalLikes=[dicWallID objectForKey:@"TotalLikes"];
    
    NSString *WallID=[dicWallID objectForKey:@"WallID"];
    NSString *WallTypeTerm=[dicWallID objectForKey:@"WallTypeTerm"];
    
    if ([_checkscreen isEqualToString:@"Standard"])
    {
        [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO StandardWall (AssociationID,AssociationType,DateOfPost,FileMimeType,FileType,FullName,IsAllowPeoplePostCommentWall,IsAllowPeopleToLikeAndDislikeCommentWall,IsAllowPeopleToLikeOrDislikeOnYourPost,IsAllowPeopleToPostMessageOnYourWall,IsAllowPeopleToShareCommentWall,IsAllowPeopleToShareYourPost,IsDislike,IsLike,MemberID,Photo,PostCommentID,PostCommentNote,PostCommentTypesTerm,PostedOn,ProfilePicture,RowNo,TempDate,TotalComments,TotalDislike,TotalLikes,WallID,WallTypeTerm) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",AssociationID,AssociationType,DateOfPost,FileMimeType,FileType,FullName,IsAllowPeoplePostCommentWall,IsAllowPeopleToLikeAndDislikeCommentWall,IsAllowPeopleToLikeOrDislikeOnYourPost,IsAllowPeopleToPostMessageOnYourWall,IsAllowPeopleToShareCommentWall,IsAllowPeopleToShareYourPost,IsDislike,IsLike,MemberID,Photo,PostCommentID,PostCommentNote,PostCommentTypesTerm,PostedOn,ProfilePicture,RowNo,TempDate,TotalComments,TotalDislike,TotalLikes,WallID,WallTypeTerm]];
    }
    else if ([_checkscreen isEqualToString:@"Division"])
    {
        [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO DivisionWall (AssociationID,AssociationType,DateOfPost,FileMimeType,FileType,FullName,IsAllowPeoplePostCommentWall,IsAllowPeopleToLikeAndDislikeCommentWall,IsAllowPeopleToLikeOrDislikeOnYourPost,IsAllowPeopleToPostMessageOnYourWall,IsAllowPeopleToShareCommentWall,IsAllowPeopleToShareYourPost,IsDislike,IsLike,MemberID,Photo,PostCommentID,PostCommentNote,PostCommentTypesTerm,PostedOn,ProfilePicture,RowNo,TempDate,TotalComments,TotalDislike,TotalLikes,WallID,WallTypeTerm) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",AssociationID,AssociationType,DateOfPost,FileMimeType,FileType,FullName,IsAllowPeoplePostCommentWall,IsAllowPeopleToLikeAndDislikeCommentWall,IsAllowPeopleToLikeOrDislikeOnYourPost,IsAllowPeopleToPostMessageOnYourWall,IsAllowPeopleToShareCommentWall,IsAllowPeopleToShareYourPost,IsDislike,IsLike,MemberID,Photo,PostCommentID,PostCommentNote,PostCommentTypesTerm,PostedOn,ProfilePicture,RowNo,TempDate,TotalComments,TotalDislike,TotalLikes,WallID,WallTypeTerm]];
    }
    else if ([_checkscreen isEqualToString:@"Subject"])
    {
        [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO SubjectWall (AssociationID,AssociationType,DateOfPost,FileMimeType,FileType,FullName,IsAllowPeoplePostCommentWall,IsAllowPeopleToLikeAndDislikeCommentWall,IsAllowPeopleToLikeOrDislikeOnYourPost,IsAllowPeopleToPostMessageOnYourWall,IsAllowPeopleToShareCommentWall,IsAllowPeopleToShareYourPost,IsDislike,IsLike,MemberID,Photo,PostCommentID,PostCommentNote,PostCommentTypesTerm,PostedOn,ProfilePicture,RowNo,TempDate,TotalComments,TotalDislike,TotalLikes,WallID,WallTypeTerm) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",AssociationID,AssociationType,DateOfPost,FileMimeType,FileType,FullName,IsAllowPeoplePostCommentWall,IsAllowPeopleToLikeAndDislikeCommentWall,IsAllowPeopleToLikeOrDislikeOnYourPost,IsAllowPeopleToPostMessageOnYourWall,IsAllowPeopleToShareCommentWall,IsAllowPeopleToShareYourPost,IsDislike,IsLike,MemberID,Photo,PostCommentID,PostCommentNote,PostCommentTypesTerm,PostedOn,ProfilePicture,RowNo,TempDate,TotalComments,TotalDislike,TotalLikes,WallID,WallTypeTerm]];
    }
}

-(void)update_std_Divi_Subj_Wall_localDB:(NSMutableDictionary *)dicWallID
{
    //insert loacl db
    NSString *AssociationID=[dicWallID objectForKey:@"AssociationID"];
    NSString *AssociationType=[dicWallID objectForKey:@"AssociationType"];
    
    NSString *DateOfPost=[dicWallID objectForKey:@"DateOfPost"];
    NSString *FileMimeType=[dicWallID objectForKey:@"FileMimeType"];
    NSString *FileType=[dicWallID objectForKey:@"FileType"];
    NSString *FullName=[dicWallID objectForKey:@"FullName"];
    NSString *IsAllowPeoplePostCommentWall=[dicWallID objectForKey:@"IsAllowPeoplePostCommentWall"];
    
    NSString *IsAllowPeopleToLikeAndDislikeCommentWall=[dicWallID objectForKey:@"IsAllowPeopleToLikeAndDislikeCommentWall"];
    NSString *IsAllowPeopleToLikeOrDislikeOnYourPost=[dicWallID objectForKey:@"IsAllowPeopleToLikeOrDislikeOnYourPost"];
    NSString *IsAllowPeopleToPostMessageOnYourWall=[dicWallID objectForKey:@"IsAllowPeopleToPostMessageOnYourWall"];
    NSString *IsAllowPeopleToShareCommentWall=[dicWallID objectForKey:@"IsAllowPeopleToShareCommentWall"];
    NSString *IsAllowPeopleToShareYourPost=[dicWallID objectForKey:@"IsAllowPeopleToShareYourPost"];
    
    NSString *IsDislike=[dicWallID objectForKey:@"IsDislike"];
    NSString *IsLike=[dicWallID objectForKey:@"IsLike"];
    NSString *MemberID=[dicWallID objectForKey:@"MemberID"];
    NSString *Photo=[dicWallID objectForKey:@"Photo"];
    NSString *PostCommentID=[dicWallID objectForKey:@"PostCommentID"];
    
    NSString *PostCommentNote=[dicWallID objectForKey:@"PostCommentNote"];
    NSString *PostCommentTypesTerm=[dicWallID objectForKey:@"PostCommentTypesTerm"];
    NSString *PostedOn=[dicWallID objectForKey:@"PostedOn"];
    NSString *ProfilePicture=[dicWallID objectForKey:@"ProfilePicture"];
    NSString *RowNo=[dicWallID objectForKey:@"RowNo"];
    
    NSString *TempDate=[dicWallID objectForKey:@"TempDate"];
    NSString *TotalComments=[dicWallID objectForKey:@"TotalComments"];
    NSString *TotalDislike=[dicWallID objectForKey:@"TotalDislike"];
    NSString *TotalLikes=[dicWallID objectForKey:@"TotalLikes"];
    
    NSString *WallID=[dicWallID objectForKey:@"WallID"];
    NSString *WallTypeTerm=[dicWallID objectForKey:@"WallTypeTerm"];
    
    if ([_checkscreen isEqualToString:@"Standard"])
    {
        [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE StandardWall SET AssociationID ='%@',AssociationType= '%@',DateOfPost='%@',FileMimeType= '%@',FileType= '%@',FullName= '%@',IsAllowPeoplePostCommentWall= '%@',IsAllowPeopleToLikeAndDislikeCommentWall= '%@',IsAllowPeopleToLikeOrDislikeOnYourPost= '%@',IsAllowPeopleToPostMessageOnYourWall= '%@',IsAllowPeopleToShareCommentWall= '%@',IsAllowPeopleToShareYourPost= '%@',IsDislike= '%@',IsLike= '%@',MemberID= '%@',Photo= '%@',PostCommentID= '%@',PostCommentNote= '%@',PostCommentTypesTerm= '%@',PostedOn= '%@',ProfilePicture= '%@',RowNo= '%@',TempDate= '%@',TotalComments= '%@',TotalDislike= '%@',TotalLikes= '%@',WallID= '%@',WallTypeTerm= '%@' WHERE PostCommentID= '%@'",AssociationID,AssociationType,DateOfPost,FileMimeType,FileType,FullName,IsAllowPeoplePostCommentWall,IsAllowPeopleToLikeAndDislikeCommentWall,IsAllowPeopleToLikeOrDislikeOnYourPost,IsAllowPeopleToPostMessageOnYourWall,IsAllowPeopleToShareCommentWall,IsAllowPeopleToShareYourPost,IsDislike,IsLike,MemberID,Photo,PostCommentID,PostCommentNote,PostCommentTypesTerm,PostedOn,ProfilePicture,RowNo,TempDate,TotalComments,TotalDislike,TotalLikes,WallID,WallTypeTerm,PostCommentID]];
    }
    else if ([_checkscreen isEqualToString:@"Division"])
    {
        [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE DivisionWall SET AssociationID ='%@',AssociationType= '%@',DateOfPost='%@',FileMimeType= '%@',FileType= '%@',FullName= '%@',IsAllowPeoplePostCommentWall= '%@',IsAllowPeopleToLikeAndDislikeCommentWall= '%@',IsAllowPeopleToLikeOrDislikeOnYourPost= '%@',IsAllowPeopleToPostMessageOnYourWall= '%@',IsAllowPeopleToShareCommentWall= '%@',IsAllowPeopleToShareYourPost= '%@',IsDislike= '%@',IsLike= '%@',MemberID= '%@',Photo= '%@',PostCommentID= '%@',PostCommentNote= '%@',PostCommentTypesTerm= '%@',PostedOn= '%@',ProfilePicture= '%@',RowNo= '%@',TempDate= '%@',TotalComments= '%@',TotalDislike= '%@',TotalLikes= '%@',WallID= '%@',WallTypeTerm= '%@' WHERE PostCommentID= '%@'",AssociationID,AssociationType,DateOfPost,FileMimeType,FileType,FullName,IsAllowPeoplePostCommentWall,IsAllowPeopleToLikeAndDislikeCommentWall,IsAllowPeopleToLikeOrDislikeOnYourPost,IsAllowPeopleToPostMessageOnYourWall,IsAllowPeopleToShareCommentWall,IsAllowPeopleToShareYourPost,IsDislike,IsLike,MemberID,Photo,PostCommentID,PostCommentNote,PostCommentTypesTerm,PostedOn,ProfilePicture,RowNo,TempDate,TotalComments,TotalDislike,TotalLikes,WallID,WallTypeTerm,PostCommentID]];

    }
    else if ([_checkscreen isEqualToString:@"Subject"])
    {
        [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE SubjectWall SET AssociationID ='%@',AssociationType= '%@',DateOfPost='%@',FileMimeType= '%@',FileType= '%@',FullName= '%@',IsAllowPeoplePostCommentWall= '%@',IsAllowPeopleToLikeAndDislikeCommentWall= '%@',IsAllowPeopleToLikeOrDislikeOnYourPost= '%@',IsAllowPeopleToPostMessageOnYourWall= '%@',IsAllowPeopleToShareCommentWall= '%@',IsAllowPeopleToShareYourPost= '%@',IsDislike= '%@',IsLike= '%@',MemberID= '%@',Photo= '%@',PostCommentID= '%@',PostCommentNote= '%@',PostCommentTypesTerm= '%@',PostedOn= '%@',ProfilePicture= '%@',RowNo= '%@',TempDate= '%@',TotalComments= '%@',TotalDislike= '%@',TotalLikes= '%@',WallID= '%@',WallTypeTerm= '%@' WHERE PostCommentID= '%@'",AssociationID,AssociationType,DateOfPost,FileMimeType,FileType,FullName,IsAllowPeoplePostCommentWall,IsAllowPeopleToLikeAndDislikeCommentWall,IsAllowPeopleToLikeOrDislikeOnYourPost,IsAllowPeopleToPostMessageOnYourWall,IsAllowPeopleToShareCommentWall,IsAllowPeopleToShareYourPost,IsDislike,IsLike,MemberID,Photo,PostCommentID,PostCommentNote,PostCommentTypesTerm,PostedOn,ProfilePicture,RowNo,TempDate,TotalComments,TotalDislike,TotalLikes,WallID,WallTypeTerm,PostCommentID]];

    }
}

#pragma mark - apiCall For Share Post

-(void)apiCallFor_SharePost:(NSString *)strInternet ShareType:(NSString *)ShareType
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_post,apk_SharePost_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    if ([_checkscreen isEqualToString:@"Institute"])
    {
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstitutionWallID"]] forKey:@"WallID"];
    }
    else if([_checkscreen isEqualToString:@"Standard"])
    {
        [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]] forKey:@"WallID"];
    }
    else if ([_checkscreen isEqualToString:@"Division"])
    {
        [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]] forKey:@"WallID"];
    }
    else if ([_checkscreen isEqualToString:@"Subject"])
    {
        [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]] forKey:@"WallID"];
    }
    else
    {
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] forKey:@"WallID"];
    }
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicSelect_SharePopup objectForKey:@"PostCommentID"]] forKey:@"SharePostID"];
    [param setValue:[NSString stringWithFormat:@"%@",ShareType] forKey:@"ShareType"];
    
    if([ShareType isEqualToString:@"Special Friend"])
    {
        NSArray *arrFriendID = [arrSelected_SpecialFriendList valueForKey:@"FriendID"];
        NSString *strFriendID = [arrFriendID componentsJoinedByString:@","];
        [param setValue:[NSString stringWithFormat:@"%@",strFriendID] forKey:@"TagID"];
        
    }
    else
    {
        [param setValue:[NSString stringWithFormat:@""] forKey:@"TagID"];
    }
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicSelect_SharePopup objectForKey:@"MemberID"]] forKey:@"SendToMemberID"];
    
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
                 }
                 else if([strStatus isEqualToString:@"Post share successfully"])
                 {
                     [self apiCallMethod];
                     [WToast showWithText:@"Post share successfully"];
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



-(void)apiCallFor_GetFriendList : (BOOL)checkProgress
{
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_friends,apk_GetFriendList];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
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
                     arrSpecialFriendListMain  =[[NSMutableArray alloc]init];
                     arrSelected_SpecialFriendList = [[NSMutableArray alloc]init];
                     arrSpecialFriendList = [[NSMutableArray alloc]init];
                     arrSpecialFriendList=[arrResponce mutableCopy];
                     arrSpecialFriendListMain  =[arrResponce mutableCopy];
                     [self.tblSpecialFriendsList reloadData];
                     
                     [self.view endEditing:YES];
                     [self.viewSpecialFriends_Popup setHidden:NO];
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



#pragma mark - UITextfield Delegate

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length == 0)
    {
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [[textField text] stringByReplacingCharactersInRange:range withString:string];
    if (textField == self.txtSearch_SpecialFriends)
    {
        if([newString length] > 0)
        {
            arrSpecialFriendList=[[NSMutableArray alloc]init];
            NSArray *arrKeyName=[[arrSpecialFriendListMain valueForKey:@"FullName"]mutableCopy];
            
            NSUInteger index = 0;
            for (NSString *strKeyName in arrKeyName)
            {
                NSMutableDictionary *dicData=[[arrSpecialFriendListMain objectAtIndex:index]mutableCopy];
                if(![strKeyName isKindOfClass:[NSNull class]])
                {
                    if([strKeyName rangeOfString:newString options:NSCaseInsensitiveSearch].location == NSNotFound)
                    {
                        [arrSpecialFriendList removeObject:dicData];
                    }
                    else
                    {
                        if(![arrSpecialFriendList containsObject:dicData])
                        {
                            [arrSpecialFriendList addObject:dicData];
                        }
                    }
                }
                index++;
            }
        }
        else if([newString isEqualToString:@""])
        {
            arrSpecialFriendList=[[NSMutableArray alloc]init];
            arrSpecialFriendList=[arrSpecialFriendListMain mutableCopy];
        }
    }
    
    [self.tblSpecialFriendsList reloadData];
    return YES;
}

#pragma mark - UITableview Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.tblWallMemberList)
    {
        return 117;
    }
    else if(tableView == self.tblSpecialFriendsList)
    {
        return 51;
    }
    else
    {
#pragma mark - set Post Detail Height
        NSMutableDictionary *dicResponce=[arrGeneralWall objectAtIndex:indexPath.row];
        NSString *strFileType=[dicResponce objectForKey:@"FileType"];
        if([strFileType isEqualToString:@"IMAGE"])
        {
            if([[dicResponce objectForKey:@"Photo"] length] != 0)
            {
                NSString *strPostCommentNote=[dicResponce objectForKey:@"PostCommentNote"];
                strPostCommentNote =[strPostCommentNote stringByReplacingOccurrencesOfString:@"</br>" withString:@""];
                strPostCommentNote =[strPostCommentNote stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
                
               // CGSize size = [strPostCommentNote sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:14] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-16, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
                
                NSString *TotalLikes = [dicResponce objectForKey:@"TotalLikes"];
                NSString *TotalDislike = [dicResponce objectForKey:@"TotalDislike"];
                NSString *TotalComments = [dicResponce objectForKey:@"TotalComments"];
                if([TotalLikes integerValue]  == 0   &&
                   [TotalDislike integerValue]  == 0 &&
                   [TotalComments integerValue]  == 0)
                {
                    return 310 + 28;
                }
                else
                {
                    return 325 + 28;
                }
            }
            else
            {
                return 350;
            }
        }
        else if([strFileType isEqualToString:@"Text"])
        {
            NSString *strPostCommentNote = [dicResponce objectForKey:@"PostCommentNote"];
            strPostCommentNote = [strPostCommentNote stringByReplacingOccurrencesOfString:@"</br> </br>" withString:@""];
            
           // CGSize size = [[NSString stringWithFormat:@"%@",strPostCommentNote] sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:14] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-16, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
            
            NSString *TotalLikes = [dicResponce objectForKey:@"TotalLikes"];
            NSString *TotalDislike = [dicResponce objectForKey:@"TotalDislike"];
            NSString *TotalComments = [dicResponce objectForKey:@"TotalComments"];
            if([TotalLikes integerValue]  == 0   &&
               [TotalDislike integerValue]  == 0 &&
               [TotalComments integerValue]  == 0)
            {
                return 125+18;
            }
            else
            {
                return 139+18;
            }
        }
        else if([strFileType isEqualToString:@"VIDEO"])
        {
            NSString *strPostCommentNote = [dicResponce objectForKey:@"PostCommentNote"];
            strPostCommentNote = [strPostCommentNote stringByReplacingOccurrencesOfString:@"</br> </br>" withString:@""];
           // CGSize size = [[NSString stringWithFormat:@"%@",strPostCommentNote] sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:14] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-16, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
            
            NSString *TotalLikes = [dicResponce objectForKey:@"TotalLikes"];
            NSString *TotalDislike = [dicResponce objectForKey:@"TotalDislike"];
            NSString *TotalComments = [dicResponce objectForKey:@"TotalComments"];
            if([TotalLikes integerValue]  == 0   &&
               [TotalDislike integerValue]  == 0 &&
               [TotalComments integerValue]  == 0)
            {
                return 250 + 28;
            }
            else
            {
                return 260 + 28;
            }

        }
        else if([strFileType isEqualToString:@"FILE"])
        {
            return 220;
        }
        else
        {
            return 350;
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.tblWallMemberList)
    {
        return [arrWallMemberList count];
    }
    else if(tableView == self.tblSpecialFriendsList)
    {
        return [arrSpecialFriendList count];
    }
    else
    {
        return [arrGeneralWall count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.tblWallMemberList)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellwallmember"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellwallmember"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *viewBck=(UIView*)[cell.contentView viewWithTag:1];
        if (indexPath.row % 2 ==0)
        {
            viewBck.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        }
        else
        {
            viewBck.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
        }
        
        UIView *viewimgBorder=(UIView*)[cell.contentView viewWithTag:2];
        [viewimgBorder.layer setBorderColor:[UIColor colorWithRed:34/255.0f green:49/255.0f blue:89/255.0f alpha:1.0f].CGColor];
        [viewimgBorder.layer setBorderWidth:1];
        
        NSMutableDictionary *dicResponce=[arrWallMemberList objectAtIndex:indexPath.row];
        NSString *strProfilePic_url=[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[dicResponce objectForKey:@"ProfilePicture"]];
        
        UIImageView *imgUser=(UIImageView* )[cell.contentView viewWithTag:3];
        [imgUser sd_setImageWithURL:[NSURL URLWithString:strProfilePic_url] placeholderImage:[UIImage imageNamed:@"blank-user.png"]];
        
        UILabel *lblUserName=(UILabel*)[cell.contentView viewWithTag:4];
        [lblUserName setText:[NSString stringWithFormat:@"%@",[dicResponce objectForKey:@"FullName"]]];

        UILabel *lblMemberType=(UILabel*)[cell.contentView viewWithTag:5];
        [lblMemberType setText:[NSString stringWithFormat:@"%@",[dicResponce objectForKey:@"MemberType"]]];
        
        return cell;
    }
    else if(tableView == self.tblSpecialFriendsList)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellSpecialFriend"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellSpecialFriend"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row % 2 ==0)
        {
            cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        }
        else
        {
            cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
        }
        
        NSMutableDictionary *dicResponce=[arrSpecialFriendList objectAtIndex:indexPath.row];
        NSString *strProfilePic_url=[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[dicResponce objectForKey:@"ProfilePicture"]];
        
        UIImageView *imgUser=(UIImageView*)[cell.contentView viewWithTag:101];
        imgUser.layer.cornerRadius = imgUser.frame.size.height/2;
        imgUser.clipsToBounds=YES;
        [imgUser.layer setBorderWidth:2];
        [imgUser.layer setBorderColor:[UIColor colorWithRed:227/255.0f green:227/255.0f blue:227/255.0f alpha:1.0f].CGColor];
        [imgUser sd_setImageWithURL:[NSURL URLWithString:strProfilePic_url] placeholderImage:[UIImage imageNamed:@"blank-user.png"]];
        
        UILabel *lblUserName=(UILabel*)[cell.contentView viewWithTag:102];
        [lblUserName setText:[NSString stringWithFormat:@"%@",[dicResponce objectForKey:@"FullName"]]];
        
        UIButton *btnCheckBox=(UIButton*)[cell.contentView viewWithTag:103];
        
        if([arrSelected_SpecialFriendList containsObject:dicResponce])
        {
            [btnCheckBox setImage:[UIImage imageNamed:@"checkboxblue.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btnCheckBox setImage:[UIImage imageNamed:@"checkboxunselected.png"] forState:UIControlStateNormal];
        }
        return cell;
    }
    else
    {
        WallCustomeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[WallCustomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        NSMutableDictionary *dicResponce=[arrGeneralWall objectAtIndex:indexPath.row];
        
#pragma mark - set Header
        NSString *strProfilePic_url=[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[dicResponce objectForKey:@"ProfilePicture"]];
        
        [cell.imgProfilePic sd_setImageWithURL:[NSURL URLWithString:strProfilePic_url] placeholderImage:[UIImage imageNamed:@"user.png"]];
        
        NSString *strFullName=[dicResponce objectForKey:@"FullName"];
        [cell.lblProfileName setText:strFullName];
        
        NSString *strDateOfPost=[dicResponce objectForKey:@"DateOfPost"];
        NSString *strPostCommentTypesTerm=[dicResponce objectForKey:@"PostCommentTypesTerm"];
        [cell.lblProfileDetail setText:[NSString stringWithFormat:@"%@ %@",strPostCommentTypesTerm,strDateOfPost]];
        
        NSString *strPostedOn=[dicResponce objectForKey:@"PostedOn"];
        [cell.lblProfile_PostType setText:[NSString stringWithFormat:@"%@",strPostedOn]];
        
        
#pragma mark - set Post Detail
        
        
        NSString *strPostCommentNote=[dicResponce objectForKey:@"PostCommentNote"];
        strPostCommentNote =[strPostCommentNote stringByReplacingOccurrencesOfString:@"</br>" withString:@""];
        strPostCommentNote =[strPostCommentNote stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
        //NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[strPostCommentNote dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        cell.lblPostDetailHTML.text = strPostCommentNote;
        
        NSString *strFileType=[dicResponce objectForKey:@"FileType"];
        if([strFileType isEqualToString:@"IMAGE"])
        {
            NSString *strPost_Photo=[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[dicResponce objectForKey:@"Photo"]];
            if([[dicResponce objectForKey:@"Photo"] length] != 0)
            {
                [cell.imgPost sd_setImageWithURL:[NSURL URLWithString:strPost_Photo] placeholderImage:[UIImage imageNamed:@"no_img.png"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        WallCustomeCell* theCell = (WallCustomeCell*)[tableView cellForRowAtIndexPath:indexPath];
                        theCell.imgPost.image=image;                    });
                }];
                
//                [cell.imgPost sd_setImageWithURL:[NSURL URLWithString:strPost_Photo] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        WallCustomeCell* theCell = (WallCustomeCell*)[tableView cellForRowAtIndexPath:indexPath];
//                        theCell.imgPost.image=image;
//                    });
//                }];
            }
            else
            {
                
            }
        }
        else if([strFileType isEqualToString:@"VIDEO"])
        {
            cell.imgPost.image = [UIImage imageNamed:@"dummy_video.png"];
        }
        else if([strFileType isEqualToString:@"FILE"])
        {
            cell.imgPost.image = [UIImage imageNamed:@"pdf_blue.png"];
        }
        else
        {
            cell.imgPost.image = [UIImage imageNamed:@"no_img.png"];
        }
#pragma mark - Like UnLike Comment COUNT
        
        NSString *TotalLikes = [dicResponce objectForKey:@"TotalLikes"];
        NSString *TotalDislike = [dicResponce objectForKey:@"TotalDislike"];
        NSString *TotalComments = [dicResponce objectForKey:@"TotalComments"];
        if([TotalLikes integerValue]  == 0   &&
           [TotalDislike integerValue]  == 0 &&
           [TotalComments integerValue]  == 0)
        {
            cell.lblLike_Count_Height.constant=0;
            [cell layoutIfNeeded];
        }
        else
        {
            cell.lblLike_Count_Height.constant=15;
            
            //Like
            if([TotalLikes integerValue] <= 0)
            {
                [cell.lblLike_Count setText:[NSString stringWithFormat:@""]];
            }
            else
            {
                if([TotalLikes integerValue] > 1)
                {
                    [cell.lblLike_Count setText:[NSString stringWithFormat:@"%@ Likes",TotalLikes]];
                }
                else
                {
                    [cell.lblLike_Count setText:[NSString stringWithFormat:@"%@ Like",TotalLikes]];
                }
                
            }
            
            //UnLike
            if([TotalDislike integerValue] == 0)
            {
                [cell.lblUnLike_Count setText:[NSString stringWithFormat:@""]];
            }
            else
            {
                if([TotalDislike integerValue] > 1)
                {
                    [cell.lblUnLike_Count setText:[NSString stringWithFormat:@" %@ Unlikes",TotalDislike]];
                }
                else
                {
                    [cell.lblUnLike_Count setText:[NSString stringWithFormat:@" %@ Unlike",TotalDislike]];
                }
            }
            
            //Comment
            if([TotalComments integerValue] == 0)
            {
                [cell.lblComment_Count setText:[NSString stringWithFormat:@""]];
            }
            else
            {
                [cell.lblComment_Count setText:[NSString stringWithFormat:@" %@ Comment",TotalComments]];
            }
            [cell layoutIfNeeded];
        }
        
#pragma mark - Like Unlike Comment Share
        
        NSString *str_IsLike=[dicResponce objectForKey:@"IsLike"];
        if([str_IsLike integerValue] == 0)
        {
            [cell.imgLike setImage:[UIImage imageNamed:@"fb_like_gray"]];
            [cell.lblLike setTextColor:[UIColor darkGrayColor]];
        }
        else
        {
            cell.imgLike.image = [cell.imgLike.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [cell.imgLike setTintColor:[UIColor colorWithRed:34/255.0 green:49/255.0 blue:89/255.0 alpha:1.0]];
            [cell.lblLike setTextColor:[UIColor colorWithRed:34/255.0 green:49/255.0 blue:89/255.0 alpha:1.0]];
        }
        
        NSString *str_IsDislike=[dicResponce objectForKey:@"IsDislike"];
        if([str_IsDislike integerValue] == 0)
        {
            [cell.imgUnlike setImage:[UIImage imageNamed:@"fb_like_gray"]];
            [cell.lblUnlike setTextColor:[UIColor darkGrayColor]];
        }
        else
        {
            cell.imgUnlike.image = [cell.imgUnlike.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [cell.imgUnlike setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
            [cell.lblUnlike setTextColor:[UIColor colorWithRed:34/255.0 green:49/255.0 blue:89/255.0 alpha:1.0]];
        }
        
        [cell.btnLike addTarget:self action:@selector(btnCellLike_Click:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnUnlike addTarget:self action:@selector(btnCellUnLike_Click:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnComment addTarget:self action:@selector(btnCellComment_Click:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnShare addTarget:self action:@selector(btnCellShare_Click:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnImageVideo_Click addTarget:self action:@selector(btnImageVideo_Click:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(tableView == self.tblWallMemberList)
    {
        
    }
    else if(tableView == self.tblSpecialFriendsList)
    {
    }
    else
    {
        NSInteger totalRow = [tableView numberOfRowsInSection:indexPath.section];
        
        if(indexPath.row == totalRow -1)
        {
            if(countResponce == 10)
            {
                totalCountView = totalCountView + 10;
                
                if ([Utility isInterNetConnectionIsActive] == true)
                {
                    [self.aWallTableView.tableFooterView setHidden:NO];
                    [self apiCallFor_GetGeneralWallData:@"0"];
                }
                else
                {
                    [self.aWallTableView.tableFooterView setHidden:YES];
                }
            }
            else
            {
                [self.aWallTableView.tableFooterView setHidden:YES];
            }
        }
    }
}

#pragma mark - tbl UIButton Action

-(void)btnCellLike_Click:(UIButton*)sender
{
    if ([Utility isInterNetConnectionIsActive] == true)
    {
        
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.aWallTableView];
        NSIndexPath *indexPath = [self.aWallTableView indexPathForRowAtPoint:buttonPosition];
        
        WallCustomeCell *cell = (WallCustomeCell*)[self.aWallTableView cellForRowAtIndexPath:indexPath];
        [cell.btnLike setUserInteractionEnabled:NO];
        [cell.btnUnlike setUserInteractionEnabled:NO];
        [cell.btnComment setUserInteractionEnabled:NO];
        [cell.btnShare setUserInteractionEnabled:NO];
        
        NSMutableDictionary *dicResponce=[[arrGeneralWall objectAtIndex:indexPath.row]mutableCopy];
        //call api Like
        [self apiCallFor_LikePost:@"0" dicselectedWall:dicResponce indexPath:indexPath];
        
        NSString *IsLike=[dicResponce objectForKey:@"IsLike"];
        NSString *TotalLikes=[dicResponce objectForKey:@"TotalLikes"];
        NSString *PostCommentID=[dicResponce objectForKey:@"PostCommentID"];
        
        //set IsLike and TotalLikes
        if([IsLike integerValue] == 0)
        {
            IsLike=@"1";
            long TotalLikesTemp = [TotalLikes integerValue] + 1;
            TotalLikes = [NSString stringWithFormat:@"%ld",TotalLikesTemp];
        }
        else
        {
            IsLike=@"0";
            long TotalLikesTemp = [TotalLikes integerValue] - 1;
            TotalLikes = [NSString stringWithFormat:@"%ld",TotalLikesTemp];
        }
        
        if ([_checkscreen isEqualToString:@"Institute"])
        {
            //update
            [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE InstituteWall SET IsLike = '%@', TotalLikes = '%@' WHERE PostCommentID = '%@'",IsLike,TotalLikes,PostCommentID]];
            
            //get update data localdb
            arrGeneralWall = [[NSMutableArray alloc]init];
            arrGeneralWall = [DBOperation selectData:@"select * from InstituteWall"];
        }
        else if ([_checkscreen isEqualToString:@"Standard"])
        {
            //update
            [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE StandardWall SET IsLike = '%@', TotalLikes = '%@' WHERE PostCommentID = '%@'",IsLike,TotalLikes,PostCommentID]];
            
            //get update data localdb
            arrGeneralWall = [[NSMutableArray alloc]init];
            arrGeneralWall = [DBOperation selectData:@"select * from StandardWall"];

        }
        else if ([_checkscreen isEqualToString:@"Division"])
        {
            //update
            [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE DivisionWall SET IsLike = '%@', TotalLikes = '%@' WHERE PostCommentID = '%@'",IsLike,TotalLikes,PostCommentID]];
            
            //get update data localdb
            arrGeneralWall = [[NSMutableArray alloc]init];
            arrGeneralWall = [DBOperation selectData:@"select * from DivisionWall"];
            
        }
        else if ([_checkscreen isEqualToString:@"Subject"])
        {
            //update
            [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE SubjectWall SET IsLike = '%@', TotalLikes = '%@' WHERE PostCommentID = '%@'",IsLike,TotalLikes,PostCommentID]];
            
            //get update data localdb
            arrGeneralWall = [[NSMutableArray alloc]init];
            arrGeneralWall = [DBOperation selectData:@"select * from SubjectWall"];
            
        }
        else
        {
            //update
            [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE GeneralWall SET IsLike = '%@', TotalLikes = '%@' WHERE PostCommentID = '%@'",IsLike,TotalLikes,PostCommentID]];
            
            //get update data localdb
            arrGeneralWall = [[NSMutableArray alloc]init];
            arrGeneralWall = [DBOperation selectData:@"select * from GeneralWall"];
        }
        
        //set color like and unlike
        if([IsLike integerValue] == 0)
        {
            [cell.imgLike setImage:[UIImage imageNamed:@"fb_like_gray"]];
            [cell.lblLike setTextColor:[UIColor darkGrayColor]];
        }
        else
        {
            cell.imgLike.image = [cell.imgLike.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [cell.imgLike setTintColor:[UIColor colorWithRed:34/255.0 green:49/255.0 blue:89/255.0 alpha:1.0]];
            [cell.lblLike setTextColor:[UIColor colorWithRed:34/255.0 green:49/255.0 blue:89/255.0 alpha:1.0]];
        }
        
        //set total count
        NSString *TotalDislike = [dicResponce objectForKey:@"TotalDislike"];
        NSString *TotalComments = [dicResponce objectForKey:@"TotalComments"];
        if([TotalLikes integerValue]  == 0   &&
           [TotalDislike integerValue]  == 0 &&
           [TotalComments integerValue]  == 0)
        {
            cell.lblLike_Count_Height.constant=0;
            
        }
        else
        {
            cell.lblLike_Count_Height.constant=15;
            
            //Like
            if([TotalLikes integerValue] <= 0)
            {
                [cell.lblLike_Count setText:[NSString stringWithFormat:@""]];
            }
            else
            {
                if([TotalLikes integerValue] > 1)
                {
                    [cell.lblLike_Count setText:[NSString stringWithFormat:@"%@ Likes",TotalLikes]];
                }
                else
                {
                    [cell.lblLike_Count setText:[NSString stringWithFormat:@"%@ Like",TotalLikes]];
                }
            }
            
            //UnLike
            if([TotalDislike integerValue] == 0)
            {
                [cell.lblUnLike_Count setText:[NSString stringWithFormat:@""]];
            }
            else
            {
                if([TotalDislike integerValue] > 1)
                {
                    [cell.lblUnLike_Count setText:[NSString stringWithFormat:@" %@ Unlikes",TotalDislike]];
                }
                else
                {
                    [cell.lblUnLike_Count setText:[NSString stringWithFormat:@" %@ Unlike",TotalDislike]];
                }
            }
            
            //Comment
            if([TotalComments integerValue] == 0)
            {
                [cell.lblComment_Count setText:[NSString stringWithFormat:@""]];
            }
            else
            {
                [cell.lblComment_Count setText:[NSString stringWithFormat:@" %@ Comment",TotalComments]];
            }
            
        }
        [cell layoutIfNeeded];
    }
    else
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
    }
}

-(void)btnCellUnLike_Click:(UIButton*)sender
{
    if ([Utility isInterNetConnectionIsActive] == true)
    {
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.aWallTableView];
        NSIndexPath *indexPath = [self.aWallTableView indexPathForRowAtPoint:buttonPosition];
        
        WallCustomeCell *cell = (WallCustomeCell*)[self.aWallTableView cellForRowAtIndexPath:indexPath];
        [cell.btnLike setUserInteractionEnabled:NO];
        [cell.btnUnlike setUserInteractionEnabled:NO];
        [cell.btnComment setUserInteractionEnabled:NO];
        [cell.btnShare setUserInteractionEnabled:NO];
        
        NSMutableDictionary *dicResponce=[[arrGeneralWall objectAtIndex:indexPath.row]mutableCopy];
        //call api Like
        [self apiCallFor_UnLikePost:@"0" dicselectedWall:dicResponce indexPath:indexPath];
        
        
        NSString *IsDislike=[dicResponce objectForKey:@"IsDislike"];
        NSString *TotalDislike=[dicResponce objectForKey:@"TotalDislike"];
        NSString *PostCommentID=[dicResponce objectForKey:@"PostCommentID"];
        
        //set IsLike and TotalLikes
        if([IsDislike integerValue] == 0)
        {
            IsDislike=@"1";
            long TotalDislikeTemp = [TotalDislike integerValue] + 1;
            TotalDislike = [NSString stringWithFormat:@"%ld",TotalDislikeTemp];
        }
        else
        {
            IsDislike=@"0";
            long TotalDislikeTemp = [TotalDislike integerValue] - 1;
            TotalDislike = [NSString stringWithFormat:@"%ld",TotalDislikeTemp];
        }
        
        if ([_checkscreen isEqualToString:@"Institute"])
        {
            //update
            [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE InstituteWall SET IsDislike = '%@', TotalDislike = '%@' WHERE PostCommentID = '%@'",IsDislike,TotalDislike,PostCommentID]];
            
            //get update data localdb
            arrGeneralWall = [[NSMutableArray alloc]init];
            arrGeneralWall = [DBOperation selectData:@"select * from InstituteWall"];
        }
        else if ([_checkscreen isEqualToString:@"Standard"])
        {
            //update
            [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE StandardWall SET IsDislike = '%@', TotalDislike = '%@' WHERE PostCommentID = '%@'",IsDislike,TotalDislike,PostCommentID]];
            
            //get update data localdb
            arrGeneralWall = [[NSMutableArray alloc]init];
            arrGeneralWall = [DBOperation selectData:@"select * from StandardWall"];
        }
        else if ([_checkscreen isEqualToString:@"Division"])
        {
            //update
            [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE DivisionWall SET IsDislike = '%@', TotalDislike = '%@' WHERE PostCommentID = '%@'",IsDislike,TotalDislike,PostCommentID]];
            
            //get update data localdb
            arrGeneralWall = [[NSMutableArray alloc]init];
            arrGeneralWall = [DBOperation selectData:@"select * from DivisionWall"];
        }
        else if ([_checkscreen isEqualToString:@"Subject"])
        {
            //update
            [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE SubjectWall SET IsDislike = '%@', TotalDislike = '%@' WHERE PostCommentID = '%@'",IsDislike,TotalDislike,PostCommentID]];
            
            //get update data localdb
            arrGeneralWall = [[NSMutableArray alloc]init];
            arrGeneralWall = [DBOperation selectData:@"select * from SubjectWall"];
        }
        else
        {
            //update
            [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE GeneralWall SET IsDislike = '%@', TotalDislike = '%@' WHERE PostCommentID = '%@'",IsDislike,TotalDislike,PostCommentID]];
            
            //get update data localdb
            arrGeneralWall = [[NSMutableArray alloc]init];
            arrGeneralWall = [DBOperation selectData:@"select * from GeneralWall"];
        }
        
        
        //set color like and unlike
        if([IsDislike integerValue] == 0)
        {
            [cell.imgUnlike setImage:[UIImage imageNamed:@"fb_like_gray"]];
            [cell.lblUnlike setTextColor:[UIColor darkGrayColor]];
        }
        else
        {
            cell.imgUnlike.image = [cell.imgUnlike.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [cell.imgUnlike setTintColor:[UIColor colorWithRed:34/255.0 green:49/255.0 blue:89/255.0 alpha:1.0]];
            [cell.lblUnlike setTextColor:[UIColor colorWithRed:34/255.0 green:49/255.0 blue:89/255.0 alpha:1.0]];
        }
        
        //set total count
        NSString *TotalLikes = [dicResponce objectForKey:@"TotalLikes"];
        NSString *TotalComments = [dicResponce objectForKey:@"TotalComments"];
        if([TotalLikes integerValue]  == 0   &&
           [TotalDislike integerValue]  == 0 &&
           [TotalComments integerValue]  == 0)
        {
            cell.lblLike_Count_Height.constant=0;
        }
        else
        {
            cell.lblLike_Count_Height.constant=15;
            
            //UnLike
            if([TotalDislike integerValue] <= 0)
            {
                [cell.lblUnLike_Count setText:[NSString stringWithFormat:@""]];
            }
            else
            {
                if([TotalDislike integerValue] > 1)
                {
                    [cell.lblUnLike_Count setText:[NSString stringWithFormat:@" %@ Unlikes",TotalDislike]];
                }
                else
                {
                    [cell.lblUnLike_Count setText:[NSString stringWithFormat:@" %@ Unlike",TotalDislike]];
                }
            }
            
            //Like
            if([TotalLikes integerValue] <= 0)
            {
                [cell.lblLike_Count setText:[NSString stringWithFormat:@""]];
            }
            else
            {
                if([TotalLikes integerValue] > 1)
                {
                    [cell.lblLike_Count setText:[NSString stringWithFormat:@"%@ Likes",TotalLikes]];
                }
                else
                {
                    [cell.lblLike_Count setText:[NSString stringWithFormat:@"%@ Like",TotalLikes]];
                }
            }
            //Comment
            if([TotalComments integerValue] == 0)
            {
                [cell.lblComment_Count setText:[NSString stringWithFormat:@""]];
            }
            else
            {
                [cell.lblComment_Count setText:[NSString stringWithFormat:@" %@ Comment",TotalComments]];
            }
        }
        [cell layoutIfNeeded];
    }
    else
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
    }
}

-(void)btnCellComment_Click:(UIButton*)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.aWallTableView];
    NSIndexPath *indexPath = [self.aWallTableView indexPathForRowAtPoint:buttonPosition];
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    else
    {
        AddCommentVc *b = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddCommentVc"];
        b.dicSelectedPost_Comment = [arrGeneralWall objectAtIndex:indexPath.row];
        b.checkscreen=_checkscreen;
        [self.navigationController pushViewController:b animated:YES];
    }
}

-(void)btnCellShare_Click:(UIButton*)sender
{
    [self.view endEditing:YES];
    arrPopup = [[NSMutableArray alloc]init];
    [arrPopup addObject:[Utility addCell_PopupView:self.viewshare_Popup ParentView:self.view sender:sender]];
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.aWallTableView];
    NSIndexPath *indexPath = [self.aWallTableView indexPathForRowAtPoint:buttonPosition];
    dicSelect_SharePopup= [arrGeneralWall objectAtIndex:indexPath.row];
}

-(void)btnImageVideo_Click:(UIButton*)sender
{
    [self.view endEditing:YES];
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.aWallTableView];
    NSIndexPath *indexPath = [self.aWallTableView indexPathForRowAtPoint:buttonPosition];
    NSMutableDictionary *dicResponce=[arrGeneralWall objectAtIndex:indexPath.row];
    
    NSString *strFileType=[dicResponce objectForKey:@"FileType"];
    if([strFileType isEqualToString:@"VIDEO"] ||
     [strFileType isEqualToString:@"IMAGE"])
    {
        PostDetailVC *b = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"PostDetailVC"];
        b.dicPostDetail = [arrGeneralWall objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:b animated:YES];
    }
    else if([strFileType isEqualToString:@"FILE"])
    {
        NSString *strPost_Photo=[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[dicResponce objectForKey:@"Photo"]];

        NSArray *activityItems = @[[NSURL fileURLWithPath:strPost_Photo]];
        
        UIActivityViewController *activityViewController =
        [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                          applicationActivities:nil];        
        [activityViewController setCompletionHandler:^(NSString *activityType, BOOL completed) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self presentViewController:activityViewController
                           animated:YES
                         completion:nil];
    }
}
- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller {
    return self;
}

- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller
{
   
}

- (IBAction)btnCell_CheckBox_SpecialFriends:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblSpecialFriendsList];
    NSIndexPath *indexPath = [self.tblSpecialFriendsList indexPathForRowAtPoint:buttonPosition];
    
    if([arrSelected_SpecialFriendList containsObject:[arrSpecialFriendList objectAtIndex:indexPath.row]])
    {
        [arrSelected_SpecialFriendList removeObject:[arrSpecialFriendList objectAtIndex:indexPath.row]];
    }
    else
    {
        [arrSelected_SpecialFriendList addObject:[arrSpecialFriendList objectAtIndex:indexPath.row]];
    }
    [self.tblSpecialFriendsList reloadData];
}

#pragma mark - CMPopTipViewDelegate methods

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
    [arrPopup removeObject:popTipView];
}

#pragma mark - SharePost UIButton Action

- (IBAction)btnPublic_SharePopup:(id)sender
{
    [Utility dismissAllPopTipViews:arrPopup];
    [self apiCallFor_SharePost:@"1" ShareType:@"Public"];
}

- (IBAction)btnOnlyMe_SharePopup:(id)sender
{
    [Utility dismissAllPopTipViews:arrPopup];
    [self apiCallFor_SharePost:@"1" ShareType:@"Only Me"];
}

- (IBAction)btnFriends_SharePopup:(id)sender
{
    [Utility dismissAllPopTipViews:arrPopup];
    [self apiCallFor_SharePost:@"1" ShareType:@"Friend"];
}

- (IBAction)btnSpecialFriend_SharePopup:(id)sender
{
    [Utility dismissAllPopTipViews:arrPopup];
    [self.view endEditing:YES];
    [self apiCallFor_GetFriendList:YES];
}

#pragma mark - Special Friend UIButton Action

- (IBAction)btnBack_SpecialFriends:(id)sender
{
    [self.view endEditing:YES];
    [self.viewSpecialFriends_Popup setHidden:YES];
}

- (IBAction)btnDone_SpecialFriends:(id)sender
{
    [self.view endEditing:YES];
    [self.viewSpecialFriends_Popup setHidden:YES];
    if([arrSelected_SpecialFriendList count] != 0)
    {
        [self apiCallFor_SharePost:@"1" ShareType:@"Special Friend"];
    }
    else
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Please_Select_Friend delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        
    }
}

- (IBAction)btnCheckAll_SpecialFriends:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if(btn.selected)
    {
        arrSelected_SpecialFriendList = [[NSMutableArray alloc]init];
        btn.selected=NO;
        [self.btnCheckAll_SpecialFriends setImage:[UIImage imageNamed:@"menu_select_all"] forState:UIControlStateNormal];
    }
    else
    {
        for (NSMutableDictionary *dic in arrSpecialFriendList) {
            if([arrSelected_SpecialFriendList containsObject:dic])
            {
            }
            else
            {
                [arrSelected_SpecialFriendList addObject:dic];
            }
        }
        btn.selected=YES;
        [self.btnCheckAll_SpecialFriends setImage:[UIImage imageNamed:@"menu_select_all_blue"] forState:UIControlStateNormal];
    }
    [self.tblSpecialFriendsList reloadData];
}

#pragma mark - UIButton Action

- (IBAction)MenuBtnClicked:(id)sender
{
    if ([_checkscreen isEqualToString:@"Institute"])
    {
        [self apiCallFor_GetWallMember:@"1"];
    }
    else if ([_checkscreen isEqualToString:@"Standard"] ||
             [_checkscreen isEqualToString:@"Division"] ||
             [_checkscreen isEqualToString:@"Subject"])
    {
        [self apiCallFor_GetWallMember:@"1"];
    }
    else
    {
        self.frostedViewController.direction = REFrostedViewControllerDirectionRight;
        if (app.checkview == 0)
        {
            [self.frostedViewController presentMenuViewController];
            app.checkview = 1;
        }
        else
        {
            [self.frostedViewController hideMenuViewController];
            app.checkview = 0;
        }
    }
}

- (IBAction)WhatsyourmindBtnClicked:(id)sender
{
    if ([_checkscreen isEqualToString:@"Institute"])
    {
        AddpostVc *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddpostVc"];
        wc.checkscreen=self.checkscreen;
        [self.navigationController pushViewController:wc animated:YES];
    }
    else if([_checkscreen isEqualToString:@"Standard"])
    {
        AddpostVc *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddpostVc"];
        wc.checkscreen=self.checkscreen;
        wc.dicSelect_std_divi_sub=[self.dicSelect_std_divi_sub mutableCopy];
        [self.navigationController pushViewController:wc animated:YES];
    }
    else if ([_checkscreen isEqualToString:@"Division"])
    {
        AddpostVc *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddpostVc"];
        wc.checkscreen=self.checkscreen;
        wc.dicSelect_std_divi_sub=[self.dicSelect_std_divi_sub mutableCopy];
        [self.navigationController pushViewController:wc animated:YES];
    }
    else if ([_checkscreen isEqualToString:@"Subject"])
    {
        AddpostVc *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddpostVc"];
        wc.checkscreen=self.checkscreen;
        wc.dicSelect_std_divi_sub=[self.dicSelect_std_divi_sub mutableCopy];
        [self.navigationController pushViewController:wc animated:YES];
    }
    else
    {
        AddpostVc *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddpostVc"];
        wc.checkscreen=self.checkscreen;
        [self.navigationController pushViewController:wc animated:YES];
    }
}

- (IBAction)HomeBtnClicked:(id)sender
{
    if ([_checkscreen isEqualToString:@"Institute"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if([_checkscreen isEqualToString:@"Standard"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ([_checkscreen isEqualToString:@"Division"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ([_checkscreen isEqualToString:@"Subject"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.frostedViewController hideMenuViewController];
        OrataroVc *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"OrataroVc"];
        [self.navigationController pushViewController:wc animated:NO];
    }
}


- (IBAction)btnBack_WallMember:(id)sender
{
    [self.viewWallMember setHidden:YES];
}
- (IBAction)btnWallMember:(id)sender {
    [self apiCallFor_GetWallMember:@"1"];
    
}
@end
