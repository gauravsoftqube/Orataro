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

@interface DEMOMenuViewController ()
{
    NSMutableArray *menu,*imgary;
    NSMutableArray *amenuary,*aimgary;
    AppDelegate *ag ;
}
@end

@implementation DEMOMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.view.frame = CGRectMake(50, 64, self.view.frame.size.width-50, self.view.frame.size.height);
    
    ag = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    menu = [[NSMutableArray alloc]initWithObjects:@"Profile",@"Circular",@"Wall",@"Homework",@"Classwork",@"Attendance",@"PT Communication",@"Exam Timing",@"Time Table",@"Notes",@"Holiday",@"Calendar",@"Poll",@"Notification",@"Reminder",@"About Orataro",@"Settings",@"FAQ",@"Switch Account", nil];
    
    imgary = [[NSMutableArray alloc]initWithObjects:@"dash_profile",@"dash_circular",@"dash_fb_wall",@"dash_homework",@"classimg",@"attendance",@"dash_pt_communication",@"dash_school_timing",@"dash_timetable",@"dash_notice",@"dash_holidays",@"dash_calendar",@"dash_fb_poll",@"speech",@"todo",@"user",@"settings",@"faq",@"dash_switch", nil];
    
    //_tblMenuTable.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    [_tblMenuTable registerNib:[UINib nibWithNibName:@"RightCell" bundle:nil] forCellReuseIdentifier:@"RightCell"];
    _tblMenuTable.backgroundColor= [UIColor clearColor];
    _tblMenuTable.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    
    cell.aTextLb.text = [menu objectAtIndex:indexPath.row];
    cell.aImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[imgary objectAtIndex:indexPath.row]]];
    
    cell.aImageView.image = [cell.aImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [cell.aImageView setTintColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return self.view.frame.size.height/menu.count;
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // first
    
    MyProfileVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"MyProfileVc"];
    
    //second
    
    CircularVc *vc2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"CircularVc"];
    //third
    
    WallVc *vc1 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WallVc"];
    
    //forth
    
    HomeWrokVc *vc3 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"HomeWrokVc"];
    //fifth
    
    ClassworkVC *vc4 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ClassworkVC"];
    
    //six
    
    AttendanceVC *vc5 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AttendanceVC"];
    //seven
    
    ListSelectionVc *vc6 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ListSelectionVc"];
    // eight
    
    MessageVc *vc7 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"MessageVc"];
    
    // nine
    
    TimeTableVc *vc8 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"TimeTableVc"];
    
    // ten
    
    NoteVc *vc9 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"NoteVc"];
    
    // eleven
    
    HolidayVc *vc10 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"HolidayVc"];
    // twelwe
    
    CalenderVc *vc11 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"CalenderVc"];
    
    // thirteen
    
    PollVc *vc12 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"PollVc"];
    // forteen
    
    NotificationVc *vc13 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"NotificationVc"];
    //fifteen
    
    CreateReminderVc *vc14 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"CreateReminderVc"];
    //sixteen
    
    AboutOrataroVc *vc15 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AboutOrataroVc"];
    //seventy
    
    SettingVcViewController *vc16 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SettingVcViewController"];
    //eighty
    
    FAQvc *vc17 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"FAQvc"];
    
    //AddCircularVc *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddCircularVc"];
    
    //
    
    //AddClassWorkVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddClassWorkVc"];
    
    
    //StudentListViewController
    
    // StudentListViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"StudentListViewController"];
    
    // PTCommuniVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"PTCommuniVc"];
    
    // AddNoteVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddNoteVc"];
    
    
    //AddPollVc
    
    //AddPollVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddPollVc"];
    
    //ResultVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ResultVc"];
    
    //
    
    //
    
    //OrataroVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"OrataroVc"];
    
    //ReminderVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ReminderVc"];
    
    //
    
    // HelpDeskVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"HelpDeskVc"];
    
    // AboutUsVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AboutUsVc"];
    
    //
    
    //
    //MyProfileVc
    
    //
    
    //  PageVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"PageVc"];
    
    //MessageVc
    
    
    //BlogVc
    
    //  BlogVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"BlogVc"];
    
    //FriendVc
    
    // FriendVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"FriendVc"];
    
    
    
    //MyProfileVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"MyProfileVc"];
    
    
    //DEMONavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    // navigationController.navigationBar.hidden = YES;
    
    //UIViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyProfileVc"];
   
    //navigationController.viewControllers = @[homeViewController];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DEMONavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
    
    switch (indexPath.row)
    {
        case 0:
        {
            MyProfileVc  *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyProfileVc"];
            navigationController.viewControllers = @[homeViewController];
            break;
        }
        case 1:
            
            //   [self.revealViewController pushFrontViewController:vc2 animated:YES];
            break;
            
        case 2:
            
            // [self.revealViewController pushFrontViewController:vc1 animated:YES];
            break;
            
        case 3:
            
            // [self.revealViewController pushFrontViewController:vc3 animated:YES];
            break;
            
        case 4:
            
            // [self.revealViewController pushFrontViewController:vc4 animated:YES];
            break;
            
        case 5:
            
            //[self.revealViewController pushFrontViewController:vc5 animated:YES];
            break;
            
        case 6:
            
            // [[NSUserDefaults standardUserDefaults]setObject:@"PTCommunication" forKey:@"Homework"];
            //  [[NSUserDefaults standardUserDefaults]synchronize];
            ag.checkListelection = 1;
            //[self.revealViewController pushFrontViewController:vc6 animated:YES];
            
            break;
        case 7:
            
            //[self.revealViewController pushFrontViewController:vc7 animated:YES];
            
            break;
        case 8:
            
            //[self.revealViewController pushFrontViewController:vc8 animated:YES];
            
            break;
        case 9:
            
            //[self.revealViewController pushFrontViewController:vc9 animated:YES];
            
            break;
        case 10:
            
            // [self.revealViewController pushFrontViewController:vc10 animated:YES];
            
            break;
        case 11:
            
            // [self.revealViewController pushFrontViewController:vc11 animated:YES];
            
            break;
        case 12:
            
            // [self.revealViewController pushFrontViewController:vc12 animated:YES];
            
            break;
        case 13:
            
            //[self.revealViewController pushFrontViewController:vc13 animated:YES];
            
            break;
        case 14:
            
            //[self.revealViewController pushFrontViewController:vc14 animated:YES];
            
            break;
        case 15:
            
            //  [self.revealViewController pushFrontViewController:vc15 animated:YES];
            
            break;
        case 16:
            
            // [self.revealViewController pushFrontViewController:vc16 animated:YES];
            
            break;
        case 17:
            
            // [self.revealViewController pushFrontViewController:vc17 animated:YES];
            
            break;
        default:
            break;
    }
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
    
    //
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    DEMONavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
//    
//    if (indexPath.section == 0 && indexPath.row == 0) {
//        DEMOHomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"homeController"];
//        navigationController.viewControllers = @[homeViewController];
//    } else {
//        
//    }
//    
//    self.frostedViewController.contentViewController = navigationController;
//    [self.frostedViewController hideMenuViewController];
//}
//
//#pragma mark UITableView Datasource
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 54;
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 2;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
//{
//    return menu.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *cellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
//    cell.textLabel.text = [menu objectAtIndex:indexPath.row];
//    
//    return cell;
//}

@end
