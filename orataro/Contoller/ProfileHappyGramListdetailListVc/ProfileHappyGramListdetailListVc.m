//
//  ProfileHappyGramListdetailListVc.m
//  orataro
//
//  Created by Softqube on 24/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ProfileHappyGramListdetailListVc.h"
#import "ProfileAddUpdateListDetailListVc.h"
#import "Global.h"

@interface ProfileHappyGramListdetailListVc ()
{
    NSMutableArray *aryGetHappyGramList;
    NSString *checkStudentTeacher;
}
@end

@implementation ProfileHappyGramListdetailListVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _addView.layer.cornerRadius = 30.0;
    
    // Do any additional setup after loading the view.
    [self commonData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    self.tblDetailList.separatorStyle=UITableViewCellSeparatorStyleNone;
}

-(void)viewWillAppear:(BOOL)animated
{
    NSArray *ary = [DBOperation selectData:@"select * from ProfileHappyGramList"];
    aryGetHappyGramList = [Utility getLocalDetail:ary columnKey:@"happyGramJsonStr"];
    [_tblDetailList reloadData];
    
    if (aryGetHappyGramList.count == 0)
    {
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        else
        {
            [self apiCallFor_getHappygramList:YES];
            
        }
    }
    else
    {
       // aryGetHappyGramList = [Utility getLocalDetail:ary columnKey:@"happyGramJsonStr"];
       // [_tblDetailList reloadData];
        
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            
        }
        else
        {
            [self apiCallFor_getHappygramList:NO];
        }
    }
}
#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [aryGetHappyGramList count];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *HeaderCellIdentifier = @"cellSection";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCellIdentifier];
    }
    UIView *viewRound=(UIView *)[cell.contentView viewWithTag:1];
    [viewRound.layer setCornerRadius:40];
    viewRound.clipsToBounds=YES;
    [viewRound.layer setBorderColor:[UIColor colorWithRed:202/255.0f green:202/255.0f blue:202/255.0f alpha:1.0f].CGColor];
    [viewRound.layer setBorderWidth:2];
    
    NSString *st = [[aryGetHappyGramList objectAtIndex:section] objectForKey:@"Groups"];
    
    NSString *getfrmt = [Utility convertDateFtrToDtaeFtr:@"MM/yyyy" newDateFtr:@"MMM yyyy" date:st];
    
    
    NSArray* getary = [getfrmt componentsSeparatedByString: @" "];
    
    UILabel *lb = (UILabel *)[cell.contentView viewWithTag:2];
    lb.text = [getary objectAtIndex:0];
    
    
    UILabel *lb1 = (UILabel *)[cell.contentView viewWithTag:3];
    lb1.text = [getary objectAtIndex:1];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = [[[aryGetHappyGramList objectAtIndex:section] objectForKey:@"items"] count];
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellRow"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    UIView *viewBackgroundCell=(UIView *)[cell.contentView viewWithTag:3];
    [viewBackgroundCell.layer setCornerRadius:4];
    viewBackgroundCell.clipsToBounds=YES;
    [viewBackgroundCell.layer setBorderColor:[UIColor colorWithRed:34/255.0f green:49/255.0f blue:89/255.0f alpha:1.0f].CGColor];
    [viewBackgroundCell.layer setBorderWidth:1];
    
    NSLog(@"ary=%@",aryGetHappyGramList);
    
    NSDictionary *d = [[[aryGetHappyGramList objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
    NSString *getdt = [d objectForKey:@"DateOfHappyGram"];
    
    UILabel *lbHeaderDt = (UILabel *)[cell.contentView viewWithTag:2];
    NSString *getfrmt = [Utility convertDateFtrToDtaeFtr:@"dd MMM yyyy" newDateFtr:@"dd EEE" date:getdt];
    lbHeaderDt.text = getfrmt;
    
    UILabel *lb = (UILabel *)[cell.contentView viewWithTag:4];
    lb.text = [d objectForKey:@"FullName"];
    
    UILabel *lb1 = (UILabel *)[cell.contentView viewWithTag:6];
    lb1.text = [d objectForKey:@"Appreciation"];
    
    UILabel *lb2 = (UILabel *)[cell.contentView viewWithTag:11];
    lb2.text = [d objectForKey:@"Note"];
    
    UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:5];
    img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[d objectForKey:@"Emotion"]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileAddUpdateListDetailListVc *l = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfileAddUpdateListDetailListVc"];
    l.strVctoNavigate =@"Edit";
    
    l.dicUpdateList = [[[aryGetHappyGramList objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];;
    l.dicHappygramDetails = _dicHappyGrameList;
    [self.navigationController pushViewController:l animated:YES];
    
}

#pragma mark - UIButton Action

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnAddNew:(id)sender
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    ProfileAddUpdateListDetailListVc *l = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfileAddUpdateListDetailListVc"];
    l.strVctoNavigate =@"Add";
    l.dicHappygramDetails = _dicHappyGrameList;
    
    [self.navigationController pushViewController:l animated:YES];
}


#pragma mark - Call Api

-(void)apiCallFor_getHappygramList: (BOOL)strCheckVal
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_happygram,apk_StudentHappyGramSelectForListing_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    
    [param setValue:[_dicHappyGrameList objectForKey:@"GradeID"] forKey:@"GradeID"];
    [param setValue:[_dicHappyGrameList objectForKey:@"DivisionID"] forKey:@"DivisionID"];
    
    if([[dicCurrentUser objectForKey:@"MemberType"] isEqualToString:@"Student"])
    {
        checkStudentTeacher = @"true";
    }
    else
    {
        checkStudentTeacher = @"false";
    }
    
    [param setValue:checkStudentTeacher forKey:@"IsStudnets"];
    
    if (strCheckVal == YES)
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
                     [aryGetHappyGramList removeAllObjects];
                     [_tblDetailList reloadData];
                 }
                 else
                 {
                     [self ManageHappyGramList:arrResponce];
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

#pragma mark - ManagedList

-(void)ManageHappyGramList:(NSMutableArray *)arrResponce
{
    aryGetHappyGramList = [[NSMutableArray alloc]init];
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:arrResponce];
    
    for (int i=0; i< mutableArray.count; i++)
    {
        NSMutableDictionary *d = [[mutableArray objectAtIndex:i] mutableCopy];
        
        NSString *DateOfCircular=[Utility convertDateFtrToDtaeFtr:@"dd MMM yyyy" newDateFtr:@"MM/yyyy" date:[NSString stringWithFormat:@"%@",[[mutableArray objectAtIndex:i]objectForKey:@"DateOfHappyGram"]]];
        
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
    
    int  count = [[NSString stringWithFormat:@"%lu",(unsigned long)sortedArray.count]intValue];
    
    NSMutableArray *aryTemp = [[NSMutableArray alloc]init];
    
    for (int i = count-1 ; i>=0; i--)
    {
        
        [aryTemp addObject:[sortedArray objectAtIndex:i]];
    }
    sortedArray = [[NSMutableArray alloc]initWithArray:aryTemp];
    for (NSString *area in sortedArray)
    {
        __autoreleasing NSMutableDictionary *entry = [NSMutableDictionary new];
        [entry setObject:area forKey:@"Groups"];
        
        __autoreleasing NSArray *temp = [arrResponce filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"Group = %@", area]];
        
        __autoreleasing NSMutableArray *items = [NSMutableArray new];
        
        NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"Group"                                                                        ascending:NO];
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
        items = [[NSMutableArray alloc] initWithArray:[temp sortedArrayUsingDescriptors:sortDescriptors]];
        
        
        NSSortDescriptor * brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"DateOfHappyGram" ascending:NO];
        NSArray * sortedArray3 = [items sortedArrayUsingDescriptors:@[brandDescriptor]];
        
        
        [entry setObject:sortedArray3 forKey:@"items"];
        [aryGetHappyGramList addObject:entry];
    }
    [DBOperation executeSQL:@"delete from ProfileHappyGramList"];
    
    for (NSMutableDictionary *dic in aryGetHappyGramList)
    {
        NSString *getjsonstr = [Utility Convertjsontostring:dic];
        [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO ProfileHappyGramList (happyGramJsonStr) VALUES ('%@')",getjsonstr]];
        
    }
    
    NSArray *ary = [DBOperation selectData:@"select * from ProfileHappyGramList"];
    aryGetHappyGramList = [Utility getLocalDetail:ary columnKey:@"happyGramJsonStr"];
    
    [_tblDetailList reloadData];
}

@end
