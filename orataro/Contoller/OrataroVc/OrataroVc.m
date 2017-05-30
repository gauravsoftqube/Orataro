//
//  OrataroVc.m
//  orataro
//
//  Created by MAC008 on 08/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "OrataroVc.h"
#import "OrataroCell.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "REFrostedViewController.h"
#import "DEMONavigationController.h"
#import "Global.h"

@interface OrataroVc ()<UIScrollViewDelegate>
    {
        UICollectionView *coll;
        NSMutableArray *ary;
        NSMutableArray *aimageary,*imgary;
        AppDelegate *ap;
        NSMutableDictionary *dic;
        NSString *s;
        NSMutableArray *aryGetMemberCount;
    }
    @end

@implementation OrataroVc
    @synthesize aCollectionView,aHeaderView;
    
- (void)viewDidLoad
    {
        [super viewDidLoad];
        
        _viewLogout.hidden = YES;
        _imgClose.image = [_imgClose.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_imgClose setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
        _viewSaveOuter.layer.cornerRadius = 30.0;
        _viewSaveInner.layer.cornerRadius = 25.0;
        
        ap = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        // String[] colorlist = { "#2D2079", "#582388", "#741A87", "#DC55A1",
        //  "#2D288A", "#2D68A0", "#6E649E", "#B089A9", "#E487A5", "#40AD9F",
        // "#6BBE95", "#582388", "#741A87","#E487A5","#2D288A" , "#6E649E","#DC55A1", "#741A87","#582388"};
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        
        ary = [[NSMutableArray alloc]initWithObjects:@"Profile",@"Circular",@"Wall",@"Homework",@"Classwork",@"Attendance",@"PT Communication",@"Exam Timing",@"Time Table",@"Notes",@"Holiday",@"Calendar",@"Poll",@"Notification",@"Reminder",@"About Orataro",@"Settings",@"FAQ", nil];
        
        
        imgary = [[NSMutableArray alloc]initWithObjects:@"dash_profile",@"dash_circular",@"dash_fb_wall",@"dash_homework",@"classimg",@"attendance",@"dash_pt_communication",@"dash_school_timing",@"dash_timetable",@"dash_notice",@"dash_holidays",@"dash_calendar",@"dash_fb_poll",@"speech",@"todo",@"user",@"settings",@"faq", nil];
        
        self.headerImageViewHeight.constant = 100;
        [self adjustContentViewHeight];
        
        
        for (int i=0; i<ary.count; i++)
        {
            
            if (ary.count % 3 == 0)
            {
                NSLog(@"val=%d ary count=%lu",i,ary.count/3);
            }
            else
            {
                NSLog(@"val1 is=%d",i);
            }
        }
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [layout setItemSize:CGSizeMake(coll.frame.size.width/3, coll.frame.size.width/3)];
        [layout setMinimumLineSpacing:0];
        [layout setMinimumInteritemSpacing:0];
        
        coll = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
        
        CGFloat f = coll.frame.size.width/3;
        
        NSLog(@"data=%f",f);
        
        CGFloat cal = (f * ary.count/3);
        
        NSLog(@"data=%f",cal);
        
        NSLog(@"data=%f",(f*ary.count));
        
        
        self.contentViewHeight.constant = (f*ary.count)/3;
        [coll setFrame:CGRectMake(0, 0, self.view.frame.size.width, f*ary.count/3)];
        
        [coll setScrollEnabled:NO];
        [coll setBounces:NO];
        
        [coll setDataSource:self];
        [coll setDelegate:self];
        
        [coll registerClass:[OrataroCell class] forCellWithReuseIdentifier:@"OrataroCell"];
        [coll setBackgroundColor:[UIColor clearColor]];
        
        [coll registerNib:[UINib nibWithNibName:@"OrataroCell" bundle:nil] forCellWithReuseIdentifier:@"OrataroCell"];
        
        [self.contentView addSubview:coll];;
        // Do any additional setup after loading the view.
    }
    
- (void)didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }
    
-(void)viewWillAppear:(BOOL)animated
    {
        // dic = [[[NSUserDefaults standardUserDefaults]valueForKey:@"TotalCountofMember"]mutableCopy];
        
        // NSLog(@"Dic=%@",dic);
        
        // NSMutableArray *ary1 = [dic objectForKey:@"Table"];
        
        // s  = [NSString stringWithFormat:@"%@",[[ary1 objectAtIndex:0]objectForKey:@"NotificationCount"]];
        [self api_getMemberCount];
    }
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
    {
        OrataroCell *cell = (OrataroCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"OrataroCell" forIndexPath:indexPath];
        
        cell.aLable.text = [ary objectAtIndex:indexPath.row];
        cell.aImageView.image = [UIImage imageNamed:[imgary objectAtIndex:indexPath.row]];
        
        
        if (indexPath.row == 2)
        {
            //cell.aLable.hidden = no;
            cell.lbWallCount.hidden = NO;
            cell.lbWallCount.layer.cornerRadius = 10.0;
            cell.lbWallCount.clipsToBounds = YES;
            cell.aLable.text = @"Wall";
            
            //NSLog(@"Ary=%@",getData);
            
            NSString *str = [NSString stringWithFormat:@"%@",[[aryGetMemberCount objectAtIndex:0]objectForKey:@"NotificationCount"]];
            
            // NSLog(@"Data=%lu",(unsigned long)str.length);
            
            if (str == (id)[NSNull null] || str.length == 0 || [str isEqual: [NSNull null]] || [str isEqualToString:@"(null)"])
            {
                cell.lbWallCount.hidden = YES;
            }
            else
            {
                if ([str isEqualToString:@"0"])
                {
                    cell.lbWallCount.hidden = YES;
                }
                else
                {
                    cell.lbWallCount.hidden = NO;
                    cell.lbWallCount.text = str;
                }
                
            }
            cell.aView.backgroundColor = [UIColor colorWithRed:116.0/255.0 green:26.0/255.0 blue:135.0/255.0 alpha:1.0];
        }
        else
        {
            if (indexPath.row == 0)
            {
                cell.lbWallCount.hidden = YES;
                cell.aView.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:32.0/255.0 blue:121.0/255.0 alpha:1.0];
            }
            else if (indexPath.row == 1)
            {
                cell.lbWallCount.hidden = YES;
                
                cell.aView.backgroundColor = [UIColor colorWithRed:88.0/255.0 green:35.0/255.0 blue:136.0/255.0 alpha:1.0];
            }
            else if (indexPath.row == 3)
            {
                cell.lbWallCount.hidden = YES;
                cell.aView.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:85.0/255.0 blue:161.0/255.0 alpha:1.0];
            }
            else if (indexPath.row == 4)
            {
                cell.lbWallCount.hidden = YES;
                cell.aView.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:40.0/255.0 blue:138.0/255.0 alpha:1.0];
            }
            else if (indexPath.row == 5)
            {
                cell.lbWallCount.hidden = YES;
                cell.aView.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:104.0/255.0 blue:160.0/255.0 alpha:1.0];
            }
            else if (indexPath.row == 6)
            {
                cell.lbWallCount.hidden = YES;
                cell.aView.backgroundColor = [UIColor colorWithRed:110.0/255.0 green:100.0/255.0 blue:158.0/255.0 alpha:1.0];
                
            }else if (indexPath.row == 7)
            {
                cell.lbWallCount.hidden = YES;
                cell.aView.backgroundColor = [UIColor colorWithRed:176.0/255.0 green:137.0/255.0 blue:169.0/255.0 alpha:1.0];
                
            }else if (indexPath.row == 8)
            {
                cell.lbWallCount.hidden = YES;
                cell.aView.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:135.0/255.0 blue:165.0/255.0 alpha:1.0];
            }else if (indexPath.row == 9)
            {
                cell.lbWallCount.hidden = YES;
                cell.aView.backgroundColor = [UIColor colorWithRed:64.0/255.0 green:173.0/255.0 blue:159.0/255.0 alpha:1.0];
            }else if (indexPath.row == 10)
            {
                cell.lbWallCount.hidden = YES;
                cell.aView.backgroundColor = [UIColor colorWithRed:107.0/255.0 green:190.0/255.0 blue:149.0/255.0 alpha:1.0];
            }else if (indexPath.row == 11)
            {
                cell.lbWallCount.hidden = YES;
                cell.aView.backgroundColor = [UIColor colorWithRed:88.0/255.0 green:35.0/255.0 blue:136.0/255.0 alpha:1.0];
            }else if (indexPath.row == 12)
            {
                cell.lbWallCount.hidden = YES;
                cell.aView.backgroundColor = [UIColor colorWithRed:116.0/255.0 green:26.0/255.0 blue:135.0/255.0 alpha:1.0];
            }
            else if (indexPath.row == 13)
            {
                cell.lbWallCount.hidden = YES;
                cell.aView.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:135.0/255.0 blue:134.0/165.0 alpha:1.0];
            }
            else if (indexPath.row == 14)
            {
                cell.lbWallCount.hidden = YES;
                cell.aView.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:40.0/255.0 blue:138.0/255.0 alpha:1.0];
            }else if (indexPath.row == 15)
            {
                cell.lbWallCount.hidden = YES;
                cell.aView.backgroundColor = [UIColor colorWithRed:110.0/255.0 green:100.0/255.0 blue:158.0/255.0 alpha:1.0];
            }
            else if (indexPath.row == 16)
            {
                cell.lbWallCount.hidden = YES;
                cell.aView.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:85.0/255.0 blue:161.0/255.0 alpha:1.0];
            }
            else if (indexPath.row == 17)
            {
                cell.lbWallCount.hidden = YES;
                cell.aView.backgroundColor = [UIColor colorWithRed:116.0/255.0 green:26.0/255.0 blue:135.0/255.0 alpha:1.0];
            }
        }
        
        /* switch (indexPath.row)
         {
         case 0:
         
         //2D2079 ,45,32,121
         
         cell.lbWallCount.hidden = YES;
         cell.aView.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:32.0/255.0 blue:121.0/255.0 alpha:1.0];
         
         break;
         case 1:
         
         //582388 88,35,136
         cell.lbWallCount.hidden = YES;
         
         cell.aView.backgroundColor = [UIColor colorWithRed:88.0/255.0 green:35.0/255.0 blue:136.0/255.0 alpha:1.0];
         
         //cell.aView.backgroundColor = [UIColor colorWithRed:87.0/255.0 green:40.0/255.0 blue:134.0/255.0 alpha:1.0];
         
         break;
         case 2:
         
         //,116,26,135
         // cell.lbWallCount.hidden = NO;
         
         cell.lbWallCount.layer.cornerRadius = 10.0;
         
         if ([s isEqualToString:@"0"])
         {
         cell.lbWallCount.hidden = YES;
         }
         else
         {
         cell.lbWallCount.hidden = NO;
         cell.lbWallCount.text = [NSString stringWithFormat:@"%@",[[ary objectAtIndex:0]objectForKey:@"NotificationCount"]];
         }
         
         
         /* NSString *str = [NSString stringWithFormat:@"%@",[[aryGetMemberCount objectAtIndex:0]objectForKey:@"NotificationCount"]];
         
         // NSLog(@"Data=%lu",(unsigned long)str.length);
         
         if (str == (id)[NSNull null] || str.length == 0 || [str isEqual: [NSNull null]] || [str isEqualToString:@"(null)"])
         {
         cell.lbWallCount.hidden = YES;
         }
         else
         {
         if ([str isEqualToString:@"0"])
         {
         cell.lbWallCount.hidden = YES;
         }
         else
         {
         cell.lbWallCount.hidden = NO;
         cell.lbWallCount.text = str;
         }
         
         }
         
         
         cell.aView.backgroundColor = [UIColor colorWithRed:116.0/255.0 green:26.0/255.0 blue:135.0/255.0 alpha:1.0];
         
         break;
         case 3:
         
         //220,85,161
         cell.lbWallCount.hidden = YES;
         cell.aView.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:85.0/255.0 blue:161.0/255.0 alpha:1.0];
         
         break;
         case 4:
         
         //45,40,138
         cell.lbWallCount.hidden = YES;
         cell.aView.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:40.0/255.0 blue:138.0/255.0 alpha:1.0];
         
         break;
         case 5:
         
         //45,104,160
         cell.lbWallCount.hidden = YES;
         cell.aView.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:104.0/255.0 blue:160.0/255.0 alpha:1.0];
         
         break;
         case 6:
         
         //110,100,158
         cell.lbWallCount.hidden = YES;
         cell.aView.backgroundColor = [UIColor colorWithRed:110.0/255.0 green:100.0/255.0 blue:158.0/255.0 alpha:1.0];
         
         break;
         case 7:
         
         //B089A9 176,137,169
         cell.lbWallCount.hidden = YES;
         cell.aView.backgroundColor = [UIColor colorWithRed:176.0/255.0 green:137.0/255.0 blue:169.0/255.0 alpha:1.0];
         
         break;
         case 8:
         
         //228,135,165
         cell.lbWallCount.hidden = YES;
         cell.aView.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:135.0/255.0 blue:165.0/255.0 alpha:1.0];
         
         break;
         case 9:
         
         //64,173,159
         cell.lbWallCount.hidden = YES;
         cell.aView.backgroundColor = [UIColor colorWithRed:64.0/255.0 green:173.0/255.0 blue:159.0/255.0 alpha:1.0];
         
         break;
         case 10:
         
         //107,190,149
         cell.lbWallCount.hidden = YES;
         cell.aView.backgroundColor = [UIColor colorWithRed:107.0/255.0 green:190.0/255.0 blue:149.0/255.0 alpha:1.0];
         
         break;
         case 11:
         cell.lbWallCount.hidden = YES;
         //8835136
         cell.aView.backgroundColor = [UIColor colorWithRed:88.0/255.0 green:35.0/255.0 blue:136.0/255.0 alpha:1.0];
         
         break;
         case 12:
         
         //116,26,135
         cell.lbWallCount.hidden = YES;
         cell.aView.backgroundColor = [UIColor colorWithRed:116.0/255.0 green:26.0/255.0 blue:135.0/255.0 alpha:1.0];
         
         break;
         case 13:
         cell.lbWallCount.hidden = YES;
         cell.aView.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:135.0/255.0 blue:134.0/165.0 alpha:1.0];
         
         break;
         case 14:
         //,45,40,138
         cell.lbWallCount.hidden = YES;
         cell.aView.backgroundColor = [UIColor colorWithRed:45.0/255.0 green:40.0/255.0 blue:138.0/255.0 alpha:1.0];
         
         break;
         case 15:
         
         //,110,100,158
         cell.lbWallCount.hidden = YES;
         cell.aView.backgroundColor = [UIColor colorWithRed:110.0/255.0 green:100.0/255.0 blue:158.0/255.0 alpha:1.0];
         
         break;
         case 16:
         
         //220,85,161
         cell.lbWallCount.hidden = YES;
         cell.aView.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:85.0/255.0 blue:161.0/255.0 alpha:1.0];
         
         break;
         case 17:
         cell.lbWallCount.hidden = YES;
         //741A87 116,26,135
         cell.aView.backgroundColor = [UIColor colorWithRed:116.0/255.0 green:26.0/255.0 blue:135.0/255.0 alpha:1.0];
         
         break;
         
         default:
         break;
         }*/
        //OrataroCell
        
        //UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
        //recipeImageView.image =
        return cell;
    }
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
    {
        return ary.count;
    }
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
    {
        CGFloat f = coll.frame.size.width/3;
        
        //  self.contentViewHeight.constant = f*ary.count;
        
        NSLog(@"ary count=%lu",(unsigned long)ary.count);
        
        NSLog(@"view width=%f",f);
        
        return CGSizeMake(f, f);
    }
    
    
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}
    
- (IBAction)backtoLanguageBtnClicked:(id)sender
    {
        //  ProfileSubjectVc *p7 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfileSubjectVc"];
        //  [self.navigationController pushViewController:f animated:YES];
        
        
        //NSLog(@"array=%@",[self.navigationController viewControllers]ob);
        
        ap.checkhomeLang = 1;
        ViewController *p7 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ViewController"];
        [self.navigationController pushViewController:p7 animated:YES];
        
        
        if ([[self.navigationController viewControllers]containsObject:p7])
        {
            NSLog(@"ssdsdsd");
        }
        // [self.navigationController popViewControllerAnimated:YES];
    }
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
    {
        switch (indexPath.row)
        {
            case 0:
            {
                UIViewController  *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MyProfileVc"];
                [self.navigationController pushViewController:vc animated:YES];
                
                break;
            }
            case 1:
            {
                UIViewController  *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CircularVc"];
                [self.navigationController pushViewController:vc animated:YES];            break;
            }
            case 2:
            {
                UIViewController  *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WallVc"];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 3:
            {
                UIViewController  *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeWrokVc"];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 4:
            {
                UIViewController  *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ClassworkVC"];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 5:
            
            {
                UIViewController  *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AttendanceVC"];
                [self.navigationController pushViewController:vc animated:YES];            break;
            }
            case 6:
            
            {
                if([[Utility getMemberType] isEqualToString:@"Student"])
                {
                    UIViewController  *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"StudentListViewController"];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else
                {
                    UIViewController  *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ListSelectionVc"];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                break;
            }
            case 7:
            
            {
                UIViewController  *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageVc"];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 8:
            
            {
                UIViewController  *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TimeTableVc"];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 9:
            
            {
                UIViewController  *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NoteVc"];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 10:
            
            {
                UIViewController  *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"HolidayVc"];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            
            case 11:
            
            {
                UIViewController  *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CalenderVc"];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 12:
            
            {
                UIViewController  *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PollVc"];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 13:
            
            {
                UIViewController  *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationVc"];
                [self.navigationController pushViewController:vc animated:YES];            break;
            }
            case 14:
            
            {
                UIViewController  *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateReminderVc"];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            
            case 15:
            
            {
                UIViewController  *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutOrataroVc"];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            
            case 16:
            
            {
                UIViewController  *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingVcViewController"];
                [self.navigationController pushViewController:vc animated:YES];            break;
            }
            case 17:
            
            {
                UIViewController  *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FAQvc"];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            
            default:
            break;
        }
        // self.frostedViewController.contentViewController = navigationController;
        // [self.frostedViewController hideMenuViewController];
        
        
    }
    
#pragma mark - button action
    
- (IBAction)btnCancelClicked:(id)sender
    {
        _viewLogout.hidden = YES;
    }
- (IBAction)btnSaveClicked:(id)sender
    {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"TotalCountofMember"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"DeviceToken"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"currentDeviceId"];
       // [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Password"];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"LoginVC"];
        [self.navigationController pushViewController:wc animated:YES];
    }
- (IBAction)LogoutBtnClicked:(UIButton *)sender
    {
        _viewLogout.hidden = NO;
        [self.view bringSubviewToFront:_viewLogout];
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
                         aryGetMemberCount = [arrResponce objectForKey:@"Table"];
                         
                         [[NSUserDefaults standardUserDefaults]setObject:arrResponce forKey:@"TotalCountofMember"];
                         [[NSUserDefaults standardUserDefaults]synchronize];
                         [aCollectionView reloadData];
                         
                     }
                     @catch (NSException *exception)
                     {
                         //UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         //[alrt show];
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
