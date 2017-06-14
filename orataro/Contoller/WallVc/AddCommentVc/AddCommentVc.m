//
//  AddCommentVc.m
//  orataro
//
//  Created by Softqube on 25/04/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "AddCommentVc.h"
#import "Global.h"

@interface AddCommentVc ()
{
    long totalCountView,countResponce;
    NSMutableArray *arrCommentList;
}
@end
static NSString *CellIdentifier = @"WallCustomeCell";

@implementation AddCommentVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)commonData
{
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    //
    self.tblCommentList.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    //alloc array
    arrCommentList = [[NSMutableArray alloc] init];
    totalCountView=1;
    
    //set Like Count
    NSString *TotalDislike=[self.dicSelectedPost_Comment objectForKey:@"TotalLikes"];
    if([TotalDislike integerValue] <= 0)
    {
        [self.lblLikeCount setText:[NSString stringWithFormat:@"Be the first to like this."]];
    }
    else
    {
        if([TotalDislike integerValue] > 1)
        {
            [self.lblLikeCount setText:[NSString stringWithFormat:@"%@ Likes",TotalDislike]];
        }
        else
        {
            [self.lblLikeCount setText:[NSString stringWithFormat:@"%@ Like",TotalDislike]];
        }
    }
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    //
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    spinner.frame = CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 44);
    self.tblCommentList.tableFooterView = spinner;
    
    //
    [self apiCallFor_GetWallPostComments:@"1"];
}

#pragma mark - keyboard NSNotification

- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    self.viewCommentPost_Bottom.constant=keyboardSize.height;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.viewCommentPost_Bottom.constant=0;

}

#pragma mark - UITextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - apiCall

-(void)apiCallFor_GetWallPostComments:(NSString *)strInternet
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_getwallpostcomment,apk_GetWallPostComments_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%ld",totalCountView] forKey:@"rowno"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectedPost_Comment objectForKey:@"WallID"]] forKey:@"WallID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectedPost_Comment objectForKey:@"PostCommentID"]] forKey:@"PostID"];
    
//    if([strInternet isEqualToString:@"1"])
//    {
//        [ProgressHUB showHUDAddedTo:self.view];
//    }
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [self.tblCommentList.tableFooterView setHidden:YES];
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
                     [self.tblCommentList setHidden:YES];
                 }
                 else
                 {
                     [self.tblCommentList setHidden:NO];
                     countResponce = [arrResponce count];
                     arrCommentList = [arrResponce mutableCopy];
                    
                     NSString *PostCommentID=[self.dicSelectedPost_Comment objectForKey:@"PostCommentID"];
                     if ([_checkscreen isEqualToString:@"Institute"])
                     {
                         //update
                         [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE InstituteWall SET TotalComments = '%lu' WHERE PostCommentID = '%@'",(unsigned long)[arrCommentList count],PostCommentID]];
                     }
                     else if ([_checkscreen isEqualToString:@"Standard"] ||
                              [_checkscreen isEqualToString:@"Division"] ||
                              [_checkscreen isEqualToString:@"Subject"] ||
                              [_checkscreen isEqualToString:@"Group"] ||
                              [_checkscreen isEqualToString:@"Project"])
                     {
                         //update
                         [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE DynamicWall SET TotalComments = '%lu' WHERE PostCommentID = '%@'",(unsigned long)[arrCommentList count],PostCommentID]];
                     }
                     else if ([_checkscreen isEqualToString:@"MyWall"])
                     {
                         //update
                         [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE MyWall SET TotalComments = '%lu' WHERE PostCommentID = '%@'",(unsigned long)[arrCommentList count],PostCommentID]];
                     }
                     else
                     {
                         //update
                         [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE GeneralWall SET TotalComments = '%lu' WHERE PostCommentID = '%@'",(unsigned long)[arrCommentList count],PostCommentID]];
                     }
                     
                     [self.tblCommentList reloadData];
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

-(void)apiCallFor_AddComments:(NSString *)strInternet
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_post,apk_AddComments_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectedPost_Comment objectForKey:@"AssociationID"]] forKey:@"AssociationID"];
    
    [param setValue:[NSString stringWithFormat:@""] forKey:@"RefCommentID"];
   
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
   
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
   
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
   
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
   
    [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectedPost_Comment objectForKey:@"AssociationType"]] forKey:@"AssociationTypeTerm"];
  
    [param setValue:[NSString stringWithFormat:@"%@",self.txtPostComment.text] forKey:@"Comment"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"PostByType"]] forKey:@"PostByType"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectedPost_Comment objectForKey:@"MemberID"]] forKey:@"SendToMemberID"];

    if([strInternet isEqualToString:@"1"])
    {
        [ProgressHUB showHUDAddedTo:self.view];
    }
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [self.tblCommentList.tableFooterView setHidden:YES];
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
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:COMMENTLIST delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else if([strStatus isEqualToString:@"Comment Added successfully."])
                 {
                     [self.txtPostComment setText:@""];
                     [self apiCallFor_GetWallPostComments:@"1"];
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
        [self apiCallFor_GetWallPostComments:@"1"];
    }];
}

#pragma mark - UITableview Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrCommentList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dicResponce=[arrCommentList objectAtIndex:indexPath.row];
    
    NSString *comment=[dicResponce objectForKey:@"Comment"];
    NSString *yourText = [NSString stringWithFormat:@"%@",comment];
    
    CGSize size = [yourText sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:15] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-74, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    return 55 + size.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row % 2 ==0)
    {
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    }
    
    NSMutableDictionary *dicResponce=[arrCommentList objectAtIndex:indexPath.row];
    
    UIImageView *imgProfilePic = (UIImageView *)[cell.contentView viewWithTag:1];
    NSString *strProfilePic_url=[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[dicResponce objectForKey:@"ProfilePicture"]];
    [imgProfilePic sd_setImageWithURL:[NSURL URLWithString:strProfilePic_url] placeholderImage:[UIImage imageNamed:@"user.png"]];
    
    UILabel *lblUserName = (UILabel *)[cell.contentView viewWithTag:2];
    [lblUserName setText:[NSString stringWithFormat:@"%@",[dicResponce objectForKey:@"FullName"]]];
    
    UILabel *lblComment = (UILabel *)[cell.contentView viewWithTag:3];
    [lblComment setText:[NSString stringWithFormat:@"%@",[dicResponce objectForKey:@"Comment"]]];
    
    UILabel *lblCommentOn = (UILabel *)[cell.contentView viewWithTag:4];
    [lblCommentOn setText:[NSString stringWithFormat:@"%@",[dicResponce objectForKey:@"CommentOn"]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSInteger totalRow = [tableView numberOfRowsInSection:indexPath.section];
    
    if(indexPath.row == totalRow -1)
    {
        if(countResponce == 15)
        {
            totalCountView = totalCountView + 15;
            
            if ([Utility isInterNetConnectionIsActive] == true)
            {
                [self.tblCommentList.tableFooterView setHidden:NO];
                [self apiCallFor_GetWallPostComments:@"0"];
            }
        }
        else
        {
            [self.tblCommentList.tableFooterView setHidden:YES];
        }
    }
}


#pragma mark - UIButton Action

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnPostComment:(id)sender
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    if ([Utility validateBlankField:self.txtPostComment.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Enter_Post_Comment delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    [self apiCallFor_AddComments:@"1"];
}
@end
