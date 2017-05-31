//
//  PTCommuniVc.m
//  orataro
//
//  Created by Softqube Mac IOS on 06/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "PTCommuniVc.h"
#import "ChatVc.h"
#import "Global.h"

@interface PTCommuniVc ()
{
    NSMutableArray *arrCummunicationList,*arrCummunicationList_Search;
}
@end

@implementation PTCommuniVc
@synthesize aAddBtnouterView,aSearchTextField,noPtCommunLb,aTableView,ACloseImageView,aTextField,aPopupMainView,aSaveInnerView,aSaveOuterView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    aAddBtnouterView.layer.cornerRadius = 20;
    aAddBtnouterView.layer.masksToBounds = YES;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    aSearchTextField.leftView = paddingView;
    aSearchTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    aTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    
    aSaveOuterView.layer.cornerRadius = 30.0;
    aSaveInnerView.layer.cornerRadius = 25.0;
    
    
    ACloseImageView.image = [ACloseImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [ACloseImageView setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Taptohide:)];
    [aPopupMainView addGestureRecognizer:tap];
    
    aPopupMainView.hidden = YES;
    
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(5, aTextField.frame.size.height - 1, aTextField.frame.size.width-50, 1.0f);
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [aTextField.layer addSublayer:bottomBorder];
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    aTextField.leftView = paddingView1;
    aTextField.leftViewMode = UITextFieldViewModeAlways;
    
    // Do any additional setup after loading the view.
    arrCummunicationList=[[NSMutableArray alloc]init];
    arrCummunicationList_Search=[[NSMutableArray alloc]init];
    if([[Utility getMemberType] isEqualToString:@"Student"])
    {
        [self.aAddBtnouterView setHidden:YES];
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            arrCummunicationList=[DBOperation selectData:[NSString stringWithFormat:@"SELECT * FROM PTCommunicationList"]];
            arrCummunicationList_Search=[DBOperation selectData:[NSString stringWithFormat:@"SELECT * FROM PTCommunicationList"]];
            [self.aTableView reloadData];
        }
        else
        {
            NSArray *Arr=[DBOperation selectData:[NSString stringWithFormat:@"SELECT * FROM PTCommunicationList"]];
            
            if(Arr.count != 0)
            {
                [self apiCallFor_getPTCommunicationList:@"0"];
            }
            else
            {
                [self apiCallFor_getPTCommunicationList:@"1"];
            }
        }
    }
    else
    {
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            arrCummunicationList=[DBOperation selectData:[NSString stringWithFormat:@"SELECT * FROM PTCommunicationList"]];
            arrCummunicationList_Search=[DBOperation selectData:[NSString stringWithFormat:@"SELECT * FROM PTCommunicationList"]];
            [self.aTableView reloadData];
        }
        else
        {
            NSArray *Arr=[DBOperation selectData:[NSString stringWithFormat:@"SELECT * FROM PTCommunicationList"]];
            
            if(Arr.count != 0)
            {
                [self apiCallFor_getPTCommunicationList:@"0"];
            }
            else
            {
                [self apiCallFor_getPTCommunicationList:@"1"];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - apiCall

-(void)apiCallFor_getPTCommunicationList:(NSString *)strInternet
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_ptcommunication,apk_GetPTCommunicationList_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    
    if([[Utility getMemberType] isEqualToString:@"Student"])
    {
        [param setValue:[NSString stringWithFormat:@"Student"] forKey:@"MemberType"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"GradeID"]] forKey:@"GradeID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"DivisionID"]] forKey:@"DivisionID"];
        [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectedList objectForKey:@"SubjectID"]] forKey:@"SubjectID"];
        
        
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"TeacherMemberID"];
        [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectedList objectForKey:@"MemberID"]] forKey:@"StudentMemberID"];
    }
    else
    {
        [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectedList objectForKey:@"GradeID"]] forKey:@"GradeID"];
        [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectedList objectForKey:@"DivisionID"]] forKey:@"DivisionID"];
        [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectedList objectForKey:@"SubjectID"]] forKey:@"SubjectID"];
        
        [param setValue:[NSString stringWithFormat:@"Teacher"] forKey:@"MemberType"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"TeacherMemberID"];
        [param setValue:[NSString stringWithFormat:@"%@",self.strSelectMemberID] forKey:@"StudentMemberID"];
    }
    
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
                     arrCummunicationList=[[NSMutableArray alloc]init];
                     arrCummunicationList = [arrResponce mutableCopy];
                     arrCummunicationList_Search=[[NSMutableArray alloc]init];
                     arrCummunicationList_Search = [arrResponce mutableCopy];
                     
                     [DBOperation executeSQL:[NSString stringWithFormat:@"DELETE FROM PTCommunicationList"]];
                     
                     for (NSMutableDictionary *dic in arrCummunicationList)
                     {
                         NSString *CommunicationDetail = [dic objectForKey:@"CommunicationDetail"];
                         NSString *CommunicationID = [dic objectForKey:@"CommunicationID"];
                         NSString *SeqNo = [dic objectForKey:@"SeqNo"];
                         NSString *UnReadCount = [dic objectForKey:@"UnReadCount"];
                         NSString *UserName = [dic objectForKey:@"UserName"];
                         
                         [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO PTCommunicationList(CommunicationDetail,CommunicationID,SeqNo,UnReadCount,UserName)values('%@','%@','%@','%@','%@')",CommunicationDetail,CommunicationID,SeqNo,UnReadCount,UserName]];
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

-(void)apiCallFor_CreateNewPTCommnunication:(NSString *)strInternet
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_ptcommunication,apk_CreateNewPTCommnunication_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"TeacherMemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",self.strSelectMemberID] forKey:@"StudentMemberID"];
    [param setValue:[NSString stringWithFormat:@"Teacher"] forKey:@"MemberType"];
    
    [param setValue:[NSString stringWithFormat:@"%@",self.aTextField.text] forKey:@"Title"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectedList objectForKey:@"DivisionID"]] forKey:@"DivisionID"];
    [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectedList objectForKey:@"GradeID"]] forKey:@"GradeID"];
    [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectedList objectForKey:@"SubjectID"]] forKey:@"SujbectID"];
    [param setValue:@"" forKey:@"BeachID"];
    if([strInternet isEqualToString:@"1"])
    {
        [ProgressHUB showHUDAddedTo:self.view];
    }
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             if([dicResponce count] != 0)
             {
                 [self apiCallFor_SendPushNotification];
                 
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

-(void)apiCallFor_SendPushNotification
{
    if ([Utility isInterNetConnectionIsActive] == false){
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_notifications,apk_SendPushNotification_action];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    [ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error){
        [ProgressHUB hideenHUDAddedTo:self.view];
        [self apiCallFor_getPTCommunicationList:@"1"];
    }];
}

#pragma mark - UITextField Delegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [[textField text] stringByReplacingCharactersInRange:range withString:string];
    if (textField == self.aSearchTextField)
    {
        if([newString length] > 0)
        {
            arrCummunicationList=[[NSMutableArray alloc]init];
            NSArray *arrKeyName=[[arrCummunicationList_Search valueForKey:@"CommunicationDetail"]mutableCopy];
            
            NSUInteger index = 0;
            for (NSString *strKeyName in arrKeyName)
            {
                NSMutableDictionary *dicData=[[arrCummunicationList_Search objectAtIndex:index]mutableCopy];
                if(![strKeyName isKindOfClass:[NSNull class]])
                {
                    if([strKeyName rangeOfString:newString options:NSCaseInsensitiveSearch].location == NSNotFound)
                    {
                        [arrCummunicationList removeObject:dicData];
                    }
                    else
                    {
                        if(![arrCummunicationList containsObject:dicData])
                        {
                            [arrCummunicationList addObject:dicData];
                        }
                    }
                }
                index++;
            }
        }
        else if([newString isEqualToString:@""])
        {
            arrCummunicationList=[[NSMutableArray alloc]init];
            arrCummunicationList=[arrCummunicationList_Search mutableCopy];
        }
    }
    
    [self.aTableView reloadData];
    return YES;
}


#pragma mark - tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunicationCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommunicationCell"];
    }
    if (indexPath.row % 2 ==0)
    {
        cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    }
    
    UILabel *lblTitle=(UILabel*)[cell.contentView viewWithTag:11];
    [lblTitle setText:[NSString stringWithFormat:@"%@",[arrCummunicationList[indexPath.row] objectForKey:@"CommunicationDetail"]]];
    
    UILabel *lblUserName=(UILabel*)[cell.contentView viewWithTag:12];
    [lblUserName setText:[NSString stringWithFormat:@"%@",[arrCummunicationList[indexPath.row] objectForKey:@"UserName"]]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrCummunicationList count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 82;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatVc  *c = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ChatVc"];
    c.dicChatData = [arrCummunicationList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:c animated:YES];
}



#pragma mark - button action
-(void)Taptohide:(UIGestureRecognizer *)tap
{
    aPopupMainView.hidden = YES;
    [self.view endEditing:YES];
    [self apiCallFor_CreateNewPTCommnunication:@"1"];
}
- (IBAction)AddBtnClicked:(id)sender
{
    if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"])
    {
        if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
            {
                if([[Utility getUserRoleRightList:@"PT Communicatoin" settingType:@"IsCreate"] integerValue] == 1)
                {
                    aPopupMainView.hidden = NO;
                    [self.view bringSubviewToFront:aPopupMainView];
                }
                else
                {
                    [WToast showWithText:You_dont_have_permission];
                }
            }
            else
            {
                aPopupMainView.hidden = NO;
                [self.view bringSubviewToFront:aPopupMainView];
            }
        }
        else
        {
            aPopupMainView.hidden = NO;
            [self.view bringSubviewToFront:aPopupMainView];
        }
    }
    else
    {
        aPopupMainView.hidden = NO;
        [self.view bringSubviewToFront:aPopupMainView];
    }
}

- (IBAction)BackBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)CloseBtnClicked:(id)sender
{
    aPopupMainView.hidden = YES;
}

@end
