//
//  ProfilePhoneChainVc.m
//  orataro
//
//  Created by MAC008 on 02/05/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ProfilePhoneChainVc.h"
#import "Global.h"

@interface ProfilePhoneChainVc ()
{
    NSMutableArray *aryPhoneList;
    NSString *strCheckEditAdd,*strCheckSelectPriority;
    NSMutableArray *arySelectType,*aryPriorityType;
    NSString *strAddEdit;
    NSMutableDictionary *dicGetPhoneBookEditData,*dicDeleteDic;

}
@end

@implementation ProfilePhoneChainVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self CommonData];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)CommonData
{
    _tblPhoneList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    strCheckEditAdd =@"Add";
    _tblPhoneList.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _viewAdd.layer.cornerRadius = 20.0;
    _viewOuterAdd.layer.cornerRadius = 30.0;
    _viewInnerAdd.layer.cornerRadius = 25.0;
    
    _lbNoContact.hidden = YES;
    
    _imgCancel.image = [_imgCancel.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_imgCancel setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    _imgDeleteView.image =[_imgDeleteView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_imgDeleteView setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
  //  _imgDeletePopupCancel.image = [_imgDeletePopupCancel.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  //  [_imgDeletePopupCancel setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    _viewSelectOuterLayer.layer.cornerRadius = 0.5;
    _viewTypeOuterLayer.layer.cornerRadius = 0.5;
    
    _viewDeleteOuter.layer.cornerRadius = 30.0;
    _viewDeleteInner.layer.cornerRadius = 25.0;
    
    aryPriorityType = [NSMutableArray arrayWithObjects:
                       [NSDictionary dictionaryWithObjectsAndKeys:@"Please Select Priority",@"Name",@"1",@"Value", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"Important",@"Name",@"0",@"Value", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"Normal",@"Name",@"0",@"Value", nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"Not Important",@"Name",@"0",@"Value", nil], nil];
    
    [_tblPriorityHeight setConstant:55*aryPriorityType.count];
    _tblPriority.scrollEnabled = NO;
    [_tblPriority reloadData];
    
    arySelectType = [NSMutableArray arrayWithObjects:
                     
                     [NSDictionary dictionaryWithObjectsAndKeys:@"Please Select Contact Type",@"Name",@"1",@"Value", nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"Mobile",@"Name",@"0",@"Value", nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"Home",@"Name",@"0",@"Value", nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"Office",@"Name",@"0",@"Value", nil], nil];
    [_tblSelectTypeHeight setConstant:55*arySelectType.count];
    _tblSelectType.scrollEnabled = NO;
    [_tblSelectType reloadData];
}
-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"Select Type=%@",arySelectType);
    
    [self getPhoneBookList:YES];
}
#pragma mark - button action

- (IBAction)btnDeletePopupCancelClicked:(id)sender
{
    _viewDelete.hidden = YES;
}

- (IBAction)btnDeletePopupClicked:(id)sender
{
    [self api_EditPhoneBook:dicDeleteDic];
}

- (IBAction)btnBackClicked:(id)sender
{
    for (UIViewController *controller in self.navigationController.viewControllers)
    {
        if ([controller isKindOfClass:[MyProfileVc class]])
        {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
    }
    
}

- (IBAction)btnPriorityClicked:(id)sender
{
    _viewSelect.hidden = NO;
    [_viewSelect addSubview:_tblPriority];
    [self.view bringSubviewToFront:_viewSelect];
    
}

- (IBAction)btnSelectTypeClicked:(id)sender
{
    _viewSelect.hidden = NO;
    [_viewSelect addSubview:_tblSelectType];
    [self.view bringSubviewToFront:_viewSelect];

}

- (IBAction)btnCancelClicked:(id)sender
{
    _viewCreatePhoneContact.hidden = YES;
}

- (IBAction)btnAddClicked:(id)sender
{
    strAddEdit = @"Add";
    
    _txtName.text = @"";
    _txtRelation.text = @"";
    _txtPhoneNumber.text = @"";
    _lbSelectType.text = @"Please Select Contact Type";
    _lbPriority.text = @"Please Select Priority";
    
    
     _lbCreatePopupHeaderTitle.text = @"Add Phone";
     [_imgEditImage setImage:[UIImage imageNamed:@"add"]];
    
    _viewCreatePhoneContact.hidden = NO;
    [self.view bringSubviewToFront:_viewCreatePhoneContact];
    
    NSString *str =@"Please Select Contact Type";
    NSString *str1 =@"Please Select Priority";
    
    for (int i=0; i<arySelectType.count; i++)
    {
        NSMutableDictionary *d = [[arySelectType objectAtIndex:i] mutableCopy];
        
        if ([str isEqualToString:[[arySelectType objectAtIndex:i]objectForKey:@"Name"]])
        {
            [d setValue:@"1" forKey:@"Value"];
        }
        else
        {
            [d setValue:@"0" forKey:@"Value"];
        }
        [arySelectType replaceObjectAtIndex:i withObject:d];
    }
    
    for (int i=0; i<aryPriorityType.count; i++)
    {
        NSMutableDictionary *d = [[aryPriorityType objectAtIndex:i] mutableCopy];
        
        if ([str1 isEqualToString:[[aryPriorityType objectAtIndex:i]objectForKey:@"Name"]])
        {
            [d setValue:@"1" forKey:@"Value"];
        }
        else
        {
            [d setValue:@"0" forKey:@"Value"];
        }
        [aryPriorityType replaceObjectAtIndex:i withObject:d];
    }
    
    [_tblSelectType reloadData];
    [_tblPriority reloadData];

}

- (IBAction)btnDeleteClicked:(id)sender
{
    _viewDelete.hidden = NO;
    [self.view bringSubviewToFront:_viewDelete];
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_tblPhoneList];
    NSIndexPath *indexPath = [_tblPhoneList indexPathForRowAtPoint:buttonPosition];
    dicDeleteDic= [aryPhoneList objectAtIndex:indexPath.row];
}
- (IBAction)btnEditClicked:(id)sender
{
    strAddEdit = @"Edit";

    _lbCreatePopupHeaderTitle.text = @"Edit Phone";
    [_imgEditImage setImage:[UIImage imageNamed:@"save"]];
    
    _viewCreatePhoneContact.hidden = NO;
    [self.view bringSubviewToFront:_viewCreatePhoneContact];
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_tblPhoneList];
    NSIndexPath *indexPath = [_tblPhoneList indexPathForRowAtPoint:buttonPosition];
    
    _txtName.text = [[aryPhoneList objectAtIndex:indexPath.row]objectForKey:@"ContactName"];
    
    _txtRelation.text = [[aryPhoneList objectAtIndex:indexPath.row]objectForKey:@"ContactDetails"];
    
    _txtPhoneNumber.text = [[aryPhoneList objectAtIndex:indexPath.row]objectForKey:@"ContactNo"];
    
    NSString *str = [[aryPhoneList objectAtIndex:indexPath.row]objectForKey:@"ContactTypeTerm"];
    
    NSString *str1 = [[aryPhoneList objectAtIndex:indexPath.row]objectForKey:@"PriorityLevelTerm"];
    
    _lbSelectType.text = str;
    _lbPriority.text = str1;
    
    dicGetPhoneBookEditData = [aryPhoneList objectAtIndex:indexPath.row];
    
    for (int i=0; i<arySelectType.count; i++)
    {
        NSMutableDictionary *d = [[arySelectType objectAtIndex:i] mutableCopy];
        
        if ([str isEqualToString:[[arySelectType objectAtIndex:i]objectForKey:@"Name"]])
        {
            [d setValue:@"1" forKey:@"Value"];
        }
        else
        {
            [d setValue:@"0" forKey:@"Value"];
        }
        [arySelectType replaceObjectAtIndex:i withObject:d];
    }
    
    for (int i=0; i<aryPriorityType.count; i++)
    {
        NSMutableDictionary *d = [[aryPriorityType objectAtIndex:i] mutableCopy];
        
        if ([str isEqualToString:[[aryPriorityType objectAtIndex:i]objectForKey:@"Name"]])
        {
            [d setValue:@"1" forKey:@"Value"];
        }
        else
        {
            [d setValue:@"0" forKey:@"Value"];
        }
        [aryPriorityType replaceObjectAtIndex:i withObject:d];
    }
    
    [_tblSelectType reloadData];
    [_tblPriority reloadData];
    
}
- (IBAction)btnAddPhoneListClicked:(id)sender
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        [WToast showWithText:INTERNETVALIDATION];
       
        return;
    }
    
    if ([Utility validateBlankField:_txtName.text])
    {
         [WToast showWithText:@"Please Enter Name"];
        return;
    }
    if ([Utility validateBlankField:_txtRelation.text])
    {
        [WToast showWithText:@"Please Enter Relation"];
        return;
    }
    if ([Utility validateBlankField:_txtPhoneNumber.text])
    {
       [WToast showWithText:@"Please Enter Phone Number"];
        return;
    }
    if ([_lbSelectType.text isEqualToString:@"Please Select Contact Type"])
    {
        [WToast showWithText:@"Please Select Contact Type"];
        return;

    }
    if ([_lbPriority.text isEqualToString:@"Please Select Priority"])
    {
        [WToast showWithText:@"Please Select Priority"];
        return;
        
    }

    if ([strAddEdit isEqualToString:@"Add"])
    {
         [self api_createPhoneBook];
    }
    else
    {
        [self api_EditPhoneBook:dicGetPhoneBookEditData];
    }
}

#pragma mark - tableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tblPhoneList)
    {
        if(aryPhoneList.count>0)
        {
            return aryPhoneList.count;
        }
    }
    if (tableView == _tblSelectType)
    {
        return 4;
    }
    if (tableView == _tblPriority)
    {
        return 4;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tblPhoneList)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhoneCell"];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PhoneCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row %2 ==0)
        {
            cell.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
        }
        else
        {
             cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
           
        }
        
        UILabel *lb = (UILabel *)[cell.contentView viewWithTag:1];
        lb.text = [[aryPhoneList objectAtIndex:indexPath.row]objectForKey:@"ContactName"];
        
        UILabel *lb1 = (UILabel *)[cell.contentView viewWithTag:2];
        lb1.text = [[aryPhoneList objectAtIndex:indexPath.row]objectForKey:@"ContactDetails"];
        
        UILabel *lb2 = (UILabel *)[cell.contentView viewWithTag:3];
        lb2.text = [[aryPhoneList objectAtIndex:indexPath.row]objectForKey:@"ContactNo"];
        
        return cell;
    }
    if (tableView == _tblSelectType)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectTypeCell"];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SelectTypeCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
            UILabel *lb = (UILabel *)[cell.contentView viewWithTag:1];
            
            lb.text = [[arySelectType objectAtIndex:indexPath.row]objectForKey:@"Name"];
            
            UIImageView *img= (UIImageView *)[cell.contentView viewWithTag:2];
            
            if ([[[arySelectType objectAtIndex:indexPath.row]objectForKey:@"Value"] isEqualToString:@"1"])
            {
                [img setImage:[UIImage imageNamed:@"unradiop"]];
            }
            else
            {
                [img setImage:[UIImage imageNamed:@"radiop"]];
            }
        return cell;
    }
    if (tableView == _tblPriority)
    {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PriorityTypeCell"];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PriorityTypeCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        UILabel *lb = (UILabel *)[cell.contentView viewWithTag:1];
        
        lb.text = [[aryPriorityType objectAtIndex:indexPath.row]objectForKey:@"Name"];
        
        UIImageView *img= (UIImageView *)[cell.contentView viewWithTag:2];
        
        if ([[[aryPriorityType objectAtIndex:indexPath.row]objectForKey:@"Value"] isEqualToString:@"1"])
        {
            [img setImage:[UIImage imageNamed:@"unradiop"]];
        }
        else
        {
            [img setImage:[UIImage imageNamed:@"radiop"]];
        }
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tblPhoneList)
    {
       NSString *str = [NSString stringWithFormat:@"%@",[[aryPhoneList objectAtIndex:indexPath.row]objectForKey:@"ContactName"]];
        CGSize size = [str sizeWithFont:[UIFont fontWithName:@"System" size:16] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-34, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        
        return 92+size.height;
    }
    if (tableView == _tblSelectType)
    {
        return 55;
    }
    if (tableView == _tblPriority)
    {
        return 55;
    }
    return 0.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tblSelectType)
    {
        _lbSelectType.text = [[arySelectType objectAtIndex:indexPath.row]objectForKey:@"Name"];
            
            NSString *s = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
            
            for (int i=0; i< arySelectType.count; i++)
            {
                NSMutableDictionary *d = [[arySelectType objectAtIndex:i] mutableCopy];
                NSString *s1 = [NSString stringWithFormat:@"%d",i];
                
                if (s == s1)
                {
                    [d setValue:@"1" forKey:@"Value"];
                }
                else
                {
                    [d setValue:@"0" forKey:@"Value"];
                }
                [arySelectType replaceObjectAtIndex:i withObject:d];
            }
            [_tblSelectType reloadData];
            _viewSelect.hidden = YES;
    }
    if (tableView == _tblPriority)
    {
        _lbPriority.text = [[aryPriorityType objectAtIndex:indexPath.row]objectForKey:@"Name"];
        
        NSString *s = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        
        for (int i=0; i< aryPriorityType.count; i++)
        {
            NSMutableDictionary *d = [[aryPriorityType objectAtIndex:i] mutableCopy];
            NSString *s1 = [NSString stringWithFormat:@"%d",i];
            
            if (s == s1)
            {
                [d setValue:@"1" forKey:@"Value"];
            }
            else
            {
                [d setValue:@"0" forKey:@"Value"];
            }
            [aryPriorityType replaceObjectAtIndex:i withObject:d];
        }
        [_tblPriority  reloadData];
        _viewSelect.hidden = YES;
    }
}
#pragma mark - Fetch Phone Data

-(void)getPhoneBookList : (BOOL)checkVal
{
    //#define URL_Api  @"http://orataro.com/Services/"
    //#define apk_phonebook @"apk_phonebook.asmx"
    //#define apk_GetPhoneBook @"GetPhoneBook"
    //#define apk_CreatePhoneBook @"CreatePhoneBook"
    // <ClientID>guid</ClientID>
    //<InstituteID>guid</InstituteID>
    //<UserID>guid</UserID>
    //<BeachID>guid</BeachID>
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    

    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_phonebook,apk_GetPhoneBook];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    //    if ([strCheckEditAdd isEqualToString:@"Edit"])
    //    {
    //        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"EditID"];
    //    }
    //    else
    //    {
    //        [param setValue:@"" forKey:@"EditID"];
    //    }
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
                     [aryPhoneList removeAllObjects];
                     [_tblPhoneList reloadData];
                     _lbNoContact.hidden = NO;
                     [self.view bringSubviewToFront:_lbNoContact];
                 }
                 else
                 {
                      _lbNoContact.hidden = YES;
                     aryPhoneList = [[NSMutableArray alloc]initWithArray:arrResponce];
                     [_tblPhoneList reloadData];
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

#pragma mark - Api Add Contact List

-(void)api_createPhoneBook
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_phonebook,apk_CreatePhoneBook];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    //    <EditID>guid</EditID>
    //    <ContactName>string</ContactName>
    //    <ContactDetails>string</ContactDetails>
    //    <ContactNo>string</ContactNo>
    //    <ContactTypeTerm>string</ContactTypeTerm>
    //    <PriorityLevelTerm>string</PriorityLevelTerm>
    
    //    <MemberID>guid</MemberID>
    //    <ClientID>guid</ClientID>
    //    <InstituteID>guid</InstituteID>
    //    <UserID>guid</UserID>
    //    <BeachID>guid</BeachID>
    
    [param setValue:@"" forKey:@"EditID"];
    [param setValue:_txtName.text forKey:@"ContactName"];
    [param setValue:_txtRelation.text forKey:@"ContactDetails"];
    [param setValue:_txtPhoneNumber.text forKey:@"ContactNo"];
    [param setValue:_lbSelectType.text forKey:@"ContactTypeTerm"];
    [param setValue:_lbPriority.text forKey:@"PriorityLevelTerm"];
    
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    
    [ProgressHUB showHUDAddedTo:self.view];

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
                 if([strStatus isEqualToString:@"Phonebook Created SuccessFully."])
                 {
                      _viewCreatePhoneContact.hidden = YES;
                     [self getPhoneBookList:YES];
                     
                 }
                 else
                 {
                     _viewCreatePhoneContact.hidden = NO;
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
#pragma mark - Edit Phonebook

-(void)api_EditPhoneBook : (NSMutableDictionary *)dicEditData
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    NSLog(@"Delete=%@",dicEditData);
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_phonebook,apk_DeletePhoneBook];
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[dicEditData objectForKey:@"PhoneBookID"] forKey:@"PhonebookID"];
    [ProgressHUB showHUDAddedTo:self.view];
    
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
                 if([strStatus isEqualToString:@"Record Deleted Successfully."])
                 {
                    _viewDelete.hidden = YES;
                     [self getPhoneBookList:YES];
                     
                 }
                 else
                 {
                  //   _viewDelete.hidden = NO;
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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

#pragma mark - Delete Phonebook

-(void)api_DeletePhoneBook : (NSMutableDictionary *)dicEditData
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_phonebook,apk_CreatePhoneBook];
    
    NSLog(@"Edit=%@",dicEditData);
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    //    <EditID>guid</EditID>
    //    <ContactName>string</ContactName>
    //    <ContactDetails>string</ContactDetails>
    //    <ContactNo>string</ContactNo>
    //    <ContactTypeTerm>string</ContactTypeTerm>
    //    <PriorityLevelTerm>string</PriorityLevelTerm>
    
    //    <MemberID>guid</MemberID>
    //    <ClientID>guid</ClientID>
    //    <InstituteID>guid</InstituteID>
    //    <UserID>guid</UserID>
    //    <BeachID>guid</BeachID>
    
    [param setValue:[dicGetPhoneBookEditData objectForKey:@"PhoneBookID"] forKey:@"EditID"];
    [param setValue:_txtName.text forKey:@"ContactName"];
    [param setValue:_txtRelation.text forKey:@"ContactDetails"];
    [param setValue:_txtPhoneNumber.text forKey:@"ContactNo"];
    [param setValue:_lbSelectType.text forKey:@"ContactTypeTerm"];
    [param setValue:_lbPriority.text forKey:@"PriorityLevelTerm"];
    
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    
    [ProgressHUB showHUDAddedTo:self.view];
    
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
                 if([strStatus isEqualToString:@"Phonebook Updated SuccessFully."])
                 {
                     _viewCreatePhoneContact.hidden = YES;
                     [self getPhoneBookList:YES];
                     
                 }
                 else
                 {
                     _viewCreatePhoneContact.hidden = NO;
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
