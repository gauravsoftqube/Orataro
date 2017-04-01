//
//  FAQvc.m
//  orataro
//
//  Created by MAC008 on 13/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "FAQvc.h"
#import "FAQCustomeCell.h"
#import "REFrostedViewController.h"
#import "AppDelegate.h"

@interface FAQvc ()
{
    NSMutableDictionary *dic;
    NSMutableArray *sectionary;
    NSMutableArray *hideshowary;
    UIImageView *upDownArrow;
    NSMutableArray *tempary;
    int c2;
     AppDelegate *app;
    
}
@end

@implementation FAQvc
@synthesize aTabelView,aImageView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    dic = [[NSMutableDictionary alloc]init];
    hideshowary=[[NSMutableArray alloc]init];
   // sectionary = [[NSMutableArray alloc]initWithObjects:@"Wall",@"Home Screen",@"Profile",@"Circulars",@"Home Work",@"Classwork",@"PT communication",@"School Timing",@"Time Table",@"Notes",@"Holidays",@"Calender",@"Poll",@"Notification",@"Reminder",@"About ORATARO",@"Switch Account",@"My Profile",@"Institute Pages",@"Blogs",@"Friends",@"Photo",@"School Groups",@"My Happygram",@"Information",@"School Prayer",@"Institute Wall",@"Standard Wall",@"Division Wall",@"Subject Wall",@"Projects",@"Change Password", nil];
    
    NSMutableArray  *ary = [[NSMutableArray alloc]init];
  
    NSMutableDictionary *dic1=[[NSMutableDictionary alloc]init];
    [dic1 setValue:@"Wall" forKey:@"Title"];
    [dic1 setValue:@"After Login to Orataro you will have Wall screen on your mobile where you can read homework, classwork, circular, messages, photos etc. related updates directly at one place with scrolling it.   You can Like, Unlike and Share it." forKey:@"Description"];
    [dic1 setValue:@"1.PNG" forKey:@"ImageName"];
    
    NSMutableDictionary *dic2=[[NSMutableDictionary alloc]init];
    [dic2 setValue:@"Home Screen" forKey:@"Title"];
    [dic2 setValue:@"Press Home button on top left of screen where you will have Main menu with frequent use option which are explained in detail as per below." forKey:@"Description"];
    [dic2 setValue:@"2.png" forKey:@"ImageName"];

    NSMutableDictionary *dic3=[[NSMutableDictionary alloc]init];
    [dic3 setValue:@"Profile" forKey:@"Title"];
    [dic3 setValue:@"Parents can introduce to school and other Parents for Better Communication via Orataro. Same time they can control their private information with level of privacy setting." forKey:@"Description"];
    [dic3 setValue:@"" forKey:@"ImageName"];

    NSMutableDictionary *dic4=[[NSMutableDictionary alloc]init];
    [dic4 setValue:@"Circulars" forKey:@"Title"];
    [dic4 setValue:@"School circulars can be viewed from here in month and Date wise list on press of single circular will open in detailed view to read it. Once parents read it will be marked as read. Press back button to go back to circular list." forKey:@"Description"];
    [dic4 setValue:@"" forKey:@"ImageName"];

    NSMutableDictionary *dic5=[[NSMutableDictionary alloc]init];
    [dic5 setValue:@"Home Work" forKey:@"Title"];
    [dic5 setValue:@"Very much Helpful for parents to involve with day to day schooling by checking daily Home Work on App with Finish Date. Press a single homework to read instruction in detail and see which teacher has sent it." forKey:@"Description"];
    [dic5 setValue:@"" forKey:@"ImageName"];

    NSMutableDictionary *dic6=[[NSMutableDictionary alloc]init];
    [dic6 setValue:@"Classwork" forKey:@"Title"];
    [dic6 setValue:@" It make schooling more transparent and updates parents with day to day teaching activity by posting daily Class Work on Orataro where it displays period wise teaching information. Press a single classwork to read instruction in detail and see which teacher has sent it." forKey:@"Description"];
    [dic6 setValue:@"" forKey:@"ImageName"];

    NSMutableDictionary *dic7=[[NSMutableDictionary alloc]init];
    [dic7 setValue:@"PT communication" forKey:@"Title"];
    [dic7 setValue:@"To communicate teacher for Childs study matter but not activated now." forKey:@"Description"];
    [dic7 setValue:@"" forKey:@"ImageName"];

    NSMutableDictionary *dic8=[[NSMutableDictionary alloc]init];
    [dic8 setValue:@"School Timing" forKey:@"Title"];
    [dic8 setValue:@"It will Display School Wise timing which may change seasonal or periodically." forKey:@"Description"];
    [dic8 setValue:@"" forKey:@"ImageName"];

    NSMutableDictionary *dic9=[[NSMutableDictionary alloc]init];
    [dic9 setValue:@"Time Table" forKey:@"Title"];
    [dic9 setValue:@"Helps students to prepare books and homework according to daily class periods. Here normally you can see today’s time table but on scrolling forward you can see future days, weeks time table as well past days time table also." forKey:@"Description"];
    [dic9 setValue:@"" forKey:@"ImageName"];

    NSMutableDictionary *dic10=[[NSMutableDictionary alloc]init];
    [dic10 setValue:@"Notes" forKey:@"Title"];
    [dic10 setValue:@"Important exam notes, Ref. study materials, Test papers, Assignments etc. will be posted here by school you can download it also for printing and future use." forKey:@"Description"];
    [dic10 setValue:@"" forKey:@"ImageName"];

    NSMutableDictionary *dic11=[[NSMutableDictionary alloc]init];
    [dic11 setValue:@"Holidays" forKey:@"Title"];
    [dic11 setValue:@"It will display List of Holidays." forKey:@"Description"];
    [dic11 setValue:@"" forKey:@"ImageName"];

    NSMutableDictionary *dic12=[[NSMutableDictionary alloc]init];
    [dic12 setValue:@"Calendar" forKey:@"Title"];
    [dic12 setValue:@"Will Remind you about upcoming events, reminders etc. posted by school." forKey:@"Description"];
    [dic12 setValue:@"" forKey:@"ImageName"];

    NSMutableDictionary *dic13=[[NSMutableDictionary alloc]init];
    [dic13 setValue:@"Poll" forKey:@"Title"];
    [dic13 setValue:@"To collect views, decisions via small survey of students, parents, teachers before starting activities will be activated later." forKey:@"Description"];
    [dic13 setValue:@"" forKey:@"ImageName"];

    
    NSMutableDictionary *dic14=[[NSMutableDictionary alloc]init];
    [dic14 setValue:@"Notification" forKey:@"Title"];
    [dic14 setValue:@"About to view notifications of posts,like, dislike, comments etc. all activities happened related to you in a List view like Email." forKey:@"Description"];
    [dic14 setValue:@"" forKey:@"ImageName"];

    NSMutableDictionary *dic15=[[NSMutableDictionary alloc]init];
    [dic15 setValue:@"Reminder" forKey:@"Title"];
    [dic15 setValue:@"It’s a kind of Organizer where students can set their study, Exam related reminders which parents can also view and remind them on time to complete it." forKey:@"Description"];
    [dic15 setValue:@"" forKey:@"ImageName"];

    NSMutableDictionary *dic16=[[NSMutableDictionary alloc]init];
    [dic16 setValue:@"About ORATARO" forKey:@"Title"];
    [dic16 setValue:@"Where we mentioned range of options to reach us including help desk details and social media. Top of that parents can access our other free Apps. Useful for toddlers." forKey:@"Description"];
    [dic16 setValue:@"" forKey:@"ImageName"];

    NSMutableDictionary *dic17=[[NSMutableDictionary alloc]init];
    [dic17 setValue:@"Switch Account" forKey:@"Title"];
    [dic17 setValue:@"Useful to parents who need to access more than one child on this application." forKey:@"Description"];
    [dic17 setValue:@"" forKey:@"ImageName"];

    [ary addObject:dic1];
    [ary addObject:dic2];
    [ary addObject:dic3];
    [ary addObject:dic4];
    [ary addObject:dic5];
    [ary addObject:dic6];
    [ary addObject:dic7];
    [ary addObject:dic8];
    [ary addObject:dic9];
    [ary addObject:dic10];
    [ary addObject:dic11];
    [ary addObject:dic12];
    [ary addObject:dic13];
    [ary addObject:dic14];
    [ary addObject:dic15];
    [ary addObject:dic16];
    [ary addObject:dic17];
    sectionary=[ary valueForKey:@"Title"];
    for (int i=0; i<sectionary.count; i++)
    {
        [dic setObject:[ary objectAtIndex:i] forKey:[sectionary objectAtIndex:i]];
        [hideshowary addObject:[NSNumber numberWithBool:NO]];
    }
    
    [aTabelView registerNib:[UINib nibWithNibName:@"FAQCustomeCell" bundle:nil] forCellReuseIdentifier:@"FaqCell"];
    aTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    aTabelView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
   
    //[aTabelView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
}

#pragma mark - tableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[hideshowary objectAtIndex:section] boolValue])
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   FAQCustomeCell *cell1 = (FAQCustomeCell *)[tableView dequeueReusableCellWithIdentifier:@"FaqCell"];
    cell1.selectionStyle=UITableViewCellSelectionStyleNone;
    
    NSMutableDictionary  *dic1=[dic objectForKey:[sectionary objectAtIndex:indexPath.section]];
    
    NSString *yourText;
    
    yourText=[dic1 objectForKey:@"Description"];
    
    
    if (indexPath.section % 2 == 0)
    {
        cell1.aTextLabel.backgroundColor  = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    }
    else
    {
        cell1.aTextLabel.backgroundColor      = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    }
    
    NSString *strImageName = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"ImageName"]];
    cell1.imgName.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",strImageName]];
    cell1.img_Height.constant=0;
    

    if(strImageName.length != 0)
    {
        cell1.imgName.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",strImageName]];
        cell1.img_Height.constant=250;
    }
    cell1.aTextLabel.textColor = [UIColor blackColor];
    BOOL manyCells  = [[hideshowary objectAtIndex:indexPath.section] boolValue];
    if (!manyCells)
    {
        // cell.textLabel.text = @"click to enlarge";
    }
    else
    {
        cell1.aTextLabel.text = yourText;
    }
    
    return cell1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *dic1=[dic objectForKey:[sectionary objectAtIndex:indexPath.section]];
    NSString *strText = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"Description"]];
     NSString *strImageName = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"ImageName"]];

    CGSize size = [strText sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:14] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];

    if ([[hideshowary objectAtIndex:indexPath.section] boolValue])
    {
        if(strImageName.length != 0)
        {
             return size.height + 10 + 250;
        }
        return size.height + 15;
    }
    return 0.0;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sectionary.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  /*  upDownArrow.tag = section;
    
    UIView *headerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    headerView.tag                  = section;
    headerView.backgroundColor      = [UIColor clearColor];
    UILabel *headerString           = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-70, 50)];
    [headerString setBackgroundColor:[UIColor clearColor]];
    
    if (headerView.tag % 2 == 0)
    {
        headerView.backgroundColor      = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    }
    else
    {
        headerView.backgroundColor      = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    }
    headerString.text = [sectionary objectAtIndex:section];
    
    //headerString.font = [UIFont fontWithName:@"Lato-Bold" size:15.0];
    headerString.textAlignment      = NSTextAlignmentLeft;
    headerString.textColor          = [UIColor colorWithRed:67.0/255.0 green:67.0/255.0 blue:67.0/255.0 alpha:1.0];
    
    [headerView addSubview:headerString];
    
    //upgray
    
    //downgray
    
    BOOL manyCells  = [[hideshowary objectAtIndex:section] boolValue];
    UIImageView *img=[[UIImageView alloc]init];
    img.frame=CGRectMake(headerString.frame.size.width+23, (headerView.frame.size.height-300)/2, 30, 30);
   //  upDownArrow.frame = CGRectMake(headerString.frame.size.width+23, (headerView.frame.size.height-300)/2, 30, 30);
  
    if (!manyCells)
    {
        img.image = [UIImage imageNamed:@"arrow-down"];
    }
    else
    {
        img.image = [UIImage imageNamed:@"arrow-up"];
    }
    
    [headerView addSubview:img];
    */
    
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"sectionCell"];
    
    if (section % 2 == 0)
    {
        cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    }
    UILabel *lblTitle=(UILabel *)[cell.contentView viewWithTag:1];
    lblTitle.text = [sectionary objectAtIndex:section];
    
    UIImageView *img=(UIImageView *)[cell.contentView viewWithTag:2];
    BOOL manyCells  = [[hideshowary objectAtIndex:section] boolValue];
    if (!manyCells)
    {
        img.image = [UIImage imageNamed:@"arrow-down"];
    }
    else
    {
        img.image = [UIImage imageNamed:@"arrow-up"];
    }
    
    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    headerTapped.view.tag = section;
    [cell.contentView addGestureRecognizer:headerTapped];
    cell.contentView.tag  = section;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    NSString *sectionstr = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
    
    
    tempary = [[NSMutableArray alloc]initWithArray:hideshowary];
    
    [hideshowary removeAllObjects];
    
    NSString *strAlreadySelected;
    for (int i=0; i<tempary.count; i++)
    {
        NSString *str = [NSString stringWithFormat:@"%d",i];
        
        if ([str isEqualToString:sectionstr])
        {
            if([[tempary objectAtIndex:i]integerValue] == 1)
            {
                strAlreadySelected=@"1";
                [tempary replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:0]];
            }
            else
            {
                strAlreadySelected=@"0";
                [tempary replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:1]];
            }
        }
        else
        {
            [tempary replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:0]];
        }
    }
    hideshowary = [[NSMutableArray alloc]initWithArray:tempary];
    
    [aTabelView reloadData];
    
    
//    [UIView animateWithDuration:1.0 delay:2.0 options:UIViewAnimationOptionRepeat animations:^{
//        
//        aTabelView.alpha = 1.0;
//        [aTabelView reloadData];
//        
//    } completion:^(BOOL finished) {
//        
//    }];
    
   // NSInteger rows = [aTabelView numberOfRowsInSection:gestureRecognizer.view.tag];
  
    if([strAlreadySelected isEqualToString:@"0"])
    {
        [aTabelView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]
                      atScrollPosition:UITableViewScrollPositionBottom
                              animated:YES];

    }
}
#pragma mark -button action

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
