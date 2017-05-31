//
//  NotificationVc.m
//  orataro
//
//  Created by MAC008 on 08/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "NotificationVc.h"
#import "REFrostedViewController.h"
#import "AppDelegate.h"
#import "Global.h"

@interface NotificationVc ()
{
    int c2;
    AppDelegate *app;
    long totalCountView,countResponce;
    NSMutableArray *arrNotificationList;
}
@end

@implementation NotificationVc
@synthesize aTableview;

- (void)viewDidLoad
{
    [super viewDidLoad];

    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    aTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
 
    totalCountView=1;
    
    [self commonData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    arrNotificationList = [[NSMutableArray alloc]init];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    UITableViewController *tableViewController = [[UITableViewController alloc] init];
    tableViewController.tableView = self.aTableview;
    tableViewController.refreshControl = refreshControl;
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    spinner.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 44);
    self.aTableview.tableFooterView = spinner;
    
    
    NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
    if (arr.count != 0) {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Notification (%@)",[arr objectAtIndex:0]];
    }
    else
    {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Notification"];
    }
    
    [self apiCallMethod];
}

- (void)refresh
{
    
}

-(void)refreshData
{
    [self apiCallMethod];
}

-(void)apiCallMethod
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        arrNotificationList = [[NSMutableArray alloc]init];
        NSArray *ary = [DBOperation selectData:@"select * from NotificationList"];
        arrNotificationList = [Utility getLocalDetail:ary columnKey:@"dic_json"];
        
        [self.aTableview reloadData];
        
        if(arrNotificationList.count == 0)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
    }
    else
    {
        arrNotificationList = [[NSMutableArray alloc]init];
        NSArray *ary = [DBOperation selectData:@"select * from NotificationList"];
        arrNotificationList = [Utility getLocalDetail:ary columnKey:@"dic_json"];
        
        
        [self.aTableview reloadData];
        
        if(arrNotificationList.count == 0)
        {
            [self apiCallFor_getNotifList:YES];
        }
        else
        {
            [self apiCallFor_getNotifList:NO];
        }
    }
}

#pragma mark - ApiCall

-(void)apiCallFor_SetViewFlageOnNotification : (NSMutableArray *)arrId
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_notifications,apk_SetViewFlageOnNotification_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];

    NSString *strNotiId=[arrId componentsJoinedByString:@","];
    
    [param setValue:[NSString stringWithFormat:@"%@",strNotiId] forKey:@"multidataidsepratbycomma"];
    
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         
         if(!error)
         {
//             NSString *strArrd=[dicResponce objectForKey:@"d"];
//             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
//             NSMutableArray *arrResponce = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]mutableCopy];
//             
//             if([arrResponce count] != 0)
//             {
//                 NSMutableDictionary *dic=[[arrResponce objectAtIndex:0]mutableCopy];
//                 NSString *strStatus=[[dic objectForKey:@"message"]mutableCopy];
//                 if([strStatus isEqualToString:@"No Data Found"])
//                 {
//                     
//                 }
//                 else
//                 {
//                 }
//             }
//             else
//             {
//                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                 [alrt show];
//             }
         }
         else
         {
//             UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//             [alrt show];
         }
     }];
}


-(void)apiCallFor_getNotifList : (BOOL)checkProgress
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_notifications,apk_NotificationGetList_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%ld",totalCountView] forKey:@"RowCount"];
    [param setValue:[NSString stringWithFormat:@""] forKey:@"IsView"];
    
    
    if (checkProgress == YES)
    {
       // [ProgressHUB showHUDAddedTo:self.view];
    }
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [aTableview.tableFooterView setHidden:YES];
         [self.aTableview.bottomRefreshControl endRefreshing];
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             if([strArrd length] != 0)
             {
                 NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
                 NSMutableArray *arrResponce = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]mutableCopy];
                 
                 if([arrResponce count] != 0)
                 {
                     NSMutableDictionary *dic=[[arrResponce objectAtIndex:0]mutableCopy];
                     NSString *strStatus=[[dic objectForKey:@"message"]mutableCopy];
                     if([strStatus isEqualToString:@"No Data Found"])
                     {
                         UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [alrt show];
                     }
                     else
                     {
                         countResponce = [arrResponce count];
                         for (NSMutableDictionary *dic in arrResponce) {
                             if([[arrNotificationList valueForKey:@"NotificationID"] containsObject:[dic objectForKey:@"NotificationID"]])
                             {
                                 [arrNotificationList removeObject:dic];
                                 [arrNotificationList addObject:dic];
                             }
                             else
                             {
                                 [arrNotificationList addObject:dic];
                             }
                         }
                         
                         [arrNotificationList addObjectsFromArray:arrResponce];
                         
                         [DBOperation executeSQL:@"delete from NotificationList"];
                         for (NSMutableDictionary *dic in arrNotificationList)
                         {
                             NSString *getjsonstr = [Utility Convertjsontostring:dic];
                             [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO NotificationList (dic_json) VALUES ('%@')",getjsonstr]];
                         }
                         
                         NSMutableArray *ArrNotifId=[arrResponce valueForKey:@"NotificationID"];
                         if ([Utility isInterNetConnectionIsActive] == true)
                         {
                             [self apiCallFor_SetViewFlageOnNotification:ArrNotifId];
                         }
                         [self.aTableview reloadData];
                     }
                     
                 }
                 else
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
             }
         }
         else
         {
             UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alrt show];
         }
     }];
}

#pragma mark - tableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrNotificationList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NotificationCell"];
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

    UIImageView *img1 = (UIImageView *)[cell.contentView viewWithTag:2];
    
    
    
    NSString *FullName=[[arrNotificationList objectAtIndex:indexPath.row]objectForKey:@"FullName"];
    
    
    NSString *NotificationType=[[arrNotificationList objectAtIndex:indexPath.row]objectForKey:@"NotificationType"];
    
    if( [NotificationType caseInsensitiveCompare:@"like"] == NSOrderedSame )
    {
        img1.image = [UIImage imageNamed:@"fb_like_gray"];
        img1.image = [img1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [img1 setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    }
    else if( [NotificationType caseInsensitiveCompare:@"dislike"] == NSOrderedSame )
    {
        img1.image = [UIImage imageNamed:@"fb_unlike_gray"];
        img1.image = [img1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [img1 setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    }
    else if( [NotificationType caseInsensitiveCompare:@"Share"] == NSOrderedSame )
    {
        img1.image = [UIImage imageNamed:@"fb_share_gray"];
        img1.image = [img1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [img1 setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    }
    else if( [NotificationType caseInsensitiveCompare:@"Comment"] == NSOrderedSame )
    {
        img1.image = [UIImage imageNamed:@"fb_comments_gry"];
        img1.image = [img1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [img1 setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    }
    
    NSString *comment=[[arrNotificationList objectAtIndex:indexPath.row]objectForKey:@"NotificationText"];
    
    //3,4,5
    UILabel *lbl = (UILabel *)[cell.contentView viewWithTag:1];
    lbl.text=[NSString stringWithFormat:@"%@ %@",FullName,comment];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *FullName=[[arrNotificationList objectAtIndex:indexPath.row]objectForKey:@"FullName"];
    NSString *comment=[[arrNotificationList objectAtIndex:indexPath.row]objectForKey:@"NotificationText"];
    NSString *yourText = [NSString stringWithFormat:@"%@ %@",FullName,comment];
    
    CGSize size = [yourText sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:14] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-54, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    return size.height+30;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSInteger totalRow = [tableView numberOfRowsInSection:indexPath.section];
    
    if(indexPath.row == totalRow -1)
    {
        if(countResponce == 15)
        {
            totalCountView = totalCountView + 15;

            if ([Utility isInterNetConnectionIsActive] == true)
            {
                [self.aTableview.tableFooterView setHidden:NO];
                [self apiCallFor_getNotifList:NO];
            }
        }
        else
        {
            [self.aTableview.tableFooterView setHidden:YES];
        }
    }
}


#pragma mark - button action

- (IBAction)MenuBtnClicked:(id)sender
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

- (IBAction)btnHomeClicked:(id)sender
{
     [self.frostedViewController hideMenuViewController];
    
    UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"OrataroVc"];
    
    [self.navigationController pushViewController:wc animated:NO];
}

@end
