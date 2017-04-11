//
//  CreateReminderVc.m
//  orataro
//
//  Created by MAC008 on 21/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "CreateReminderVc.h"
#import "REFrostedViewController.h"
#import "ReminderVc.h"
#import "AppDelegate.h"
#import "Global.h"

@interface CreateReminderVc ()
{
    int c2;
    AppDelegate *app;
    NSMutableArray *arrTodoList;
}
@end

@implementation CreateReminderVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    _aCalenderView.layer.cornerRadius = 50.0;
    _aCalenderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _aCalenderView.layer.borderWidth = 2.0;
    _aView1.layer.cornerRadius = 30.0;
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)commonData
{
    NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
    if (arr.count != 0) {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Reminder (%@)",[arr objectAtIndex:0]];
    }
    else
    {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Reminder"];
    }
    self.tblTodoList.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    //[self.mytable addSubview:refreshControl];
    UITableViewController *tableViewController = [[UITableViewController alloc] init];
    tableViewController.tableView = self.tblTodoList;
    tableViewController.refreshControl = refreshControl;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self apiCallMethod];
}

-(void)refreshData
{
    [self apiCallMethod];
}

-(void)apiCallMethod
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        arrTodoList = [[NSMutableArray alloc]init];
        NSArray *ary = [DBOperation selectData:@"select * from ReminderList"];
        arrTodoList = [Utility getLocalDetail:ary columnKey:@"dic_json"];
       
        [_tblTodoList.refreshControl endRefreshing];
        [self.tblTodoList reloadData];
        
        if(arrTodoList.count == 0)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
    }
    else
    {
        arrTodoList = [[NSMutableArray alloc]init];
        NSArray *ary = [DBOperation selectData:@"select * from ReminderList"];
        arrTodoList = [Utility getLocalDetail:ary columnKey:@"dic_json"];
        
        
        [self.tblTodoList reloadData];
        
        if(arrTodoList.count == 0)
        {
            [self apiCallFor_getReminder:YES];
        }
        else
        {
            [self apiCallFor_getReminder:NO];
        }
    }
}

#pragma mark - ApiCall

-(void)apiCallFor_getReminder : (BOOL)checkProgress
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_todos,apk_GetToDosList_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@""] forKey:@"BeachID"];
    
    
    if (checkProgress == YES)
    {
        [ProgressHUB showHUDAddedTo:self.view];
    }
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [_tblTodoList.refreshControl endRefreshing];
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
                     [self ManageTodoList:arrResponce];
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

-(void)ManageTodoList:(NSMutableArray *)arrResponce
{
    arrTodoList = [[NSMutableArray alloc]init];
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:arrResponce];
    
    for (int i=0; i< mutableArray.count; i++)
    {
        NSMutableDictionary *d = [[mutableArray objectAtIndex:i] mutableCopy];
        NSString *dateMiliSec=[NSString stringWithFormat:@"%@",[[mutableArray objectAtIndex:i]objectForKey:@"CreateOn"]];
        dateMiliSec = [Utility convertMiliSecondtoDate:@"MM/dd/yyyy" date:dateMiliSec];
        NSString *DateOfCircular=[Utility convertDateFtrToDtaeFtr:@"MM/dd/yyyy" newDateFtr:@"MM/yyyy" date:dateMiliSec];
        [d setObject:DateOfCircular forKey:@"Group"];
        [mutableArray replaceObjectAtIndex:i withObject:d];
        
        arrResponce = mutableArray;
    }
    
    NSArray *temp = [arrResponce sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"Group" ascending:YES]]];
    
    
    [arrResponce removeAllObjects];
    [arrResponce addObjectsFromArray:temp];
    
    NSArray *areas = [arrResponce valueForKeyPath:@"@distinctUnionOfObjects.Group"];
    
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES];
    
    NSArray *sorters = [[NSArray alloc] initWithObjects:sorter, nil];
    NSArray *sortedArray = [areas sortedArrayUsingDescriptors:sorters];
    NSDateFormatter *dateFormatter1 = [NSDateFormatter new];
    dateFormatter1.dateFormat = @"MM-yyyy";
    NSArray *sortedArray1 = [sortedArray sortedArrayUsingComparator:^(NSString *string1, NSString *string2)
                             {
                                 NSDate *date1 = [dateFormatter1 dateFromString:string1];
                                 NSDate *date2 = [dateFormatter1 dateFromString:string2];
                                 
                                 return [date1 compare:date2];
                             }];
    
    
    sortedArray = [[NSArray alloc]initWithArray:sortedArray1];
    
    for (NSString *area in sortedArray)
    {
        __autoreleasing NSMutableDictionary *entry = [NSMutableDictionary new];
        [entry setObject:area forKey:@"Groups"];
        
        __autoreleasing NSArray *temp = [arrResponce filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"Group = %@", area]];
        
        __autoreleasing NSMutableArray *items = [NSMutableArray new];
        
        NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"Group"                                                                        ascending:YES];
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
        items = [[NSMutableArray alloc] initWithArray:[temp sortedArrayUsingDescriptors:sortDescriptors]];
        
        
        NSSortDescriptor * brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"CreateOn" ascending:YES];
        NSArray * sortedArray3 = [items sortedArrayUsingDescriptors:@[brandDescriptor]];
        
        
        [entry setObject:sortedArray3 forKey:@"items"];
        [arrTodoList addObject:entry];
    }
//    NSArray *temp12 = [arrTodoList sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"Groups" ascending:YES]]];
//    [arrTodoList removeAllObjects];
//    arrTodoList =[temp12 mutableCopy];
    
    arrTodoList = [[[arrTodoList reverseObjectEnumerator]allObjects]mutableCopy];
    
    [DBOperation executeSQL:@"delete from ReminderList"];
    
    for (NSMutableDictionary *dic in arrTodoList)
    {
        NSString *getjsonstr = [Utility Convertjsontostring:dic];
        [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO ReminderList (dic_json) VALUES ('%@')",getjsonstr]];
        
    }
    
    [_tblTodoList.refreshControl endRefreshing];
    [_tblTodoList reloadData];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [arrTodoList count];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *HeaderCellIdentifier = @"cellSection";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCellIdentifier];
    }
    UIView *viewRound=(UIView *)[cell.contentView viewWithTag:1];
    [viewRound.layer setCornerRadius:50];
    viewRound.clipsToBounds=YES;
    [viewRound.layer setBorderColor:[UIColor colorWithRed:202/255.0f green:202/255.0f blue:202/255.0f alpha:1.0f].CGColor];
    [viewRound.layer setBorderWidth:2];
    
    NSString *st = [[arrTodoList objectAtIndex:section] objectForKey:@"Groups"];
    NSString *getfrmt = [Utility convertDateFtrToDtaeFtr:@"MM/yyyy" newDateFtr:@"MMM yyyy" date:st];
    NSArray* getary = [getfrmt componentsSeparatedByString: @" "];
    
    UILabel *lbTitle = (UILabel *)[cell.contentView viewWithTag:2];
    lbTitle.text = [getary objectAtIndex: 0];
    
    UILabel *lbDesc = (UILabel *)[cell.contentView viewWithTag:3];
    lbDesc.text = [getary objectAtIndex: 1];
    
   

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = [[[arrTodoList objectAtIndex:section] objectForKey:@"items"] count];
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellRow"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UIView *viewBackgroundCell=(UIView *)[cell.contentView viewWithTag:1];
    UIView *viewDateBackground=(UIView *)[cell.contentView viewWithTag:2];
    if(indexPath.row % 2)
    {
        [viewBackgroundCell setBackgroundColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f]];
        [viewDateBackground setBackgroundColor:[UIColor colorWithRed:46/255.0f green:60/255.0f blue:100/255.0f alpha:1.0f]];
    }
    else
    {
        [viewBackgroundCell setBackgroundColor:[UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f]];
        [viewDateBackground setBackgroundColor:[UIColor colorWithRed:29/255.0f green:42/255.0f blue:76/255.0f alpha:1.0f]];
    }
    
    NSDictionary *d = [[[arrTodoList objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
    
    NSString *getdt = [d objectForKey:@"CreateOn"];
    getdt = [Utility convertMiliSecondtoDate:@"yyyy/MM/dd" date:getdt];
    getdt =[Utility convertDateFtrToDtaeFtr:@"yyyy/MM/dd" newDateFtr:@"dd EEE" date:getdt];
    
    UILabel *lbHeaderDt = (UILabel *)[cell.contentView viewWithTag:3];
    lbHeaderDt.text = getdt;
    
    NSString *Title = [d objectForKey:@"Title"];
    NSString *activitydetails = [d objectForKey:@"Details"];
    NSString *Status = [d objectForKey:@"Status"];
    
    UILabel *lblTitle = (UILabel *)[cell.contentView viewWithTag:4];
    [lblTitle setText:[[NSString stringWithFormat:@"%@",Title] capitalizedString]];
    
    
    UILabel *lblDetail = (UILabel *)[cell.contentView viewWithTag:6];
    [lblDetail setText:@""];
    if(![activitydetails isKindOfClass:[NSNull class]])
    {
        [lblDetail setText:[[NSString stringWithFormat:@"%@",activitydetails] capitalizedString]];
    }
    
    UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:22];
    [img setImage:[UIImage imageNamed:@"tick_sky_blue"]];
    if(![Status isKindOfClass:[NSNull class]])
    {
        if([Status isEqualToString:@"Completed"])
        {
            [img setImage:[UIImage imageNamed:@"double_tick_sky_blue"]];
        }
        else
        {
            [img setImage:[UIImage imageNamed:@"tick_sky_blue"]];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ReminderVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ReminderVc"];
    vc.dicSelected=[[[arrTodoList objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)btnCell_DeleteRow:(id)sender {
    
}

#pragma mark - UIButton action

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

- (IBAction)AddBtnClicked:(UIButton *)sender
{
    ReminderVc *r = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ReminderVc"];
    [self.navigationController pushViewController:r animated:YES];
}

- (IBAction)btnHomeClicked:(id)sender
{
    [self.frostedViewController hideMenuViewController];
    UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"OrataroVc"];
    
    [self.navigationController pushViewController:wc animated:NO];
}

@end
