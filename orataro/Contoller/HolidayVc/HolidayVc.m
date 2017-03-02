//
//  HolidayVc.m
//  orataro
//
//  Created by MAC008 on 07/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "HolidayVc.h"
#import "HolidayVcCell.h"
#import "REFrostedViewController.h"

@interface HolidayVc ()
{
    NSMutableArray *DispData;
    int c2;
}
@end

@implementation HolidayVc
@synthesize aTableView,aTableHeaderView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DispData = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *dic  = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"23/05/2016",@"date",@"Tue",@"day",@"Ganesh Chaturthi",@"festival", nil];
    
    NSMutableDictionary *dic1  = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"24/05/2016",@"date",@"Mon",@"day",@"Makarsankrati",@"festival", nil];
    
     NSMutableDictionary *dic2  = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"26/05/2016",@"date",@"Wed",@"day",@"Raksha Bandhan ddsdsd dfdfdfdf trtrtrt sewew wewew wewwe rtrtr wewe wrere erere  rtrt rtrt uiui",@"festival", nil];
    
    [DispData addObject:dic];
    [DispData addObject:dic1];
    [DispData addObject:dic2];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [aTableView registerNib:[UINib nibWithNibName:@"HolidayVcCell" bundle:nil] forCellReuseIdentifier:@"HolidayCell"];
    
    aTableView.tableHeaderView = aTableHeaderView;
    
    aTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HolidayVcCell *cell = (HolidayVcCell *)[tableView dequeueReusableCellWithIdentifier:@"HolidayCell"];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AttendanceTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    if (indexPath.row % 2 ==0)
    {
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    }
    else
    {
         cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.aDayLabel.text = [[DispData objectAtIndex:indexPath.row]objectForKey:@"day"];
    
    cell.aDateLabel.text = [[DispData objectAtIndex:indexPath.row]objectForKey:@"date"];
    
    cell.aFestivalLabel.text = [[DispData objectAtIndex:indexPath.row]objectForKey:@"festival"];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static HolidayVcCell *cell = nil;
    NSString *yourText = [[DispData objectAtIndex:indexPath.row]objectForKey:@"festival"];
    
    CGSize size = [yourText sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:17] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-193, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    return size.height+40;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return DispData.count;
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
