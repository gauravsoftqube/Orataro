//
//  ProfileStandardVc.m
//  orataro
//
//  Created by Softqube on 23/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ProfileStandardVc.h"
#import "WallVc.h"
#import "Global.h"

@interface ProfileStandardVc ()
{
    NSMutableArray *arySaveStandard,*arySaveData;
}
@end

@implementation ProfileStandardVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arySaveStandard = [[NSMutableArray alloc]init];
    arySaveData = [[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view.
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    self.tblStatndardList.separatorStyle=UITableViewCellSeparatorStyleNone;
}

-(void)viewWillAppear:(BOOL)animated
{
    //CREATE TABLE "TeacherStandardList" ("id" INTEGER PRIMARY KEY  NOT NULL , "TeacherStandardJsonStr" VARCHAR)
    
    NSArray *ary = [DBOperation selectData:@"select * from TeacherStandardList"];
    arySaveData = [Utility getLocalDetail:ary columnKey:@"TeacherStandardJsonStr"];
    [_tblStatndardList reloadData];
    
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
            [self apiCallFor_getStandard:YES];
            
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
             [self apiCallFor_getStandard:NO];
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
    
    UILabel *lblStd=(UILabel *)[cell.contentView viewWithTag:2];
    lblStd.text = [[arySaveData objectAtIndex:indexPath.row]objectForKey:@"WallName"];
    
//    [lblStd setText:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WallVc  *vc10 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WallVc"];
    vc10.checkscreen = @"Standard";
    [self.navigationController pushViewController:vc10 animated:YES];
    
    //    WallVc *p7 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"WallVc"];
    //    [self.navigationController pushViewController:p7 animated:YES];
}

#pragma mark - ApiCall

-(void)apiCallFor_getStandard : (BOOL)checkProgress
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
                         
                         if ([[dic objectForKey:@"AssociationType"] isEqualToString:@"Grade"])
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
    //CREATE TABLE "TeacherStandardList" ("id" INTEGER PRIMARY KEY  NOT NULL , "TeacherStandardJsonStr" VARCHAR)
    NSLog(@"Ary=%@",arrResponce);
    [DBOperation executeSQL:@"delete from TeacherStandardList"];
    
    NSLog(@"ary Response=%@",arrResponce);
    
    for (NSMutableDictionary *dic in arrResponce)
    {
        NSString *getjsonstr = [Utility Convertjsontostring:dic];
        [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO TeacherStandardList (TeacherStandardJsonStr) VALUES ('%@')",getjsonstr]];
    }
    
    NSArray *ary = [DBOperation selectData:@"select * from TeacherStandardList"];
    arySaveData = [Utility getLocalDetail:ary columnKey:@"TeacherStandardJsonStr"];
    
    [_tblStatndardList reloadData];
}



#pragma mark - UIButton Action

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
