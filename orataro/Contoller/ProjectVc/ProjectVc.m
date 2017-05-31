//
//  ProjectVc.m
//  orataro
//
//  Created by Softqube on 13/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ProjectVc.h"
#import "ORGDetailViewController.h"
#import "ORGContainerCell.h"
#import "ORGContainerCellView.h"
#import "CreateProjectVc.h"
#import "Global.h"

@interface ProjectVc ()
{
    NSMutableArray *aryProjectData;
    NSMutableDictionary *dicDelProject;
}
@end

@implementation ProjectVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //  aryProjectData = [[NSMutableArray alloc]init];
    
    _AddBtn.layer.cornerRadius = 20.0;
    
    
    _viewDeletePopup.hidden = YES;
    
    _imgCancel.image = [_imgCancel.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //[_imgCancelicon setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    _viewSave.layer.cornerRadius = 30.0;
    _viewInnerSave.layer.cornerRadius = 25.0;
    
    

    
    
    _tblProjectList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    // Do any additional setup after loading the view.
    NSMutableArray *arrTemp=[[NSMutableArray alloc]init];
    NSMutableArray *arrsecDetail=[[NSMutableArray alloc]init];
    [arrsecDetail addObject:@"a"];
    [arrsecDetail addObject:@"a"];
    [arrsecDetail addObject:@"a"];
    [arrsecDetail addObject:@"a"];
    [arrsecDetail addObject:@"a"];
    [arrsecDetail addObject:@"a"];
    [arrsecDetail addObject:@"a"];
    [arrsecDetail addObject:@"a"];
    [arrsecDetail addObject:@"a"];
    [arrsecDetail addObject:@"a"];
    
    NSMutableDictionary *dicSection=[[NSMutableDictionary alloc]init];
    [dicSection setObject:@"asa" forKey:@"FloorID"];
    [dicSection setObject:arrsecDetail forKey:@"Floor"];
    [arrTemp addObject:dicSection];
    
    self.sampleData=[arrTemp mutableCopy];
    
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    // Register the table cell
    [self.tblProjectList registerClass:[ORGContainerCell class] forCellReuseIdentifier:@"ORGContainerCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectItemFromCollectionView:) name:@"didSelectItemFromCollectionView" object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    _lbHeaderTitle.text = [NSString stringWithFormat:@"Project (%@)",[Utility getCurrentUserName]];
    
    //CREATE TABLE "ProjectList" ("id" INTEGER PRIMARY KEY  NOT NULL , "projectJsonStr" VARCHAR, "flag" VARCHAR, "imageStr" VARCHAR)
    
    [self api_getProjectList:YES];
    
}

#pragma mark - Table View

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 67;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [aryProjectData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ORGContainerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ORGContainerCell"];
    NSDictionary *cellData = [aryProjectData objectAtIndex:[indexPath section]];
    NSArray *articleData=  [cellData objectForKey:@"aryImages"];
    [cell setCollectionData:articleData];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *HeaderCellIdentifier = @"cellSection";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderCellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCellIdentifier];
    }
    
    UIImageView *img1 = (UIImageView *)[cell.contentView viewWithTag:50];
    img1.image = [img1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [img1 setTintColor:[UIColor colorWithRed:39.0/255.0 green:48.0/255.0 blue:91.0/255.0 alpha:1.0]];
    img1.contentMode = UIViewContentModeScaleAspectFit;
    
    //UIButton *btn = (UIButton *)[cell.contentView viewWithTag:4];
    
    UILabel *lb = (UILabel *)[cell.contentView viewWithTag:2];
    
    lb.text = [[aryProjectData objectAtIndex:section]objectForKey:@"ProjectTitle"];
    
    UILabel *lb1 = (UILabel *)[cell.contentView viewWithTag:3];
    lb1.text = [[aryProjectData objectAtIndex:section]objectForKey:@"UserName"];
    
    UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
    headerTapped.view.tag = section;
    [cell.contentView addGestureRecognizer:headerTapped];
    cell.contentView.tag  = section;
    
    //cell.contentView.backgroundColor = [UIColor colorWithRed:39.0/255.0 green:48.0/255.0 blue:48.0/255.0 alpha:1.0];
   // _btnSave.tag = section;
    
    return cell;
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    NSDictionary *cellData = [notification object];
////
////    if (cellData)
////    {
////
////    }

//}

#pragma mark - NSNotification to select table cell

- (void) didSelectItemFromCollectionView:(NSNotification *)notification
{
    
    //    NSDictionary *cellData = [notification object];
    //
    //    if (cellData)
    //    {
    //
    //    }
    //    CreateProjectVc *s = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"CreateProjectVc"];
    //    s.projectvar =@"Edit";
    //    [self.navigationController pushViewController:s animated:YES];
}

#pragma mark - button action

- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    
  //  NSLog(@"Data=%@",[aryProjectData objectAtIndex:indexPath.section]);
    
    CreateProjectVc *s = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"CreateProjectVc"];
    s.projectvar =@"Edit";
    s.dicCreateProject = [aryProjectData objectAtIndex:indexPath.section];
    [self.navigationController pushViewController:s animated:YES];
}

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addBtnClicked:(id)sender
{
    if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"])
    {
        if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
            {
                if([[Utility getUserRoleRightList:@"Project" settingType:@"IsCreate"] integerValue] == 1)
                {
                    if ([Utility isInterNetConnectionIsActive] == false)
                    {
                        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alrt show];
                        return;
                    }
                    CreateProjectVc *s = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"CreateProjectVc"];
                    s.projectvar = @"Create";
                    [self.navigationController pushViewController:s animated:YES];
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
                CreateProjectVc *s = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"CreateProjectVc"];
                s.projectvar = @"Create";
                [self.navigationController pushViewController:s animated:YES];
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
            CreateProjectVc *s = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"CreateProjectVc"];
            s.projectvar = @"Create";
            [self.navigationController pushViewController:s animated:YES];
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
        CreateProjectVc *s = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"CreateProjectVc"];
        s.projectvar = @"Create";
        [self.navigationController pushViewController:s animated:YES];
    }
    
}


- (IBAction)btnDeleteClicked:(id)sender
{
    if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"])
    {
        if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
            {
                if([[Utility getUserRoleRightList:@"Project" settingType:@"IsDelete"] integerValue] == 1)
                {
                    _viewDeletePopup.hidden = NO;
                    [self.view bringSubviewToFront:_viewDeletePopup];
                    
                    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_tblProjectList];
                    NSIndexPath *indexPath = [_tblProjectList indexPathForRowAtPoint:buttonPosition];
                    dicDelProject = [aryProjectData objectAtIndex:indexPath.section];
                }
                else
                {
                    [WToast showWithText:You_dont_have_permission];
                }
            }
            else
            {
                _viewDeletePopup.hidden = NO;
                [self.view bringSubviewToFront:_viewDeletePopup];
                
                CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_tblProjectList];
                NSIndexPath *indexPath = [_tblProjectList indexPathForRowAtPoint:buttonPosition];
                dicDelProject = [aryProjectData objectAtIndex:indexPath.section];
            }
        }
        else
        {
            _viewDeletePopup.hidden = NO;
            [self.view bringSubviewToFront:_viewDeletePopup];
            
            CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_tblProjectList];
            NSIndexPath *indexPath = [_tblProjectList indexPathForRowAtPoint:buttonPosition];
            dicDelProject = [aryProjectData objectAtIndex:indexPath.section];
        }
    }
    else
    {
        _viewDeletePopup.hidden = NO;
        [self.view bringSubviewToFront:_viewDeletePopup];
        
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_tblProjectList];
        NSIndexPath *indexPath = [_tblProjectList indexPathForRowAtPoint:buttonPosition];
        dicDelProject = [aryProjectData objectAtIndex:indexPath.section];
    }
    
}
- (IBAction)btnSaveClicked:(id)sender
{
    [self api_delteProjectList:dicDelProject :YES];
}

- (IBAction)btnCancelClicked:(id)sender
{
    _viewDeletePopup.hidden = YES;
}

#pragma mark - Get Project List Api

-(void)api_getProjectList :(BOOL)checkVal
{
    
    //CREATE TABLE "ProjectList" ("id" INTEGER PRIMARY KEY  NOT NULL , "projectJsonStr" VARCHAR, "flag" VARCHAR, "imageStr" VARCHAR)
    
    //    #define apk_projects @"apk_projects.asmx"
    //
    //    #define apk_GetProjectList_action  @"GetProjectList"
    //    #define apk_PrjectDataByID_action  @"PrjectDataByID"
    //    #define apk_saveupdateproject_action @"saveupdateproject"
    //    #define apk_DeleteProjects_action @"DeleteProjects"
    
    //    <GetProjectList xmlns="http://tempuri.org/">
    //    <InstituteID>guid</InstituteID>
    //    <ClientID>guid</ClientID>
    //    <UserID>guid</UserID>
    //    <BeachID>guid</BeachID>
    //    </GetProjectList>
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_projects,apk_GetProjectList_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    
    if (checkVal == YES)
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
                     
                     aryProjectData = [[NSMutableArray alloc]initWithArray:arrResponce];
                     
                     NSLog(@"ary Getdata=%@",aryProjectData);
                     
                     NSMutableDictionary *dic  = [[NSMutableDictionary alloc]init];
                     
                     for (int i=0; i<aryProjectData.count; i++)
                     {
                        dic = [[aryProjectData objectAtIndex:i]mutableCopy];
                         
                         NSString *str=  [dic objectForKey:@"ProfilePicture"];
                         NSArray *articleData = [str componentsSeparatedByString:@","];
                         
                         NSMutableArray *trmpary = [[NSMutableArray alloc]init];
                         
                         for (int j=0; j<articleData.count; j++)
                         {
                             NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                             
                             [dic setValue:[articleData objectAtIndex:j] forKey:@"Images"];
                             
                             [trmpary addObject:dic];
                         }
                         [dic setValue:trmpary forKey:@"aryImages"];
                         
                         [aryProjectData replaceObjectAtIndex:i withObject:dic];
                        // [aryProjectData replaceObjectAtIndex:i withObject:@"ProfilePicture"];
                     }
                     NSLog(@"Aryproject=%@",aryProjectData);
                     
                    [_tblProjectList reloadData];
                
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

#pragma mark - Delete Project 

-(void)api_delteProjectList :(NSMutableDictionary *)dic :(BOOL)checkVal
{
    
    //CREATE TABLE "ProjectList" ("id" INTEGER PRIMARY KEY  NOT NULL , "projectJsonStr" VARCHAR, "flag" VARCHAR, "imageStr" VARCHAR)
    
    //    #define apk_projects @"apk_projects.asmx"
    //
    //    #define apk_GetProjectList_action  @"GetProjectList"
    //    #define apk_PrjectDataByID_action  @"PrjectDataByID"
    //    #define apk_saveupdateproject_action @"saveupdateproject"
    //    #define apk_DeleteProjects_action @"DeleteProjects"
    
    //    <GetProjectList xmlns="http://tempuri.org/">
    //    <InstituteID>guid</InstituteID>
    //    <ClientID>guid</ClientID>
    //    <UserID>guid</UserID>
    //    <BeachID>guid</BeachID>
    //    </GetProjectList>
    
    //DeleteProjects
    
    //ProjectID=6fd72a14-695b-4d1f-aa82-db0821b71c85
    //InstituteID=4f4bbf0e-858a-46fa-a0a7-bf116f537653
    //ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
    //UserID=30032284-31d1-4ba6-8ef4-54edb8e223aa
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_projects,apk_DeleteProjects_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dic  objectForKey:@"ProjectID"]] forKey:@"ProjectID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    
    if (checkVal == YES)
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
                 if([strStatus isEqualToString:@"Record delete successfully"])
                 {
                      _viewDeletePopup.hidden = YES;
                     [self api_getProjectList:YES];
                     
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

@end
