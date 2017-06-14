//
//  ReminderVc.m
//  orataro
//
//  Created by MAC008 on 09/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ReminderVc.h"
#import "Global.h"

@interface ReminderVc ()
{
    NSMutableArray *arrImportant,*arrImportantMain,*arrCancelled,*arrCancelledMain,*arrFiled,*arrFiledTemp;
    NSString *strSelectedPopup;
    
    UIDatePicker *datePicker;
    UIAlertView *alert;
    
    UIDatePicker *datePickerEnd;
    UIAlertView *alertEnd;
    
    
    NSMutableArray *aryImp,*aryCan;
    NSString *strCheckCanImp;
}
@end

@implementation ReminderVc
@synthesize aTitleTextfield,aCancelTextField,aEnddateTextfield,aImportantTextField,aSatrtDateTextField,aDescriptionTextview;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //arrImportantMain = [[NSMutableArray alloc]initWithObjects:@"Important",@"Normal",@"not Important", nil];
    //arrCancelledMain = [[NSMutableArray alloc]initWithObjects:@"Cancelled",@"Completed",@"In-Progress",@"Insufficient", nil];
    
   
    
    
    aryImp = [NSMutableArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"Important",@"Name",@"1",@"Value", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"Normal",@"Name",@"0",@"Value", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"not Important",@"Name",@"0",@"Value", nil],nil];
    
 //   [_tblPopup reloadData];
    
    aryCan = [NSMutableArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"Cancelled",@"Name",@"1",@"Value", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"Completed",@"Name",@"0",@"Value", nil],
              [NSDictionary dictionaryWithObjectsAndKeys:@"In-Progress",@"Name",@"0",@"Value", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"Insufficient",@"Name",@"0",@"Value", nil],nil];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    aTitleTextfield.leftView = paddingView;
    aTitleTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    aCancelTextField.leftView = paddingView1;
    aCancelTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    aEnddateTextfield.leftView = paddingView2;
    aEnddateTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    aImportantTextField.leftView = paddingView3;
    aImportantTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    aSatrtDateTextField.leftView = paddingView4;
    aSatrtDateTextField.leftViewMode = UITextFieldViewModeAlways;
    aDescriptionTextview.textContainerInset = UIEdgeInsetsMake(8, 0, 0, 0);
    
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    [self.viewPopup setHidden:YES];
    _tblPopup.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    //StartDate
    CGRect frame = CGRectMake(0, 0, 200, 200);
    datePicker = [[UIDatePicker alloc] initWithFrame:frame];
    datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    NSDate *Date=[NSDate date];
    datePicker.minimumDate=Date;
    
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
    
    alertEnd = [[UIAlertView alloc]
                initWithTitle:@"Select Date"
                message:nil
                delegate:self
                cancelButtonTitle:@"OK"
                otherButtonTitles:@"Cancel", nil];
    alertEnd.delegate = self;
    alertEnd.tag=112;
    [alertEnd setValue:datePickerEnd forKey:@"accessoryView"];
    
    //popup
    arrImportantMain = [[NSMutableArray alloc]initWithObjects:@"Important",@"Normal",@"not Important", nil];
    arrImportant=[[NSMutableArray alloc]init];
    
    
    arrCancelledMain = [[NSMutableArray alloc]initWithObjects:@"Cancelled",@"Completed",@"In-Progress",@"Insufficient", nil];
    arrCancelled =[[NSMutableArray alloc]init];
    
    
    
    if(self.dicSelected != nil)
    {
        [self setSeletedValue];
    }
}

-(void)setSeletedValue
{
    NSString *strTitle=[self.dicSelected objectForKey:@"Title"];
    NSString *Details=[self.dicSelected objectForKey:@"Details"];
    
    self.aTitleTextfield.text = strTitle;
    self.aDescriptionTextview.text =Details;
    
    NSString *TypeTerm=[self.dicSelected objectForKey:@"TypeTerm"];
    NSString *Status=[self.dicSelected objectForKey:@"Status"];
    
    self.aImportantTextField.text= TypeTerm;
    self.aCancelTextField.text = Status;
    
    NSString *CreateOn=[self.dicSelected objectForKey:@"CreateOn"];
    CreateOn = [Utility convertMiliSecondtoDate:@"dd-MM-yyyy" date:CreateOn];
    NSString *EndDate=[self.dicSelected objectForKey:@"EndDate"];
    EndDate = [Utility convertMiliSecondtoDate:@"dd-MM-yyyy" date:EndDate];
    
    self.aSatrtDateTextField.text=CreateOn;
    self.aEnddateTextfield.text= EndDate;
}

#pragma mark - ApiCall

-(void)apiCallFor_postReminder
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_todos,apk_SaveUpdateTodos_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    if(self.dicSelected != nil)
    {
        [param setValue:[NSString stringWithFormat:@"%@",[self.dicSelected objectForKey:@"TodosID"]] forKey:@"EditID"];
    }
    else
    {
        [param setValue:[NSString stringWithFormat:@""] forKey:@"EditID"];
    }
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] forKey:@"WallID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    [param setValue:[NSString stringWithFormat:@"%@",self.aTitleTextfield.text] forKey:@"title"];
    
    [param setValue:[NSString stringWithFormat:@"%@",self.aDescriptionTextview.text] forKey:@"details"];
    [param setValue:[NSString stringWithFormat:@"%@",self.aImportantTextField.text] forKey:@"typeterm"];
    [param setValue:[NSString stringWithFormat:@"%@",self.aCancelTextField.text] forKey:@"status"];
    [param setValue:[NSString stringWithFormat:@"%@",aSatrtDateTextField.text] forKey:@"startdate"];
    
    [param setValue:[NSString stringWithFormat:@"%@",aEnddateTextfield.text] forKey:@"EndDate"];
    [param setValue:[NSString stringWithFormat:@""] forKey:@"CompletDate"];
    
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
                 if([strStatus isEqualToString:@"Record Inserted Successfully..!!!"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                     [self apiCallFor_SendPushNotification];
                 }
                 else if([strStatus isEqualToString:@"Record Updated Successfully..!!!"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                     [self apiCallFor_SendPushNotification];
                 }
                 else
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:RECORDNOTFOUND delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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

#pragma mark - UITableview Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == _tblPopup)
    {
         return [aryImp count];
    }
    if (tableView == _tblCancelled)
    {
        return [aryCan count];
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tblPopup)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        UILabel *lblName = (UILabel *)[cell.contentView viewWithTag:1];
        
        NSString *strName=[[aryImp objectAtIndex:indexPath.row]objectForKey:@"Name"];
        
        lblName.text=[strName capitalizedString];
        
        UIButton *btn=(UIButton*)[cell.contentView viewWithTag:2];
        
        NSLog(@"arr=%@",aryImp);
        
        if([[[aryImp objectAtIndex:indexPath.row]objectForKey:@"Value"] isEqualToString:@"1"])
        {
            [btn setImage:[UIImage imageNamed:@"unradiop"] forState:UIControlStateNormal];
        }
        else
        {
            [btn setImage:[UIImage imageNamed:@"radiop"] forState:UIControlStateNormal];
            
            
        }
        
        return cell;
    }
    if (tableView == _tblCancelled)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellCencell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        UILabel *lblName = (UILabel *)[cell.contentView viewWithTag:1];
        
        NSString *strName=[[aryCan objectAtIndex:indexPath.row]objectForKey:@"Name"];
        
        lblName.text=[strName capitalizedString];
        
        UIButton *btn=(UIButton*)[cell.contentView viewWithTag:2];
        
        NSLog(@"arr=%@",aryCan);
        
        if([[[aryCan objectAtIndex:indexPath.row]objectForKey:@"Value"] isEqualToString:@"1"])
        {
            [btn setImage:[UIImage imageNamed:@"unradiop"] forState:UIControlStateNormal];
        }
        else
        {
            [btn setImage:[UIImage imageNamed:@"radiop"] forState:UIControlStateNormal];
            
            
        }
        
        return cell;

    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tblPopup)
    {
        NSString *str=[[aryImp objectAtIndex:indexPath.row]objectForKey:@"Name"];
        self.aImportantTextField.text=[str capitalizedString];
        
        NSMutableDictionary *dic = [[aryImp objectAtIndex:indexPath.row]mutableCopy];
        
        NSLog(@"Dic=%@",dic);
        
        //NSLog(@"ary=%@",aryImp);
        
        for (int i=0; i<aryImp.count; i++)
        {
            NSMutableDictionary *dic2 = [[aryImp objectAtIndex:i]mutableCopy];
            
            NSLog(@"Data=%@",[aryImp objectAtIndex:i]);
            
            if ([dic2 isEqualToDictionary:dic])
            {
                [dic2 setObject:@"1" forKey:@"Value"];
                [aryImp replaceObjectAtIndex:i withObject:dic2];
            }
            else
            {
                [dic2 setObject:@"0" forKey:@"Value"];
                [aryImp replaceObjectAtIndex:i withObject:dic2];
            }
            
        }
        NSLog(@"ary=%@",aryImp);
        [_tblPopup reloadData];
         _viewPopup.hidden =YES;
    }
    if (tableView == _tblCancelled)
    {
        NSString *str=[[aryCan objectAtIndex:indexPath.row]objectForKey:@"Name"];
        self.aCancelTextField.text=[str capitalizedString];
        
        NSMutableDictionary *dic = [[aryCan objectAtIndex:indexPath.row]mutableCopy];
        
        
        for (int i=0; i<aryCan.count; i++)
        {
            NSMutableDictionary *dic2 = [[aryCan objectAtIndex:i]mutableCopy];
            
            if ([dic2 isEqualToDictionary:dic])
            {
                [dic2 setObject:@"1" forKey:@"Value"];
                [aryCan replaceObjectAtIndex:i withObject:dic2];
            }
            else
            {
                [dic2 setObject:@"0" forKey:@"Value"];
                [aryCan replaceObjectAtIndex:i withObject:dic2];
            }

        }
       //  NSLog(@"ary=%@",aryCan);
        [_tblCancelled reloadData];
        _viewPopup.hidden =YES;

       
    }
  /*  if ([strSelectedPopup isEqualToString:@"Important"])
    {
        NSString *str=[[arrFiled objectAtIndex:indexPath.row]objectForKey:@"Name"];
        self.aImportantTextField.text=[str capitalizedString];
        
        NSMutableDictionary *dic = [[arrFiled objectAtIndex:indexPath.row]mutableCopy];
        
        NSLog(@"Dic=%@",dic);
        
        //
        
        for (int i=0; i<arrFiled.count; i++)
        {
            NSMutableDictionary *dic2 = [[arrFiled objectAtIndex:i]mutableCopy];
            
            NSLog(@"Data=%@",[arrFiled objectAtIndex:i]);
            
            if ([dic2 isEqualToDictionary:dic])
            {
                [dic2 setObject:@"1" forKey:@"Value"];
                [arrFiled replaceObjectAtIndex:i withObject:dic2];
            }
            else
            {
                 [dic2 setObject:@"0" forKey:@"Value"];
                [arrFiled replaceObjectAtIndex:i withObject:dic2];
            }
            
        }
        
        NSLog(@"ary=%@",arrFiled);
//        [arrFiledTemp removeAllObjects];
//        [arrFiledTemp addObject:str];
//        
//        [arrImportant removeAllObjects];
//        [arrImportant addObject:str];
        
    }
    else
    {
        NSString *str=[[arrFiled objectAtIndex:indexPath.row]objectForKey:@"Name"];
        self.aCancelTextField.text=[str capitalizedString];
        
        NSMutableDictionary *dic = [[arrFiled objectAtIndex:indexPath.row]mutableCopy];
        
        
        for (int i=0; i<arrFiled.count; i++)
        {
            NSMutableDictionary *dic2 = [[arrFiled objectAtIndex:i]mutableCopy];
            
            if ([[arrFiled objectAtIndex:i] containsObject:dic])
            {
                [dic2 setObject:@"0" forKey:@"Value"];
            }
            else
            {
                [dic2 setObject:@"1" forKey:@"Value"];
            }
            [arrFiled replaceObjectAtIndex:i withObject:dic2];
        }
        
        NSLog(@"ary=%@",arrFiled);
        
//        [arrFiledTemp removeAllObjects];
//        [arrFiledTemp addObject:str];
//        
//        [arrCancelled removeAllObjects];
//        [arrCancelled addObject:str];
    }
    
    [self.tblPopup reloadData];
    [self.viewPopup setHidden:YES];*/
}

- (IBAction)btnPopup_Radio:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblPopup];
    NSIndexPath *indexPath = [self.tblPopup indexPathForRowAtPoint:buttonPosition];
    
    if ([strSelectedPopup isEqualToString:@"Important"])
    {
        NSString *str=[[arrFiled objectAtIndex:indexPath.row]objectForKey:@"Name"];
        self.aImportantTextField.text=[str capitalizedString];
        [arrFiledTemp removeAllObjects];
        [arrFiledTemp addObject:str];
    }
    else
    {
        NSString *str=[[arrFiled objectAtIndex:indexPath.row]objectForKey:@"Name"];
        self.aCancelTextField.text=[str capitalizedString];
        [arrFiledTemp removeAllObjects];
        [arrFiledTemp addObject:str];
    }
    
    [self.tblPopup reloadData];
    [self.viewPopup setHidden:YES];
}

#pragma mark -  Date Picker Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 111)
    {
        if (buttonIndex == 0)
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
            self.aSatrtDateTextField.text = theDate;
        }
        
    }
    if (alertView.tag == 112)
    {
        if (buttonIndex == 0)
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePickerEnd date]];
            self.aEnddateTextfield.text = theDate;
        }
        
    }
    
}

#pragma mark - UIButton Action

- (IBAction)BackBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SaveBtnClicked:(id)sender
{
    if ([Utility validateBlankField:aTitleTextfield.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:CIRCULAR_TITLE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    if ([Utility validateBlankField:aDescriptionTextview.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:CIRCULAR_DESC delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    
    if ([Utility validateBlankField:aSatrtDateTextField.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Select_Start_Date delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    if ([Utility validateBlankField:aEnddateTextfield.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Select_End_Date delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    [self apiCallFor_postReminder];
}

- (IBAction)btnImportant:(id)sender
{
   // strSelectedPopup=@"Important";
    
  //  arrFiled = [aryImp mutableCopy];
    
   // arrFiled = [arrImportantMain mutableCopy];
    //arrFiledTemp = [arrImportant mutableCopy];
    
   
    
    _tblCancelled.hidden = YES;
    _tblPopup.hidden = NO;
    [_viewPopup bringSubviewToFront:_tblPopup];
    [self.tblPopup reloadData];
    [self.viewPopup setHidden:NO];
}

- (IBAction)btnCancelled:(id)sender
{
  //  strSelectedPopup=@"Cancelled";
    
   // arrFiled = [aryCan mutableCopy];
    
   // arrFiled = [arrCancelledMain mutableCopy];
    //arrFiledTemp = [arrCancelled mutableCopy];
    
    
    _tblCancelled.hidden = NO;
    _tblPopup.hidden = YES;
    [_viewPopup bringSubviewToFront:_tblCancelled];
    
    [self.tblCancelled reloadData];
    [self.viewPopup setHidden:NO];
}

- (IBAction)btnHiddenPopup:(id)sender
{
    [self.viewPopup setHidden:YES];
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


//self.frostedViewController.direction = REFrostedViewControllerDirectionRight;
//
//if (app.checkview == 0)
//{
//    [self.frostedViewController presentMenuViewController];
//    app.checkview = 1;
//
//}
//else
//{
//    [self.frostedViewController hideMenuViewController];
//    app.checkview = 0;
//}
@end
