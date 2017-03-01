//
//  FAQvc.m
//  orataro
//
//  Created by MAC008 on 13/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "FAQvc.h"
#import "FAQCustomeCell.h"
#import "SWRevealViewController.h"


@interface FAQvc ()
{
    NSMutableDictionary *dic;
    NSMutableArray *sectionary;
    NSMutableArray *hideshowary;
    UIImageView *upDownArrow;
    NSMutableArray *tempary;
    
}
@end

@implementation FAQvc
@synthesize aTabelView,aImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
   
    
    dic = [[NSMutableDictionary alloc]init];
    hideshowary=[[NSMutableArray alloc]init];
    //tempary = [[NSMutableArray alloc]init];
    
    sectionary = [[NSMutableArray alloc]initWithObjects:@"Wall",@"Home Screen",@"Profile",@"Circulars",@"Home Work",@"Classwork",@"PT communication",@"School Timing",@"Time Table",@"Notes",@"Holidays",@"Calender",@"Poll",@"Notification",@"Reminder",@"About ORATARO",@"Switch Account",@"My Profile",@"Institute Pages",@"Blogs",@"Friends",@"Photo",@"School Groups",@"My Happygram",@"Information",@"School Prayer",@"Institute Wall",@"Standard Wall",@"Division Wall",@"Subject Wall",@"Projects",@"Change Password", nil];
    
    NSArray *ary = [[NSArray alloc]initWithObjects:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.", nil];
    
    for (int i=0; i<sectionary.count; i++)
    {
        [dic setObject:ary forKey:[sectionary objectAtIndex:i]];
        [hideshowary addObject:[NSNumber numberWithBool:NO]];
    }
    [aTabelView registerNib:[UINib nibWithNibName:@"FAQCustomeCell" bundle:nil] forCellReuseIdentifier:@"FaqCell"];
    aTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //  [aTabelView reloadData];
    aTabelView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [aTabelView reloadData];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
}

#pragma mark - tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   FAQCustomeCell *cell1 = (FAQCustomeCell *)[tableView dequeueReusableCellWithIdentifier:@"FaqCell"];
    
    NSLog(@"data=%@",[dic objectForKey:[sectionary objectAtIndex:indexPath.section]]);
    
    NSMutableArray *arr=[dic objectForKey:[sectionary objectAtIndex:indexPath.section]];
    
    NSString *yourText;
    if([arr count] != 0)
    {
        yourText=[arr objectAtIndex:0];
        
    }
    
    if (indexPath.section % 2 == 0)
    {
        cell1.aTextLabel.backgroundColor  = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    }
    else
    {
        cell1.aTextLabel.backgroundColor      = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
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
        
        NSLog(@"data=%@",cell1.aTextLabel.text);
        
    }
    
    //cell.aImageView
    
    return cell1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sectionary.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"data==%@",hideshowary);
    
    if ([[hideshowary objectAtIndex:section] boolValue])
    {
        return [[dic objectForKey:[sectionary objectAtIndex:section]]count];
    }
    return 0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *yourText = [NSString stringWithFormat:@"%@",[dic objectForKey:[sectionary objectAtIndex:indexPath.section]]];
    
    NSString *stringWithoutSpaces = [yourText
                                     stringByReplacingOccurrencesOfString:@"(" withString:@""];
    
    NSString *stringWithoutSpaces1 = [stringWithoutSpaces
                                      stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    CGSize size = [stringWithoutSpaces1 sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:17] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    if ([[hideshowary objectAtIndex:indexPath.section] boolValue])
    {
        return size.height;
        
    }
    return 0.0;
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    upDownArrow.tag = section;
    
    UIView *headerView              = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
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
    
    if (!manyCells)
    {
        upDownArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow-down"]];
        
        upDownArrow.frame = CGRectMake(headerString.frame.size.width+23, (headerView.frame.size.height-35)/2, 35, 35);
    }
    else
    {
        upDownArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow-up"]];
        
        upDownArrow.frame = CGRectMake(headerString.frame.size.width+23, (headerView.frame.size.height-35)/2, 35, 35);
    }
    
    [headerView addSubview:upDownArrow];
    
    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    headerTapped.view.tag = section;
    
    [headerView addGestureRecognizer:headerTapped];
    
    headerView.tag  = section;
    
    return headerView;
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
    
    for (int i=0; i<tempary.count; i++)
    {
        NSString *str = [NSString stringWithFormat:@"%d",i];
        
        if ([str isEqualToString:sectionstr])
        {
            [tempary replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:1]];
        }
        else
        {
            [tempary replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:0]];
        }
    }
    hideshowary = [[NSMutableArray alloc]initWithArray:tempary];
    
    [UIView animateWithDuration:1.0 delay:2.0 options:UIViewAnimationOptionRepeat animations:^{
        
        aTabelView.alpha = 1.0;
        [aTabelView reloadData];
        
    } completion:^(BOOL finished) {
        
    }];
    
    NSInteger rows = [aTabelView numberOfRowsInSection:gestureRecognizer.view.tag];
    
    [aTabelView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rows-1 inSection:gestureRecognizer.view.tag]
                      atScrollPosition:UITableViewScrollPositionBottom
                              animated:YES];
}

#pragma mark -button action

- (IBAction)MenuBtnClicked:(id)sender
{
    [self.revealViewController rightRevealToggle:nil];
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
