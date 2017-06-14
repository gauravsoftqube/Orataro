//
//  ChatVc.m
//  orataro
//
//  Created by MAC008 on 22/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ChatVc.h"
#import "Global.h"
#import "SenderMessage.h"
#import "ReceiveMessege.h"
#import "IQKeyboardManager.h"

@interface ChatVc ()
{
    
    NSMutableArray *aryChatMessage;
    CGSize setsize;
}
@end

@implementation ChatVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tblChatMessage.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
   // _tblChatMessage.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tblChatMessage addGestureRecognizer:gestureRecognizer];
    
    // Do any additional setup after loading the view.
}
- (void) hideKeyboard
{
    [_txtMessageText resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    NSLog(@"Dic=%@",_dicChatData);
    
  
    
   [self api_getChatHistory];
}
-(void) viewWillDisappear
{
    
}

#pragma mark -textfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_txtMessageText resignFirstResponder];
    return YES;
}
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
//    return YES;
//}
//
//
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
//    
//    [self.view endEditing:YES];
//    return YES;
//}


#pragma mark - keyboard hide show

/*- (void)keyboardDidShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
      [_viewChatMessage setTransform: CGAffineTransformMakeTranslation(0, -1*keyboardSize.height)];

    if ([aryChatMessage count] > 0)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:aryChatMessage.count-1 inSection:0];
        [_tblChatMessage scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
  _tblChatMessage.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0);
    
   // setsize = keyboardSize;
    
    // [self performSelector:@selector(ShowTable1) withObject:nil afterDelay:0.01];
}
-(void)ShowTable1
{
       _tblChatMessage.contentInset = UIEdgeInsetsMake(0, 0, setsize.height, 0);
    
     [self performSelector:@selector(ShowTable) withObject:nil afterDelay:0.1];
}
-(void)ShowTable
{
    [_viewChatMessage setTransform: CGAffineTransformMakeTranslation(0, -1*setsize.height)];
    if ([aryChatMessage count] > 0)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:aryChatMessage.count-1 inSection:0];
        [_tblChatMessage scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }

}
-(void)keyboardDidHide:(NSNotification *)notification
{
     _tblChatMessage.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    if ([aryChatMessage count] > 0)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:aryChatMessage.count-1 inSection:0];
        [_tblChatMessage scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
    }
    
    [_viewChatMessage setTransform: CGAffineTransformIdentity];

}*/


- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
     [_viewChatMessage setTransform: CGAffineTransformMakeTranslation(0, -1*keyboardSize.height)];
    
    UIEdgeInsets contentInsets;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.height), 0.0);
    } else {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.width), 0.0);
    }
    
    _tblChatMessage.contentInset = contentInsets;
    _tblChatMessage.scrollIndicatorInsets = contentInsets;
     NSIndexPath *indexPath = [NSIndexPath indexPathForRow:aryChatMessage.count-1 inSection:0];
    
    [_tblChatMessage scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [_viewChatMessage setTransform: CGAffineTransformIdentity];
    _tblChatMessage.contentInset = UIEdgeInsetsZero;
    _tblChatMessage.scrollIndicatorInsets = UIEdgeInsetsZero;
}


#pragma mark - button action

- (IBAction)BackBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSendClicked:(id)sender
{
    [self api_sendMessage];
}


#pragma mark - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return messages.count;
    return aryChatMessage.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //tick
    //double_tick_sky_blue
    
    
    NSLog(@"aryresp=%@",aryChatMessage);
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    
    NSLog(@"sdsdsdsdsd=%@",[dicCurrentUser objectForKey:@"MemberID"]);
    
    if (![[[aryChatMessage objectAtIndex:indexPath.row]objectForKey:@"MemberID"] isEqualToString:[dicCurrentUser objectForKey:@"MemberID"]])
    {
        ReceiveMessege *cell = (ReceiveMessege *)[tableView dequeueReusableCellWithIdentifier:@"ReceiveCell"];
        if (cell == nil)
        {
            NSArray *xib = [[NSBundle mainBundle] loadNibNamed:@"ReceiveMessege" owner:self options:nil];
            cell = [xib objectAtIndex:0];
        }
        
        cell.aView.layer.cornerRadius = 10.0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lbReceiverMessage.text = [[aryChatMessage objectAtIndex:indexPath.row]objectForKey:@"Details"];
        cell.lbReceiverTime.text = [Utility convertMiliSecondtoDate:@"HH:mm a" date:[[aryChatMessage objectAtIndex:indexPath.row]objectForKey:@"CreatedOn"]];
        
      //  NSString *strMsg = [[aryChatMessage objectAtIndex:indexPath.row]objectForKey:@"Details"];
        
        CGSize size = [self findHeightForText:[[aryChatMessage objectAtIndex:indexPath.row]objectForKey:@"Details"] havingWidth:([UIScreen mainScreen].bounds.size.width-65) andFont:[UIFont systemFontOfSize:15.0]];
        
        if (size.width < 65)
        {
            cell.trailingSpace.constant = [UIScreen mainScreen].bounds.size.width - (size.width+65);
          //   cell.aView.layer.cornerRadius = size.width+62/2;
        }
        else
        {
            cell.trailingSpace.constant = [UIScreen mainScreen].bounds.size.width - (size.width+25);
            //cell.aView.layer.cornerRadius = size.width+25/2;
        }
        [cell layoutIfNeeded];
        
        return cell;
        
    }
    else
    {
        SenderMessage *cell = (SenderMessage *)[tableView dequeueReusableCellWithIdentifier:@"SenderCell"];
        if (cell == nil)
        {
            NSArray *xib = [[NSBundle mainBundle] loadNibNamed:@"SenderMessage" owner:self options:nil];
            cell = [xib objectAtIndex:0];
        }
        
        cell.aView.layer.cornerRadius = 10.0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lbSenderMessage.text = [[aryChatMessage objectAtIndex:indexPath.row]objectForKey:@"Details"];
        cell.lbSenderTime.text = [Utility convertMiliSecondtoDate:@"HH:mm a" date:[[aryChatMessage objectAtIndex:indexPath.row]objectForKey:@"CreatedOn"]];
        

        CGSize size = [self findHeightForText:[[aryChatMessage objectAtIndex:indexPath.row]objectForKey:@"Details"] havingWidth:([UIScreen mainScreen].bounds.size.width-65) andFont:[UIFont systemFontOfSize:15.0]];
        
        if (size.width < 65)
        {
            cell.leadingSpace.constant = [UIScreen mainScreen].bounds.size.width - (size.width+70);
            //cell.aView.layer.cornerRadius = size.width+65/2;
        }
        else
        {
            cell.leadingSpace.constant = [UIScreen mainScreen].bounds.size.width - (size.width+10);
            //cell.aView.layer.cornerRadius = size.width+10/2;
        }
        
        
        [cell layoutIfNeeded];
        
        return cell;
        
    }
    
    /*  if (indexPath.row%2!=0)
     {
     ReceiveMessege *cell = (ReceiveMessege *)[tableView dequeueReusableCellWithIdentifier:@"ReceiveCell"];
     if (cell == nil)
     {
     NSArray *xib = [[NSBundle mainBundle] loadNibNamed:@"ReceiveMessege" owner:self options:nil];
     cell = [xib objectAtIndex:0];
     }
     
     cell.aView.layer.cornerRadius = 2.0;
     
     
     cell.lbReceiverMessage.text = [messages objectAtIndex:indexPath.row];
     cell.lbReceiverTime.text = [messages1 objectAtIndex:indexPath.row];
     
     
     CGSize size = [self findHeightForText:[messages objectAtIndex:indexPath.row] havingWidth:([UIScreen mainScreen].bounds.size.width-65) andFont:[UIFont systemFontOfSize:15.0]];
     
     if (size.width < 65)
     {
     cell.trailingSpace.constant = [UIScreen mainScreen].bounds.size.width - (size.width+65);
     }
     else
     {
     cell.trailingSpace.constant = [UIScreen mainScreen].bounds.size.width - (size.width+25);
     }
     [cell layoutIfNeeded];
     
     return cell;
     
     }
     else
     {
     SenderMessage *cell = (SenderMessage *)[tableView dequeueReusableCellWithIdentifier:@"SenderCell"];
     if (cell == nil)
     {
     NSArray *xib = [[NSBundle mainBundle] loadNibNamed:@"SenderMessage" owner:self options:nil];
     cell = [xib objectAtIndex:0];
     }
     
     cell.aView.layer.cornerRadius = 2.0;
     
     cell.lbSenderMessage.text = [messages objectAtIndex:indexPath.row];
     cell.lbSenderTime.text = [messages1 objectAtIndex:indexPath.row];
     
     
     
     CGSize size = [self findHeightForText:[messages objectAtIndex:indexPath.row] havingWidth:([UIScreen mainScreen].bounds.size.width-65) andFont:[UIFont systemFontOfSize:15.0]];
     
     if (size.width < 65)
     {
     cell.leadingSpace.constant = [UIScreen mainScreen].bounds.size.width - (size.width+65);
     }
     else
     {
     cell.leadingSpace.constant = [UIScreen mainScreen].bounds.size.width - (size.width+10);
     }
     
     
     [cell layoutIfNeeded];
     
     return cell;
     
     }*/
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [self findHeightForText:[[aryChatMessage objectAtIndex:indexPath.row]objectForKey:@"Details"] havingWidth:([UIScreen mainScreen].bounds.size.width-70) andFont:[UIFont systemFontOfSize:15.0]];
    
    //NSLog(@"Data=%f",size.height);
    
    //NSLog(@"%f",height);
    // return (size.height+25.0 > 50.0?size.height+25.0:50.0);
    
    //  return (size.height+59 > 60.0?size.height+50.0:60.0);
    
    return size.height + 50;
}

- (CGSize)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font
{
    CGSize size = CGSizeZero;
    if (text)
    {
        //iOS 7
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size;
    
}
-(void)tableViewScrollToBottomAnimated:(BOOL)animated
{
    NSInteger numberOfRows = [_tblChatMessage numberOfRowsInSection:0];
    if (numberOfRows)
    {
        [_tblChatMessage scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:numberOfRows-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
}

#pragma mark - Get ChatData

-(void)api_getChatHistory
{
    //#define apk_ptcommunication  @"apk_ptcommunication.asmx"
    //#define apk_PTCommunicationChatHistory_action @"PTCommunicationChatHistory"
    
    // <ClientID>guid</ClientID>
    // <InstituteID>guid</InstituteID>
    // <PTCommunicationID>guid</PTCommunicationID>
    
    NSLog(@"Dic=%@",_dicChatData);
    
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_ptcommunication,apk_PTCommunicationChatHistory_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    
    [param setValue:[_dicChatData objectForKey:@"CommunicationID"] forKey:@"PTCommunicationID"];
    
    [ProgressHUB showHUDAddedTo:self.view];
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         //  [ProgressHUB hideenHUDAddedTo:self.view];
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
                     [aryChatMessage removeAllObjects];
                     [_tblChatMessage reloadData];
                     
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:CHATHISTORY delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     aryChatMessage = [[NSMutableArray alloc]initWithArray:arrResponce];
                     
                     [self api_PTCommunicationChatHistorySetViewFlag:arrResponce];
                     
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

#pragma mark - api for setViewReadUnread

-(void)api_PTCommunicationChatHistorySetViewFlag : (NSMutableArray *)arrResponse
{
    // if([[Utility getMemberType]
    
    //apk_ptcommunication
    ///apk_PTCommunicationChatHistorySetViewFlag
    
    //                     <PTCommunicationDetailIDByComma>string</PTCommunicationDetailIDByComma>
    //                     <MemberType>string</MemberType>
    //                     <ClientID>guid</ClientID>
    //                     <InstituteID>guid</InstituteID>
    //                     </PTCommunicationChatHistorySetViewFlag>
    
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_ptcommunication,apk_PTCommunicationChatHistorySetViewFlag];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[Utility getMemberType] forKey:@"MemberType"];
    
    NSMutableArray *aryTempStoreID= [[NSMutableArray alloc]init];
    
    for (NSMutableDictionary *dic in arrResponse)
    {
        if ([[dic objectForKey:@"MemberType"] isEqualToString:@"Teacher"])
        {
            NSString *isTeacher = [NSString stringWithFormat:@"%@",[dic objectForKey:@"IsTeacherRead"]];
            
            if ([isTeacher isEqualToString:@"0"])
            {
                [aryTempStoreID addObject:[dic objectForKey:@"PTCommunicationDetailsID"]];
            }
            else
            {
                
            }
        }
        else
        {
            NSString *isParent = [NSString stringWithFormat:@"%@",[dic objectForKey:@"IsParentRead"]];
            
            if ([isParent isEqualToString:@"0"])
            {
                [aryTempStoreID addObject:[dic objectForKey:@"PTCommunicationDetailsID"]];
            }
            else
            {
                
            }
        }
    }
    
    NSLog(@"Id=%@",aryTempStoreID);
    
    if (aryTempStoreID.count > 0)
    {
        NSString *st = [aryTempStoreID componentsJoinedByString:@","];
        
        [param setValue:st forKey:@"PTCommunicationDetailIDByComma"];
        
        //  [ProgressHUB showHUDAddedTo:self.view];
        
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
                         UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:CHATCOMMU delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [alrt show];
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
    else{
        [ProgressHUB hideenHUDAddedTo:self.view];
        
        [_tblChatMessage reloadData];
        
        if ([aryChatMessage count] > 0)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:aryChatMessage.count-1 inSection:0];
            [_tblChatMessage scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
        }
    }
    
}

#pragma mark - Send message api

-(void)api_sendMessage
{
    NSLog(@"Dic =%@",_dicChatData);
    NSLog(@"Dic=%@",aryChatMessage);
    
    //aryChatMessage
    
    
    // apk_ptcommunication
    // apk_WriteCommentsInPTCommnunication
    
    /*
     
     <InstituteID>guid</InstituteID>
     <ClientID>guid</ClientID>
     <UserID>guid</UserID>
     <MemberID>guid</MemberID>
     <MemberType>string</MemberType>
     
     <PTCommunicationDetailsID>guid</PTCommunicationDetailsID>
     <Message>string</Message>
     <PostByType>string</PostByType>
     <PTCommunicationID>guid</PTCommunicationID>
     
     */
    
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_ptcommunication,apk_WriteCommentsInPTCommnunication];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[Utility getMemberType] forKey:@"MemberType"];
    [param setValue:@"" forKey:@"PTCommunicationDetailsID"];
    [param setValue:_txtMessageText.text forKey:@"Message"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"PostByType"]] forKey:@"PostByType"];
    [param setValue:[_dicChatData objectForKey:@"CommunicationID"] forKey:@"PTCommunicationID"];
    
    [ProgressHUB showHUDAddedTo:self.view];
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             // NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             //NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             
             //             NSString *strArrd=[dicResponce objectForKey:@"d"];
             //             if([dicResponce count] != 0)
             //             {
             
             if([dicResponce count] != 0)
             {
                 // NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[dicResponce objectForKey:@"message"];
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dicResponce objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     //aryChatMessage = [[NSMutableArray alloc]initWithArray:arrResponce];
                     
                     // [self api_PTCommunicationChatHistorySetViewFlag:arrResponce];
                     _txtMessageText.text = @"";
                     [self api_getChatHistory];
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
