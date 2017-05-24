//
//  MyProfileVc.m
//  orataro
//
//  Created by MAC008 on 15/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "MyProfileVc.h"
#import "GlobalVc.h"
#import "REFrostedViewController.h"
#import "PageVc.h"
#import "BlogVc.h"
#import "FriendVc.h"
#import "ChangePasswordVc.h"
#import "ScoolGroupVc.h"
#import "ProjectVc.h"
#import "PhotoVc.h"
#import "PhotoAlbumVc.h"
#import "ProfileVideoVc.h"
#import "ProfileSubjectVc.h"
#import "ProfileStandardVc.h"
#import "ProfileDivisionVc.h"
#import "ListSelectionVc.h"
#import "AppDelegate.h"
#import "SchoolVc.h"
#import "WallVc.h"
#import "ProfileLeaveListSelectVc.h"
#import "DEMONavigationController.h"
#import "Utility.h"
#import "LeaveVc.h"
#import "ProfileLeaveDetailListVc.h"

@interface MyProfileVc ()<UIGestureRecognizerDelegate>
{
    GlobalVc *vc;
    NSMutableArray *imgary,*textary;
    AppDelegate *aj;
    int c2;
    NSMutableDictionary *dic2;
    NSMutableArray *aryGetCount;
}
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@end

@implementation MyProfileVc
@synthesize aProfileTable,aHeaderView,aProfileNameLb,aProfileimageview;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    aj = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    vc = [[GlobalVc alloc]init];
    
    
    imgary = [[NSMutableArray alloc]initWithObjects:@"dash_pages",@"blogico",@"friends",@"photo_blue",@"video",@"photo",@"dash_school_group",@"dash_happygram",@"dash_school_prayer",@"dash_institute",@"standard",@"dash_division",@"dash_subject",@"project",@"leave",@"password", nil];
    
    textary = [[NSMutableArray alloc]initWithObjects:@"Institute Pages",@"Blogs",@"Friends",@"All Photo",@"Video",@"Photo",@"School Groups",@"My Happygram",@"School Prayer",@"Institute",@"Standard",@"Division",@"Subject",@"Project",@"Leave",@"Password", nil];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    aProfileTable.tableHeaderView = aHeaderView;
    
    aProfileTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //set Header Title
    NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
    if (arr.count != 0)
    {
        self.aProfileNameLb.text=[NSString stringWithFormat:@"%@",[[Utility getCurrentUserDetail]objectForKey:@"FullName"]];
        [self getCurrentUserImage:[Utility getCurrentUserDetail]];
    }
    else
    {
        self.aProfileNameLb.text=[NSString stringWithFormat:@""];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    //dic2 = [[[NSUserDefaults standardUserDefaults]valueForKey:@"TotalCountofMember"]mutableCopy];
    
    
  //  NSLog(@"Dic Viewwill=%@",dic2);
    
    
    _lbHeaderTitle.text = [NSString stringWithFormat:@"My Profile (%@)",[Utility getCurrentUserName]];
    
    if([[Utility getMemberType] isEqualToString:@"Student"])
    {
        _btnHealth.hidden = NO;
        _btnParent.hidden = NO;
        _btnPhoneChain.hidden = NO;
    }
    else
    {
        _btnHealth.hidden = YES;
        _btnParent.hidden = YES;
        _btnPhoneChain.hidden = YES;
    }
    
    [self api_getMemberCount];

   
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
            [self.aProfileimageview sd_setImageWithURL:imageURL];
        }
    }
}

#pragma mark - tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyProfileCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyProfileCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row % 2 ==0)
    {
        cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    }
    
    //tag 3
    UIImageView *img1 = (UIImageView *)[cell.contentView viewWithTag:3];
    
    img1.image = [UIImage imageNamed:[imgary objectAtIndex:indexPath.row]];
    
    img1.image = [img1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [img1 setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    img1.contentMode = UIViewContentModeScaleAspectFit;
    
    //tag 2
    UILabel *lb = (UILabel *)[cell.contentView viewWithTag:2];
    
    
    //tag 10
    UILabel *lb1 = (UILabel *)[cell.contentView viewWithTag:10];
    
    //tag 20
    UILabel *lb2 = (UILabel *)[cell.contentView viewWithTag:20];
    
  //  NSLog(@"Dic Cell=%@",dic2);
    
    /* if (indexPath.row == 14)
     {
     lb.hidden = YES;
     lb1.hidden = NO;
     //lb2.hidden = NO;
     lb2.layer.cornerRadius = 10.0;
     lb2.clipsToBounds = YES;
     lb1.text = @"Leave";
     NSMutableArray *ary = [dic2 objectForKey:@"Table2"];
     [lb2 setBackgroundColor:[UIColor redColor]];
     
     NSString *s = [NSString stringWithFormat:@"%@",[[ary objectAtIndex:0]objectForKey:@"LeaveApplication"]];
     
     if ([s isEqualToString:@"0"])
     {
     lb.hidden = YES;
     }
     else
     {
     lb2.hidden = NO;
     lb2.text = [NSString stringWithFormat:@"%@",[[ary objectAtIndex:0]objectForKey:@"LeaveApplication"]];
     }
     
     
     // lb2.text = [textary objectAtIndex:indexPath.row];
     }*/
    
    if (indexPath.row == 14)
    {
        lb.hidden = YES;
        lb1.hidden = NO;
        lb2.layer.cornerRadius = 10.0;
        lb2.clipsToBounds = YES;
        lb1.text = @"Leave";
        [lb2 setBackgroundColor:[UIColor redColor]];

        
        NSLog(@"Ary=%@",aryGetCount);
        
        
        if (aryGetCount.count > 0)
        {
            NSString *str = [NSString stringWithFormat:@"%@",[[aryGetCount objectAtIndex:0]objectForKey:@"LeaveApplication"]];
            
            // NSLog(@"Data=%lu",(unsigned long)str.length);
            
            if (str == (id)[NSNull null] || str.length == 0 || [str isEqual: [NSNull null]] || [str isEqualToString:@"(null)"])
            {
                lb2.hidden = YES;
            }
            else
            {
                if ([str isEqualToString:@"0"])
                {
                    lb2.hidden = YES;
                }
                else
                {
                    lb2.hidden = NO;
                    lb2.text = str;
                }
                
            }

        }
        else
        {
            lb2.hidden = YES;
        }
    }
    else
    {
        lb.hidden = NO;
        lb1.hidden = YES;
        lb2.hidden = YES;
        lb.text = [textary objectAtIndex:indexPath.row];
    }
    
    
    
    UIImageView *imageView;
    
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 6)
    {
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next"]];
    }
    cell.accessoryView = imageView;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return textary.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // as per content
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PageVc *p = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"PageVc"];
    
    BlogVc *b = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"BlogVc"];
    
    FriendVc *f = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"FriendVc"];
    
    ChangePasswordVc *c = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ChangePasswordVc"];
    
    ScoolGroupVc *s = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ScoolGroupVc"];
    
    ProjectVc *p1 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProjectVc"];
    
    PhotoVc *p2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"PhotoVc"];
    
    PhotoAlbumVc *p3 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"PhotoAlbumVc"];
    
    ProfileVideoVc *p4 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfileVideoVc"];
    
    ProfileStandardVc *p5 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfileStandardVc"];
    
    ProfileDivisionVc *p6 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfileDivisionVc"];
    
    ProfileSubjectVc *p7 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfileSubjectVc"];
    
    ListSelectionVc *vc6 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ListSelectionVc"];
    
    SchoolVc  *vc9 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SchoolVc"];
    
    WallVc  *vc10 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WallVc"];
    
    ProfileLeaveListSelectVc *vc12 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfileLeaveListSelectVc"];
    
    ProfileLeaveDetailListVc *vc13 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfileLeaveDetailListVc"];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    
    switch (indexPath.row)
    {
        case 0:
            
            [self.navigationController pushViewController:p animated:YES];
            break;
            
        case 1:
            
            [self.navigationController pushViewController:b animated:YES];
            break;
            
        case 2:
            
            [self.navigationController pushViewController:f animated:YES];
            break;
            
        case 3:
            
            [self.navigationController pushViewController:p2 animated:YES];
            break;
            
        case 4:
            
            [self.navigationController pushViewController:p4 animated:YES];
            break;
            
        case 5:
            
            [self.navigationController pushViewController:p3 animated:YES];
            break;
            
        case 6:
            
            [self.navigationController pushViewController:s animated:YES];
            break;
            
        case 7:
            
            aj.checkListelection = 3;
            [self.navigationController pushViewController:vc6 animated:YES];
            
            break;
            
        case 8:
            //SchoolVc
            [self.navigationController pushViewController:vc9 animated:YES];
            //webview vc
            break;
        case 9:
            
            // wall vc
            vc10.checkscreen = @"Institute";
            [self.navigationController pushViewController:vc10 animated:YES];
            
            break;
        case 10:
            
            [self.navigationController pushViewController:p5 animated:YES];
            break;
        case 11:
            
            [self.navigationController pushViewController:p6 animated:YES];
            break;
            
        case 12:
            
            [self.navigationController pushViewController:p7 animated:YES];
            break;
            
        case 13:
            
            [self.navigationController pushViewController:p1 animated:YES];
            break;
            
        case 14:
            
            if([[Utility getMemberType] isEqualToString:@"Student"])
            {
                [self.navigationController pushViewController:vc13 animated:YES];
            }
            else
            {
                
                [self.navigationController pushViewController:vc12 animated:YES];
            }
            
            break;
            
        case 15:
            [self.navigationController pushViewController:c animated:YES];
            
            break;
            
        default:
            
            break;
    }
}
#pragma mark - button action

- (IBAction)btnGoToMyWall:(id)sender
{
    WallVc  *vc10 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WallVc"];
    vc10.checkscreen = @"MyWall";
    [self.navigationController pushViewController:vc10 animated:YES];
}

- (IBAction)MenuBtnClicked:(id)sender
{
    self.frostedViewController.direction = REFrostedViewControllerDirectionRight;
    
    NSLog(@"app=%d",aj.checkview);
    
    if (aj.checkview == 0)
    {
        [self.frostedViewController presentMenuViewController];
        aj.checkview = 1;
        
    }
    else
    {
        [self.frostedViewController hideMenuViewController];
        aj.checkview = 0;
    }
}

- (IBAction)btnHomeClicked:(id)sender
{
    [self.frostedViewController hideMenuViewController];
    UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"OrataroVc"];
    
    [self.navigationController pushViewController:wc animated:NO];
}

- (IBAction)btnPhoneChainClicked:(id)sender
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"ProfilePhoneChainVc" bundle:nil];
    UIViewController *initViewController = [storyBoard instantiateViewControllerWithIdentifier:@"ProfilePhoneChainVc"];
    [self.navigationController pushViewController:initViewController animated:YES];
}

- (IBAction)btnParentClicked:(id)sender
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"ProfilePhoneChainVc" bundle:nil];
    UIViewController *initViewController = [storyBoard instantiateViewControllerWithIdentifier:@"ParentProfileVc"];
    [self.navigationController pushViewController:initViewController animated:YES];
}

- (IBAction)btnHealthClicked:(id)sender
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"ProfilePhoneChainVc" bundle:nil];
    UIViewController *initViewController = [storyBoard instantiateViewControllerWithIdentifier:@"HealthRecordVc"];
    [self.navigationController pushViewController:initViewController animated:YES];
}

#pragma mark - Member Count

-(void)api_getMemberCount
{
    //#define apk_Notification @"apk_Notification.asmx"
    //#define apk_MemberAllTypeOfCounts_action @"MemberAllTypeOfCounts"
    
    //    <MemberID>guid</MemberID>
    //    <ClientID>guid</ClientID>
    //    <InstituteID>guid</InstituteID>
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_Notification,apk_MemberAllTypeOfCounts_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    
    
   // [ProgressHUB showHUDAddedTo:self.view];
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableDictionary *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             if([arrResponce count] != 0)
             {
                 NSLog(@"arr=%@",arrResponce);
                 
                 @try
                 {
                     aryGetCount = [arrResponce objectForKey:@"Table2"];
                     
                     [[NSUserDefaults standardUserDefaults]setObject:arrResponce forKey:@"TotalCountofMember"];
                     [[NSUserDefaults standardUserDefaults]synchronize];
                     [aProfileTable reloadData];
                     
                 }
                 @catch (NSException *exception)
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 
                 
                 // strCheckUser =@"SwitchAccount";
                 //  strCheckUser =@"WallVc";
                 
                 // NSLog(@"Strcheck=%@",strCheckUser);
                 //
                 //                 if ([strCheckUser isEqualToString:@"SwitchAccount"])
                 //                 {
                 //                     UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SwitchAcoountVC"];
                 //                     [self.navigationController pushViewController:wc animated:YES];
                 //                 }
                 //                 else
                 //                 {
                 //                     [self performSegueWithIdentifier:@"ShowWall" sender:self];
                 //                 }
                 //                 WallVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WallVc"];
                 //                 vc.checkscreen = @"FromLogin";
                 //                 app.checkview = 0;
                 //
                 //                 [self.navigationController pushViewController:vc animated:YES];
                 
                 
                 
                 //api_getMemberCount
                 // [self performSegueWithIdentifier:@"ShowWall" sender:self];
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
