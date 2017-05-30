//
//  PollVc.m
//  orataro
//
//  Created by MAC008 on 08/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "PollVc.h"
#import "REFrostedViewController.h"
#import "AddPollVc.h"
#import "AppDelegate.h"
#import "Global.h"


@interface PollVc ()
{
    int c2;
    AppDelegate *app;
    
    NSMutableArray *arrAddPage;
    NSMutableArray *arrParticipantPage;
    NSMutableArray *arrParticipantPageOption;
    NSMutableArray *arrFiled;
    
    NSString *strFlagShowList;
    
    NSMutableArray *arrPopup;
    
    NSMutableArray *arrVoteList;
    NSMutableArray *arrVoteList_selected;
    
    NSMutableDictionary *dicSelected_Participaint;
    
    NSString *isRefresh;
    NSString *strdeletePollID;
}
@end

@implementation PollVc
@synthesize aFirstImage,aBottomView1,aBottomView2,aSecondImage;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    _lbNopoll.hidden =YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tblPoll.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    aBottomView1.hidden = NO;
    [aFirstImage setImage:[UIImage imageNamed:@"pollico_shiw"]];
    
    aBottomView2.hidden = YES;
    [aSecondImage setImage:[UIImage imageNamed:@"voting"]];
    
    _viewAdd.layer.cornerRadius = 20;
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    strFlagShowList = @"AddPage";
    //
    if(![[Utility getMemberType] isEqualToString:@"Teacher"])
    {
        strFlagShowList=@"participantPage";
        [self.viewStudentTop setHidden:NO];
        [self.viewAdd setHidden:YES];
        [self.btnadd setHidden:YES];
        [self apiCallMethod_ParticipaintPage];
    }
    else
    {
        [self.viewStudentTop setHidden:YES];
    }
    
    //
    NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
    if (arr.count != 0) {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Poll (%@)",[arr objectAtIndex:0]];
    }
    else
    {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Poll"];
    }
    
    //
    arrVoteList_selected=[[NSMutableArray alloc]init];
    
    //vote
    [self.viewVote_Popup setHidden:YES];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    UITableViewController *tableViewController = [[UITableViewController alloc] init];
    tableViewController.tableView = self.tblPoll;
    tableViewController.refreshControl = refreshControl;
}

-(void)viewWillAppear:(BOOL)animated
{
    if([strFlagShowList isEqualToString:@"AddPage"])
    {
        [self.viewAdd setHidden:NO];
        [self.btnadd setHidden:NO];
        [self apiCallMethod_AddPage];
    }
    else
    {
        [self.viewAdd setHidden:YES];
        [self.btnadd setHidden:YES];
    }
    
    
}

-(void)refreshData
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    if([strFlagShowList isEqualToString:@"AddPage"])
    {
        [self apiCallFor_GetPollsListForAddPage:NO];
    }
    else
    {
        [self apiCallFor_GetPollsListForParticipantPage:NO];
    }
}

-(void)apiCallMethod_AddPage
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        NSArray *ary = [DBOperation selectData:@"select * from PollAddPage"];
        NSMutableArray *arrAddPageTemp = [Utility getLocalDetail:ary columnKey:@"dic_json"];
        [self manageAddPageList:arrAddPageTemp];
        
        if(arrAddPage.count == 0)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
    }
    else
    {
        NSArray *ary = [DBOperation selectData:@"select * from PollAddPage"];
        NSMutableArray *arrAddPageTemp = [Utility getLocalDetail:ary columnKey:@"dic_json"];
        [self manageAddPageList:arrAddPageTemp];
        
        if(arrAddPage.count == 0)
        {
            [self apiCallFor_GetPollsListForAddPage:YES];
        }
        else
        {
            [self apiCallFor_GetPollsListForAddPage:NO];
        }
    }
}

-(void)apiCallMethod_ParticipaintPage
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        //Participaint
        NSArray *ary = [DBOperation selectData:@"select * from PollParticipantPage"];
        NSMutableArray *arrParticipantPageTemp = [Utility getLocalDetail:ary columnKey:@"dic_json"];
        [self manageParticipantPageList:arrParticipantPageTemp];
        
        //option
        NSArray *aryOption = [DBOperation selectData:@"select * from PollParticipantPage_Votelist"];
        arrParticipantPageOption = [[NSMutableArray alloc]init];
        arrParticipantPageOption = [Utility getLocalDetail:aryOption columnKey:@"dic_json"];
        
        
        if(arrParticipantPage.count == 0)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
    }
    else
    {
        //Participaint
        NSArray *ary = [DBOperation selectData:@"select * from PollParticipantPage"];
        NSMutableArray *arrParticipantPageTemp = [Utility getLocalDetail:ary columnKey:@"dic_json"];
        [self manageParticipantPageList:arrParticipantPageTemp];
        
        //option
        NSArray *aryOption = [DBOperation selectData:@"select * from PollParticipantPage_Votelist"];
        arrParticipantPageOption = [[NSMutableArray alloc]init];
        arrParticipantPageOption = [Utility getLocalDetail:aryOption columnKey:@"dic_json"];
        
        if(arrParticipantPage.count == 0)
        {
            [self apiCallFor_GetPollsListForParticipantPage:YES];
        }
        else
        {
            [self apiCallFor_GetPollsListForParticipantPage:NO];
        }
    }
}

#pragma mark - ApiCall

-(void)apiCallFor_GetPollsListForAddPage : (BOOL)checkProgress
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_poll,apk_GetPollsListForAddPage_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    
    if (checkProgress == YES)
    {
        [ProgressHUB showHUDAddedTo:self.view];
    }
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [_tblPoll.refreshControl endRefreshing];
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]mutableCopy];
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[[arrResponce objectAtIndex:0]mutableCopy];
                 NSString *strStatus=[[dic objectForKey:@"message"]mutableCopy];
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     [DBOperation executeSQL:@"delete from PollAddPage"];
                     for (NSMutableDictionary *dic in arrResponce)
                     {
                         NSString *getjsonstr = [Utility Convertjsontostring:dic];
                         [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO PollAddPage (dic_json) VALUES ('%@')",getjsonstr]];
                     }
                     [self manageAddPageList:arrResponce];
                     
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

-(void)manageAddPageList:(NSMutableArray *)arrResponce
{
    arrAddPage = [[NSMutableArray alloc]init];
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:arrResponce];
    
    for (int i=0; i< mutableArray.count; i++)
    {
        NSMutableDictionary *d = [[mutableArray objectAtIndex:i] mutableCopy];
        
        NSString *startDate=[NSString stringWithFormat:@"%@",[[mutableArray objectAtIndex:i]objectForKey:@"StartDate"]];
        startDate=[Utility convertMiliSecondtoDate:@"MM/dd/yyyy" date:startDate];
        NSString *DateOfCircular=[Utility convertDateFtrToDtaeFtr:@"MM/dd/yyyy" newDateFtr:@"MM/yyyy" date:startDate];
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
        
        
        NSSortDescriptor * brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"StartDate" ascending:NO];
        NSArray * sortedArray3 = [items sortedArrayUsingDescriptors:@[brandDescriptor]];
        
        
        [entry setObject:sortedArray3 forKey:@"items"];
        [arrAddPage addObject:entry];
    }
    
    arrAddPage = [[[arrAddPage reverseObjectEnumerator]allObjects]mutableCopy];
    
    if([strFlagShowList isEqualToString:@"AddPage"])
    {
        arrFiled =[[NSMutableArray alloc]init];
        arrFiled = [arrAddPage mutableCopy];
        [self.tblPoll reloadData];
    }
    else
    {
        arrFiled =[[NSMutableArray alloc]init];
        arrFiled = [arrParticipantPage mutableCopy];
        [self.tblPoll reloadData];
    }
}
-(void)apiCallFor_GetPollsListForParticipantPage : (BOOL)checkProgress
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_poll,apk_GetPollsListForParticipantPage_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    
    if (checkProgress == YES)
    {
        [ProgressHUB showHUDAddedTo:self.view];
    }
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [_tblPoll.refreshControl endRefreshing];
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableDictionary *dicResponce = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]mutableCopy];
             
             if(dicResponce != nil)
             {
                 
                 NSString *strStatus=[[dicResponce objectForKey:@"message"]mutableCopy];
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dicResponce objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     arrParticipantPageOption =[[NSMutableArray alloc]init];
                     NSMutableArray *Table=[dicResponce objectForKey:@"Table"];
                     NSMutableArray *Table1=[dicResponce objectForKey:@"Table1"];
                     arrParticipantPageOption = [Table1 mutableCopy];
                     
                     //Participaint
                     [DBOperation executeSQL:@"delete from PollParticipantPage"];
                     for (NSMutableDictionary *dic in Table)
                     {
                         NSString *getjsonstr = [Utility Convertjsontostring:dic];
                         [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO PollParticipantPage (dic_json) VALUES ('%@')",getjsonstr]];
                     }
                     
                     //Partiipaint Option
                     [DBOperation executeSQL:@"delete from PollParticipantPage_Votelist"];
                     for (NSMutableDictionary *dic in Table1)
                     {
                         NSString *getjsonstr = [Utility Convertjsontostring:dic];
                         [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO PollParticipantPage_Votelist (dic_json) VALUES ('%@')",getjsonstr]];
                     }
                     
                     [self manageParticipantPageList:Table];
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

-(void)manageParticipantPageList:(NSMutableArray *)arrResponce
{
    arrParticipantPage = [[NSMutableArray alloc]init];
    if([arrResponce count]  != 0)
    {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:arrResponce];
        
        for (int i=0; i< mutableArray.count; i++)
        {
            NSMutableDictionary *d = [[mutableArray objectAtIndex:i] mutableCopy];
            
            NSString *startDate=[NSString stringWithFormat:@"%@",[[mutableArray objectAtIndex:i]objectForKey:@"StartDate"]];
            startDate=[Utility convertMiliSecondtoDate:@"MM/dd/yyyy" date:startDate];
            NSString *DateOfCircular=[Utility convertDateFtrToDtaeFtr:@"MM/dd/yyyy" newDateFtr:@"MM/yyyy" date:startDate];
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
            
            
            NSSortDescriptor * brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"StartDate" ascending:NO];
            NSArray * sortedArray3 = [items sortedArrayUsingDescriptors:@[brandDescriptor]];
            
            
            [entry setObject:sortedArray3 forKey:@"items"];
            [arrParticipantPage addObject:entry];
        }
    }
    arrParticipantPage = [[[arrParticipantPage reverseObjectEnumerator]allObjects]mutableCopy];
    
    if([strFlagShowList isEqualToString:@"AddPage"])
    {
        
    }
    else
    {
        arrFiled =[[NSMutableArray alloc]init];
        arrFiled = [arrParticipantPage mutableCopy];
        [self.tblPoll reloadData];
    }
}


-(void)apiCallFor_postSavePollOptionVote : (BOOL)checkProgress
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_poll,apk_SavePollOptionVote_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    NSMutableArray *arrSelectId=[[NSMutableArray alloc]init];
    for (int i = 0; i< [arrVoteList_selected count]; i++) {
        NSMutableDictionary *dic=[[arrVoteList_selected objectAtIndex:i]mutableCopy];
        NSString *strPollID=[[dic objectForKey:@"PollID"]mutableCopy];
        NSString *strOption=[[dic objectForKey:@"PollOptionID"]mutableCopy];
        [arrSelectId addObject:[NSString stringWithFormat:@"%@,%@",strPollID,strOption]];
    }
    NSString *strPostPollID=[arrSelectId componentsJoinedByString:@",#"];
    
    [param setValue:[NSString stringWithFormat:@"%@,#",strPostPollID] forKey:@"PollIDOptionIDByCommaHase"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"VMemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"VUserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BachID"];
    
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
             NSMutableArray *arrResponce = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]mutableCopy];
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dicResponce=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[[dicResponce objectForKey:@"message"]mutableCopy];
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dicResponce objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else if([strStatus isEqualToString:@"Somthing are wrong...!!!"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dicResponce objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dicResponce objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                     [self apiCallFor_GetPollsListForParticipantPage:YES];
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

-(void)apiCallFor_PollDelete : (BOOL)checkProgress  PollID:(NSString *)PollID
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_poll,apk_PollDelete_action];
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",PollID] forKey:@"PollID"];
    
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
             NSMutableArray *arrResponce = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]mutableCopy];
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dicResponce=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[[dicResponce objectForKey:@"message"]mutableCopy];
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dicResponce objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else if([strStatus isEqualToString:@"Record delete successfully"])
                 {
                     //                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dicResponce objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     //                     [alrt show];
                 }
                 else
                 {
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


#pragma mark - UITableView

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.tblVoteList)
    {
        return 44;
    }
    else
    {
        if([strFlagShowList isEqualToString:@"AddPage"])
        {
            NSDictionary *d = [[[arrFiled objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
            NSString *Details = [d objectForKey:@"Details"];
            
            NSString *yourText = [NSString stringWithFormat:@"%@",Details];
            
            CGSize size = [yourText sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:12] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-81, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
            
            return size.height+120;
        }
        else
        {
            NSDictionary *d = [[[arrFiled objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
            NSString *Details = [d objectForKey:@"Details"];
            NSString *yourText = [NSString stringWithFormat:@"%@",Details];
            
            CGSize size = [yourText sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:12] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-81, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
            
            return size.height+120;
        }
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == self.tblVoteList)
    {
        return 1;
    }
    else
    {
        return [arrFiled count];
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView == self.tblVoteList)
    {
        return nil;
    }
    else
    {
        static NSString *HeaderCellIdentifier = @"PollHeaderCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCellIdentifier];
        }
        UIView *viewRound=(UIView *)[cell.contentView viewWithTag:1];
        [viewRound.layer setCornerRadius:50];
        viewRound.clipsToBounds=YES;
        [viewRound.layer setBorderColor:[UIColor colorWithRed:202/255.0f green:202/255.0f blue:202/255.0f alpha:1.0f].CGColor];
        [viewRound.layer setBorderWidth:2];
        
        NSString *st = [[arrFiled objectAtIndex:section] objectForKey:@"Groups"];
        NSString *getfrmt = [Utility convertDateFtrToDtaeFtr:@"MM/yyyy" newDateFtr:@"MMM yyyy" date:st];
        NSArray* getary = [getfrmt componentsSeparatedByString: @" "];
        
        UILabel *lbTitle = (UILabel *)[cell.contentView viewWithTag:2];
        lbTitle.text = [getary objectAtIndex: 0];
        
        UILabel *lbDesc = (UILabel *)[cell.contentView viewWithTag:3];
        lbDesc.text = [getary objectAtIndex: 1];
        return cell;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.tblVoteList)
    {
        return [arrVoteList count];
    }
    else
    {
        NSInteger rows = [[[arrFiled objectAtIndex:section] objectForKey:@"items"] count];
        return rows;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.tblVoteList)
    {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"voteCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        NSMutableDictionary *dic=[arrVoteList objectAtIndex:indexPath.row];
        
        UILabel *lbl=(UILabel*)[cell.contentView viewWithTag:2];
        [lbl setText:[[NSString stringWithFormat:@"%@",[dic objectForKey:@"Option"]] capitalizedString]];
        
        UIButton *btn=(UIButton*)[cell.contentView viewWithTag:1];
        [btn setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
        if([arrVoteList_selected containsObject:dic])
        {
            [btn setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
        }
        else
        {
            [btn setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
        }
        return cell;
    }
    else
    {
        if([strFlagShowList isEqualToString:@"AddPage"])
        {
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PollRowCell"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            UIView *viewBackgroundCell=(UIView *)[cell.contentView viewWithTag:1];
            UIView *viewDateBackground=(UIView *)[cell.contentView viewWithTag:2];
            if(indexPath.row % 2)
            {
                [viewBackgroundCell setBackgroundColor:[UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f]];
                [viewDateBackground setBackgroundColor:[UIColor colorWithRed:29/255.0f green:42/255.0f blue:76/255.0f alpha:1.0f]];
            }
            else
            {
                [viewBackgroundCell setBackgroundColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f]];
                [viewDateBackground setBackgroundColor:[UIColor colorWithRed:46/255.0f green:60/255.0f blue:100/255.0f alpha:1.0f]];
            }
            
            NSDictionary *d = [[[arrFiled objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
            NSString *getdt = [d objectForKey:@"StartDate"];
            getdt=[Utility convertMiliSecondtoDate:@"MM/dd/yyyy" date:getdt];
            UILabel *lbHeaderDt = (UILabel *)[cell.contentView viewWithTag:3];
            NSString *getfrmt = [Utility convertDateFtrToDtaeFtr:@"MM/dd/yyyy" newDateFtr:@"dd EEE" date:getdt];
            lbHeaderDt.text = getfrmt;
            
            NSString *Title = [d objectForKey:@"Title"];
            NSString *Details = [d objectForKey:@"Details"];
            NSString *UserName = [d objectForKey:@"UserName"];
            
            NSString *Participant = [d objectForKey:@"Participant"];
            
            UILabel *lblTitle = (UILabel *)[cell.contentView viewWithTag:4];
            [lblTitle setText:[[NSString stringWithFormat:@"%@",Title] capitalizedString]];
            
            UILabel *lblDetails = (UILabel *)[cell.contentView viewWithTag:5];
            [lblDetails setText:[[NSString stringWithFormat:@"%@",Details] capitalizedString]];
            
            UILabel *lblUserName = (UILabel *)[cell.contentView viewWithTag:6];
            [lblUserName setText:[NSString stringWithFormat:@"%@",UserName]];
            
            UILabel *lblParticipant = (UILabel *)[cell.contentView viewWithTag:8];
            [lblParticipant setText:[NSString stringWithFormat:@"Participant: %@",Participant]];
            
            NSString *strMemberType=[Utility getMemberType];
            if([strMemberType isEqualToString:@"Student"])
            {
                NSString *EndDate = [d objectForKey:@"EndDate"];
                EndDate = [Utility convertMiliSecondtoDate:@"dd-MM-yyyy" date:EndDate];
                UILabel *lblsubmmisionin = (UILabel *)[cell.contentView viewWithTag:9];
                [lblsubmmisionin setText:[NSString stringWithFormat:@"%@",EndDate]];
            }
            else
            {
                NSString *StartIn = [d objectForKey:@"StartIn"];
                NSString *EndIn = [d objectForKey:@"EndIn"];
                
                UILabel *lblsubmmisionin = (UILabel *)[cell.contentView viewWithTag:9];
                [lblsubmmisionin setTextColor:[UIColor blackColor]];
                if([StartIn integerValue] > 0)
                {
                    [lblsubmmisionin setText:[NSString stringWithFormat:@"%@",StartIn]];
                }
                else if ([EndIn integerValue] > 0)
                {
                    [lblsubmmisionin setText:[NSString stringWithFormat:@"%@",EndIn]];
                }
                else
                {
                    [lblsubmmisionin setTextColor:[UIColor redColor]];
                    [lblsubmmisionin setText:[NSString stringWithFormat:@"Already End"]];
                }
                
                UIButton *btnDelete = (UIButton *)[cell.contentView viewWithTag:5];
                if([[Utility getMemberType] isEqualToString:@"Student"])
                {
                    [btnDelete setHidden:YES];
                    [btnDelete setFrame:CGRectMake(btnDelete.frame.origin.x, btnDelete.frame.origin.y, 0, btnDelete.frame.size.height)];
                }
            }
            
            return cell;
        }
        else
        {
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PollRowCell1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            UIView *viewBackgroundCell=(UIView *)[cell.contentView viewWithTag:1];
            UIView *viewDateBackground=(UIView *)[cell.contentView viewWithTag:2];
            if(indexPath.row % 2)
            {
                [viewBackgroundCell setBackgroundColor:[UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f]];
                [viewDateBackground setBackgroundColor:[UIColor colorWithRed:29/255.0f green:42/255.0f blue:76/255.0f alpha:1.0f]];
            }
            else
            {
                [viewBackgroundCell setBackgroundColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f]];
                [viewDateBackground setBackgroundColor:[UIColor colorWithRed:46/255.0f green:60/255.0f blue:100/255.0f alpha:1.0f]];
            }
            
            NSDictionary *d = [[[arrFiled objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
            NSString *getdt = [d objectForKey:@"StartDate"];
            getdt=[Utility convertMiliSecondtoDate:@"MM/dd/yyyy" date:getdt];
            UILabel *lbHeaderDt = (UILabel *)[cell.contentView viewWithTag:3];
            NSString *getfrmt = [Utility convertDateFtrToDtaeFtr:@"MM/dd/yyyy" newDateFtr:@"dd EEE" date:getdt];
            lbHeaderDt.text = getfrmt;
            
            NSString *Title = [d objectForKey:@"Title"];
            NSString *Details = [d objectForKey:@"Details"];
            NSString *UserName = [d objectForKey:@"FullName"];
            
            UILabel *lblTitle = (UILabel *)[cell.contentView viewWithTag:4];
            [lblTitle setText:[[NSString stringWithFormat:@"%@",Title] capitalizedString]];
            
            UILabel *lblDetails = (UILabel *)[cell.contentView viewWithTag:5];
            [lblDetails setText:[[NSString stringWithFormat:@"%@",Details] capitalizedString]];
            
            UILabel *lblUserName = (UILabel *)[cell.contentView viewWithTag:6];
            [lblUserName setText:[NSString stringWithFormat:@"%@",UserName]];
            
            NSString *EndDate = [d objectForKey:@"EndDate"];
            EndDate = [Utility convertMiliSecondtoDate:@"dd-MM-yyyy" date:EndDate];
            UILabel *lblsubmmisionin = (UILabel *)[cell.contentView viewWithTag:7];
            [lblsubmmisionin setText:[NSString stringWithFormat:@"%@",EndDate]];
            
            UIButton *btnDelete = (UIButton *)[cell.contentView viewWithTag:5];
            if([[Utility getMemberType] isEqualToString:@"Student"])
            {
                [btnDelete setHidden:YES];
                [btnDelete setFrame:CGRectMake(btnDelete.frame.origin.x, btnDelete.frame.origin.y, 0, btnDelete.frame.size.height)];
            }
            
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.tblVoteList)
    {
        NSString *IsMultiChoice=[dicSelected_Participaint objectForKey:@"IsMultiChoice"];
        if([IsMultiChoice integerValue] == 1)
        {
            NSMutableDictionary *dic=[[arrVoteList objectAtIndex:indexPath.row]mutableCopy];
            if([arrVoteList containsObject:dic])
            {
                [arrVoteList_selected removeObject:dic];
            }
            else
            {
                [arrVoteList_selected addObject:dic];
            }
            [self.tblVoteList reloadData];
        }
        else
        {
            NSMutableDictionary *dic=[[arrVoteList objectAtIndex:indexPath.row]mutableCopy];
            [arrVoteList_selected removeAllObjects];
            [arrVoteList_selected addObject:dic];
            [self.tblVoteList reloadData];
        }
    }
    else
    {
        if([strFlagShowList isEqualToString:@"AddPage"])
        {
            AddPollVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"AddPollVc"];
            vc.strPoll = @"Edit";
            vc.dicSelected_AddPage=[[[arrFiled objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            
        }
    }
}

- (IBAction)btnCell_AddPage:(id)sender
{
    arrPopup = [[NSMutableArray alloc]init];
    [arrPopup addObject:[Utility addCell_PopupView:self.viewAddPage ParentView:self.view sender:sender]];
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblPoll];
    NSIndexPath *indexPath = [self.tblPoll indexPathForRowAtPoint:buttonPosition];
    NSMutableDictionary *dicAddpage = [[[arrFiled objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
    strdeletePollID=[dicAddpage objectForKey:@"PollID"];
}

- (IBAction)btnCell_ParticipaintPage:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblPoll];
    NSIndexPath *indexPath = [self.tblPoll indexPathForRowAtPoint:buttonPosition];
    dicSelected_Participaint = [[[arrFiled objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
    NSString *Title=[dicSelected_Participaint objectForKey:@"Title"];
    self.lblVote_TItle.text=Title;
    
    arrPopup = [[NSMutableArray alloc]init];
    [arrPopup addObject:[Utility addCell_PopupView:self.viewParticipaint_Popup ParentView:self.view sender:sender]];
}

- (IBAction)btnVote_Checkbox:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblVoteList];
    NSIndexPath *indexPath = [self.tblVoteList indexPathForRowAtPoint:buttonPosition];
    
    NSString *IsMultiChoice=[dicSelected_Participaint objectForKey:@"IsMultiChoice"];
    if([IsMultiChoice integerValue] == 1)
    {
        NSMutableDictionary *dic=[[arrVoteList objectAtIndex:indexPath.row]mutableCopy];
        if([arrVoteList_selected containsObject:dic])
        {
            [arrVoteList_selected removeObject:dic];
        }
        else
        {
            [arrVoteList_selected addObject:dic];
        }
        [self.tblVoteList reloadData];
    }
    else
    {
        NSMutableDictionary *dic=[[arrVoteList objectAtIndex:indexPath.row]mutableCopy];
        [arrVoteList_selected removeAllObjects];
        [arrVoteList_selected addObject:dic];
        [self.tblVoteList reloadData];
    }
    
}

#pragma mark - CMPopTipViewDelegate methods

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
    [arrPopup removeObject:popTipView];
}

#pragma mark - button action

- (IBAction)btnAddClicked:(UIButton *)sender
{
    if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"])
    {
        if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
            {
                if([[Utility getUserRoleRightList:@"Poll" settingType:@"IsCreate"] integerValue] == 1)
                {
                    AddPollVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"AddPollVc"];
                    vc.strPoll = @"Add";
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else
                {
                    [WToast showWithText:You_dont_have_permission];
                }
            }
            else
            {
                AddPollVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"AddPollVc"];
                vc.strPoll = @"Add";
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        else
        {
            AddPollVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"AddPollVc"];
            vc.strPoll = @"Add";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else
    {
        AddPollVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"AddPollVc"];
        vc.strPoll = @"Add";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)aFirstBtnClicked:(id)sender
{
    strFlagShowList = @"AddPage";
    
    aBottomView1.hidden = NO;
    [aFirstImage setImage:[UIImage imageNamed:@"pollico_shiw"]];
    
    aBottomView2.hidden = YES;
    [aSecondImage setImage:[UIImage imageNamed:@"voting"]];
    
    [self.viewAdd setHidden:NO];
    [self.btnadd setHidden:NO];
    
    arrFiled = [[NSMutableArray alloc]init];
    arrFiled = [arrAddPage mutableCopy];
    [self.tblPoll reloadData];
}
- (IBAction)aSeconBtnClicked:(id)sender
{
    strFlagShowList = @"participantPage";
    
    aBottomView1.hidden = YES;
    [aFirstImage setImage:[UIImage imageNamed:@"pollico"]];
    
    aBottomView2.hidden = NO;
    [aSecondImage setImage:[UIImage imageNamed:@"voting_shoe"]];
    
    [self.viewAdd setHidden:YES];
    [self.btnadd setHidden:YES];
    
    //    if([isRefresh isEqualToString:@"1"])
    //    {
    //
    //    }
    //    else
    //    {
    //        isRefresh = @"1";
    [self apiCallMethod_ParticipaintPage];
    //    }
    
    arrFiled = [[NSMutableArray alloc]init];
    arrFiled = [arrParticipantPage mutableCopy];
    [self.tblPoll reloadData];
}

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

- (IBAction)btnResult_AddPage_popup:(id)sender
{
    [Utility dismissAllPopTipViews:arrPopup];
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    ResultAddPageVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ResultAddPageVc"];
    vc.strSelectPollID=strdeletePollID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnDelete_AddPage_popup:(id)sender
{
    [Utility dismissAllPopTipViews:arrPopup];
    
    if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"])
    {
        if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
            {
                if([[Utility getUserRoleRightList:@"Poll" settingType:@"IsDelete"] integerValue] == 1)
                {
                    if ([Utility isInterNetConnectionIsActive] == false)
                    {
                        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alrt show];
                        return;
                    }
                    
                    NSArray *ary = [DBOperation selectData:@"select * from PollAddPage"];
                    NSMutableArray *arrAddPageTemp = [Utility getLocalDetail:ary columnKey:@"dic_json"];
                    for (int i=0;i<[arrAddPageTemp count]; i++) {
                        NSMutableDictionary *dic=[arrAddPageTemp objectAtIndex:i];
                        NSString *str=[[dic objectForKey:@"PollID"]mutableCopy];
                        if([str isEqualToString:strdeletePollID])
                        {
                            NSMutableDictionary *dicLocalDB=[[ary objectAtIndex:i]mutableCopy];
                            NSString *strid=[dicLocalDB objectForKey:@"id"];
                            [DBOperation executeSQL:[NSString stringWithFormat:@"delete from PollAddPage where id = '%@'",strid]];
                            [arrAddPageTemp removeObject:dic];
                        }
                    }
                    
                    [self manageAddPageList:arrAddPageTemp];
                    
                    if([strdeletePollID length] != 0)
                    {
                        [self apiCallFor_PollDelete:NO PollID:strdeletePollID];
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
                    return;
                }
                
                NSArray *ary = [DBOperation selectData:@"select * from PollAddPage"];
                NSMutableArray *arrAddPageTemp = [Utility getLocalDetail:ary columnKey:@"dic_json"];
                for (int i=0;i<[arrAddPageTemp count]; i++) {
                    NSMutableDictionary *dic=[arrAddPageTemp objectAtIndex:i];
                    NSString *str=[[dic objectForKey:@"PollID"]mutableCopy];
                    if([str isEqualToString:strdeletePollID])
                    {
                        NSMutableDictionary *dicLocalDB=[[ary objectAtIndex:i]mutableCopy];
                        NSString *strid=[dicLocalDB objectForKey:@"id"];
                        [DBOperation executeSQL:[NSString stringWithFormat:@"delete from PollAddPage where id = '%@'",strid]];
                        [arrAddPageTemp removeObject:dic];
                    }
                }
                
                [self manageAddPageList:arrAddPageTemp];
                
                if([strdeletePollID length] != 0)
                {
                    [self apiCallFor_PollDelete:NO PollID:strdeletePollID];
                }
            }
        }
        else
        {
            if ([Utility isInterNetConnectionIsActive] == false)
            {
                UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alrt show];
                return;
            }
            
            NSArray *ary = [DBOperation selectData:@"select * from PollAddPage"];
            NSMutableArray *arrAddPageTemp = [Utility getLocalDetail:ary columnKey:@"dic_json"];
            for (int i=0;i<[arrAddPageTemp count]; i++) {
                NSMutableDictionary *dic=[arrAddPageTemp objectAtIndex:i];
                NSString *str=[[dic objectForKey:@"PollID"]mutableCopy];
                if([str isEqualToString:strdeletePollID])
                {
                    NSMutableDictionary *dicLocalDB=[[ary objectAtIndex:i]mutableCopy];
                    NSString *strid=[dicLocalDB objectForKey:@"id"];
                    [DBOperation executeSQL:[NSString stringWithFormat:@"delete from PollAddPage where id = '%@'",strid]];
                    [arrAddPageTemp removeObject:dic];
                }
            }
            
            [self manageAddPageList:arrAddPageTemp];
            
            if([strdeletePollID length] != 0)
            {
                [self apiCallFor_PollDelete:NO PollID:strdeletePollID];
            }
        }
    }
    else
    {
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        
        NSArray *ary = [DBOperation selectData:@"select * from PollAddPage"];
        NSMutableArray *arrAddPageTemp = [Utility getLocalDetail:ary columnKey:@"dic_json"];
        for (int i=0;i<[arrAddPageTemp count]; i++) {
            NSMutableDictionary *dic=[arrAddPageTemp objectAtIndex:i];
            NSString *str=[[dic objectForKey:@"PollID"]mutableCopy];
            if([str isEqualToString:strdeletePollID])
            {
                NSMutableDictionary *dicLocalDB=[[ary objectAtIndex:i]mutableCopy];
                NSString *strid=[dicLocalDB objectForKey:@"id"];
                [DBOperation executeSQL:[NSString stringWithFormat:@"delete from PollAddPage where id = '%@'",strid]];
                [arrAddPageTemp removeObject:dic];
            }
        }
        
        [self manageAddPageList:arrAddPageTemp];
        
        if([strdeletePollID length] != 0)
        {
            [self apiCallFor_PollDelete:NO PollID:strdeletePollID];
        }
    }
}

#pragma mark - Vote UIButton Action

- (IBAction)btnVote_Participaint_popup:(id)sender
{
    [Utility dismissAllPopTipViews:arrPopup];
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    arrVoteList_selected =[[NSMutableArray alloc]init];
    arrVoteList =[[NSMutableArray alloc]init];
    NSString *PollID =[dicSelected_Participaint objectForKey:@"PollID"];
    for (NSMutableDictionary *dic in arrParticipantPageOption) {
        NSString *PollIDTemp=[dic objectForKey:@"PollID"];
        if([PollID isEqualToString:PollIDTemp])
        {
            [arrVoteList addObject:dic];
        }
    }
    [self.tblVoteList reloadData];
    [self.viewVote_Popup setHidden:NO];
}

- (IBAction)btnVote_Cancel:(id)sender
{
    [self.viewVote_Popup setHidden:YES];
}

- (IBAction)btnVote_Ok:(id)sender
{
    if ([arrVoteList_selected count] == 0)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Select_Option delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    [self.viewVote_Popup setHidden:YES];
    [self apiCallFor_postSavePollOptionVote:YES];
}

@end
