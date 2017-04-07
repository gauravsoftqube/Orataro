//
//  AddNoteVc.m
//  orataro
//
//  Created by Softqube Mac IOS on 06/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "AddNoteVc.h"
#import "Global.h"

@interface AddNoteVc ()
{
    UIDatePicker *datePicker;
    UIAlertView *alert;
    
    UIDatePicker *datePickerEnd;
    UIAlertView *alertEnd;
    
    NSMutableArray *arrSubandDiv,*arrSortDesc,*arrSelected_SortDesc;
}
@end

@implementation AddNoteVc
@synthesize aPhoto,aDescTextview,aTitleTextfield,aStandardTextfield,aEnddateTextfield,aShortDescTextfield,aStartdateTextfield,aViewWidth,aViewHeight,aScrollview;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [aScrollview setContentSize:CGSizeMake(self.view.frame.size.width, 2000)];
    [aViewHeight setConstant:700];
    [aViewWidth setConstant:self.view.frame.size.width];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    aTitleTextfield.leftView = paddingView;
    aTitleTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    aStandardTextfield.leftView = paddingView1;
    aStandardTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    aEnddateTextfield.leftView = paddingView2;
    aEnddateTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    aShortDescTextfield.leftView = paddingView3;
    aShortDescTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    aStartdateTextfield.leftView = paddingView4;
    aStartdateTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    aDescTextview.textContainerInset = UIEdgeInsetsMake(10, 17, 0, 0);
    
    [self.tblStd_Div setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tblShortDesc_popup setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    [self.viewStandardANdDevision_popup setHidden:YES];
    [self.viewShortDesc_Popup setHidden:YES];
    arrSelected_SortDesc = [[NSMutableArray alloc]init];
    
    
    
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
    
    [self apiCallFor_getSubDiv];
}

#pragma mark - UTexfield delegate

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (aDescTextview.text.length == 0)
    {
        aDescTextview.text = @"";
        aDescTextview.textColor = [UIColor blackColor];
    }
    if ([aDescTextview.text isEqualToString:@"Description"])
    {
        aDescTextview.text = @"";
        aDescTextview.textColor = [UIColor blackColor];
    }
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(aDescTextview.text.length == 0){
        aDescTextview.textColor = [UIColor lightGrayColor];
        aDescTextview.text = @"Description";
        [aDescTextview resignFirstResponder];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(aDescTextview.text.length == 0){
            aDescTextview.textColor = [UIColor lightGrayColor];
            aDescTextview.text = @"Desciption";
            [aDescTextview resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
}

#pragma mark - apiCall

-(void)apiCallFor_getSubDiv
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        [ProgressHUB hideenHUDAddedTo:self.view];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_gradedivisionsubject,apk_GetGradeDivisionSubjectbyTeacher_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:@"Teacher" forKey:@"Role"];
    
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
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     [self ManageSubjectList:arrResponce];
                     [self apiCallFor_getShortDesc];
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

-(void)apiCallFor_getShortDesc
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_login,apk_GetProjectType_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSLog(@"dic=%@",dicCurrentUser);
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:@"DressCode" forKey:@"Category"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    
    
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
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     arrSortDesc=[[NSMutableArray alloc]init];
                     arrSortDesc = [arrResponce mutableCopy];
                     [self.tblShortDesc_popup reloadData];
                     //  NSLog(@"arra=%@",circularAry);
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

#pragma mark - Manage Group of Subject and Division

-(void)ManageSubjectList : (NSMutableArray *)aryResponse
{
    NSMutableArray *aryTmp = [[NSMutableArray alloc]initWithArray:aryResponse];
    for (int i=0; i< aryTmp.count; i++)
    {
        NSMutableDictionary *d = [[aryTmp objectAtIndex:i] mutableCopy];
        NSString *str = [NSString stringWithFormat:@"%@%@",[d objectForKey:@"Grade"],[d objectForKey:@"Division"]];
        [d setObject:str forKey:@"Group"];
        [aryTmp replaceObjectAtIndex:i withObject:d];
    }
    
    NSArray *temp = [aryTmp sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"Group" ascending:YES]]];
    [aryTmp removeAllObjects];
    [aryTmp addObjectsFromArray:temp];
    
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    for (NSMutableDictionary *dic in aryTmp) {
        NSString *STR=[dic objectForKey:@"Group"];
        if (![[arr valueForKey:@"Group"] containsObject:STR]) {
            [arr addObject:dic];
        }
    }
    NSSortDescriptor *sortIdClient =
    [NSSortDescriptor sortDescriptorWithKey:@"Group"
                                  ascending:YES
                                 comparator: ^(id obj1, id obj2){
                                     
                                     return [obj1 compare:obj2 options:NSOrderedAscending];
                                     
                                 }];
    
    NSArray *sortDescriptors = @[sortIdClient];
    
    NSArray *arrTemp = [arr sortedArrayUsingDescriptors:sortDescriptors];
    
    
    arrSubandDiv=[[NSMutableArray alloc]init];
    arrSubandDiv = [[NSMutableArray alloc]initWithArray:arrTemp];
    [self.tblStd_Div reloadData];
}

#pragma mark - tabelview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tblStd_Div)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubjectCell"];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SubjectCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        
        if (indexPath.row % 2 ==0)
        {
            cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
        }
        else
        {
            cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *lb = (UILabel *)[cell.contentView viewWithTag:1];
        lb.text = [[arrSubandDiv objectAtIndex:indexPath.row]objectForKey:@"Grade"];
        
        UILabel *lb1 = (UILabel *)[cell.contentView viewWithTag:2];
        lb1.text = [[arrSubandDiv objectAtIndex:indexPath.row]objectForKey:@"Division"];
        
        UIButton *btnSelect = (UIButton *)[cell.contentView viewWithTag:4];
        btnSelect.tag = indexPath.row;
        
        UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:3];
        
        NSMutableArray *arySelect = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"SelectAryData"]];
        
        if ([arySelect containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])
        {
            [img setImage:[UIImage imageNamed:@"checkboxblue"]];
        }
        else
        {
            [img setImage:[UIImage imageNamed:@"checkboxunselected"]];
        }
        
        return cell;
    }
    if (tableView == _tblShortDesc_popup)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_shortdesc"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        NSString *strName=[[arrSortDesc objectAtIndex:indexPath.row]objectForKey:@"Term"];
        UILabel *lblName = (UILabel *)[cell.contentView viewWithTag:1];
        lblName.text=[strName capitalizedString];
        
        UIButton *btn=(UIButton*)[cell.contentView viewWithTag:2];
        [btn setImage:[UIImage imageNamed:@"radiop"] forState:UIControlStateNormal];
        
        NSMutableDictionary *dic=[[arrSortDesc objectAtIndex:indexPath.row]mutableCopy];
        if([arrSelected_SortDesc containsObject:dic])
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tblStd_Div)
    {
        return 59;
    }
    if (tableView == _tblShortDesc_popup)
    {
        return 44;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tblStd_Div)
    {
        if (arrSubandDiv.count > 0)
        {
            return arrSubandDiv.count;
        }
    }
    if (tableView == self.tblShortDesc_popup)
    {
        return [arrSortDesc count];
    }
    return 5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tblStd_Div)
    {
        [self.viewStandardANdDevision_popup setHidden:YES];
    }
    if (tableView == self.tblShortDesc_popup)
    {
        NSString *str=[[arrSortDesc objectAtIndex:indexPath.row]objectForKey:@"Term"];
        self.aShortDescTextfield.text=[str capitalizedString];
        NSMutableDictionary *dic=[[arrSortDesc objectAtIndex:indexPath.row]mutableCopy];
        [arrSelected_SortDesc removeAllObjects];
        [arrSelected_SortDesc addObject:dic];
        [self.tblShortDesc_popup reloadData];
        
        [self.viewShortDesc_Popup setHidden:YES];
    }
}

- (IBAction)btnRadio_ShortDesc:(id)sender {
    //
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblShortDesc_popup];
    NSIndexPath *indexPath = [self.tblShortDesc_popup indexPathForRowAtPoint:buttonPosition];
    
    NSString *str=[[arrSortDesc objectAtIndex:indexPath.row]objectForKey:@"Term"];
    self.aShortDescTextfield.text=[str capitalizedString];
    
    NSMutableDictionary *dic=[[arrSortDesc objectAtIndex:indexPath.row]mutableCopy];
    [arrSelected_SortDesc removeAllObjects];
    [arrSelected_SortDesc addObject:dic];
    [self.tblShortDesc_popup reloadData];
    
}
- (IBAction)btnCancelShortDesc:(id)sender {
    [self.viewShortDesc_Popup setHidden:YES];
}

- (IBAction)btnCell_StdandDiv:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblStd_Div];
    NSIndexPath *indexPath = [self.tblStd_Div indexPathForRowAtPoint:buttonPosition];
    
    NSMutableArray *aryTemp=[[NSMutableArray alloc]init];
    aryTemp = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"SelectAryData"]];
    
    if ([aryTemp containsObject:[NSString stringWithFormat:@"%ld",indexPath.row]])
    {
        [aryTemp removeObject:[NSString stringWithFormat:@"%ld",indexPath.row]];
    }
    else
    {
        [aryTemp addObject:[NSString stringWithFormat:@"%ld",indexPath.row]];
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:aryTemp forKey:@"SelectAryData"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [self.tblStd_Div reloadData];
}


#pragma mark - ActionSheet delegates

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( buttonIndex == 0 )
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *pickerView =[[UIImagePickerController alloc]init];
            pickerView.allowsEditing = YES;
            pickerView.delegate = self;
            pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentModalViewController:pickerView animated:true];
        }
    }
    else if( buttonIndex == 1)
    {
        UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
        pickerView.allowsEditing = YES;
        pickerView.delegate = self;
        [pickerView setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentModalViewController:pickerView animated:YES];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //  [self dismissModalViewControllerAnimated:true];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage * img = [info valueForKey:UIImagePickerControllerEditedImage];
    [aPhoto setBackgroundImage:img forState:UIControlStateNormal];
    // PostImageView.image = img;
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
            self.aStartdateTextfield.text = theDate;
        }
        
    }
    if (alertView.tag == 112)
    {
        if (buttonIndex == 0)
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
            self.aEnddateTextfield.text = theDate;
        }
        
    }

}

#pragma mark - Button Action

- (IBAction)BackBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SelectPhotoBtnClicked:(id)sender
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Add Photo!" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose from Liabrary", nil];
    
    [action showInView:self.view];
}

- (IBAction)btnStandardDevision:(id)sender {
    [self.viewStandardANdDevision_popup setHidden:NO];
}

- (IBAction)btnShortDescText:(id)sender {
    [self.viewShortDesc_Popup setHidden:NO];
}

- (IBAction)btnStartDate:(id)sender {
    [self.view endEditing:YES];
    [datePicker setDate:[NSDate date]];
    [alert show];
}

- (IBAction)btnEndDate:(id)sender {
    [self.view endEditing:YES];
    [datePickerEnd setDate:[NSDate date]];
    [alertEnd show];

}



- (IBAction)btnCancel_StdandDiv:(id)sender {
    [self.viewStandardANdDevision_popup setHidden:YES];
}

- (IBAction)btnDone_StdandDiv:(id)sender {
    NSMutableArray *strStandard = [[NSMutableArray alloc]init];
    
    NSMutableArray *aryGet = [[NSUserDefaults standardUserDefaults]valueForKey:@"SelectAryData"];
    
    for (int i=0; i<arrSubandDiv.count; i++)
    {
        if ([aryGet containsObject:[NSString stringWithFormat:@"%d",i]])
        {
            [strStandard addObject:[arrSubandDiv objectAtIndex:i]];
        }
    }
    
    NSMutableArray *arySet = [[NSMutableArray alloc]init];
    
    for(int i=0 ; i<strStandard.count;i++)
    {
        [arySet addObject:[NSString stringWithFormat:@"%@-%@",[[strStandard objectAtIndex:i]objectForKey:@"Grade"],[[strStandard objectAtIndex:i]objectForKey:@"Division"]]];
    }
    
    NSString *strTableColumn = [arySet componentsJoinedByString:@","];
    [[NSUserDefaults standardUserDefaults]setObject:strTableColumn forKey:@"setStandard"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    self.aStandardTextfield.text = strTableColumn;
    [self.viewStandardANdDevision_popup setHidden:YES];
}
@end
