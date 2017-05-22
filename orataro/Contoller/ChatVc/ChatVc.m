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

@interface ChatVc ()
{
    
    NSMutableArray *aryChatMessage;
}
@end

@implementation ChatVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tblChatMessage.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self api_getChatHistory];
}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//}

#pragma mark -textfield delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [self.view endEditing:YES];
    return YES;
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [_viewChatMessage setTransform: CGAffineTransformMakeTranslation(0, -1*keyboardSize.height)];
    
    // Assign new frame to your view
    //[self.viewChatMessage setFrame:CGRectMake(0,-110,self.view.frame.size.width,60)]; //here taken -110 for example i.e. your view will be scrolled to -110. change its value according to your requirement.
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
     [_viewChatMessage setTransform: CGAffineTransformIdentity];
   // [self.viewChatMessage setFrame:CGRectMake(0,0,self.view.frame.size.width,60)];
}



#pragma mark - button action

- (IBAction)BackBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSendClicked:(id)sender
{
    
}


#pragma mark - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // return messages.count;
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2!=0)
    {
        ReceiveMessege *cell = (ReceiveMessege *)[tableView dequeueReusableCellWithIdentifier:@"ReceiveCell"];
        if (cell == nil)
        {
            NSArray *xib = [[NSBundle mainBundle] loadNibNamed:@"ReceiveMessege" owner:self options:nil];
            cell = [xib objectAtIndex:0];
        }
        
        cell.aView.layer.cornerRadius = 2.0;

        
       /* cell.lbReceiverMessage.text = [messages objectAtIndex:indexPath.row];
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
        [cell layoutIfNeeded];*/
        
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
        
        /*cell.lbSenderMessage.text = [messages objectAtIndex:indexPath.row];
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
        
        
        [cell layoutIfNeeded];*/
        
        return cell;
        
    }
    return nil;
}

/*- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [self findHeightForText:[messages objectAtIndex:indexPath.row] havingWidth:([UIScreen mainScreen].bounds.size.width-70) andFont:[UIFont systemFontOfSize:15.0]];
    
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
    
}*/


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
                     
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
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
                         UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
    }
    
}

#pragma mark - Send message api

-(void)api_sendMessage
{
    //WriteCommentsInPTCommnunication
    
   // apk_ptcommunication
   // apk_WriteCommentsInPTCommnunication
    
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
