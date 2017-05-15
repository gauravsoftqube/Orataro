//
//  SingleWallVC.m
//  orataro
//
//  Created by Softqube on 11/05/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "SingleWallVC.h"
#import "Global.h"

@interface SingleWallVC ()
{
    NSMutableArray *arrCommentList;
    long totalCountView;
    long countResponce;
    NSMutableArray *arrPopup;
    
    NSMutableArray *arrSpecialFriendList,*arrSelected_SpecialFriendList,*arrSpecialFriendListMain;

}
@end
static NSString *CellIdentifier = @"WallCustomeCell";

@implementation SingleWallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    //set search
    [self SearchTextView:self.viewSearch_SpecialFriends];
    
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    //
    self.tblSpecialFriendsList.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tblPostAndCommentList.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.lblNOComment setHidden:YES];
    [self.viewLike.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.viewLike.layer setBorderWidth:1];
    
    //
    [self.tblPostAndCommentList registerNib:[UINib nibWithNibName:@"WallCustomeCell" bundle:nil] forCellReuseIdentifier:@"WallCustomeCell"];
    
    
    //alloc array
    arrCommentList = [[NSMutableArray alloc] init];
    totalCountView=1;
    
    
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
    self.tblPostAndCommentList.tableFooterView = spinner;
    
    //set Header Title
    NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
    if (arr.count != 0)
    {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Post (%@)",[arr objectAtIndex:0]];
    }
    else
    {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Post"];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    //
    [self apiCallFor_GetWallPostComments:@"1"];

}

-(void)SearchTextView: (UIView *)viewSearch
{
    //Bottom border self.view.frame.size.width
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, viewSearch.frame.size.height - 1, [UIScreen mainScreen].bounds.size.width - 66, 1.0f);
    bottomBorder.shadowColor = [UIColor grayColor].CGColor;
    bottomBorder.shadowOffset = CGSizeMake(1, 1);
    bottomBorder.shadowOpacity = 1;
    bottomBorder.shadowRadius = 1.0;
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [viewSearch.layer addSublayer:bottomBorder];
    
    //left border
    CALayer *leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(0.0f, 30.0f, 1.0f, viewSearch.frame.size.height-30);
    leftBorder.shadowColor = [UIColor grayColor].CGColor;
    leftBorder.shadowOffset = CGSizeMake(1, 1);
    leftBorder.shadowOpacity = 1;
    leftBorder.shadowRadius = 1.0;
    leftBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [viewSearch.layer addSublayer:leftBorder];
    
    //right border
    CALayer *rightBorder = [CALayer layer];
    rightBorder.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-66, 30.0f, 1.0f, viewSearch.frame.size.height-30);
    rightBorder.shadowColor = [UIColor grayColor].CGColor;
    rightBorder.shadowOffset = CGSizeMake(1, 1);
    rightBorder.shadowOpacity = 1;
    rightBorder.shadowRadius = 1.0;
    rightBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [viewSearch.layer addSublayer:rightBorder];
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

#pragma mark - UITextfield Delegate

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length == 0)
    {
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [[textField text] stringByReplacingCharactersInRange:range withString:string];
    if (textField == self.txtSearch_SpecialFriends)
    {
        if([newString length] > 0)
        {
            arrSpecialFriendList=[[NSMutableArray alloc]init];
            NSArray *arrKeyName=[[arrSpecialFriendListMain valueForKey:@"FullName"]mutableCopy];
            
            NSUInteger index = 0;
            for (NSString *strKeyName in arrKeyName)
            {
                NSMutableDictionary *dicData=[[arrSpecialFriendListMain objectAtIndex:index]mutableCopy];
                if(![strKeyName isKindOfClass:[NSNull class]])
                {
                    if([strKeyName rangeOfString:newString options:NSCaseInsensitiveSearch].location == NSNotFound)
                    {
                        [arrSpecialFriendList removeObject:dicData];
                    }
                    else
                    {
                        if(![arrSpecialFriendList containsObject:dicData])
                        {
                            [arrSpecialFriendList addObject:dicData];
                        }
                    }
                }
                index++;
            }
        }
        else if([newString isEqualToString:@""])
        {
            arrSpecialFriendList=[[NSMutableArray alloc]init];
            arrSpecialFriendList=[arrSpecialFriendListMain mutableCopy];
        }
    }
    
    [self.tblSpecialFriendsList reloadData];
    return YES;
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
         [self.tblPostAndCommentList.tableFooterView setHidden:YES];
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
                     //                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     //                     [alrt show];
                 }
                 else
                 {
                     countResponce = [arrResponce count];
                     long index=0;
                     for (NSMutableDictionary *dicID in arrResponce)
                     {
                         if ([[arrCommentList valueForKey:@"CommentID"] containsObject:[dicID objectForKey:@"CommentID"]])
                         {
                             [arrCommentList removeObjectAtIndex:index];
                             [arrCommentList addObject:dicID];
                         }
                         else
                         {
                             [arrCommentList addObject:dicID];
                         }
                         
                         index++;
                     }
                     
                     [self.tblPostAndCommentList reloadData];
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

-(void)apiCallFor_LikePost:(NSString *)strInternet dicselectedWall:(NSMutableDictionary *)dicSelectedWall
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_post,apk_LikePost_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicSelectedWall objectForKey:@"PostCommentID"]] forKey:@"pdataID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicSelectedWall objectForKey:@"AssociationType"]] forKey:@"ptype"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicSelectedWall objectForKey:@"MemberID"]] forKey:@"SendToMemberID"];
    
    if([[dicSelectedWall objectForKey:@"IsLike"] integerValue] == 1)
    {
        [param setValue:[NSString stringWithFormat:@"false"] forKey:@"IsLike"];
    }
    else
    {
        [param setValue:[NSString stringWithFormat:@"true"] forKey:@"IsLike"];
    }
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicSelectedWall objectForKey:@"WallID"]] forKey:@"WallID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    
    
    if([strInternet isEqualToString:@"1"])
    {
        [ProgressHUB showHUDAddedTo:self.view];
    }
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         //
         [self setUIButton_EnableYes];
         
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
                 }
                 else
                 {
                     NSString *TotalLikes=[dic objectForKey:@"TotalLikes"];
                     NSString *PostCommentID=[dic objectForKey:@"PostCommentID"];
                     
                     if ([_checkscreen isEqualToString:@"Institute"])
                     {
                         //update
                         [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE InstituteWall SET TotalLikes = '%@' WHERE PostCommentID = '%@'",TotalLikes,PostCommentID]];
                     }
                     else if([_checkscreen isEqualToString:@"Standard"])
                     {
                         //update
                         [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE StandardWall SET TotalLikes = '%@' WHERE PostCommentID = '%@'",TotalLikes,PostCommentID]];
                     }
                     else if ([_checkscreen isEqualToString:@"Division"])
                     {
                         //update
                         [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE DivisionWall SET TotalLikes = '%@' WHERE PostCommentID = '%@'",TotalLikes,PostCommentID]];
                     }
                     else if ([_checkscreen isEqualToString:@"Subject"])
                     {
                         //update
                         [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE SubjectWall SET TotalLikes = '%@' WHERE PostCommentID = '%@'",TotalLikes,PostCommentID]];
                     }
                     else if ([_checkscreen isEqualToString:@"MyWall"])
                     {
                         //update
                         [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE MyWall SET TotalLikes = '%@' WHERE PostCommentID = '%@'",TotalLikes,PostCommentID]];
                     }
                     else
                     {
                         //update
                         [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE GeneralWall SET TotalLikes = '%@' WHERE PostCommentID = '%@'",TotalLikes,PostCommentID]];
                     }
                     
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

-(void)apiCallFor_UnLikePost:(NSString *)strInternet dicselectedWall:(NSMutableDictionary *)dicSelectedWall
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_post,apk_DisLikePost_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicSelectedWall objectForKey:@"PostCommentID"]] forKey:@"pdataID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicSelectedWall objectForKey:@"AssociationType"]] forKey:@"ptype"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicSelectedWall objectForKey:@"MemberID"]] forKey:@"SendToMemberID"];
    
    if([[dicSelectedWall objectForKey:@"IsDislike"] integerValue] == 1)
    {
        [param setValue:[NSString stringWithFormat:@"false"] forKey:@"IsDislike"];
    }
    else
    {
        [param setValue:[NSString stringWithFormat:@"true"] forKey:@"IsDislike"];
    }
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicSelectedWall objectForKey:@"WallID"]] forKey:@"WallID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    
    
    if([strInternet isEqualToString:@"1"])
    {
        [ProgressHUB showHUDAddedTo:self.view];
    }
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [self setUIButton_EnableYes];
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
                 }
                 else
                 {
                     NSString *TotalDislike=[dic objectForKey:@"TotalDislike"];
                     NSString *PostCommentID=[dic objectForKey:@"PostCommentID"];
                     if ([_checkscreen isEqualToString:@"Institute"])
                     {
                         //update
                         [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE InstituteWall SET TotalDislike = '%@' WHERE PostCommentID = '%@'",TotalDislike,PostCommentID]];
                     }
                     else if([_checkscreen isEqualToString:@"Standard"])
                     {
                         //update
                         [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE StandardWall SET TotalDislike = '%@' WHERE PostCommentID = '%@'",TotalDislike,PostCommentID]];
                     }
                     else if ([_checkscreen isEqualToString:@"Division"])
                     {
                         //update
                         [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE DivisionWall SET TotalDislike = '%@' WHERE PostCommentID = '%@'",TotalDislike,PostCommentID]];
                     }
                     else if ([_checkscreen isEqualToString:@"Subject"])
                     {
                         //update
                         [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE SubjectWall SET TotalDislike = '%@' WHERE PostCommentID = '%@'",TotalDislike,PostCommentID]];
                     }
                     else if ([_checkscreen isEqualToString:@"MyWall"])
                     {
                         //update
                         [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE MyWall SET TotalDislike = '%@' WHERE PostCommentID = '%@'",TotalDislike,PostCommentID]];
                     }
                     else
                     {
                         //update
                         [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE GeneralWall SET TotalDislike = '%@' WHERE PostCommentID = '%@'",TotalDislike,PostCommentID]];
                     }
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

#pragma mark - apiCall For Share Post

-(void)apiCallFor_SharePost:(NSString *)strInternet ShareType:(NSString *)ShareType
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_post,apk_SharePost_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    if ([_checkscreen isEqualToString:@"Institute"])
    {
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstitutionWallID"]] forKey:@"WallID"];
    }
    else if([_checkscreen isEqualToString:@"Standard"])
    {
        [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]] forKey:@"WallID"];
    }
    else if ([_checkscreen isEqualToString:@"Division"])
    {
        [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]] forKey:@"WallID"];
    }
    else if ([_checkscreen isEqualToString:@"Subject"])
    {
        [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]] forKey:@"WallID"];
    }
    else if ([_checkscreen isEqualToString:@"MyWall"])
    {
        [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelect_std_divi_sub objectForKey:@"WallID"]] forKey:@"WallID"];
    }
    else
    {
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] forKey:@"WallID"];
    }
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectedPost_Comment objectForKey:@"PostCommentID"]] forKey:@"SharePostID"];
    [param setValue:[NSString stringWithFormat:@"%@",ShareType] forKey:@"ShareType"];
    
    if([ShareType isEqualToString:@"Special Friend"])
    {
        NSArray *arrFriendID = [arrSelected_SpecialFriendList valueForKey:@"FriendID"];
        NSString *strFriendID = [arrFriendID componentsJoinedByString:@","];
        [param setValue:[NSString stringWithFormat:@"%@",strFriendID] forKey:@"TagID"];
    }
    else
    {
        [param setValue:[NSString stringWithFormat:@""] forKey:@"TagID"];
    }
    
    [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelectedPost_Comment objectForKey:@"MemberID"]] forKey:@"SendToMemberID"];
    
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
                 }
                 else if([strStatus isEqualToString:@"Post share successfully"])
                 {
                     [WToast showWithText:@"Post share successfully"];
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

-(void)apiCallFor_GetFriendList : (BOOL)checkProgress
{
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_friends,apk_GetFriendList];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    
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
                     arrSpecialFriendListMain  =[[NSMutableArray alloc]init];
                     arrSelected_SpecialFriendList = [[NSMutableArray alloc]init];
                     arrSpecialFriendList = [[NSMutableArray alloc]init];
                     arrSpecialFriendList=[arrResponce mutableCopy];
                     arrSpecialFriendListMain  =[arrResponce mutableCopy];
                     [self.tblSpecialFriendsList reloadData];
                     
                     [self.view endEditing:YES];
                     [self.viewSpecialFriends_Popup setHidden:NO];
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


#pragma mark - UITableview Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView == self.tblSpecialFriendsList)
    {
        return 0;
    }
    else
    {
#pragma mark - set Post Detail Height
        NSMutableDictionary *dicResponce=[self.dicSelectedPost_Comment mutableCopy];
        NSString *strFileType=[dicResponce objectForKey:@"FileType"];
        if([strFileType isEqualToString:@"IMAGE"])
        {
            if([[dicResponce objectForKey:@"Photo"] length] != 0)
            {
                NSString *strPostCommentNote=[dicResponce objectForKey:@"PostCommentNote"];
                strPostCommentNote =[strPostCommentNote stringByReplacingOccurrencesOfString:@"</br>" withString:@""];
                strPostCommentNote =[strPostCommentNote stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
                
                CGSize size = [strPostCommentNote sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:14] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-16, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
                
                NSString *TotalLikes = [dicResponce objectForKey:@"TotalLikes"];
                NSString *TotalDislike = [dicResponce objectForKey:@"TotalDislike"];
                NSString *TotalComments = [dicResponce objectForKey:@"TotalComments"];
                if([TotalLikes integerValue]  == 0   &&
                   [TotalDislike integerValue]  == 0 &&
                   [TotalComments integerValue]  == 0)
                {
                    return 310 + size.height - 30;
                }
                else
                {
                    return 325 + size.height - 30;
                }
            }
            else
            {
                return 350 - 30;
            }
        }
        else if([strFileType isEqualToString:@"Text"])
        {
            NSString *strPostCommentNote = [dicResponce objectForKey:@"PostCommentNote"];
            strPostCommentNote = [strPostCommentNote stringByReplacingOccurrencesOfString:@"</br> </br>" withString:@""];
            
            CGSize size = [[NSString stringWithFormat:@"%@",strPostCommentNote] sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:14] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-16, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
            
            NSString *TotalLikes = [dicResponce objectForKey:@"TotalLikes"];
            NSString *TotalDislike = [dicResponce objectForKey:@"TotalDislike"];
            NSString *TotalComments = [dicResponce objectForKey:@"TotalComments"];
            if([TotalLikes integerValue]  == 0   &&
               [TotalDislike integerValue]  == 0 &&
               [TotalComments integerValue]  == 0)
            {
                return 125 + size.height - 27;
            }
            else
            {
                return 139 + size.height - 27;
            }
        }
        else if([strFileType isEqualToString:@"VIDEO"])
        {
            NSString *strPostCommentNote = [dicResponce objectForKey:@"PostCommentNote"];
            strPostCommentNote = [strPostCommentNote stringByReplacingOccurrencesOfString:@"</br> </br>" withString:@""];
            CGSize size = [[NSString stringWithFormat:@"%@",strPostCommentNote] sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:14] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-16, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
            
            NSString *TotalLikes = [dicResponce objectForKey:@"TotalLikes"];
            NSString *TotalDislike = [dicResponce objectForKey:@"TotalDislike"];
            NSString *TotalComments = [dicResponce objectForKey:@"TotalComments"];
            if([TotalLikes integerValue]  == 0   &&
               [TotalDislike integerValue]  == 0 &&
               [TotalComments integerValue]  == 0)
            {
                return 250 + size.height - 30;
            }
            else
            {
                return 260 + size.height - 30;
            }
            
        }
        else if([strFileType isEqualToString:@"FILE"])
        {
            return 220 - 30;
        }
        else
        {
            return 350 - 30;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == self.tblSpecialFriendsList)
    {
        return 1;
    }
    else
    {
        return 1;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView == self.tblSpecialFriendsList)
    {
        return nil;
    }
    else
    {
        WallCustomeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[WallCustomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.viewLike_Height.constant=0;
        cell.imgLike_Height.constant=0;
        cell.imgDisLike_Height.constant=0;
        cell.imgComment_Height.constant=0;
        cell.imgShare_Height.constant=0;
        
#pragma mark - set Header
        NSString *strProfilePic_url=[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[self.dicSelectedPost_Comment objectForKey:@"ProfilePicture"]];
        
        [cell.imgProfilePic sd_setImageWithURL:[NSURL URLWithString:strProfilePic_url] placeholderImage:[UIImage imageNamed:@"user.png"]];
        
        NSString *strFullName=[self.dicSelectedPost_Comment objectForKey:@"FullName"];
        [cell.lblProfileName setText:strFullName];
        
        NSString *strDateOfPost=[self.dicSelectedPost_Comment objectForKey:@"DateOfPost"];
        NSString *strPostCommentTypesTerm=[self.dicSelectedPost_Comment objectForKey:@"PostCommentTypesTerm"];
        [cell.lblProfileDetail setText:[NSString stringWithFormat:@"%@ %@",strPostCommentTypesTerm,strDateOfPost]];
        
        NSString *strPostedOn=[self.dicSelectedPost_Comment objectForKey:@"PostedOn"];
        [cell.lblProfile_PostType setText:[NSString stringWithFormat:@"%@",strPostedOn]];
        
        cell.btnEditDeletePost_Height.constant = 0;
        
#pragma mark - set Post Detail
        
        NSString *strPostCommentNote=[self.dicSelectedPost_Comment objectForKey:@"PostCommentNote"];
        strPostCommentNote =[strPostCommentNote stringByReplacingOccurrencesOfString:@"</br>" withString:@""];
        strPostCommentNote =[strPostCommentNote stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
        //NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[strPostCommentNote dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        cell.lblPostDetailHTML.text = strPostCommentNote;
        
        NSString *strFileType=[self.dicSelectedPost_Comment objectForKey:@"FileType"];
        if([strFileType isEqualToString:@"IMAGE"])
        {
            NSString *strPost_Photo=[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[self.dicSelectedPost_Comment objectForKey:@"Photo"]];
            if([[self.dicSelectedPost_Comment objectForKey:@"Photo"] length] != 0)
            {
                [cell.imgPost sd_setImageWithURL:[NSURL URLWithString:strPost_Photo] placeholderImage:[UIImage imageNamed:@"no_img.png"]];
            }
            else
            {
                
            }
        }
        else if([strFileType isEqualToString:@"VIDEO"])
        {
            cell.imgPost.image = [UIImage imageNamed:@"dummy_video.png"];
        }
        else if([strFileType isEqualToString:@"FILE"])
        {
            cell.imgPost.image = [UIImage imageNamed:@"pdf_blue.png"];
        }
        else
        {
            cell.imgPost.image = [UIImage imageNamed:@"no_img.png"];
        }
        
#pragma mark - Like UnLike Comment COUNT
        
        NSString *TotalLikes = [self.dicSelectedPost_Comment objectForKey:@"TotalLikes"];
        NSString *TotalDislike = [self.dicSelectedPost_Comment objectForKey:@"TotalDislike"];
        NSString *TotalComments = [self.dicSelectedPost_Comment objectForKey:@"TotalComments"];
        if([TotalLikes integerValue]  == 0   &&
           [TotalDislike integerValue]  == 0 &&
           [TotalComments integerValue]  == 0)
        {
            cell.lblLike_Count_Height.constant=0;
            [cell layoutIfNeeded];
        }
        else
        {
            cell.lblLike_Count_Height.constant=15;
            
            //Like
            if([TotalLikes integerValue] <= 0)
            {
                [cell.lblLike_Count setText:[NSString stringWithFormat:@""]];
            }
            else
            {
                if([TotalLikes integerValue] > 1)
                {
                    [cell.lblLike_Count setText:[NSString stringWithFormat:@"%@ Likes",TotalLikes]];
                }
                else
                {
                    [cell.lblLike_Count setText:[NSString stringWithFormat:@"%@ Like",TotalLikes]];
                }
                
            }
            
            //UnLike
            if([TotalDislike integerValue] == 0)
            {
                [cell.lblUnLike_Count setText:[NSString stringWithFormat:@""]];
            }
            else
            {
                if([TotalDislike integerValue] > 1)
                {
                    [cell.lblUnLike_Count setText:[NSString stringWithFormat:@" %@ Unlikes",TotalDislike]];
                }
                else
                {
                    [cell.lblUnLike_Count setText:[NSString stringWithFormat:@" %@ Unlike",TotalDislike]];
                }
            }
            
            //Comment
            if([TotalComments integerValue] == 0)
            {
                [cell.lblComment_Count setText:[NSString stringWithFormat:@""]];
            }
            else
            {
                [cell.lblComment_Count setText:[NSString stringWithFormat:@" %@ Comment",TotalComments]];
            }
            [cell layoutIfNeeded];
        }
        
#pragma mark - Like Unlike Comment Share
        
        NSString *str_IsLike=[self.dicSelectedPost_Comment objectForKey:@"IsLike"];
        if([str_IsLike integerValue] == 0)
        {
            [self.imgLike setImage:[UIImage imageNamed:@"fb_like_gray"]];
            [self.lblLike setTextColor:[UIColor darkGrayColor]];
        }
        else
        {
            self.imgLike.image = [cell.imgLike.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [self.imgLike setTintColor:[UIColor colorWithRed:34/255.0 green:49/255.0 blue:89/255.0 alpha:1.0]];
            [self.lblLike setTextColor:[UIColor colorWithRed:34/255.0 green:49/255.0 blue:89/255.0 alpha:1.0]];
        }
        
        NSString *str_IsDislike=[self.dicSelectedPost_Comment objectForKey:@"IsDislike"];
        if([str_IsDislike integerValue] == 0)
        {
            [self.imgUnlike setImage:[UIImage imageNamed:@"fb_like_gray"]];
            [self.lblUnlike setTextColor:[UIColor darkGrayColor]];
        }
        else
        {
            self.imgUnlike.image = [cell.imgUnlike.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [self.imgUnlike setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
            [self.lblUnlike setTextColor:[UIColor colorWithRed:34/255.0 green:49/255.0 blue:89/255.0 alpha:1.0]];
        }
        
        
#pragma mark set GenrallWall and MyWall setting
        
        //set Like DisLike Comment Share View Height
        long tblWall_Width= self.tblPostAndCommentList.frame.size.width/4;
        self.viewLike_Width.constant=tblWall_Width;
        self.viewDisLike_Width.constant=tblWall_Width;
        self.viewComment_Width.constant=tblWall_Width;
        self.viewShare_Width.constant=tblWall_Width;
        
        if([IS_ALLOW_SETTING isEqualToString:@"YES"])
        {
            //get setting login responce
            NSString *isIsAllowUserToLikeDislikes_Login=[[Utility getCurrentUserDetail]objectForKey:@"IsAllowUserToLikeDislikes"];
            NSString *IsAllowUserToPostComment_Login=[[Utility getCurrentUserDetail]objectForKey:@"IsAllowUserToPostComment"];
            NSString *IsAllowUserToSharePost_Login=[[Utility getCurrentUserDetail]objectForKey:@"IsAllowUserToSharePost"];
            
            if([self.checkscreen isEqualToString:@"MyWall"] ||
               [self.checkscreen length] == 0)
            {
                //get setting wall responce
                NSString *IS_USER_LIKE_WALL=[self.dicSelectedPost_Comment objectForKey:@"IsAllowPeopleToLikeAndDislikeCommentWall"];
                NSString *IS_USER_DISLIKE_WALL=[self.dicSelectedPost_Comment objectForKey:@"IsAllowPeopleToLikeAndDislikeCommentWall"];
                NSString *IS_USER_SHARE_WALL=[self.dicSelectedPost_Comment objectForKey:@"IsAllowPeopleToShareCommentWall"];
                NSString *IS_USER_COMMENT_WALL=[self.dicSelectedPost_Comment objectForKey:@"IsAllowPeoplePostCommentWall"];
                
                NSString *IS_USER_LIKE=[self.dicSelectedPost_Comment objectForKey:@"IsAllowPeopleToLikeOrDislikeOnYourPost"];
                NSString *IS_USER_DISLIKE=[self.dicSelectedPost_Comment objectForKey:@"IsAllowPeopleToLikeOrDislikeOnYourPost"];
                // NSString *IS_USER_COMMENT=[dicResponce objectForKey:@"IsAllowPeopleToPostMessageOnYourWall"];
                NSString *IS_USER_SHARE=[self.dicSelectedPost_Comment objectForKey:@"IsAllowPeopleToShareYourPost"];
                
                
                //Like
                if ([isIsAllowUserToLikeDislikes_Login integerValue] == 1)
                {
                    if([IS_USER_LIKE_WALL integerValue] == 1 &&
                       [IS_USER_LIKE integerValue] == 1)
                    {
                        self.viewLike_Width.constant=tblWall_Width;
                        self.imgLike_Width.constant=14;
                    }
                    else
                    {
                        self.viewLike_Width.constant=0;
                        self.imgLike_Width.constant=0;
                    }
                }
                else
                {
                    self.viewLike_Width.constant=0;
                    self.imgLike_Width.constant=0;
                }
                
                
                //UnLike
                if ([isIsAllowUserToLikeDislikes_Login integerValue] == 1)
                {
                    if([IS_USER_DISLIKE_WALL integerValue] == 1 &&
                       [IS_USER_DISLIKE integerValue] == 1)
                    {
                        self.viewDisLike_Width.constant=tblWall_Width;
                        self.imgDisLike_Width.constant=14;
                    }
                    else
                    {
                        self.viewDisLike_Width.constant=0;
                        self.imgDisLike_Width.constant=0;
                    }
                }
                else
                {
                    self.viewDisLike_Width.constant=0;
                    self.imgDisLike_Width.constant=0;
                }
                
                //Comment
                if ([IsAllowUserToPostComment_Login integerValue] == 1)
                {
                    //&& [IS_USER_COMMENT integerValue] == 1
                    if([IS_USER_COMMENT_WALL integerValue] == 1)
                    {
                        self.viewComment_Width.constant=tblWall_Width;
                        self.imgComment_Width.constant=14;
                    }
                    else
                    {
                        self.viewComment_Width.constant=0;
                        self.imgComment_Width.constant=0;
                    }
                }
                else
                {
                    self.viewComment_Width.constant=0;
                    self.imgComment_Width.constant=0;
                }
                
                //Share
                if ([IsAllowUserToSharePost_Login integerValue] == 1)
                {
                    if([IS_USER_SHARE_WALL integerValue] == 1 &&
                       [IS_USER_SHARE integerValue] == 1)
                    {
                        self.viewShare_Width.constant=tblWall_Width;
                        self.imgShare_Width.constant=14;
                    }
                    else
                    {
                        self.viewShare_Width.constant=0;
                        self.imgShare_Width.constant=0;
                    }
                }
                else
                {
                    self.viewShare_Width.constant=0;
                    self.imgShare_Width.constant=0;
                }
            }
            else
            {
                //get setting wall responce
                NSString *IS_USER_LIKE_WALL=[self.dicSelectedPost_Comment objectForKey:@"IsAllowPeopleToLikeAndDislikeCommentWall"];
                NSString *IS_USER_DISLIKE_WALL=[self.dicSelectedPost_Comment objectForKey:@"IsAllowPeopleToLikeAndDislikeCommentWall"];
                NSString *IS_USER_SHARE_WALL=[self.dicSelectedPost_Comment objectForKey:@"IsAllowPeopleToShareCommentWall"];
                NSString *IS_USER_COMMENT_WALL=[self.dicSelectedPost_Comment objectForKey:@"IsAllowPeoplePostCommentWall"];
                
                NSString *IS_USER_LIKE=[self.dicSelectedPost_Comment objectForKey:@"IsAllowPeopleToLikeOrDislikeOnYourPost"];
                NSString *IS_USER_DISLIKE=[self.dicSelectedPost_Comment objectForKey:@"IsAllowPeopleToLikeOrDislikeOnYourPost"];
                NSString *IS_USER_COMMENT=[self.dicSelectedPost_Comment objectForKey:@"IsAllowPeopleToPostMessageOnYourWall"];
                NSString *IS_USER_SHARE=[self.dicSelectedPost_Comment objectForKey:@"IsAllowPeopleToShareYourPost"];
                
                //get DynamicWall setting
                NSMutableDictionary *dicResponce_DynamicWall;
                if([self.arrDynamicWall_Setting count] != 0)
                {
                    dicResponce_DynamicWall = [self.arrDynamicWall_Setting objectAtIndex:0];
                }
                
                NSString *IsAllowPeopleToLikeThisWall_Dynamic=[dicResponce_DynamicWall objectForKey:@"IsAllowPeopleToLikeThisWall"];
                NSString *IsAllowPeoplePostComment_Dynamic=[dicResponce_DynamicWall objectForKey:@"IsAllowPeoplePostComment"];
                // NSString *IsAllowPeopleToShareComment_Dynamic=[dicResponce_DynamicWall objectForKey:@"IsAllowPeopleToShareComment"];
                
                //Like
                if ([isIsAllowUserToLikeDislikes_Login integerValue] == 1)
                {
                    if([IS_USER_LIKE_WALL integerValue] == 1 &&
                       [IS_USER_LIKE integerValue] == 1)
                    {
                        if([IsAllowPeopleToLikeThisWall_Dynamic integerValue] == 1)
                        {
                            self.viewLike_Width.constant=tblWall_Width;
                            self.imgLike_Width.constant=14;
                        }
                        else
                        {
                            self.viewLike_Width.constant=0;
                            self.imgLike_Width.constant=0;
                        }
                    }
                    else
                    {
                        self.viewLike_Width.constant=0;
                        self.imgLike_Width.constant=0;
                    }
                }
                else
                {
                    self.viewLike_Width.constant=0;
                    self.imgLike_Width.constant=0;
                }
                
                
                //UnLike
                if ([isIsAllowUserToLikeDislikes_Login integerValue] == 1)
                {
                    if([IS_USER_DISLIKE_WALL integerValue] == 1 &&
                       [IS_USER_DISLIKE integerValue] == 1)
                    {
                        //dynamic
                        if ([IsAllowPeopleToLikeThisWall_Dynamic integerValue] == 1)
                        {
                            self.viewDisLike_Width.constant=tblWall_Width;
                            self.imgDisLike_Width.constant=14;
                        }
                        else
                        {
                            self.viewDisLike_Width.constant=0;
                            self.imgDisLike_Width.constant=0;
                        }
                    }
                    else
                    {
                        self.viewDisLike_Width.constant=0;
                        self.imgDisLike_Width.constant=0;
                    }
                }
                else
                {
                    self.viewDisLike_Width.constant=0;
                    self.imgDisLike_Width.constant=0;
                }
                
                //Comment
                if ([IsAllowUserToPostComment_Login integerValue] == 1)
                {
                    if([IS_USER_COMMENT_WALL integerValue] == 1 &&
                       [IS_USER_COMMENT integerValue] == 1)
                    {
                        //Dynamic
                        if([IsAllowPeoplePostComment_Dynamic integerValue] == 1)
                        {
                            self.viewComment_Width.constant=tblWall_Width;
                            self.imgComment_Width.constant=14;
                        }
                        else
                        {
                            self.viewComment_Width.constant=0;
                            self.imgComment_Width.constant=0;
                        }
                    }
                    else
                    {
                        self.viewComment_Width.constant=0;
                        self.imgComment_Width.constant=0;
                    }
                }
                else
                {
                    self.viewComment_Width.constant=0;
                    self.imgComment_Width.constant=0;
                }
                
                //Share
                if ([IsAllowUserToSharePost_Login integerValue] == 1)
                {
                    if([IS_USER_SHARE_WALL integerValue] == 1 &&
                       [IS_USER_SHARE integerValue] == 1)
                    {
                        //Dynamic
                        //if ([IsAllowPeopleToShareComment_Dynamic integerValue] == 1)
                        //{
                        self.viewShare_Width.constant=tblWall_Width;
                        self.imgShare_Width.constant=14;
                        //}
                        //else
                        //{
                        //    cell.viewShare_Width.constant=0;
                        //    cell.imgShare_Width.constant=0;
                        //}
                    }
                    else
                    {
                        self.viewShare_Width.constant=0;
                        self.imgShare_Width.constant=0;
                    }
                }
                else
                {
                    self.viewShare_Width.constant=0;
                    self.imgShare_Width.constant=0;
                }
            }
        }

        
        
        [cell.btnImageVideo_Click addTarget:self action:@selector(btnImageVideo_Click:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.tblSpecialFriendsList)
    {
        return [arrSpecialFriendList count];
    }
    else
    {
        return [arrCommentList count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.tblSpecialFriendsList)
    {
        return 51;
    }
    else
    {
        NSMutableDictionary *dicResponce=[arrCommentList objectAtIndex:indexPath.row];
        
        NSString *comment=[dicResponce objectForKey:@"Comment"];
        NSString *yourText = [NSString stringWithFormat:@"%@",comment];
        
        CGSize size = [yourText sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:15] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-74, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        return 55 + size.height;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.tblSpecialFriendsList)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellSpecialFriend"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellSpecialFriend"];
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
        
        NSMutableDictionary *dicResponce=[arrSpecialFriendList objectAtIndex:indexPath.row];
        NSString *strProfilePic_url=[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[dicResponce objectForKey:@"ProfilePicture"]];
        
        UIImageView *imgUser=(UIImageView*)[cell.contentView viewWithTag:101];
        imgUser.layer.cornerRadius = imgUser.frame.size.height/2;
        imgUser.clipsToBounds=YES;
        [imgUser.layer setBorderWidth:2];
        [imgUser.layer setBorderColor:[UIColor colorWithRed:227/255.0f green:227/255.0f blue:227/255.0f alpha:1.0f].CGColor];
        [imgUser sd_setImageWithURL:[NSURL URLWithString:strProfilePic_url] placeholderImage:[UIImage imageNamed:@"blank-user.png"]];
        
        UILabel *lblUserName=(UILabel*)[cell.contentView viewWithTag:102];
        [lblUserName setText:[NSString stringWithFormat:@"%@",[dicResponce objectForKey:@"FullName"]]];
        
        UIButton *btnCheckBox=(UIButton*)[cell.contentView viewWithTag:103];
        
        if([arrSelected_SpecialFriendList containsObject:dicResponce])
        {
            [btnCheckBox setImage:[UIImage imageNamed:@"checkboxblue.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btnCheckBox setImage:[UIImage imageNamed:@"checkboxunselected.png"] forState:UIControlStateNormal];
        }
        return cell;
    }
    else
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
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(tableView == self.tblSpecialFriendsList)
    {
    }
    else
    {
        NSInteger totalRow = [tableView numberOfRowsInSection:indexPath.section];
        if(indexPath.row == totalRow -1)
        {
            if(countResponce == 15)
            {
                totalCountView = totalCountView + 15;
                
                if ([Utility isInterNetConnectionIsActive] == true)
                {
                    [self.tblPostAndCommentList.tableFooterView setHidden:NO];
                    [self apiCallFor_GetWallPostComments:@"0"];
                }
            }
            else
            {
                [self.tblPostAndCommentList.tableFooterView setHidden:YES];
            }
        }
    }
}

#pragma mark - tbl UIButton Action

-(void)btnImageVideo_Click:(UIButton*)sender
{
    [self.view endEditing:YES];
   
    NSMutableDictionary *dicResponce=[self.dicSelectedPost_Comment mutableCopy];
    
    NSString *strFileType=[dicResponce objectForKey:@"FileType"];
    if([strFileType isEqualToString:@"VIDEO"] ||
       [strFileType isEqualToString:@"IMAGE"])
    {
        PostDetailVC *b = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"PostDetailVC"];
        b.dicPostDetail = [dicResponce mutableCopy];
        [self.navigationController pushViewController:b animated:YES];
    }
    else if([strFileType isEqualToString:@"FILE"])
    {
        NSString *strPost_Photo=[NSString stringWithFormat:@"%@/%@",apk_ImageUrl,[dicResponce objectForKey:@"Photo"]];
        
        NSArray *activityItems = @[[NSURL fileURLWithPath:strPost_Photo]];
        
        UIActivityViewController *activityViewController =
        [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                          applicationActivities:nil];
        [activityViewController setCompletionHandler:^(NSString *activityType, BOOL completed) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self presentViewController:activityViewController
                           animated:YES
                         completion:nil];
    }
}

- (IBAction)btnCell_CheckBox_SpecialFriends:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblSpecialFriendsList];
    NSIndexPath *indexPath = [self.tblSpecialFriendsList indexPathForRowAtPoint:buttonPosition];
    
    if([arrSelected_SpecialFriendList containsObject:[arrSpecialFriendList objectAtIndex:indexPath.row]])
    {
        [arrSelected_SpecialFriendList removeObject:[arrSpecialFriendList objectAtIndex:indexPath.row]];
    }
    else
    {
        [arrSelected_SpecialFriendList addObject:[arrSpecialFriendList objectAtIndex:indexPath.row]];
    }
    [self.tblSpecialFriendsList reloadData];
}

#pragma mark - CMPopTipViewDelegate methods

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
    [arrPopup removeObject:popTipView];
}

#pragma mark - Special Friend UIButton Action

- (IBAction)btnBack_SpecialFriends:(id)sender
{
    [self.view endEditing:YES];
    [self.viewSpecialFriends_Popup setHidden:YES];
}

- (IBAction)btnDone_SpecialFriends:(id)sender
{
    [self.view endEditing:YES];
    [self.viewSpecialFriends_Popup setHidden:YES];
    if([arrSelected_SpecialFriendList count] != 0)
    {
        [self apiCallFor_SharePost:@"1" ShareType:@"Special Friend"];
    }
    else
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Please_Select_Friend delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        
    }
}

- (IBAction)btnCheckAll_SpecialFriends:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if(btn.selected)
    {
        arrSelected_SpecialFriendList = [[NSMutableArray alloc]init];
        btn.selected=NO;
        [self.btnCheckAll_SpecialFriends setImage:[UIImage imageNamed:@"menu_select_all"] forState:UIControlStateNormal];
    }
    else
    {
        for (NSMutableDictionary *dic in arrSpecialFriendList) {
            if([arrSelected_SpecialFriendList containsObject:dic])
            {
            }
            else
            {
                [arrSelected_SpecialFriendList addObject:dic];
            }
        }
        btn.selected=YES;
        [self.btnCheckAll_SpecialFriends setImage:[UIImage imageNamed:@"menu_select_all_blue"] forState:UIControlStateNormal];
    }
    [self.tblSpecialFriendsList reloadData];
}


#pragma mark - UIButton Action

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Like UIButton Action

-(void)setUIButton_EnableNo
{
    [self.btnLike setUserInteractionEnabled:NO];
    [self.btnUnlike setUserInteractionEnabled:NO];
    [self.btnComment setUserInteractionEnabled:NO];
    [self.btnShare setUserInteractionEnabled:NO];
}

-(void)setUIButton_EnableYes
{
    [self.btnLike setUserInteractionEnabled:YES];
    [self.btnUnlike setUserInteractionEnabled:YES];
    [self.btnComment setUserInteractionEnabled:YES];
    [self.btnShare setUserInteractionEnabled:YES];
}

- (IBAction)btnLike:(id)sender
{
    if ([Utility isInterNetConnectionIsActive] == true)
    {
        //
        [self setUIButton_EnableNo];
        
        NSMutableDictionary *dicResponce=[[NSMutableDictionary alloc]init];
        dicResponce=[self.dicSelectedPost_Comment mutableCopy];
        
        //call api Like
        [self apiCallFor_LikePost:@"0" dicselectedWall:dicResponce];
        
        NSString *IsDislike=[dicResponce objectForKey:@"IsDislike"];
        NSString *TotalDislike=[dicResponce objectForKey:@"TotalDislike"];
        
        NSString *IsLike=[dicResponce objectForKey:@"IsLike"];
        NSString *TotalLikes=[dicResponce objectForKey:@"TotalLikes"];
        
        NSString *PostCommentID=[dicResponce objectForKey:@"PostCommentID"];
        
        //set IsDislike and TotalDislike
        if([IsDislike integerValue] == 0)
        {
        }
        else
        {
            IsDislike=@"0";
            long TotalDislikeTemp = [TotalDislike integerValue] - 1;
            TotalDislike = [NSString stringWithFormat:@"%ld",TotalDislikeTemp];
        }
        
        //set IsLike and TotalLikes
        if([IsLike integerValue] == 0)
        {
            IsLike=@"1";
            long TotalLikesTemp = [TotalLikes integerValue] + 1;
            TotalLikes = [NSString stringWithFormat:@"%ld",TotalLikesTemp];
        }
        else
        {
            IsLike=@"0";
            long TotalLikesTemp = [TotalLikes integerValue] - 1;
            TotalLikes = [NSString stringWithFormat:@"%ld",TotalLikesTemp];
        }
        
        //update dictinary TotalDislike IsDislike
        [dicResponce setValue:[NSString stringWithFormat:@"%@",TotalDislike] forKey:@"TotalDislike"];
        [dicResponce setValue:[NSString stringWithFormat:@"%@",IsDislike] forKey:@"IsDislike"];
        
        //update dictinary TotalLikes IsLike
        [dicResponce setValue:[NSString stringWithFormat:@"%@",TotalLikes] forKey:@"TotalLikes"];
        [dicResponce setValue:[NSString stringWithFormat:@"%@",IsLike] forKey:@"IsLike"];
        self.dicSelectedPost_Comment=[dicResponce mutableCopy];
        
        //set color unlike
        if([IsDislike integerValue] == 0)
        {
            [self.imgUnlike setImage:[UIImage imageNamed:@"fb_like_gray"]];
            [self.lblUnlike setTextColor:[UIColor darkGrayColor]];
        }
        else
        {
            self.imgUnlike.image = [self.imgUnlike.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [self.imgUnlike setTintColor:[UIColor colorWithRed:34/255.0 green:49/255.0 blue:89/255.0 alpha:1.0]];
            [self.lblUnlike setTextColor:[UIColor colorWithRed:34/255.0 green:49/255.0 blue:89/255.0 alpha:1.0]];
        }

        //set color like
        if([IsLike integerValue] == 0)
        {
            [self.imgLike setImage:[UIImage imageNamed:@"fb_like_gray"]];
            [self.lblLike setTextColor:[UIColor darkGrayColor]];
        }
        else
        {
            self.imgLike.image = [self.imgLike.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [self.imgLike setTintColor:[UIColor colorWithRed:34/255.0 green:49/255.0 blue:89/255.0 alpha:1.0]];
            [self.lblLike setTextColor:[UIColor colorWithRed:34/255.0 green:49/255.0 blue:89/255.0 alpha:1.0]];
        }
        
        if ([_checkscreen isEqualToString:@"Institute"])
        {
            {
                //update IsDislike TotalDislike
                [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE InstituteWall SET IsDislike = '%@', TotalDislike = '%@' WHERE PostCommentID = '%@'",IsDislike,TotalDislike,PostCommentID]];
            }

            //update
            [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE InstituteWall SET IsLike = '%@', TotalLikes = '%@' WHERE PostCommentID = '%@'",IsLike,TotalLikes,PostCommentID]];
        }
        else if ([_checkscreen isEqualToString:@"Standard"])
        {
            {
                //update IsDislike TotalDislike
                [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE StandardWall SET IsDislike = '%@', TotalDislike = '%@' WHERE PostCommentID = '%@'",IsDislike,TotalDislike,PostCommentID]];
            }
            //update
            [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE StandardWall SET IsLike = '%@', TotalLikes = '%@' WHERE PostCommentID = '%@'",IsLike,TotalLikes,PostCommentID]];
        }
        else if ([_checkscreen isEqualToString:@"Division"])
        {
            {
                //update IsDislike TotalDislike
                [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE DivisionWall SET IsDislike = '%@', TotalDislike = '%@' WHERE PostCommentID = '%@'",IsDislike,TotalDislike,PostCommentID]];
            }
            //update
            [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE DivisionWall SET IsLike = '%@', TotalLikes = '%@' WHERE PostCommentID = '%@'",IsLike,TotalLikes,PostCommentID]];
        }
        else if ([_checkscreen isEqualToString:@"Subject"])
        {
            {
                //update IsDislike TotalDislike
                [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE SubjectWall SET IsDislike = '%@', TotalDislike = '%@' WHERE PostCommentID = '%@'",IsDislike,TotalDislike,PostCommentID]];
            }
            //update
            [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE SubjectWall SET IsLike = '%@', TotalLikes = '%@' WHERE PostCommentID = '%@'",IsLike,TotalLikes,PostCommentID]];
        }
        else if ([_checkscreen isEqualToString:@"MyWall"])
        {
            {
                //update IsDislike TotalDislike
                [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE MyWall SET IsDislike = '%@', TotalDislike = '%@' WHERE PostCommentID = '%@'",IsDislike,TotalDislike,PostCommentID]];
            }
            //update
            [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE MyWall SET IsLike = '%@', TotalLikes = '%@' WHERE PostCommentID = '%@'",IsLike,TotalLikes,PostCommentID]];
        }
        else
        {
            {
                //update IsDislike TotalDislike
                [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE GeneralWall SET IsDislike = '%@', TotalDislike = '%@' WHERE PostCommentID = '%@'",IsDislike,TotalDislike,PostCommentID]];
            }
            //update
            [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE GeneralWall SET IsLike = '%@', TotalLikes = '%@' WHERE PostCommentID = '%@'",IsLike,TotalLikes,PostCommentID]];
        }
        [self.tblPostAndCommentList reloadData];
    }
    else
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
    }
}

- (IBAction)btnUnlike:(id)sender
{
    if ([Utility isInterNetConnectionIsActive] == true)
    {
        //
        [self setUIButton_EnableNo];
        
        NSMutableDictionary *dicResponce=[[NSMutableDictionary alloc]init];
        dicResponce=[self.dicSelectedPost_Comment mutableCopy];
        
        //call api Like
        [self apiCallFor_UnLikePost:@"0" dicselectedWall:dicResponce];
        
        NSString *IsLike=[dicResponce objectForKey:@"IsLike"];
        NSString *TotalLikes=[dicResponce objectForKey:@"TotalLikes"];
        
        NSString *IsDislike=[dicResponce objectForKey:@"IsDislike"];
        NSString *TotalDislike=[dicResponce objectForKey:@"TotalDislike"];
        NSString *PostCommentID=[dicResponce objectForKey:@"PostCommentID"];
        
        //set IsLike and TotalLikes
        if([IsLike integerValue] == 0)
        {
        }
        else
        {
            IsLike=@"0";
            long TotalLikesTemp = [TotalLikes integerValue] - 1;
            TotalLikes = [NSString stringWithFormat:@"%ld",TotalLikesTemp];
        }

        //set  IsDislike TotalDislike
        if([IsDislike integerValue] == 0)
        {
            IsDislike=@"1";
            long TotalDislikeTemp = [TotalDislike integerValue] + 1;
            TotalDislike = [NSString stringWithFormat:@"%ld",TotalDislikeTemp];
        }
        else
        {
            IsDislike=@"0";
            long TotalDislikeTemp = [TotalDislike integerValue] - 1;
            TotalDislike = [NSString stringWithFormat:@"%ld",TotalDislikeTemp];
        }
        
        //update dictinary TotalLikes IsLike
        [dicResponce setValue:[NSString stringWithFormat:@"%@",TotalLikes] forKey:@"TotalLikes"];
        [dicResponce setValue:[NSString stringWithFormat:@"%@",IsLike] forKey:@"IsLike"];

        //update dictinary TotalDislike IsDislike
        [dicResponce setValue:[NSString stringWithFormat:@"%@",TotalDislike] forKey:@"TotalDislike"];
        [dicResponce setValue:[NSString stringWithFormat:@"%@",IsDislike] forKey:@"IsDislike"];
        self.dicSelectedPost_Comment=[dicResponce mutableCopy];
        
        //set color like
        if([IsLike integerValue] == 0)
        {
            [self.imgLike setImage:[UIImage imageNamed:@"fb_like_gray"]];
            [self.lblLike setTextColor:[UIColor darkGrayColor]];
        }
        else
        {
            self.imgLike.image = [self.imgLike.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [self.imgLike setTintColor:[UIColor colorWithRed:34/255.0 green:49/255.0 blue:89/255.0 alpha:1.0]];
            [self.lblLike setTextColor:[UIColor colorWithRed:34/255.0 green:49/255.0 blue:89/255.0 alpha:1.0]];
        }

        //set color unlike
        if([IsDislike integerValue] == 0)
        {
            [self.imgUnlike setImage:[UIImage imageNamed:@"fb_like_gray"]];
            [self.lblUnlike setTextColor:[UIColor darkGrayColor]];
        }
        else
        {
            self.imgUnlike.image = [self.imgUnlike.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [self.imgUnlike setTintColor:[UIColor colorWithRed:34/255.0 green:49/255.0 blue:89/255.0 alpha:1.0]];
            [self.lblUnlike setTextColor:[UIColor colorWithRed:34/255.0 green:49/255.0 blue:89/255.0 alpha:1.0]];
        }
        
        if ([_checkscreen isEqualToString:@"Institute"])
        {
            {
                //update IsLike TotalLikes
                [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE InstituteWall SET IsLike = '%@', TotalLikes = '%@' WHERE PostCommentID = '%@'",IsLike,TotalLikes,PostCommentID]];
            }
            //update IsDislike TotalDislike
            [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE InstituteWall SET IsDislike = '%@', TotalDislike = '%@' WHERE PostCommentID = '%@'",IsDislike,TotalDislike,PostCommentID]];
        }
        else if ([_checkscreen isEqualToString:@"Standard"])
        {
            {
                //update IsLike TotalLikes
                [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE StandardWall SET IsLike = '%@', TotalLikes = '%@' WHERE PostCommentID = '%@'",IsLike,TotalLikes,PostCommentID]];
            }

            //update IsDislike TotalDislike
            [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE StandardWall SET IsDislike = '%@', TotalDislike = '%@' WHERE PostCommentID = '%@'",IsDislike,TotalDislike,PostCommentID]];
        }
        else if ([_checkscreen isEqualToString:@"Division"])
        {
            {
                //update IsLike TotalLikes
                [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE DivisionWall SET IsLike = '%@', TotalLikes = '%@' WHERE PostCommentID = '%@'",IsLike,TotalLikes,PostCommentID]];
            }

            //update IsDislike TotalDislike
            [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE DivisionWall SET IsDislike = '%@', TotalDislike = '%@' WHERE PostCommentID = '%@'",IsDislike,TotalDislike,PostCommentID]];
        }
        else if ([_checkscreen isEqualToString:@"Subject"])
        {
            {
                //update IsLike TotalLikes
                [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE SubjectWall SET IsLike = '%@', TotalLikes = '%@' WHERE PostCommentID = '%@'",IsLike,TotalLikes,PostCommentID]];
            }

            //update IsDislike TotalDislike
            [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE SubjectWall SET IsDislike = '%@', TotalDislike = '%@' WHERE PostCommentID = '%@'",IsDislike,TotalDislike,PostCommentID]];
        }
        else if ([_checkscreen isEqualToString:@"MyWall"])
        {
            {
                //update IsLike TotalLikes
                [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE MyWall SET IsLike = '%@', TotalLikes = '%@' WHERE PostCommentID = '%@'",IsLike,TotalLikes,PostCommentID]];
            }
            
            //update IsDislike TotalDislike
            [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE MyWall SET IsDislike = '%@', TotalDislike = '%@' WHERE PostCommentID = '%@'",IsDislike,TotalDislike,PostCommentID]];
        }
        else
        {
            {
                //update IsLike TotalLikes
                [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE GeneralWall SET IsLike = '%@', TotalLikes = '%@' WHERE PostCommentID = '%@'",IsLike,TotalLikes,PostCommentID]];
            }

            //update IsDislike TotalDislike
            [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE GeneralWall SET IsDislike = '%@', TotalDislike = '%@' WHERE PostCommentID = '%@'",IsDislike,TotalDislike,PostCommentID]];
        }
        
        [self.tblPostAndCommentList reloadData];
    }
    else
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
    }
    
}

- (IBAction)btnComment:(id)sender
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    else
    {
        AddCommentVc *b = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddCommentVc"];
        b.dicSelectedPost_Comment = [self.dicSelectedPost_Comment mutableCopy];
        b.checkscreen=_checkscreen;
        [self.navigationController pushViewController:b animated:YES];
    }
}

#pragma mark - Share UIButton Action

- (IBAction)btnShare:(id)sender
{
    [self.view endEditing:YES];
    arrPopup = [[NSMutableArray alloc]init];
    [arrPopup addObject:[Utility addCell_PopupView:self.viewShare_popup ParentView:self.view sender:sender]];
}

- (IBAction)btnPublic:(id)sender
{
    [Utility dismissAllPopTipViews:arrPopup];
    [self apiCallFor_SharePost:@"1" ShareType:@"Public"];
}

- (IBAction)btnOnlyMe:(id)sender
{
    [Utility dismissAllPopTipViews:arrPopup];
    [self apiCallFor_SharePost:@"1" ShareType:@"Only Me"];
}

- (IBAction)btnFriend:(id)sender
{
    [Utility dismissAllPopTipViews:arrPopup];
    [self apiCallFor_SharePost:@"1" ShareType:@"Friend"];
}

- (IBAction)btnSpecialFriend:(id)sender
{
    [Utility dismissAllPopTipViews:arrPopup];
    [self.view endEditing:YES];
    [self apiCallFor_GetFriendList:YES];
}

@end
