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

@interface MyProfileVc ()<UIGestureRecognizerDelegate>
{
    GlobalVc *vc;
    NSMutableArray *imgary,*textary;
    AppDelegate *aj;
    int c2;
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
    
    //next
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
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
    lb.text = [textary objectAtIndex:indexPath.row];
    
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
            
            [self.navigationController pushViewController:vc12 animated:YES];
            break;
        case 15:
            
            [self.navigationController pushViewController:c animated:YES];
            
            break;
            
        default:
            
            break;
    }
}
#pragma mark - button action

- (IBAction)MenuBtnClicked:(id)sender
{
     if (c2==0)
    {
        self.frostedViewController.direction = REFrostedViewControllerDirectionRight;
        self.frostedViewController.panGestureEnabled = NO;
        [self.frostedViewController presentMenuViewController];
        c2=1;
    }
    else
    {
        [self.frostedViewController hideMenuViewController];
        self.frostedViewController.panGestureEnabled = NO;
        c2 =0;
    }
    
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
