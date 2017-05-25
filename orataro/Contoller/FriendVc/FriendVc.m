//
//  FriendVc.m
//  orataro
//
//  Created by MAC008 on 17/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "FriendVc.h"
#import "ProfileFriendRequestVc.h"
#import "profileSearchFriend.h"
#import "Global.h"

@interface FriendVc ()
{
    NSMutableArray *nameary,*aryImage,*arygetIdflag;
}
@end

@implementation FriendVc
@synthesize aNoFriendLabel,friendTableView,aPopupAddFriendImg,aPopupFriendRequestImg,aAddFriendView,aFriendRequestView,aPopupView,aFirstBtn,aSecondBtn;
int s =0 ;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    nameary = [[NSMutableArray alloc]init];
    aryImage = [[NSMutableArray alloc]init];
    
    friendTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    aAddFriendView.layer.cornerRadius = 17.5;
    aFriendRequestView.layer.cornerRadius = 17.5;
    aPopupView.alpha = 0.0;
    
    _txtSearchFriend.delegate = self;
    
    [Utility SearchTextView:_viewSearch];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSArray *ary = [DBOperation selectData:@"select * from FriendList"];
    nameary = [Utility getLocalDetail:ary columnKey:@"FriendJsonStr"];
    
    arygetIdflag = [DBOperation selectData:@"select id,flag,ImageStr from FriendList"];
    
    NSLog(@"ary=%@",arygetIdflag);
    
    [friendTableView reloadData];
    
    if (nameary.count == 0)
    {
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        else
        {
            [self apiCallFor_GetFriendList:YES];
            
        }
    }
    else
    {
        if ([Utility isInterNetConnectionIsActive] == true)
        {
            [self apiCallFor_GetFriendList:NO];
        }
        else
        {
            
        }

    }
    
    
}
#pragma mark - tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FriendCell"];
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
    
    UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:1];
    
  //  NSLog(@"get ary=%@",arygetIdflag);
    
      NSString *documentDirectory=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    if ([[[arygetIdflag objectAtIndex:indexPath.row]objectForKey:@"flag"] isEqualToString:@"0"])
    {
        if ([Utility isInterNetConnectionIsActive] == true)
        {
            [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[[nameary objectAtIndex:indexPath.row]objectForKey:@"ProfilePicture"]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
             {
                [DBOperation selectData:[NSString stringWithFormat:@"update FriendList set flag='1' where id=%@",[[arygetIdflag objectAtIndex:indexPath.row]objectForKey:@"id"]]];
                 
                 NSData *imageData = UIImagePNGRepresentation(image);
                 
                 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                 NSString *documentsDirectory = [paths objectAtIndex:0];
                 
                 NSString *setImage = [NSString stringWithFormat:@"%@",[[arygetIdflag objectAtIndex:indexPath.row]objectForKey:@"ImageStr"]];
                 
                 NSArray *ary = [setImage componentsSeparatedByString:@"/"];
                 
                 NSString *strSaveImg = [ary lastObject];
                 
                 NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
                 
                  [imageData writeToFile:imagePath atomically:NO];
                 
                 if (![imageData writeToFile:imagePath atomically:NO])
                 {
                     NSLog(@"Failed to cache image data to disk");
                 }
                 else
                 {
                     [imageData writeToFile:imagePath atomically:NO];
                     NSLog(@"the cachedImagedPath is %@",imagePath);
                 }
                 
             }];
        }
    }
    else
    {
         //fetch from local
        
            
            NSString *setImage = [NSString stringWithFormat:@"%@",[[arygetIdflag objectAtIndex:indexPath.row]objectForKey:@"ImageStr"]];
            
            NSArray *ary = [setImage componentsSeparatedByString:@"/"];
            
            NSString *strSaveImg = [ary lastObject];
            
            NSString *imagePath=[documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",strSaveImg]];
            UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
        
            img.image = image;
       
    }
    
    //tag 2
    
    UILabel *lb = (UILabel *)[cell.contentView viewWithTag:2];
    lb.text = [[nameary objectAtIndex:indexPath.row]objectForKey:@"FullName"];
    
    //tag 3
    
    
    UILabel *lb2 = (UILabel *)[cell.contentView viewWithTag:3];
    if ([[[nameary objectAtIndex:indexPath.row]objectForKey:@"GradeName"] isKindOfClass:[NSNull class]])
    {
        lb2.text = @"Standard :";
    }
    else
    {
        lb2.text = [NSString stringWithFormat:@"Standard : %@",[[nameary objectAtIndex:indexPath.row]objectForKey:@"GradeName"]];
    }
    
    //tag 4
    
    UILabel *lb3 = (UILabel *)[cell.contentView viewWithTag:4];
    if ([[[nameary objectAtIndex:indexPath.row]objectForKey:@"DivisionName"] isKindOfClass:[NSNull class]])
    {
        lb3.text = @"Division :";
    }
    else
    {
        
        lb3.text = [NSString stringWithFormat:@"Division : %@",[[nameary objectAtIndex:indexPath.row]objectForKey:@"DivisionName"]];
    }
    
    
    //tag 5
    UIView *view1 = (UIView *)[cell.contentView viewWithTag:5];
    view1.layer.cornerRadius =3.0;
    
    view1.layer.borderColor = [UIColor colorWithRed:65.0/255.0 green:68.0/255.0 blue:69.0/255.0 alpha:1.0].CGColor;
    view1.layer.borderWidth = 1.0;
    
    //tag 10
    
    UIImageView *img1 = (UIImageView *)[cell.contentView viewWithTag:10];
    img1.image = [UIImage imageNamed:@"fb_req_frnd_white"];
    img1.image = [img1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [img1 setTintColor:[UIColor colorWithRed:65.0/255.0 green:68.0/255.0 blue:69.0/255.0 alpha:1.0]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return nameary.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // as per content
    
    NSString *str = [NSString stringWithFormat:@"%@",[[nameary objectAtIndex:indexPath.row]objectForKey:@"FullName"]];
    CGSize size = [str sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:14] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-252, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    return size.height+100;
    
}

#pragma mark - button action

- (IBAction)BackBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)TxtValueChanged:(UITextField *)sender
{
    NSLog(@"sender=%@",sender.text);
}
- (IBAction)txtValueChange:(id)sender {
}

- (IBAction)FriendRequestBtnClicked:(id)sender
{
    aPopupView.alpha = 0.0;
    s =0 ;
    ProfileFriendRequestVc *p7 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfileFriendRequestVc"];
    [self.navigationController pushViewController:p7 animated:YES];
}

- (IBAction)btnSearchClicked:(id)sender
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        if(nameary.count>0)
        {
            NSMutableArray *tmpary = [[NSMutableArray alloc]init];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.FullName contains[c] %@",_txtSearchFriend.text];
            
            tmpary = [NSMutableArray arrayWithArray:[nameary filteredArrayUsingPredicate:predicate]];
            
            if (tmpary.count > 0)
            {
                nameary = [[NSMutableArray alloc]initWithArray:tmpary];
                [friendTableView reloadData];
            }
            else
            {
                UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"No Data Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alrt show];
            }
        }
        else
        {
            
        }
    }
    else
    {
        NSLog(@"Data=%@",_txtSearchFriend.text);
        
        if ([Utility validateBlankField:_txtSearchFriend.text])
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please Enter Search Text" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];

        }
        else
        {
            [self apiCallFor_SearchFriendList:YES];
        }
    }
    
}



- (IBAction)AddFrinedBtnClicked:(id)sender
{
    aPopupView.alpha = 0.0;
    s=0;
    profileSearchFriend *p8 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"profileSearchFriend"];
    [self.navigationController pushViewController:p8 animated:YES];
}
- (IBAction)AddFriendBtnClicked:(id)sender
{
    //  aPopupView.alpha = 0.0;
    
    if (s == 0)
    {
        [UIView transitionWithView:aPopupView
                          duration:0.5
                           options:UIViewAnimationOptionShowHideTransitionViews
                        animations:^{
                            //aPopupView.hidden = NO;
                            aPopupView.alpha = 1.0;
                            //   [self.view bringSubviewToFront:aPopupView];
                            s =1;
                        }
                        completion:NULL];
    }
    else
    {
        //aPopupView.hidden = YES;
        [UIView transitionWithView:aPopupView
                          duration:0.5
                           options:UIViewAnimationOptionShowHideTransitionViews
                        animations:^{
                            //aPopupView.hidden = NO;
                            aPopupView.alpha = 0.0;
                            s=0;
                            
                        }
                        completion:NULL];
    }
}

#pragma mark - textfield delegate

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length == 0)
    {
        [self viewWillAppear:YES];
    }
}
-(void)textFieldDidChange :(UITextField *)theTextField
{
    NSLog( @"text changed: %@", theTextField.text);
}

#pragma mark - ApiCall

-(void)apiCallFor_GetFriendList : (BOOL)checkProgress
{
//    if ([Utility isInterNetConnectionIsActive] == false)
//    {
//        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alrt show];
//        return;
//    }
//    
    
    //MemberID=f1a6d89d-37dc-499a-9476-cb83f0aba0f2
    //ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
    //InstituteID=4f4bbf0e-858a-46fa-a0a7-bf116f537653
    //BeachID=null
    
    //#define apk_friends @"apk_friends.asmx"
    //#define apk_GetFriendList @"GetFriendList"
    
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
                      [DBOperation executeSQL:@"delete from FriendList"];
                     [nameary removeAllObjects];
                     [friendTableView reloadData];
                     _viewSearch.hidden = YES;
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     _viewSearch.hidden = NO;
                     [self ManageCircularList:arrResponce];
                     
                     
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
    [DBOperation executeSQL:@"delete from FriendList"];
    
    for (NSMutableDictionary *dic in arrResponce)
    {
        NSString *setImage = [NSString stringWithFormat:@"%@",[dic objectForKey:@"ProfilePicture"]];
        
        NSArray *ary = [setImage componentsSeparatedByString:@"/"];
        
        NSString *strSaveImg = [ary lastObject];
        
        NSLog(@"data=%@",setImage);
        
        NSString *getjsonstr = [Utility Convertjsontostring:dic];
        [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO FriendList (FriendJsonStr,ImageStr,flag) VALUES ('%@','%@','0')",getjsonstr,strSaveImg]];
    }
    NSArray *ary = [DBOperation selectData:@"select * from FriendList"];
    nameary = [Utility getLocalDetail:ary columnKey:@"FriendJsonStr"];
    
    arygetIdflag = [DBOperation selectData:@"select id,flag,ImageStr from FriendList"];
    
    [friendTableView reloadData];
    
}

#pragma mark - Search Friend list


-(void)apiCallFor_SearchFriendList : (BOOL)checkProgress
{
    //online / offline
    
    //SearchName=a
    //MemberID=f1a6d89d-37dc-499a-9476-cb83f0aba0f2
    //ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
    //InstituteID=4f4bbf0e-858a-46fa-a0a7-bf116f537653
    
    
    //#define apk_GetFriendRequestList_action @"GetFriendRequestList"
    //MemberID=f1a6d89d-37dc-499a-9476-cb83f0aba0f2
    //ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
    //InstituteID=4f4bbf0e-858a-46fa-a0a7-bf116f537653
     
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
   NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_friends,apk_Searchfriend_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:_txtSearchFriend.text forKey:@"SearchName"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    
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
                    [self ManageCircularList:arrResponce];
                     
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



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



@end
