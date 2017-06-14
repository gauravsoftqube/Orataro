//
//  ProfileLeaveListSelectVc.m
//  orataro
//
//  Created by Softqube on 24/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ProfileLeaveListSelectVc.h"
#import "ProfileLeaveDetailListVc.h"
#import "Global.h"

@interface ProfileLeaveListSelectVc ()
{
    NSMutableArray *aryTempLeave,*arySaveDataLeave;
}
@end

@implementation ProfileLeaveListSelectVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    aryTempLeave = [[NSMutableArray alloc]init];
   // arySaveDataLeave = [[NSMutableArray alloc]init];
    
    _lbHeaderTitle.text = [NSString stringWithFormat:@"List Selection (%@)",[Utility getCurrentUserName]];
    
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
    self.tblListSelectionLeave.separatorStyle=UITableViewCellSeparatorStyleNone;
}

-(void)viewWillAppear:(BOOL)animated
{
    arySaveDataLeave=[DBOperation selectData:[NSString stringWithFormat:@"select * from SelectionList"]];
    
    //[_tblListSelectionLeave reloadData];
    
    if (arySaveDataLeave.count == 0)
    {
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        else
        {
            //[arySaveDataLeave removeAllObjects];
            //[DBOperation executeSQL:@"delete from arySaveDataLeave"];
            
        //    [_tblListSelectionLeave reloadData];

            
            [self apiCallFor_getList:YES];
            
        }
    }
    else
    {
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            arySaveDataLeave=[DBOperation selectData:[NSString stringWithFormat:@"select * from arySaveDataLeave"]];
            
            [_tblListSelectionLeave reloadData];
        }
        else
        {
           // [arySaveDataLeave removeAllObjects];
           //  [DBOperation executeSQL:@"delete from arySaveDataLeave"];
            
          //  [_tblListSelectionLeave reloadData];
            
            [self apiCallFor_getList:YES];
        }
    }
    
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arySaveDataLeave.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellRow"];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    UIView *viewBackgroundCell=(UIView *)[cell.contentView viewWithTag:1];
    if(indexPath.row % 2)
    {
        [viewBackgroundCell setBackgroundColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f]];
        
    }
    else
    {
        [viewBackgroundCell setBackgroundColor:[UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f]];
    }
    
    UILabel *lb = (UILabel *)[cell.contentView viewWithTag:2];
    lb.text = [[arySaveDataLeave objectAtIndex:indexPath.row]objectForKey:@"Grade"];
    
    UILabel *lb1 = (UILabel *)[cell.contentView viewWithTag:3];
    lb1.text= [[arySaveDataLeave objectAtIndex:indexPath.row]objectForKey:@"DivisionName"];
    
    UILabel *lb4 = (UILabel *)[cell.contentView viewWithTag:4];
    lb4.text= [NSString stringWithFormat:@"%@",[[arySaveDataLeave objectAtIndex:indexPath.row]objectForKey:@"leaveCount"]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"])
    {
        if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
            {
                if([[Utility getUserRoleRightList:@"Leave Application" settingType:@"IsEdit"] integerValue] == 1)
                {
                    //ProfileLeaveDetailListVc
                    ProfileLeaveDetailListVc  *vc10 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfileLeaveDetailListVc"];
                    vc10.dicLeaveDetails = [arySaveDataLeave objectAtIndex:indexPath.row];
                    [self.navigationController pushViewController:vc10 animated:YES];
                }
                else
                {
                    [WToast showWithText:You_dont_have_permission];
                }
            }
            else
            {
                //ProfileLeaveDetailListVc
                ProfileLeaveDetailListVc  *vc10 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfileLeaveDetailListVc"];
                vc10.dicLeaveDetails = [arySaveDataLeave objectAtIndex:indexPath.row];
                [self.navigationController pushViewController:vc10 animated:YES];
            }
        }
        else
        {
            //ProfileLeaveDetailListVc
            ProfileLeaveDetailListVc  *vc10 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfileLeaveDetailListVc"];
            vc10.dicLeaveDetails = [arySaveDataLeave objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:vc10 animated:YES];
        }
    }
    else
    {
        //ProfileLeaveDetailListVc
        ProfileLeaveDetailListVc  *vc10 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfileLeaveDetailListVc"];
        vc10.dicLeaveDetails = [arySaveDataLeave objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc10 animated:YES];
    }

   
    
}


#pragma mark - UIButton Action

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - apiCall

-(void)apiCallFor_getList:(BOOL)strInternet
{
     arySaveDataLeave = [[NSMutableArray alloc]init];
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
  //  NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_gradedivisionsubject,apk_GetGradeDivisionSubjectbyTeacher_action];
    //apk_LeaveCountByGradeDivision
    
    // NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_gradedivisionsubject,apk_LeaveCountByGradeDivision];
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_leave,apk_LeaveCountByGradeDivision];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    //[param setValue:@"Teacher" forKey:@"Role"];
    
    if (strInternet == YES)
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
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:LEAVESELECTION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     //  aryTempLeave = [[NSMutableArray alloc]init];
                     //  arySaveDataLeave = [[NSMutableArray alloc]init];
                     
                    
                     arySaveDataLeave = [arrResponce mutableCopy];
                     
                     NSLog(@"ary=%@",arySaveDataLeave);
                     
                      [_tblListSelectionLeave reloadData];
                     
                    /* NSMutableArray *aryTmp = [[NSMutableArray alloc]initWithArray:arySaveDataLeave];
                     for (int i=0; i< aryTmp.count; i++)
                     {
                         NSMutableDictionary *d = [[aryTmp objectAtIndex:i] mutableCopy];
                         NSString *str = [NSString stringWithFormat:@"%@%@",[d objectForKey:@"Grade"],[d objectForKey:@"Division"]];
                         [d setObject:str forKey:@"Group"];
                         NSLog(@"d=%@",d);
                         [aryTmp replaceObjectAtIndex:i withObject:d];
                     }
                     
                     NSArray *temp = [aryTmp sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"Group" ascending:YES]]];
                     [aryTmp removeAllObjects];
                     [aryTmp addObjectsFromArray:temp];
                     NSLog(@"Ary=%@",aryTmp);
                     
                     
                     NSMutableArray *arr=[[NSMutableArray alloc]init];
                     
                     for (NSMutableDictionary *dic in aryTmp) {
                         NSString *STR=[dic objectForKey:@"Group"];
                         if (![[arr valueForKey:@"Group"] containsObject:STR]) {
                             [arr addObject:dic];
                         }
                     }
                     
                     NSSortDescriptor *sortIdClient =
                     [NSSortDescriptor sortDescriptorWithKey:@"Group"
                                                   ascending:YES
                                                  comparator: ^(id obj1, id obj2){
                                                      
                                                      return [obj1 compare:obj2 options:NSOrderedAscending];
                                                      
                                                  }];
                     
                     NSArray *sortDescriptors = @[sortIdClient];
                     
                     NSArray *arrTemp = [arr sortedArrayUsingDescriptors:sortDescriptors];
                     
                     arySaveDataLeave = [[NSMutableArray alloc]initWithArray:arrTemp];
                     
                     [DBOperation executeSQL:[NSString stringWithFormat:@"DELETE FROM SelectionList"]];
                     
                     for (NSMutableDictionary *dic in arySaveDataLeave)
                     {
                         NSString *Division=[dic objectForKey:@"Division"];
                         NSString *DivisionID=[dic objectForKey:@"DivisionID"];
                         NSString *Grade=[dic objectForKey:@"Grade"];
                         NSString *GradeID=[dic objectForKey:@"GradeID"];
                         NSString *Subject=[dic objectForKey:@"Subject"];
                         NSString *SubjectID=[dic objectForKey:@"SubjectID"];
                         
                         [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO SelectionList(Division,DivisionID,Grade,GradeID,Subject,SubjectID)values('%@','%@','%@','%@','%@','%@')",Division,DivisionID,Grade,GradeID,Subject,SubjectID]];
                     }*/
                    
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


/*-(void)apiCallFor_getLeaveList: (BOOL)checkProgress
 {
 if ([Utility isInterNetConnectionIsActive] == false)
 {
 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
 [alrt show];
 return;
 }
 
 //CREATE TABLE "ProfileLeaveList" ("id" INTEGER PRIMARY KEY  NOT NULL , "leaveJsonStr" VARCHAR)
 
 //#define apk_leave @"apk_leave.asmx"
 //#define apk_LeaveAppList_action @"LeaveAppList"
 
 //InstituteID=4f4bbf0e-858a-46fa-a0a7-bf116f537653
 //ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
 //MemberID=f1a6d89d-37dc-499a-9476-cb83f0aba0f2
 //GradeID=ae689792-f055-4053-b6f2-610d6083c595
 //DivisionID=44de9eed-96af-43cf-a5ee-7cc63d9753ed
 //MemberType=Teacher
 
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
 [param setValue:[NSString stringWithFormat:@""] forKey:@"DivisionID"];
 [param setValue:[NSString stringWithFormat:@""] forKey:@"GradeID"];
 [param setValue:@"Teacher" forKey:@"MemberType"];
 }
 
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
 
 //             NSMutableDictionary *dic= [Utility ConvertStringtoJSON:[NSString stringWithFormat:@"%@",[dicResponce objectForKey:@"d"]]];
 //
 //             NSMutableArray *arrResponce = [dic objectForKey:@"Table"];
 
 NSLog(@"ary=%@",arrResponce);
 
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
 //                     for (NSMutableDictionary *dic in arrResponce)
 //                     {
 //                         //  NSLog(@"Dic=%@",dic);
 //
 //                         if ([[dic objectForKey:@"AssociationType"] isEqualToString:@"Subject"])
 //                         {
 //                             [arySaveStandard addObject:dic];
 //                         }
 //                     }
 
 //   NSLog(@"Data=%@",arySaveStandard);
 
 //  [self ManageCircularList:arySaveStandard];
 
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
 
 -(void)ManageCircularList:(NSMutableArray *)arrResponce
 {
 //CREATE TABLE "TeacherSubjectList" ("id" INTEGER PRIMARY KEY  NOT NULL , "subjectJsonStr" VARCHAR)
 
 // NSLog(@"Ary=%@",arrResponce);
 [DBOperation executeSQL:@"delete from TeacherSubjectList"];
 
 NSLog(@"ary Response=%@",arrResponce);
 
 for (NSMutableDictionary *dic in arrResponce)
 {
 NSString *getjsonstr = [Utility Convertjsontostring:dic];
 [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO TeacherSubjectList (subjectJsonStr) VALUES ('%@')",getjsonstr]];
 }
 
 NSArray *ary = [DBOperation selectData:@"select * from TeacherSubjectList"];
 //arySaveData = [Utility getLocalDetail:ary columnKey:@"subjectJsonStr"];
 
 // [_tblSubjectList reloadData];
 }*/

@end
