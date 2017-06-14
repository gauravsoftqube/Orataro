//
//  profileSearchFriend.m
//  orataro
//
//  Created by MAC008 on 27/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "profileSearchFriend.h"
#import "Global.h"

@interface profileSearchFriend ()
{
    NSMutableArray *nameary;
}
@end

@implementation profileSearchFriend
@synthesize aSerchview,aTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    nameary = [[NSMutableArray alloc]init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    aTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [Utility SearchTextView:aSerchview];
    
    _lbNoDataFound.hidden = YES;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchFriendCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchFriendCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row % 2 ==0)
    {
        cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    }
    
    
    NSLog(@"Name ary=%@",nameary);
    
    //tag 10
    UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:110];
    
    // NSLog(@"Data=%@",)
    [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[[nameary objectAtIndex:indexPath.row]objectForKey:@"ProfilePicture"]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
     {
         NSLog(@"Images");
     }];
    
    UIImageView *img1 = (UIImageView *)[cell.contentView viewWithTag:100];
    
    //tag 20
    UILabel *lb = (UILabel *)[cell.contentView viewWithTag:20];
    lb.text = [[nameary objectAtIndex:indexPath.row]objectForKey:@"FullName"];
    
    //tag 30
    UILabel *lb4 = (UILabel *)[cell.contentView viewWithTag:60];
    
    //tag 70
    
    UIButton *bt = (UIButton *)[cell.contentView viewWithTag:70];
    // bt.tag = indexPath.row;
    
    
    //tag 6
    UIView *view1 = (UIView *)[cell.contentView viewWithTag:6];
    view1.layer.cornerRadius =3.0;
    
    view1.layer.borderColor = [UIColor colorWithRed:65.0/255.0 green:68.0/255.0 blue:69.0/255.0 alpha:1.0].CGColor;
    view1.layer.borderWidth = 1.0;
    
    UILabel *lb6= (UILabel *)[cell.contentView viewWithTag:30];
    
    NSString *CheckFriend = [NSString stringWithFormat:@"%@",[[nameary objectAtIndex:indexPath.row]objectForKey:@"IsFriend"]];
    
    NSLog(@"Friend=%@",CheckFriend);
    
    NSString *CheckFriend1 = [NSString stringWithFormat:@"%@",[[nameary objectAtIndex:indexPath.row]objectForKey:@"IsRequested"]];
    
    NSLog(@"Friend=%@",CheckFriend1);
    
    if ([CheckFriend isEqualToString:@"1"])
    {
        img1.image = [UIImage imageNamed:@"fb_req_frnd_white"];
        img1.image = [img1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [img1 setTintColor:[UIColor colorWithRed:65.0/255.0 green:68.0/255.0 blue:69.0/255.0 alpha:1.0]];
        [lb4 setTextColor:[UIColor colorWithRed:65.0/255.0 green:68.0/255.0 blue:69.0/255.0 alpha:1.0]];
        lb4.text = @"Friend";
    }
    else
    {
        if ([CheckFriend1 isEqualToString:@"1"])
        {
            lb6.text = @"Request sent";
            img1.hidden = YES;
            bt.hidden = YES;
            view1.hidden = YES;
            //view1.hidden = NO;
            lb4.hidden = YES;
        }
        else
        {
            lb6.text = @"";
            img1.image = [UIImage imageNamed:@"fb_req_frnd_white"];
            img1.image = [img1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [img1 setTintColor:[UIColor colorWithRed:39.0/255.0 green:48.0/255.0 blue:91.0/255.0 alpha:1.0]];
            [lb4 setTextColor:[UIColor colorWithRed:39.0/255.0 green:48.0/255.0 blue:91.0/255.0 alpha:1.0]];
            lb4.text = @"Add Friend";
        }
        
    }
    
    
    
    //tag 40
    
    UILabel *lb1 = (UILabel *)[cell.contentView viewWithTag:40];
    NSString *str =[[nameary objectAtIndex:indexPath.row]objectForKey:@"GradeName"];
    
    if (str == (id)[NSNull null] || str.length == 0 ||  [str isKindOfClass:[NSNull class]] || [str isEqualToString:@"<null>"])
    {
        lb1.text = @"Standard:";
    }
    else
    {
        lb1.text = [NSString stringWithFormat:@"Standard: %@",[[nameary objectAtIndex:indexPath.row]objectForKey:@"GradeName"]];
    }
    
    
    //tag 50
    
    NSString *str2 =  [[nameary objectAtIndex:indexPath.row]objectForKey:@"DivisionName"];
    
    UILabel *lb2 = (UILabel *)[cell.contentView viewWithTag:50];
    if([str2 isEqual:@"<null>"] || [str2 isKindOfClass:[NSNull class]] || [str2 isEqualToString:@"<null>"] || str.length == 0)
    {
        lb2.text = @"Division:";
    }
    else
    {
        lb2.text = [NSString stringWithFormat:@"Division: %@",[[nameary objectAtIndex:indexPath.row]objectForKey:@"DivisionName"]];
    }
    
    
    
    //tag 10
    
    //tag 70
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return nameary.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [NSString stringWithFormat:@"%@",[[nameary objectAtIndex:indexPath.row]objectForKey:@"FullName"]];
    CGSize size = [str sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:14] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-252, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    return size.height+76;
}

#pragma mark - button action

- (IBAction)BackBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)AddFriendClicked :(UIButton *)sender
{
    UIButton *btn= (UIButton *)sender;
    
    NSLog(@"Tag=%ld",(long)btn.tag);
}
- (IBAction)btnAddFriendClicked:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:aTableView];
    NSIndexPath *indexPath = [aTableView indexPathForRowAtPoint:buttonPosition];
    
    NSLog(@"Row=%@",[nameary objectAtIndex:indexPath.row]);
    
    NSString *CheckFriend1 = [NSString stringWithFormat:@"%@",[[nameary objectAtIndex:indexPath.row]objectForKey:@"IsFriend"]];
    
    if ([CheckFriend1 isEqualToString:@"1"])
    {
    }
    else
    {
        // add friend
        [self apk_ADDFriendList:YES :[nameary objectAtIndex:indexPath.row]];
    }
}
- (IBAction)btnSearchClicked:(id)sender
{
    [self apk_searchFriendList:YES];
}

#pragma mark - textfield delegate

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length == 0)
    {
        NSMutableArray *ary = [[NSMutableArray alloc]initWithArray:nameary];
        [ary removeAllObjects];
        nameary = [[NSMutableArray alloc]initWithArray:ary];
        [aTableView reloadData];
    }
}
-(void)textFieldDidChange :(UITextField *)theTextField
{
    NSLog( @"text changed: %@", theTextField.text);
}

#pragma mark - alerview delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 500)
    {
        if (buttonIndex ==0)
        {
            [self apk_searchFriendList:YES];
        }
    }
}

#pragma mark - api call

-(void)apk_searchFriendList:(BOOL)CheckVal
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_friends,apk_Searchfriend_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:_txtSearchTextfield.text forKey:@"SearchName"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    
    if (CheckVal == YES)
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
                     _lbNoDataFound.hidden = NO;
                 }
                 else
                 {
                     _lbNoDataFound.hidden = YES;
                     NSMutableDictionary *dic= [Utility ConvertStringtoJSON:[NSString stringWithFormat:@"%@",[dicResponce objectForKey:@"d"]]];
                     
                     NSLog(@"dic=%@",dic);
                     nameary =(NSMutableArray *) dic;
                     
                     if(nameary.count>0)
                     {
                         [aTableView reloadData];
                     }
                     else
                     {
                         UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [alrt show];
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

#pragma mark - add Friend

-(void)apk_ADDFriendList:(BOOL)CheckVal : (NSMutableDictionary *)dic
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_friends,apk_SendFriendRequest_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]] forKey:@"ToMemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"ByMemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] forKey:@"WallID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    
    if (CheckVal == YES)
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
                 if([strStatus isEqualToString:@"Friend Request Send SuccessFully."])
                 {
                     [self apiCallFor_SendPushNotification];
                 }
                 else
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:FRIENDREQUEST delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
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
        [self apk_searchFriendList:YES];
    }];
}
@end
