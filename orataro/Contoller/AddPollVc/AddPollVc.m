//
//  AddPollVc.m
//  orataro
//
//  Created by MAC008 on 07/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "AddPollVc.h"
#import "Global.h"

@interface AddPollVc ()<UITextFieldDelegate>
{
    NSMutableArray *arrAnsOption;
    
    NSString *flagNotifyOnlyParticipaintUser;
    NSString *flagIsParcentage;
    NSString *flagIsMultiChoice;
    
    UIDatePicker *datePicker;
    UIAlertView *alert;
    
    UIDatePicker *datePickerEnd;
    UIAlertView *alertEnd;

}
@end

@implementation AddPollVc
@synthesize aAddOptionView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    aAddOptionView.layer.cornerRadius = 12.5;
    aAddOptionView.layer.masksToBounds =YES;
    
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
}

-(void)commonData
{
    //
    flagNotifyOnlyParticipaintUser=@"0";
    flagIsParcentage=@"0";
    flagIsMultiChoice=@"0";
    
    //set Header Title
    if ([_strPoll isEqualToString:@"Add"])
    {
        NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
        if (arr.count != 0) {
            _lbHeaderText.text=[NSString stringWithFormat:@"Add Poll (%@)",[arr objectAtIndex:0]];
        }
        else
        {
            _lbHeaderText.text=[NSString stringWithFormat:@"Add Poll"];
        }
    }
    else
    {
        NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
        if (arr.count != 0) {
            _lbHeaderText.text=[NSString stringWithFormat:@"Edit Poll (%@)",[arr objectAtIndex:0]];
        }
        else
        {
            _lbHeaderText.text=[NSString stringWithFormat:@"Edit Poll"];
        }
        [self apiCallFor_GetPollForEdit:YES];
    }
    
    //
    arrAnsOption = [[NSMutableArray alloc]init];
    
    //
    self.tblMoreOptionList.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    //
    [Utility setLeftViewInTextField:_txtPollName imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtStartDate imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtEndDate imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtAnswerChoices imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    
    //StartDate
    CGRect frame = CGRectMake(0, 0, 200, 200);
    datePicker = [[UIDatePicker alloc] initWithFrame:frame];
    datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    NSDate *Date=[NSDate date];
    NSDateFormatter *ft=[[NSDateFormatter alloc]init];
    [ft setDateFormat:@"MM-dd-yyyy"];
    NSString *strStartDate=[ft stringFromDate:Date];
    self.txtStartDate.text= strStartDate;
    datePicker.maximumDate=Date;
    
    alert = [[UIAlertView alloc]
             initWithTitle:@"Select Date"
             message:nil
             delegate:self
             cancelButtonTitle:@"OK"
             otherButtonTitles:@"Cancel", nil];
    alert.delegate = self;
    alert.tag=111;
    [alert setValue:datePicker forKey:@"accessoryView"];
    
    //EndDate
    
    CGRect frameEnd = CGRectMake(0, 0, 200, 200);
    datePickerEnd = [[UIDatePicker alloc] initWithFrame:frameEnd];
    datePickerEnd = [[UIDatePicker alloc] init];
    datePickerEnd.datePickerMode = UIDatePickerModeDate;
    
    NSDate *DateEnd=[NSDate date];
    datePickerEnd.minimumDate=DateEnd;
    
    NSDateFormatter *ftEnd=[[NSDateFormatter alloc]init];
    [ftEnd setDateFormat:@"MM-dd-yyyy"];
    NSString *strStartDateEnd=[ftEnd stringFromDate:DateEnd];
    self.txtEndDate.text= strStartDateEnd;

    
    alertEnd = [[UIAlertView alloc]
                initWithTitle:@"Select Date"
                message:nil
                delegate:self
                cancelButtonTitle:@"OK"
                otherButtonTitles:@"Cancel", nil];
    alertEnd.delegate = self;
    alertEnd.tag=112;
    [alertEnd setValue:datePickerEnd forKey:@"accessoryView"];

}

-(void)setEditValue
{
 }

#pragma mark - apiCall

-(void)apiCallFor_SaveUpdatePolls : (BOOL)checkProgress
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_poll,apk_SaveUpdatePolls_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] forKey:@"WallID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    
    if(self.dicSelected_AddPage == nil)
    {
        [param setValue:[NSString stringWithFormat:@""] forKey:@"PollID"];
    }
    else
    {
        [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelected_AddPage objectForKey:@"PollID"]] forKey:@"PollID"];
    }
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:[NSString stringWithFormat:@"%@",self.txtAnswerChoices.text] forKey:@"ans"];
    [arrAnsOption addObject:dic];
    
    for (NSMutableDictionary *dic in arrAnsOption) {
        if([[dic objectForKey:@"ans"]length] == 0)
        {
            [arrAnsOption removeObject:dic];
        }
    }
    NSArray *arrAns=[arrAnsOption valueForKey:@"ans"];
    NSString *strAns=[arrAns componentsJoinedByString:@"#"];
    [param setValue:[NSString stringWithFormat:@"%@",strAns] forKey:@"PollOptionByHase"];
    
    [param setValue:[NSString stringWithFormat:@"%@",self.txtIntroductiontext.text] forKey:@"Details"];
    
    [param setValue:[NSString stringWithFormat:@"%@",self.txtPollName.text] forKey:@"Tilte"];
    
    if([flagIsMultiChoice integerValue] == 1)
    {
        [param setValue:[NSString stringWithFormat:@"true"] forKey:@"IsMultiChoice"];
    }
    else
    {
        [param setValue:[NSString stringWithFormat:@"false"] forKey:@"IsMultiChoice"];
    }
    
    
    if([flagNotifyOnlyParticipaintUser integerValue] == 1)
    {
        [param setValue:[NSString stringWithFormat:@"true"] forKey:@"IsNotifyAll"];
    }
    else
    {
        [param setValue:[NSString stringWithFormat:@"false"] forKey:@"IsNotifyAll"];
    }
    
    
    if([flagIsParcentage integerValue] == 1)
    {
        [param setValue:[NSString stringWithFormat:@"true"] forKey:@"IsPercentege"];
    }
    else
    {
        [param setValue:[NSString stringWithFormat:@"false"] forKey:@"IsPercentege"];
    }
    
    
    [param setValue:[NSString stringWithFormat:@"%@",self.txtStartDate.text] forKey:@"StartDate"];
    [param setValue:[NSString stringWithFormat:@"%@",self.txtEndDate.text] forKey:@"EndDate"];
    
    
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
             NSMutableArray *arrResponce = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]mutableCopy];
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[[arrResponce objectAtIndex:0]mutableCopy];
                 NSString *strStatus=[[dic objectForKey:@"message"]mutableCopy];
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else if([strStatus isEqualToString:@"Record save successfully"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                     [self apiCallFor_SendPushNotification];
                 }
                 else if([strStatus isEqualToString:@"Record update successfully"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                     [self apiCallFor_SendPushNotification];
                 }
                 else
                 {
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
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

-(void)apiCallFor_GetPollForEdit : (BOOL)checkProgress
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_poll,apk_GetPollForEdit_action];
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelected_AddPage objectForKey:@"PollID"]] forKey:@"PollID"];
    
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
             NSMutableDictionary *dicResponce = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]mutableCopy];
             
             if(dicResponce  != nil)
             {
                 NSString *strStatus=[[dicResponce objectForKey:@"message"]mutableCopy];
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dicResponce objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     NSMutableArray *arrPoll=[dicResponce objectForKey:@"Poll"];
                     if([arrPoll count] != 0)
                     {
                         NSMutableDictionary *dicPoll=[arrPoll objectAtIndex:0];
                         NSString *Title=[dicPoll objectForKey:@"Title"];
                         NSString *Details=[dicPoll objectForKey:@"Details"];
                         NSString *StartDate=[Utility convertMiliSecondtoDate:@"MM-dd-yyyy" date:[dicPoll objectForKey:@"StartDate"]];
                         NSString *EndDate=[Utility convertMiliSecondtoDate:@"MM-dd-yyyy" date:[dicPoll objectForKey:@"EndDate"]];
                         
                         flagIsMultiChoice=[dicPoll objectForKey:@"IsMultiChoice"];
                         if([flagIsMultiChoice integerValue] == 0)
                         {
                             [_btnIsMultiChoice setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
                         }
                         else
                         {
                             [_btnIsMultiChoice setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
                             
                         }
                         
                         flagNotifyOnlyParticipaintUser=[dicPoll objectForKey:@"IsNotifyAll"];
                         if([flagNotifyOnlyParticipaintUser integerValue] == 0)
                         {
                             [_btnNotifyOnly setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
                         }
                         else
                         {
                             [_btnNotifyOnly setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
                             
                         }

                         flagIsParcentage=[dicPoll objectForKey:@"IsPercentege"];
                         if([flagIsParcentage integerValue] == 0)
                         {
                             [_btnIsPercentage setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
                         }
                         else
                         {
                             [_btnIsPercentage setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
                             
                         }

                         self.txtPollName.text=Title;
                         self.txtIntroductiontext.text=Details;
                         
                         self.txtStartDate.text=StartDate;
                         self.txtEndDate.text=EndDate;
                     }
                     
                     NSMutableArray *arrPollOption=[dicResponce objectForKey:@"PollOption"];
                     arrAnsOption = [[NSMutableArray alloc]init];
                     if([arrPollOption count] != 0)
                     {
                         for (NSMutableDictionary *dic in arrPollOption)
                         {
                             NSString *strOpt=[dic objectForKey:@"Option"];
                             NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
                             [dic setObject:strOpt forKey:@"ans"];
                             [arrAnsOption addObject:dic];
                         }
                     }
                     
                     if([arrAnsOption count] != 0)
                     {
                         NSString *str=[[arrAnsOption objectAtIndex:0]objectForKey:@"ans"];
                         self.txtAnswerChoices.text=str;
                         [arrAnsOption removeObjectAtIndex:0];
                         
                         long tblHeight=[arrAnsOption count] * 51;
                         self.viewMoreOption_Height.constant = tblHeight + 120;
                         [self.tblMoreOptionList reloadData];
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

#pragma mark - UITextField

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    CGPoint location = [self.tblMoreOptionList convertPoint:textField.frame.origin fromView:textField.superview];
    NSIndexPath *indexPath = [self.tblMoreOptionList indexPathForRowAtPoint:location];
    
    if(textField == self.txtPollName)
    {
        
    }
    else if(textField == self.txtStartDate)
    {
        
    }
    else if(textField == self.txtEndDate)
    {
        
    }
    else if(textField == self.txtAnswerChoices)
    {
        
    }
    else if(textField.tag == indexPath.row)
    {
        NSMutableDictionary *dic=[arrAnsOption objectAtIndex:textField.tag];
        [dic setObject:textField.text forKey:@"ans"];
    }
}

#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrAnsOption count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellANS"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    UITextField *txt=(UITextField *)[cell.contentView viewWithTag:1];
    txt.tag=indexPath.row;
    
    NSString *str=[[arrAnsOption objectAtIndex:indexPath.row]objectForKey:@"ans"];
    txt.text=str;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (IBAction)btnCell_DeleteMoreOption:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblMoreOptionList];
    NSIndexPath *indexPath = [self.tblMoreOptionList indexPathForRowAtPoint:buttonPosition];
    [arrAnsOption removeObjectAtIndex:indexPath.row];
    
    [self.tblMoreOptionList deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
  
    long tblHeight=[arrAnsOption count] * 51;
    self.viewMoreOption_Height.constant = tblHeight + 120;
}

#pragma mark -  Date Picker Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 111)
    {
        if (buttonIndex == 0)
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"MM-dd-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
            self.txtStartDate.text = theDate;
        }
        
    }
    if (alertView.tag == 112)
    {
        if (buttonIndex == 0)
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"MM-dd-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePickerEnd date]];
            self.txtEndDate.text = theDate;
        }
        
    }
    
}


#pragma mark - button action

- (IBAction)BackBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnStartDate:(id)sender
{
    [self.view endEditing:YES];
    [datePicker setDate:[NSDate date]];
    [alert show];
}

- (IBAction)btnEndDate:(id)sender
{
    [self.view endEditing:YES];
    [datePickerEnd setDate:[NSDate date]];
    [alertEnd show];
    
}

- (IBAction)btnNotifyOnly:(id)sender
{
    if([flagNotifyOnlyParticipaintUser integerValue] == 1)
    {
        flagNotifyOnlyParticipaintUser=@"0";
        [_btnNotifyOnly setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
    }
    else
    {
        flagNotifyOnlyParticipaintUser=@"1";
         [_btnNotifyOnly setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
        
    }
}

- (IBAction)btnIsPercentage:(id)sender
{
    if([flagIsParcentage integerValue] == 1)
    {
        flagIsParcentage=@"0";
        [_btnIsPercentage setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
    }
    else
    {
        flagIsParcentage=@"1";
        [_btnIsPercentage setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
        
    }
}

- (IBAction)btnIsMultiChoice:(id)sender
{
    if([flagIsMultiChoice integerValue] == 1)
    {
        flagIsMultiChoice=@"0";
        [_btnIsMultiChoice setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
    }
    else
    {
        flagIsMultiChoice=@"1";
        [_btnIsMultiChoice setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
        
    }
}

- (IBAction)btnAddMoreOption:(id)sender
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"" forKey:@"ans"];
    [arrAnsOption addObject:dic];
    
    long tblHeight=[arrAnsOption count] * 51;
    self.viewMoreOption_Height.constant = tblHeight + 120;
    [self.tblMoreOptionList reloadData];
}

- (IBAction)btnSave:(id)sender {
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:CIRCULAR_TITLE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:CIRCULAR_TITLE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:CIRCULAR_DESC delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    [self apiCallFor_SaveUpdatePolls:YES];

}
@end
