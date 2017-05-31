//
//  DEMOMenuViewController.m
//  REFrostedViewControllerStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOMenuViewController.h"
#import "DEMOHomeViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "DEMONavigationController.h"

#import "AddpostVc.h"
#import "REFrostedViewController.h"
#import "AddCircularVc.h"
#import "ListSelectionVc.h"
#import "AddClassWorkVc.h"
#import "AttendanceVC.h"
#import "StudentListViewController.h"
#import "PTCommuniVc.h"
#import "AddNoteVc.h"
#import "HolidayVc.h"
#import "AddPollVc.h"
#import "ResultVc.h"
#import "PollVc.h"
#import "NotificationVc.h"
#import "OrataroVc.h"
#import "ReminderVc.h"
#import "AboutOrataroVc.h"
#import "HelpDeskVc.h"
#import "AboutUsVc.h"
#import "SettingVcViewController.h"
#import "FAQvc.h"
#import "MyProfileVc.h"
#import "PageVc.h"
#import "MessageVc.h"
#import "BlogVc.h"
#import "FriendVc.h"
#import "WallVc.h"
#import "CircularVc.h"
#import "HomeWrokVc.h"
#import "ClassworkVC.h"
#import "TimeTableVc.h"
#import "NoteVc.h"
#import "CalenderVc.h"
#import "CreateReminderVc.h"
#import "AppDelegate.h"
#import "RightCell.h"
#import "Global.h"

@interface DEMOMenuViewController ()
{
    NSMutableArray *menu,*imgary;
    NSMutableArray *amenuary,*aimgary;
    AppDelegate *ag ;
    NSString *WallCount;
    NSMutableDictionary *dic;
    NSMutableArray *getData;
}
@end

@implementation DEMOMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.view.frame = CGRectMake(50, 64, self.view.frame.size.width-50, self.view.frame.size.height);
    
    ag = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    menu = [[NSMutableArray alloc]initWithObjects:@"Profile",@"Circular",@"Wall",@"Homework",@"Classwork",@"Attendance",@"PT Communication",@"Exam Timing",@"Time Table",@"Notes",@"Holiday",@"Calendar",@"Poll",@"Notification",@"Reminder",@"About Orataro",@"Settings",@"FAQ",@"Switch Account",@"Profile",nil];
    
    imgary = [[NSMutableArray alloc]initWithObjects:@"dash_profile",@"dash_circular",@"dash_fb_wall",@"dash_homework",@"classimg",@"attendance",@"dash_pt_communication",@"dash_school_timing",@"dash_timetable",@"dash_notice",@"dash_holidays",@"dash_calendar",@"dash_fb_poll",@"speech",@"todo",@"user",@"settings",@"faq",
              @"dash_switch",@"dash_profile",nil];
    
    //_tblMenuTable.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    [_tblMenuTable registerNib:[UINib nibWithNibName:@"RightCell" bundle:nil] forCellReuseIdentifier:@"RightCell"];
    _tblMenuTable.backgroundColor= [UIColor clearColor];
    _tblMenuTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    //  [self api_getMemberCount];
    
    //_tblMenuTable.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    //   [_tblHeight setConstant:_tblMenuTable.frame.size.height+60];
    
    // [_tblMenuTable reloadData];
    
    //Put this code where you want to reload your table view
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        [UIView transitionWithView:_tblMenuTable                          duration:0.1f
    //                           options:UIViewAnimationOptionCurveLinear
    //                        animations:^(void) {
    //                            [_tblMenuTable reloadData];
    //                        } completion:NULL];
    //    });
    
}

-(void)viewWillAppear:(BOOL)animated
{
    //NSLog(@"Getdata=%@",getData);
    
    [_tblMenuTable reloadData];
    
    [self api_getMemberCount];
}
#pragma mark UITableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return menu.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RightCell *cell = (RightCell *)[tableView dequeueReusableCellWithIdentifier:@"RightCell"];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RightCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if (indexPath.row % 2 ==0)
    {
        cell.backgroundColor = [UIColor colorWithRed:50.0/255.0 green:60.0/255.0 blue:101.0/255.0 alpha:1.0];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithRed:33.0/255.0 green:42.0/255.0 blue:77.0/255.0 alpha:1.0];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 2)
    {
        cell.aTextLb.hidden = YES;
        cell.LbWall.hidden = NO;
        cell.LbWallCount.layer.cornerRadius = 10.0;
        cell.LbWallCount.clipsToBounds = YES;
        cell.LbWall.text = @"Wall";
        cell.LbWallCount.hidden = YES;

        //NSLog(@"Ary=%@",getData);
        
        NSString *str = [NSString stringWithFormat:@"%@",[[getData objectAtIndex:0]objectForKey:@"NotificationCount"]];
        
        // NSLog(@"Data=%lu",(unsigned long)str.length);
        
        if (getData.count > 0)
        {
            if (str == (id)[NSNull null] || str.length == 0 || [str isEqual: [NSNull null]] || [str isEqualToString:@"(null)"])
            {
                cell.LbWallCount.hidden = YES;
            }
            else
            {
                if ([str isEqualToString:@"0"])
                {
                    cell.LbWallCount.hidden = YES;
                }
                else
                {
                    cell.LbWallCount.hidden = NO;
                    cell.LbWallCount.text = str;
                }
                
            }
        }
        
    }
    else
    {
        cell.aTextLb.hidden = NO;
        cell.LbWallCount.hidden = YES;
        cell.LbWall.hidden = YES;
        cell.aTextLb.text = [menu objectAtIndex:indexPath.row];
        
    }
    cell.aImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[imgary objectAtIndex:indexPath.row]]];
    
    cell.aImageView.image = [cell.aImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [cell.aImageView setTintColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]];
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // return self.view.frame.size.height/menu.count;
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DEMONavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    switch (indexPath.row)
    {
        case 0:
        {
            MyProfileVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyProfileVc"];
            navigationController.viewControllers = @[homeViewController];
            self.frostedViewController.contentViewController = navigationController;
            break;
        }
        case 1:
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"] )
            {
                if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
                {
                    if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
                    {
                        if([[Utility getUserRoleRightList:@"Circular" settingType:@"IsView"] integerValue] == 1)
                        {
                            CircularVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CircularVc"];
                            navigationController.viewControllers = @[homeViewController];
                            self.frostedViewController.contentViewController = navigationController;
                        }
                        else
                        {
                            [WToast showWithText:You_dont_have_permission];
                        }
                    }
                    else
                    {
                        CircularVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CircularVc"];
                        navigationController.viewControllers = @[homeViewController];
                        self.frostedViewController.contentViewController = navigationController;
                    }
                }
                else
                {
                    CircularVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CircularVc"];
                    navigationController.viewControllers = @[homeViewController];
                    self.frostedViewController.contentViewController = navigationController;
                }
            }
            else
            {
                CircularVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CircularVc"];
                navigationController.viewControllers = @[homeViewController];
                self.frostedViewController.contentViewController = navigationController;
            }
            break;
        }
        case 2:
        {
            WallVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WallVc"];
            navigationController.viewControllers = @[homeViewController];
            self.frostedViewController.contentViewController = navigationController;
            break;
        }
        case 3:
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"])
            {
                if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
                {
                    if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
                    {
                        if([[Utility getUserRoleRightList:@"Home Work" settingType:@"IsView"] integerValue] == 1)
                        {
                            HomeWrokVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeWrokVc"];
                            navigationController.viewControllers = @[homeViewController];
                            self.frostedViewController.contentViewController = navigationController;
                        }
                        else
                        {
                            [WToast showWithText:You_dont_have_permission];
                        }
                    }
                    else
                    {
                        HomeWrokVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeWrokVc"];
                        navigationController.viewControllers = @[homeViewController];
                        self.frostedViewController.contentViewController = navigationController;
                    }
                }
                else
                {
                    HomeWrokVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeWrokVc"];
                    navigationController.viewControllers = @[homeViewController];
                    self.frostedViewController.contentViewController = navigationController;
                }
            }
            else
            {
                HomeWrokVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeWrokVc"];
                navigationController.viewControllers = @[homeViewController];
                self.frostedViewController.contentViewController = navigationController;
            }
            break;
        }
        case 4:
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"])
            {
                if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
                {
                    if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
                    {
                        if([[Utility getUserRoleRightList:@"Class Work" settingType:@"IsView"] integerValue] == 1)
                        {
                            ClassworkVC  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ClassworkVC"];
                            navigationController.viewControllers = @[homeViewController];
                            self.frostedViewController.contentViewController = navigationController;
                        }
                        else
                        {
                            [WToast showWithText:You_dont_have_permission];
                        }
                    }
                    else
                    {
                        ClassworkVC  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ClassworkVC"];
                        navigationController.viewControllers = @[homeViewController];
                        self.frostedViewController.contentViewController = navigationController;
                    }
                }
                else
                {
                    ClassworkVC  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ClassworkVC"];
                    navigationController.viewControllers = @[homeViewController];
                    self.frostedViewController.contentViewController = navigationController;
                }
            }
            else
            {
                ClassworkVC  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ClassworkVC"];
                navigationController.viewControllers = @[homeViewController];
                self.frostedViewController.contentViewController = navigationController;
            }
            break;
        }
        case 5:
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"])
            {
                if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
                {
                    if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
                    {
                        if([[Utility getUserRoleRightList:@"Attendance" settingType:@"IsView"] integerValue] == 1)
                        {
                            if ([Utility isInterNetConnectionIsActive] == false)
                            {
                                UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                [alrt show];
                                [ProgressHUB hideenHUDAddedTo:self.view];
                                return;
                            }
                            else
                            {
                                AttendanceVC  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AttendanceVC"];
                                navigationController.viewControllers = @[homeViewController];
                                self.frostedViewController.contentViewController = navigationController;
                            }
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
                            [ProgressHUB hideenHUDAddedTo:self.view];
                            return;
                        }
                        else
                        {
                            AttendanceVC  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AttendanceVC"];
                            navigationController.viewControllers = @[homeViewController];
                            self.frostedViewController.contentViewController = navigationController;
                        }
                    }
                }
                else
                {
                    if ([Utility isInterNetConnectionIsActive] == false)
                    {
                        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alrt show];
                        [ProgressHUB hideenHUDAddedTo:self.view];
                        return;
                    }
                    else
                    {
                        AttendanceVC  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AttendanceVC"];
                        navigationController.viewControllers = @[homeViewController];
                        self.frostedViewController.contentViewController = navigationController;
                    }
                }
            }
            else
            {
                if ([Utility isInterNetConnectionIsActive] == false)
                {
                    UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alrt show];
                    [ProgressHUB hideenHUDAddedTo:self.view];
                    return;
                }
                else
                {
                    AttendanceVC  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AttendanceVC"];
                    navigationController.viewControllers = @[homeViewController];
                    self.frostedViewController.contentViewController = navigationController;
                }
            }
            break;
        }
        case 6:
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"])
            {
                if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
                {
                    if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
                    {
                        if([[Utility getUserRoleRightList:@"PT Communicatoin" settingType:@"IsView"] integerValue] == 1)
                        {
                            ag.checkListelection = 1;
                            if([[Utility getMemberType] isEqualToString:@"Student"])
                            {
                                StudentListViewController  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StudentListViewController"];
                                navigationController.viewControllers = @[homeViewController];
                                self.frostedViewController.contentViewController = navigationController;
                            }
                            else
                            {
                                ListSelectionVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListSelectionVc"];
                                navigationController.viewControllers = @[homeViewController];
                                self.frostedViewController.contentViewController = navigationController;
                            }

                        }
                        else
                        {
                            [WToast showWithText:You_dont_have_permission];
                        }
                    }
                    else
                    {
                        ag.checkListelection = 1;
                        if([[Utility getMemberType] isEqualToString:@"Student"])
                        {
                            StudentListViewController  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StudentListViewController"];
                            navigationController.viewControllers = @[homeViewController];
                            self.frostedViewController.contentViewController = navigationController;
                        }
                        else
                        {
                            ListSelectionVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListSelectionVc"];
                            navigationController.viewControllers = @[homeViewController];
                            self.frostedViewController.contentViewController = navigationController;
                        }

                    }
                }
                else
                {
                    ag.checkListelection = 1;
                    if([[Utility getMemberType] isEqualToString:@"Student"])
                    {
                        StudentListViewController  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StudentListViewController"];
                        navigationController.viewControllers = @[homeViewController];
                        self.frostedViewController.contentViewController = navigationController;
                    }
                    else
                    {
                        ListSelectionVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListSelectionVc"];
                        navigationController.viewControllers = @[homeViewController];
                        self.frostedViewController.contentViewController = navigationController;
                    }

                }
            }
            else
            {
                ag.checkListelection = 1;
                if([[Utility getMemberType] isEqualToString:@"Student"])
                {
                    StudentListViewController  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StudentListViewController"];
                    navigationController.viewControllers = @[homeViewController];
                    self.frostedViewController.contentViewController = navigationController;
                }
                else
                {
                    ListSelectionVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListSelectionVc"];
                    navigationController.viewControllers = @[homeViewController];
                    self.frostedViewController.contentViewController = navigationController;
                }

            }
            break;
        }
        case 7:
        {
            MessageVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageVc"];
            navigationController.viewControllers = @[homeViewController];
            self.frostedViewController.contentViewController = navigationController;
            break;
        }
        case 8:
        {
            TimeTableVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TimeTableVc"];
            navigationController.viewControllers = @[homeViewController];
            self.frostedViewController.contentViewController = navigationController;
            break;
        }
        case 9:
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"])
            {
                if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
                {
                    if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
                    {
                        if([[Utility getUserRoleRightList:@"Note" settingType:@"IsView"] integerValue] == 1)
                        {
                            NoteVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NoteVc"];
                            navigationController.viewControllers = @[homeViewController];
                            self.frostedViewController.contentViewController = navigationController;
                        }
                        else
                        {
                            [WToast showWithText:You_dont_have_permission];
                        }
                    }
                    else
                    {
                        NoteVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NoteVc"];
                        navigationController.viewControllers = @[homeViewController];
                        self.frostedViewController.contentViewController = navigationController;
                    }
                }
                else
                {
                    NoteVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NoteVc"];
                    navigationController.viewControllers = @[homeViewController];
                    self.frostedViewController.contentViewController = navigationController;
                }
            }
            else
            {
                NoteVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NoteVc"];
                navigationController.viewControllers = @[homeViewController];
                self.frostedViewController.contentViewController = navigationController;
            }
            break;
        }
        case 10:
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"])
            {
                if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
                {
                    if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
                    {
                        if([[Utility getUserRoleRightList:@"Holiday" settingType:@"IsView"] integerValue] == 1)
                        {
                            HolidayVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HolidayVc"];
                            navigationController.viewControllers = @[homeViewController];
                            self.frostedViewController.contentViewController = navigationController;
                        }
                        else
                        {
                            [WToast showWithText:You_dont_have_permission];
                        }
                    }
                    else
                    {
                        HolidayVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HolidayVc"];
                        navigationController.viewControllers = @[homeViewController];
                        self.frostedViewController.contentViewController = navigationController;
                    }
                }
                else
                {
                    HolidayVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HolidayVc"];
                    navigationController.viewControllers = @[homeViewController];
                    self.frostedViewController.contentViewController = navigationController;
                }
            }
            else
            {
                HolidayVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HolidayVc"];
                navigationController.viewControllers = @[homeViewController];
                self.frostedViewController.contentViewController = navigationController;
            }
            break;
        }
        case 11:
        {
            CalenderVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CalenderVc"];
            navigationController.viewControllers = @[homeViewController];
            self.frostedViewController.contentViewController = navigationController;
            break;
        }
        case 12:
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"])
            {
                if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
                {
                    if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
                    {
                        if([[Utility getUserRoleRightList:@"Poll" settingType:@"IsView"] integerValue] == 1)
                        {
                            PollVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PollVc"];
                            navigationController.viewControllers = @[homeViewController];
                            self.frostedViewController.contentViewController = navigationController;
                        }
                        else
                        {
                            [WToast showWithText:You_dont_have_permission];
                        }
                    }
                    else
                    {
                        PollVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PollVc"];
                        navigationController.viewControllers = @[homeViewController];
                        self.frostedViewController.contentViewController = navigationController;
                    }
                }
                else
                {
                    PollVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PollVc"];
                    navigationController.viewControllers = @[homeViewController];
                    self.frostedViewController.contentViewController = navigationController;
                }
            }
            else
            {
                PollVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PollVc"];
                navigationController.viewControllers = @[homeViewController];
                self.frostedViewController.contentViewController = navigationController;
            }
            break;
        }
        case 13:
        {
            NotificationVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationVc"];
            navigationController.viewControllers = @[homeViewController];
            self.frostedViewController.contentViewController = navigationController;
            break;
        }
        case 14:
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"])
            {
                if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
                {
                    if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
                    {
                        if([[Utility getUserRoleRightList:@"Reminders" settingType:@"IsView"] integerValue] == 1)
                        {
                            CreateReminderVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateReminderVc"];
                            navigationController.viewControllers = @[homeViewController];
                            self.frostedViewController.contentViewController = navigationController;
                        }
                        else
                        {
                            [WToast showWithText:You_dont_have_permission];
                        }
                    }
                    else
                    {
                        CreateReminderVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateReminderVc"];
                        navigationController.viewControllers = @[homeViewController];
                        self.frostedViewController.contentViewController = navigationController;
                    }
                }
                else
                {
                    CreateReminderVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateReminderVc"];
                    navigationController.viewControllers = @[homeViewController];
                    self.frostedViewController.contentViewController = navigationController;
                }
            }
            else
            {
                CreateReminderVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateReminderVc"];
                navigationController.viewControllers = @[homeViewController];
                self.frostedViewController.contentViewController = navigationController;
            }
            
            break;
        }
        case 15:
        {
            AboutOrataroVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutOrataroVc"];
            navigationController.viewControllers = @[homeViewController];
            self.frostedViewController.contentViewController = navigationController;
            break;
        }
        case 16:
        {
            SettingVcViewController  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingVcViewController"];
            navigationController.viewControllers = @[homeViewController];
            self.frostedViewController.contentViewController = navigationController;
            break;
        }
        case 17:
        {
            FAQvc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FAQvc"];
            navigationController.viewControllers = @[homeViewController];
            self.frostedViewController.contentViewController = navigationController;
            break;
        }
        default:
            break;
    }
    //self.frostedViewController.contentViewController = navigationController;
    // [self.frostedViewController hideMenuViewController];
    [self.frostedViewController hideMenuViewController];
    //
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
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_notifications,apk_MemberAllTypeOfCounts_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    
    
    //[ProgressHUB showHUDAddedTo:self.view];
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         // [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             if([strArrd length] != 0)
             {
                 NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
                 NSMutableDictionary *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                 
                 @try
                 {
                     NSLog(@"arr=%@",arrResponce);
                     
                     //  [[NSUserDefaults standardUserDefaults]setObject:arrResponce forKey:@"TotalCountofMember"];
                     //  [[NSUserDefaults standardUserDefaults]synchronize];
                     
                     getData= [arrResponce objectForKey:@"Table"];
                     
                     [_tblMenuTable reloadData];
                     
                     
                 }
                 @catch (NSException *exception)
                 {
                     
                 }
                 if([arrResponce count] != 0)
                 {
                     @try
                     {
                         NSLog(@"arr=%@",arrResponce);
                         
                         //  [[NSUserDefaults standardUserDefaults]setObject:arrResponce forKey:@"TotalCountofMember"];
                         // [[NSUserDefaults standardUserDefaults]synchronize];
                         
                         getData= [arrResponce objectForKey:@"Table"];
                         
                         [_tblMenuTable reloadData];
                         
                         
                     }
                     @catch (NSException *exception)
                     {
                         //  UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         //  [alrt show];
                     }
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

@end
