//
//  ProfileLeaveDetailListVc.m
//  orataro
//
//  Created by Softqube on 24/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ProfileLeaveDetailListVc.h"
#import "LeaveVc.h"
#import "Global.h"
#import "ProfileStudentLeaveVc.h"

@interface ProfileLeaveDetailListVc ()
{
    NSMutableArray *arrLeaveList;
}
@end

@implementation ProfileLeaveDetailListVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // _tblListDetail.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tblListDetail.separatorStyle=UITableViewCellSeparatorStyleNone;
    _viewAddbtn.layer.cornerRadius = 30.0;
    
    _lbHeaderTitle.text = [NSString stringWithFormat:@"Leave (%@)",[Utility getCurrentUserName]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
     NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    
    if([[dicCurrentUser objectForKey:@"MemberType"] isEqualToString:@"Student"])
    {
        _viewAddbtn.hidden = NO;
    }
    else
    {
        _viewAddbtn.hidden = YES;
    }
    
    
    NSLog(@"Dictionary=%@",_dicLeaveDetails);
    
    //CREATE TABLE "LeaveDetailList" ("id" INTEGER PRIMARY KEY  NOT NULL , "LeaveJsonStr" VARCHAR)
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        NSMutableArray *arrLoacalDb = [DBOperation selectData:@"select * from LeaveDetailList"];
        NSMutableArray *arrListTemp = [Utility getLocalDetail:arrLoacalDb columnKey:@"LeaveJsonStr"];
        
        if(arrListTemp.count == 0)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        else
        {
            [self ManageHomeworkList:arrListTemp];
        }
    }
    else
    {
        NSMutableArray *arrLoacalDb = [DBOperation selectData:@"select * from LeaveDetailList"];
        NSMutableArray *arrListTemp = [Utility getLocalDetail:arrLoacalDb columnKey:@"LeaveJsonStr"];
        //[self ManageHomeworkList:arrListTemp];
        
        if(arrListTemp.count == 0)
        {
            [self apiCallFor_getLeaveDetail:YES];
        }
        else
        {
            [self apiCallFor_getLeaveDetail:NO];
        }
    }
    
    
    
    
}
#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrLeaveList.count;
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
    
    NSString *st = [[arrLeaveList objectAtIndex:section] objectForKey:@"Groups"];
    
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
    NSInteger rows = [[[arrLeaveList objectAtIndex:section] objectForKey:@"items"] count];
    
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
    
    NSDictionary *d = [[[arrLeaveList objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
    
      NSLog(@"Dic=%@",d);
    
    
    NSString *getdt = [d objectForKey:@"DateOfApplication"];
    NSString *getMilisecond = [Utility convertMiliSecondtoDate:@"dd/MM/yyyy" date:getdt];
    UILabel *lbHeaderDt = (UILabel *)[cell.contentView viewWithTag:3];
    
    
    NSString *getfrmt = [Utility convertDateFtrToDtaeFtr:@"dd/MM/yyyy" newDateFtr:@"dd EEE" date:getMilisecond];
    lbHeaderDt.text = getfrmt;
    
    UILabel *lblLeaveFor = (UILabel *)[cell.contentView viewWithTag:4];
    lblLeaveFor.text = [d objectForKey:@"ApplicationBY"];
    

     UILabel *lblLeaveNot = (UILabel *)[cell.contentView viewWithTag:5];
    
  //  NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    
//    if([[dicCurrentUser objectForKey:@"MemberType"] isEqualToString:@"Student"])
//    {
//        lblLeaveNot.text =@"";
//    }
//    else
//    {
//       
//    }
    
    lblLeaveNot.text = [d objectForKey:@"ReasonForLeave"];
    
    UILabel *lblLeaveStatus = (UILabel *)[cell.contentView viewWithTag:6];
    lblLeaveStatus.text = [d objectForKey:@"DefStatus"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    
    if([[dicCurrentUser objectForKey:@"MemberType"] isEqualToString:@"Student"])
    {
        ProfileStudentLeaveVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileStudentLeaveVc"];
        vc.dicStudentLeaveData = [[[arrLeaveList objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
        vc.strAddEdit = @"Edit";
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else
    {
        //LeaveVc
        
        LeaveVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"LeaveVc"];
        vc.dicAddLeave = [[[arrLeaveList objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
        vc.dicLeaveDetails = _dicLeaveDetails;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - UIButton Action

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ApiCall

-(void)apiCallFor_getLeaveDetail : (BOOL)checkProgress
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    /*#define apk_leave @"apk_leave.asmx"
     #define apk_LeaveAppList_action @"LeaveAppList"*/
    
    //InstituteID=4f4bbf0e-858a-46fa-a0a7-bf116f537653
    //ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
    //MemberID=f1a6d89d-37dc-499a-9476-cb83f0aba0f2
    //GradeID=ae689792-f055-4053-b6f2-610d6083c595
    //DivisionID=44de9eed-96af-43cf-a5ee-7cc63d9753ed
    //MemberType=Teacher
    
    NSLog(@"Dic=%@",_dicLeaveDetails);
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_leave,apk_LeaveAppList_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    
    if([[dicCurrentUser objectForKey:@"MemberType"] isEqualToString:@"Student"])
    {
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"DivisionID"]] forKey:@"DivisionID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"GradeID"]] forKey:@"GradeID"];
    }
    else
    {
        [param setValue:[NSString stringWithFormat:@"%@",[_dicLeaveDetails objectForKey:@"DivisionID"]] forKey:@"DivisionID"];
        [param setValue:[NSString stringWithFormat:@"%@",[_dicLeaveDetails objectForKey:@"GradeID"]] forKey:@"GradeID"];
    }
    
    [param setValue:[dicCurrentUser objectForKey:@"MemberType"] forKey:@"MemberType"];
    
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
                     //CREATE TABLE "LeaveDetailList" ("id" INTEGER PRIMARY KEY  NOT NULL , "LeaveJsonStr" VARCHAR)
                     
                     [DBOperation executeSQL:@"delete from LeaveDetailList"];
                     for (NSMutableDictionary *dic in arrResponce)
                     {
                         NSString *getjsonstr = [Utility Convertjsontostring:dic];
                         [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO LeaveDetailList (LeaveJsonStr) VALUES ('%@')",getjsonstr]];
                     }
                     
                     [self ManageHomeworkList:arrResponce];
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

-(void)ManageHomeworkList:(NSMutableArray *)arrResponce
{
    arrLeaveList = [[NSMutableArray alloc]init];
    
    //   //CREATE TABLE "LeaveDetailList" ("id" INTEGER PRIMARY KEY  NOT NULL , "LeaveJsonStr" VARCHAR)
    
    //NSLog(@"Data=%@",arrResponce);
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:arrResponce];
    
    for (int i=0; i< mutableArray.count; i++)
    {
        NSMutableDictionary *d = [[mutableArray objectAtIndex:i] mutableCopy];
        // NSLog(@"dic=%@",d);
        
        //NSString *str =    [Utility convertMiliSecondtoDate:[NSString stringWithFormat:@"%@",[[mutableArray objectAtIndex:i]objectForKey:@"DateOfApplication"]] date:@"MM/dd/yyyy"];
        
        //  NSLog(@"Str=%@",str);
        
        //        NSString *DateOfCircular=[Utility convertDateFtrToDtaeFtr:@"MM/dd/yyyy" newDateFtr:@"MM/yyyy" date:[NSString stringWithFormat:@"%@",[[mutableArray objectAtIndex:i]objectForKey:@"DateOfApplication"]]];
        //        [d setObject:DateOfCircular forKey:@"Group"];
        //        [mutableArray replaceObjectAtIndex:i withObject:d];
        //
        //        arrResponce = mutableArray;
        
        
        // NSMutableDictionary *d = [[mutableArray objectAtIndex:i] mutableCopy];
        
        NSString *DateOfCircular=[Utility convertMiliSecondtoDate:@"MM/yyyy" date:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[[mutableArray objectAtIndex:i]objectForKey:@"DateOfApplication"]]]];
        
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
        
        
        NSSortDescriptor * brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"DateOfApplication" ascending:NO];
        NSArray * sortedArray3 = [items sortedArrayUsingDescriptors:@[brandDescriptor]];
        
        
        [entry setObject:sortedArray3 forKey:@"items"];
        [arrLeaveList addObject:entry];
    }
    // arrLeaveList = [[[arrLeaveList reverseObjectEnumerator]allObjects]mutableCopy];
    
    //CREATE TABLE "LeaveDetailList" ("id" INTEGER PRIMARY KEY  NOT NULL , "LeaveJsonStr" VARCHAR)
    
    NSLog(@"Ary=%@",arrLeaveList);
    
    [DBOperation executeSQL:@"delete from LeaveDetailList"];
    for (NSMutableDictionary *dic in arrLeaveList)
    {
        NSString *getjsonstr = [Utility Convertjsontostring:dic];
        [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO LeaveDetailList (LeaveJsonStr) VALUES ('%@')",getjsonstr]];
        
    }
    NSArray *ary = [DBOperation selectData:@"select * from LeaveDetailList"];
    arrLeaveList = [Utility getLocalDetail:ary columnKey:@"LeaveJsonStr"];
    
    [_tblListDetail reloadData];
}


- (IBAction)btnAddClicked:(id)sender
{
    ProfileStudentLeaveVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ProfileStudentLeaveVc"];
     vc.strAddEdit = @"Add";
    [self.navigationController pushViewController:vc animated:YES];
}
@end
