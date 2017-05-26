//
//  ProfileSubjectVc.m
//  orataro
//
//  Created by Softqube on 24/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ProfileSubjectVc.h"
#import "WallVc.h"
#import "Global.h"

@interface ProfileSubjectVc ()
{
     NSMutableArray *arySaveStandard,*arySaveData;
}
@end

@implementation ProfileSubjectVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arySaveStandard = [[NSMutableArray alloc]init];
    arySaveData = [[NSMutableArray alloc]init];
    
    _lbHeaderTitle.text = [NSString stringWithFormat:@"Subjects (%@)",[Utility getCurrentUserName]];
    
    // Do any additional setup after loading the view.
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    self.tblSubjectList.separatorStyle=UITableViewCellSeparatorStyleNone;
}
-(void)viewWillAppear:(BOOL)animated
{
    //CREATE TABLE "TeacherSubjectList" ("id" INTEGER PRIMARY KEY  NOT NULL , "subjectJsonStr" VARCHAR)
    
    NSArray *ary = [DBOperation selectData:@"select * from TeacherSubjectList"];
    arySaveData = [Utility getLocalDetail:ary columnKey:@"subjectJsonStr"];
    [_tblSubjectList reloadData];
    
    if (arySaveData.count == 0)
    {
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        else
        {
            [self apiCallFor_getSubject:YES];
            
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
            [self apiCallFor_getSubject:NO];
        }
    }

}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arySaveData.count;
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
    lb.text = [[arySaveData objectAtIndex:indexPath.row]objectForKey:@"WallName"];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WallVc  *vc10 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WallVc"];
    vc10.checkscreen = @"Subject";
    vc10.dicSelect_std_divi_sub=[arySaveData objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc10 animated:YES];
}


#pragma mark - UIButton Action

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ApiCall

-(void)apiCallFor_getSubject: (BOOL)checkProgress
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    //#define apk_login  @"apk_login.asmx"
    //#define apk_GetUserDynamicMenuData @"GetUserDynamicMenuData"
    
    //    <MemberID>guid</MemberID>
    //    <ClientID>guid</ClientID>
    //    <InstituteID>guid</InstituteID>
    //    <GradeID>guid</GradeID>
    //    <DivisionID>guid</DivisionID>
    //    <RoleNam e>string</RoleName>
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_login,apk_GetUserDynamicMenuData];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    
    if([[dicCurrentUser objectForKey:@"MemberType"] isEqualToString:@"Student"])
    {
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"DivisionID"]] forKey:@"DivisionID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"GradeID"]] forKey:@"GradeID"];
    }
    else
    {
        [param setValue:[NSString stringWithFormat:@""] forKey:@"DivisionID"];
        [param setValue:[NSString stringWithFormat:@""] forKey:@"GradeID"];
    }
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"RoleName"]] forKey:@"RoleName"];
    
    if (checkProgress == YES)
    {
        [ProgressHUB showHUDAddedTo:self.view];
    }
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             // NSString *strArrd=[dicResponce objectForKey:@"d"];
             // NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             // NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             NSMutableDictionary *dic= [Utility ConvertStringtoJSON:[NSString stringWithFormat:@"%@",[dicResponce objectForKey:@"d"]]];
             
             NSMutableArray *arrResponce = [dic objectForKey:@"Table"];
             
             //  NSLog(@"ary=%@",arrResponce);
             
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
                     for (NSMutableDictionary *dic in arrResponce)
                     {
                         //  NSLog(@"Dic=%@",dic);
                         
                         if ([[dic objectForKey:@"AssociationType"] isEqualToString:@"Subject"])
                         {
                             [arySaveStandard addObject:dic];
                         }
                     }
                     
                     //   NSLog(@"Data=%@",arySaveStandard);
                     
                     [self ManageCircularList:arySaveStandard];
                     
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
    arySaveData = [Utility getLocalDetail:ary columnKey:@"subjectJsonStr"];
    
    [_tblSubjectList reloadData];
    
    if([arySaveData count] == 1)
    {
        WallVc  *vc10 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WallVc"];
        vc10.checkscreen = @"Subject";
        vc10.dicSelect_std_divi_sub=[arySaveData objectAtIndex:1];
        [self.navigationController pushViewController:vc10 animated:YES];
    }
}

@end
