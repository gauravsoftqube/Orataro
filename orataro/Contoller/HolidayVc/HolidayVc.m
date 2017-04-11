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
#import "AppDelegate.h"
#import "Global.h"

@interface HolidayVc ()
{
    int c2;
    AppDelegate *app;
    NSMutableArray *arrHolidayList;
}
@end

@implementation HolidayVc
@synthesize aTableView,aTableHeaderView;

- (void)viewDidLoad {
    [super viewDidLoad];
    

   
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [aTableView registerNib:[UINib nibWithNibName:@"HolidayVcCell" bundle:nil] forCellReuseIdentifier:@"HolidayCell"];
    
    aTableView.tableHeaderView = aTableHeaderView;
    
    aTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Do any additional setup after loading the view.
    
    NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
    if (arr.count != 0) {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Holiday (%@)",[arr objectAtIndex:0]];
    }
    else
    {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Holiday"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        arrHolidayList = [[NSMutableArray alloc]init];
        NSArray *ary = [DBOperation selectData:@"select * from Holiday"];
        arrHolidayList = [Utility getLocalDetail:ary columnKey:@"dic_json"];
        [self.aTableView reloadData];
        
        if(arrHolidayList.count == 0)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
    }
    else
    {
        arrHolidayList = [[NSMutableArray alloc]init];
        NSArray *ary = [DBOperation selectData:@"select * from Holiday"];
        arrHolidayList = [Utility getLocalDetail:ary columnKey:@"dic_json"];
        [self.aTableView reloadData];
        
        if(arrHolidayList.count == 0)
        {
            [self apiCallFor_getHoliday:YES];
        }
        else
        {
           [self apiCallFor_getHoliday:NO];
        }
    }

    
}

#pragma mark - ApiCall

-(void)apiCallFor_getHoliday:(BOOL)checkProgress
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_holiday,apk_GetHoliday_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
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
                     arrHolidayList = [[NSMutableArray alloc]init];
                     
                   
                     NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"DateOfHoliday" ascending:YES];
                     NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
                     NSArray *sortedArray = [arrResponce sortedArrayUsingDescriptors:sortDescriptors];
                     arrHolidayList = [sortedArray mutableCopy];
                     
                     [DBOperation executeSQL:@"delete from Holiday"];
                     for (NSMutableDictionary *dic in arrHolidayList)
                     {
                         NSString *getjsonstr = [Utility Convertjsontostring:dic];
                         [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO Holiday (dic_json) VALUES ('%@')",getjsonstr]];
                     }
                     [self.aTableView reloadData];
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

#pragma mark - Tableview delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static HolidayVcCell *cell = nil;
    NSString *yourText = [[arrHolidayList objectAtIndex:indexPath.row]objectForKey:@"HolidayTitle"];
    
    CGSize size = [yourText sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:12] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-162, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    return size.height+40;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrHolidayList.count;
}

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
    
    cell.aDayLabel.text = [[arrHolidayList objectAtIndex:indexPath.row]objectForKey:@"Hday"];
    
    NSString *date =[[arrHolidayList objectAtIndex:indexPath.row]objectForKey:@"DateOfHoliday"];
    date=[Utility convertMiliSecondtoDate:@"dd MMM yyyy" date:date];
    
    cell.aDateLabel.text = date;
    
    cell.aFestivalLabel.text = [[[arrHolidayList objectAtIndex:indexPath.row]objectForKey:@"HolidayTitle"]capitalizedString];
    
    
    return cell;
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
