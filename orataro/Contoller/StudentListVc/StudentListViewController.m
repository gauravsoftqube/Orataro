//
//  StudentListViewController.m
//  orataro
//
//  Created by Softqube Mac IOS on 06/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "StudentListViewController.h"
#import "REFrostedViewController.h"
#import "WallVc.h"
#import "RightVc.h"
#import "PTCommuniVc.h"
#import "Global.h"
#import "AppDelegate.h"

@interface StudentListViewController ()
{
    NSMutableArray *arrStudentList;
    AppDelegate *ad;
    int c2;
    
}
@end

@implementation StudentListViewController
@synthesize aStudentTable;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ad = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    //  arrStudentList = [[NSMutableArray alloc]initWithObjects:@"Ruchita boraniya",@"patel pooja",@"patel roshni", nil];
    self.automaticallyAdjustsScrollViewInsets = NO;
    aStudentTable.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.btnBack setHidden:YES];
    [self.btnHome setHidden:YES];
    [self.btnMenu setHidden:YES];
    
    /* if([[Utility getMemberType] isEqualToString:@"Student"])
     {
     
     [self.btnBack setHidden:NO];
     [_lblHeaderTitle setText:@"Student List"];
     
     NSString *strGradeID = [self.dicSelectedList objectForKey:@"GradeID"];
     NSString *strDivisionID = [self.dicSelectedList objectForKey:@"DivisionID"];
     NSString *strSubjectID = [self.dicSelectedList objectForKey:@"SubjectID"];
     if ([Utility isInterNetConnectionIsActive] == false)
     {
     arrStudentList=[DBOperation selectData:[NSString stringWithFormat:@"SELECT * FROM StudentList WHERE GradeID = '%@' AND DivisionID = '%@' AND SubjectID = '%@'",strGradeID,strDivisionID,strSubjectID]];
     
     [self.aStudentTable reloadData];
     }
     else
     {
     NSArray *arrt=[DBOperation selectData:[NSString stringWithFormat:@"SELECT * FROM StudentList WHERE GradeID = '%@' AND DivisionID = '%@' AND SubjectID = '%@'",strGradeID,strDivisionID,strSubjectID]];
     
     if(arrt.count != 0)
     {
     [self apiCallFor_getStudentList:@"0"];
     }
     else
     {
     [self apiCallFor_getStudentList:@"1"];
     }
     }
     
     }
     else
     {
     [self.btnHome setHidden:NO];
     [self.btnMenu setHidden:NO];
     [self.lblHeaderTitle setText:@"Teacher List"];
     
     if ([Utility isInterNetConnectionIsActive] == false)
     {
     arrStudentList=[DBOperation selectData:[NSString stringWithFormat:@"SELECT * FROM TeacherList"]];
     
     [self.aStudentTable reloadData];
     }
     else
     {
     NSArray *arrt=[DBOperation selectData:[NSString stringWithFormat:@"SELECT * FROM TeacherList"]];
     
     if(arrt.count != 0)
     {
     [self apiCallFor_getTeacherList:@"0"];
     }
     else
     {
     [self apiCallFor_getTeacherList:@"1"];
     }
     }
     
     
     ////
     }*/
    
    if([[Utility getMemberType] isEqualToString:@"Student"])
    {
        [self.btnHome setHidden:NO];
        [self.btnMenu setHidden:NO];
        [self.lblHeaderTitle setText:@"Teacher List"];
        
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            arrStudentList=[DBOperation selectData:[NSString stringWithFormat:@"SELECT * FROM TeacherList"]];
            
            [self.aStudentTable reloadData];
        }
        else
        {
            NSArray *arrt=[DBOperation selectData:[NSString stringWithFormat:@"SELECT * FROM TeacherList"]];
            
            if(arrt.count != 0)
            {
                [self apiCallFor_getTeacherList:@"0"];
            }
            else
            {
                [self apiCallFor_getTeacherList:@"1"];
            }
        }
        
        
    }
    else
    {
        [self.btnBack setHidden:NO];
        [_lblHeaderTitle setText:@"Student List"];
        
        NSString *strGradeID = [self.dicSelectedList objectForKey:@"GradeID"];
        NSString *strDivisionID = [self.dicSelectedList objectForKey:@"DivisionID"];
        NSString *strSubjectID = [self.dicSelectedList objectForKey:@"SubjectID"];
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            arrStudentList=[DBOperation selectData:[NSString stringWithFormat:@"SELECT * FROM StudentList WHERE GradeID = '%@' AND DivisionID = '%@' AND SubjectID = '%@'",strGradeID,strDivisionID,strSubjectID]];
            
            [self.aStudentTable reloadData];
        }
        else
        {
            NSArray *arrt=[DBOperation selectData:[NSString stringWithFormat:@"SELECT * FROM StudentList WHERE GradeID = '%@' AND DivisionID = '%@' AND SubjectID = '%@'",strGradeID,strDivisionID,strSubjectID]];
            
            if(arrt.count != 0)
            {
                [self apiCallFor_getStudentList:@"0"];
            }
            else
            {
                [self apiCallFor_getStudentList:@"1"];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - apiCall

-(void)apiCallFor_getStudentList:(NSString *)strInternet
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_ptcommunication,apk_PTCommunicationGetStudentList_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectedList objectForKey:@"GradeID"]] forKey:@"GradeID"];
    [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectedList objectForKey:@"DivisionID"]] forKey:@"DivisionID"];
    [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectedList objectForKey:@"SubjectID"]] forKey:@"SubjectID"];
    
    if([strInternet isEqualToString:@"1"])
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
                     
                     arrStudentList = [arrResponce mutableCopy];
                     NSString *strGradeID = [self.dicSelectedList objectForKey:@"GradeID"];
                     NSString *strDivisionID = [self.dicSelectedList objectForKey:@"DivisionID"];
                     NSString *strSubjectID = [self.dicSelectedList objectForKey:@"SubjectID"];
                     
                     NSArray *arrSelected = [DBOperation selectData:[NSString stringWithFormat:@"SELECT * FROM StudentList WHERE GradeID = '%@' AND DivisionID = '%@' AND SubjectID = '%@'",strGradeID,strDivisionID,strSubjectID]];;
                     
                     for (NSMutableDictionary *dic in arrSelected) {
                         NSString *str=[dic objectForKey:@"id"];
                         [DBOperation executeSQL:[NSString stringWithFormat:@"DELETE FROM StudentList WHERE id = %@",str]];
                     }
                     
                     for (NSMutableDictionary *dic in arrStudentList)
                     {
                         NSString *FullName = [dic objectForKey:@"FullName"];
                         NSString *MemberID = [dic objectForKey:@"MemberID"];
                         NSString *ProfilePicture = [dic objectForKey:@"ProfilePicture"];
                         NSString *RegistrationNo = [dic objectForKey:@"RegistrationNo"];
                         
                         [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO StudentList(FullName,MemberID,ProfilePicture,RegistrationNo,GradeID,DivisionID,SubjectID)values('%@','%@','%@','%@','%@','%@','%@')",FullName,MemberID,ProfilePicture,RegistrationNo,strGradeID,strDivisionID,strSubjectID]];
                     }
                     [self.aStudentTable reloadData];
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

-(void)apiCallFor_getTeacherList:(NSString *)strInternet
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_ptcommunication,apk_PTCommunicationGetTeacherList_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"GradeID"]] forKey:@"GradeID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"DivisionID"]] forKey:@"DivisionID"];
    [param setValue:@"" forKey:@"SubjectID"];
    
    if([strInternet isEqualToString:@"1"])
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
                     arrStudentList = [arrResponce mutableCopy];
                     
                     [DBOperation executeSQL:[NSString stringWithFormat:@"DELETE FROM TeacherList"]];
                     for (NSMutableDictionary *dic in arrStudentList)
                     {
                         NSString *FullName = [dic objectForKey:@"FullName"];
                         NSString *MemberID = [dic objectForKey:@"MemberID"];
                         NSString *ProfilePicture = [dic objectForKey:@"ProfilePicture"];
                         NSString *RegistrationNo = [dic objectForKey:@"RegistrationNo"];
                         NSString *SubjectID = [dic objectForKey:@"SubjectID"];
                         NSString *SubjectName = [dic objectForKey:@"SubjectName"];
                         
                         [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO TeacherList(FullName,MemberID,ProfilePicture,RegistrationNo,SubjectID,SubjectName)values('%@','%@','%@','%@','%@','%@')",FullName,MemberID,ProfilePicture,RegistrationNo,SubjectID,SubjectName]];
                     }
                     [self.aStudentTable reloadData];
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

#pragma mark - tableview delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrStudentList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.row % 2 ==0)
    {
        cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    }
    
    UILabel *lbltitle=(UILabel *)[cell.contentView viewWithTag:11];
    lbltitle.text=[[arrStudentList objectAtIndex:indexPath.row]objectForKey:@"FullName"];
    
    UILabel *lbltitle1=(UILabel *)[cell.contentView viewWithTag:12];
    lbltitle1.text=@"";
    if([[[arrStudentList objectAtIndex:indexPath.row]objectForKey:@"SubjectName"] length] != 0)
    {
        lbltitle1.text=[[arrStudentList objectAtIndex:indexPath.row]objectForKey:@"SubjectName"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([[Utility getMemberType] isEqualToString:@"Student"])
    {
        PTCommuniVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"PTCommuniVc"];
        vc.dicSelectedList=arrStudentList[indexPath.row];
        vc.strSelectMemberID=[arrStudentList[indexPath.row]objectForKey:@"MemberID"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        PTCommuniVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"PTCommuniVc"];
        vc.dicSelectedList=[self.dicSelectedList mutableCopy];
        vc.strSelectMemberID=[arrStudentList[indexPath.row]objectForKey:@"MemberID"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - button action

- (IBAction)BackBtnClicked:(id)sender
{
    //    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //    // here you need to create storyboard ID of perticular view where you need to navigate your app
    //    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"WallVc"];
    //    UIViewController *vc1 = [mainStoryboard instantiateViewControllerWithIdentifier:@"RightVc"];
    //    [self.revealViewController setFrontViewController:vc animated:YES];
    //    [self.revealViewController setRightViewController:vc1 animated:YES];
    //    [self.navigationController popToViewController:self.revealViewController animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)BackClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnHome:(id)sender {
    [self.frostedViewController hideMenuViewController];
    
    UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"OrataroVc"];
    [self.navigationController pushViewController:wc animated:NO];
}
- (IBAction)btnMenu:(id)sender {
    self.frostedViewController.direction = REFrostedViewControllerDirectionRight;
    
    if (ad.checkview == 0)
    {
        [self.frostedViewController presentMenuViewController];
        ad.checkview = 1;
        
    }
    else
    {
        [self.frostedViewController hideMenuViewController];
        ad.checkview = 0;
    }
}
@end
