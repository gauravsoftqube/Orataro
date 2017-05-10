//
//  CreateProjectVc.m
//  orataro
//
//  Created by Softqube on 13/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "CreateProjectVc.h"
#import "Global.h"

@interface CreateProjectVc ()
{
    UIDatePicker *datePicker;
    UIAlertView *alert;
    NSString *strCheckStartEnd;
    NSMutableArray *aryStandard,*aryDivision,*aryStudentList;
    NSMutableDictionary *tempStoreDivision;
    NSMutableArray *arySetStudentNameList,*arySetTeacherNameList;
    NSString *strStudentTeacher;
    NSMutableArray *aryTempStu;
    NSMutableArray *aryEditTableList;
    NSMutableArray *aryStudentMemberID,*aryTeacherStudentID;
}
@end

@implementation CreateProjectVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //  aryStandard = [[NSMutableArray alloc]init];
    
    aryStudentMemberID = [[NSMutableArray alloc]init];
    aryTeacherStudentID = [[NSMutableArray alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:_txtSearchTextfield];
    
    aryDivision = [[NSMutableArray alloc]init];
    
    _tblDivision.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    // Do any additional setup after loading the view.
    [self commonData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    [Utility setLeftViewInTextField:self.txtProjectTitle imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtStartDate imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtEndDate imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtSelectProjectStudents imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtProjectMemberTeacher imageName:@"" leftSpace:0 topSpace:0 size:5];
    
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
    
    [self apiCallFor_getStandard];
    
    if ([_projectvar isEqualToString:@"Edit"])
    {
        _aHeaderTitleLb.text =@"Edit Project (Name)";
        
        _txtProjectTitle.text = [_dicCreateProject objectForKey:@"ProjectTitle"];
        _txtStartDate.text = [Utility convertMiliSecondtoDate:@"dd-MM-yyyy" date:[_dicCreateProject objectForKey:@"StartDate"]];
        
        _txtEndDate.text = [Utility convertMiliSecondtoDate:@"dd-MM-yyyy" date:[_dicCreateProject objectForKey:@"EndDate"]];
        
        [self api_getEditList:_dicCreateProject];
        
    }
    else
    {
        self.tblEditProjectMemberList_Height.constant=0;
        _aHeaderTitleLb.text =@"Create Project (Name)";
    }
    
    
}

#pragma mark - tableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tblStandard)
    {
        return aryStandard.count;
    }
    if (tableView == _tblDivision)
    {
        return aryDivision.count;
    }
    if (tableView == _tblStudentGroupMember)
    {
        return aryStudentList.count;
    }
    if (tableView == _tblEditProjectMemberList)
    {
        return aryEditTableList.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tblStandard)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StandardCell"];
        
        UILabel *lblStatus=(UILabel *)[cell.contentView viewWithTag:1];
        lblStatus.text = [[aryStandard objectAtIndex:indexPath.row]objectForKey:@"GradeName"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    if (tableView == _tblDivision)
    {
        //DivisionCell
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DivisionCell"];
        
        UILabel *lblStatus=(UILabel *)[cell.contentView viewWithTag:1];
        lblStatus.text = [[aryDivision objectAtIndex:indexPath.row]objectForKey:@"DivisionName"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    if (tableView == _tblStudentGroupMember)
    {
        
        NSLog(@"student=%@",aryStudentList);
        
        //cellStudentListName
        
        //imageview tag : 2
        
        // lable tag = 1:
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellStudentListName"];
        
        UILabel *lblStatus=(UILabel *)[cell.contentView viewWithTag:1];
        
        lblStatus.text = [[aryStudentList objectAtIndex:indexPath.row]objectForKey:@"FullName"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *img=(UIImageView *)[cell.contentView viewWithTag:2];
        if ([[[aryStudentList objectAtIndex:indexPath.row]objectForKey:@"SetUntick"] isEqualToString:@"0"])
        {
            [img setImage:[UIImage new]];
        }
        else
        {
            [img setImage:[UIImage imageNamed:@"tick_sky_blue"]];
        }
        
        
        return cell;
        
    }
    if (tableView == _tblEditProjectMemberList)
    {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        UIImageView *img=(UIImageView *)[cell.contentView viewWithTag:2];
        [img.layer setBorderColor:[UIColor colorWithRed:34/255.0f green:49/255.0f blue:89/255.0f alpha:1.0f].CGColor];
        [img.layer setBorderWidth:1.0f];
        
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[[aryEditTableList objectAtIndex:indexPath.row]objectForKey:@"ProfilePicture"]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            NSLog(@"img");
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *lblName=(UILabel *)[cell.contentView viewWithTag:3];
        lblName.text = [[aryEditTableList objectAtIndex:indexPath.row]objectForKey:@"MemberFullName"];
        
        UILabel *lblStatus=(UILabel *)[cell.contentView viewWithTag:4];
        lblStatus.text = [[aryEditTableList objectAtIndex:indexPath.row]objectForKey:@"MemberRole"];
        
        UIButton *btnRemove=(UIButton *)[cell.contentView viewWithTag:5];
        [btnRemove.layer setCornerRadius:4];
        btnRemove.clipsToBounds=YES;
        
        return cell;
        
    }
    
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tblStandard)
    {
        _viewSelectStandard.hidden = YES;
        _viewSelectDivision.hidden = NO;
        [self.view bringSubviewToFront:_viewSelectDivision];
        [self apiCallFor_getDivision:[aryStandard objectAtIndex:indexPath.row]];
        tempStoreDivision = [aryStandard objectAtIndex:indexPath.row];
    }
    if (tableView == _tblDivision)
    {
        [aryStudentList removeAllObjects];
        
        strStudentTeacher = @"Student";
        
        _viewSelectDivision.hidden = YES;
        _viewStudentGroupMember.hidden = NO;
        
        [self.view bringSubviewToFront:_viewStudentGroupMember];
        
        [self apiCallFor_getStudentGroup:[aryDivision objectAtIndex:indexPath.row] :tempStoreDivision];
        
    }
    if (tableView == _tblStudentGroupMember)
    {
        if ([[[aryStudentList objectAtIndex:indexPath.row]objectForKey:@"SetUntick"] isEqualToString:@"0"])
        {
            NSMutableDictionary *d = [[aryStudentList objectAtIndex:indexPath.row]mutableCopy];
            [d setValue:@"1" forKey:@"SetUntick"];
            
            [aryStudentList replaceObjectAtIndex:indexPath.row withObject:d];
            
            [_tblStudentGroupMember reloadData];
        }
        else
        {
            NSMutableDictionary *d = [[aryStudentList objectAtIndex:indexPath.row]mutableCopy];
            [d setValue:@"0" forKey:@"SetUntick"];
            
            [aryStudentList replaceObjectAtIndex:indexPath.row withObject:d];
            
            [_tblStudentGroupMember reloadData];
        }
    }
}

#pragma mark -  Date Picker Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 111)
    {
        if (buttonIndex == 0)
        {
            if ([strCheckStartEnd isEqualToString:@"Start"])
            {
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"dd-MM-yyyy"];
                NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
                _txtStartDate.text = theDate;
            }
            else
            {
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"dd-MM-yyyy"];
                NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
                _txtEndDate.text = theDate;
                
            }
        }
        if (buttonIndex == 1)
        {
            alert.hidden = YES;
        }
    }
}


#pragma mark - textfield delegate

- (void)textFieldDidChange:(NSNotification *)notification
{
    // Do whatever you like to respond to text changes here.
    
    if (_txtSearchTextfield.text.length == 0)
    {
        aryStudentList = [[NSMutableArray alloc]initWithArray:aryTempStu];
        
        [_tblStudentGroupMember reloadData];
    }
    else
    {
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.FullName contains[cd] %@",_txtSearchTextfield.text];
        NSArray *filteredArray = [aryStudentList filteredArrayUsingPredicate:bPredicate];
        
        aryStudentList = [[NSMutableArray alloc]initWithArray:filteredArray];
        [_tblStudentGroupMember reloadData];
    }
    
}


#pragma mark - button action

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnRemoveClicked:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblEditProjectMemberList];
    NSIndexPath *indexPath = [self.tblEditProjectMemberList indexPathForRowAtPoint:buttonPosition];
    
    [self api_removeGroupMember:[aryEditTableList objectAtIndex:indexPath.row]];
    
}

- (IBAction)btnDoneClicked:(id)sender
{
    //Project Member Teacher
    
    //  strStudentTeacher = @"Student";
    //strStudentTeacher = @"Teacher";
    
    //aryStudentMemberID = [[NSMutableArray alloc]init];
    //aryTeacherStudentID = [[NSMutableArray alloc]init];
    
    if ([strStudentTeacher isEqualToString:@"Student"])
    {
        arySetStudentNameList  = [[NSMutableArray alloc]init];
        
        for (NSMutableDictionary *dic in aryStudentList)
        {
            NSLog(@"Dic=%@",dic);
            
            if ([[dic valueForKey:@"SetUntick"] isEqualToString:@"1"])
            {
                NSString *str = [NSString stringWithFormat:@"%@",[dic valueForKey:@"FullName"]];
                [arySetStudentNameList addObject:str];
                [aryStudentMemberID addObject:[dic objectForKey:@"MemberID"]];
            }
        }
        NSString *strTableColumn = [arySetStudentNameList componentsJoinedByString:@","];
        
        if(aryStudentList.count == 0)
        {
            _lbSelectStudent.text = @"Select Project Students";
        }
        else
        {
            _lbSelectStudent.text = strTableColumn;
            
            CGSize size = [strTableColumn sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:14] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-30, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
            
            [_LbProjectStudentHeight setConstant:size.height+20];
        }
        
    }
    else
    {
        arySetTeacherNameList  = [[NSMutableArray alloc]init];
        
        for (NSMutableDictionary *dic in aryStudentList)
        {
            NSLog(@"Dic=%@",dic);
            
            if ([[dic valueForKey:@"SetUntick"] isEqualToString:@"1"])
            {
                NSString *str = [NSString stringWithFormat:@"%@",[dic valueForKey:@"FullName"]];
                [arySetTeacherNameList addObject:str];
                [aryTeacherStudentID addObject:[dic objectForKey:@"MemberID"]];
            }
        }
        NSString *strTableColumn = [arySetTeacherNameList componentsJoinedByString:@","];
        
        if(aryStudentList.count == 0)
        {
            _lbSelectTeacher.text = @"Project Member Teacher";
        }
        else
        {
            _lbSelectTeacher.text = strTableColumn;
            
            CGSize size = [strTableColumn sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:14] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-30, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
            
            [_LbSelectTeacherHeight setConstant:size.height+20];
        }
        
    }
    _viewStudentGroupMember.hidden = YES;
}

- (IBAction)btnEndDateClicked:(id)sender
{
    strCheckStartEnd = @"End";
    [alert show];
}

- (IBAction)btnStartDateClicked:(id)sender
{
    strCheckStartEnd = @"Start";
    [alert show];
}

- (IBAction)btnCancelClicked:(id)sender
{
    //  [_viewStudentGroupMember removeFromSuperview];
    _viewStudentGroupMember.hidden = YES;
    
}
- (IBAction)btnSelectTeacherMember:(id)sender
{
    strStudentTeacher = @"Teacher";
    [aryStudentList removeAllObjects];
    _viewSelectDivision.hidden = YES;
    _viewStudentGroupMember.hidden = NO;
    
    [self.view bringSubviewToFront:_viewStudentGroupMember];
    [self api_getTeacherList];
    
}

- (IBAction)btnSelectStudentMember:(id)sender
{
    _viewSelectStandard.hidden = NO;
    [self.view bringSubviewToFront:_viewSelectStandard];
}

- (IBAction)btnSumbit:(id)sender
{
    //  if ([_projectvar isEqualToString:@"Edit"])
    //  {
    
    //  }
    // else
    // {
    NSLog(@"Data  =%@",_txtProjectTitle.text);
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    if ([Utility validateBlankField:self.txtProjectTitle.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:CIRCULAR_TITLE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    if ([Utility validateBlankField:self.txtStartDate.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Select_Start_Date delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    if ([Utility validateBlankField:self.txtEndDate.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Select_End_Date delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    if ([Utility validateBlankField:_txtProjectDefination.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please enter project defination."  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    if ([_lbSelectStudent.text isEqualToString:@"Select Project Students"])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:STUDENTGROUP delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    if ([_lbSelectTeacher.text isEqualToString:@"Project Member Teacher"])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:TEACHERGROUP delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    [self api_createProject];
    //}
}

#pragma mark - Call api get Standard

-(void)apiCallFor_getStandard
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        [ProgressHUB hideenHUDAddedTo:self.view];
        return;
    }
    
    //apk_gradedivisionsubject
    //apk_GetGradeDivisionSubject
    
    //    <GradeID>guid</GradeID>
    //    <DivisionID>guid</DivisionID>
    //    <SubjectID>guid</SubjectID>
    //    <InstituteID>guid</InstituteID>
    //    <ClientID>guid</ClientID>
    //    <TeacherID>guid</TeacherID>
    //    <Type>string</Type>
    
    //    public static final String STANDERD_WSCALL_TYPE_GRADE = "Grade";
    //    public static final String STANDERD_WSCALL_TYPE_DIVISION = "Division";
    //    public static final String STANDERD_WSCALL_TYPE_SUBJECT = "Subject";
    
    //aryStandard
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_gradedivisionsubject,apk_GetGradeDivisionSubject];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    // NSLog(@"dic=%@",dicCurrentUser);
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:@"" forKey:@"GradeID"];
    [param setValue:@"" forKey:@"DivisionID"];
    [param setValue:@"" forKey:@"SubjectID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"TeacherID"];
    [param setValue:@"Grade" forKey:@"Type"];
    
    [ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             // NSLog(@"data=%@",dicResponce);
             
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             //NSLog(@"array=%@",arrResponce);
             
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
                     aryStandard = [[NSMutableArray alloc]initWithArray:arrResponce];
                     [_tblStandard reloadData];
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



#pragma mark - Call api get Division

-(void)apiCallFor_getDivision : (NSMutableDictionary *)dic
{
    NSLog(@"Dic=%@",dic);
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        [ProgressHUB hideenHUDAddedTo:self.view];
        return;
    }
    
    //apk_gradedivisionsubject
    //apk_GetGradeDivisionSubject
    
    //    <GradeID>guid</GradeID>
    //    <DivisionID>guid</DivisionID>
    //    <SubjectID>guid</SubjectID>
    //    <InstituteID>guid</InstituteID>
    //    <ClientID>guid</ClientID>
    //    <TeacherID>guid</TeacherID>
    //    <Type>string</Type>
    
    //    public static final String STANDERD_WSCALL_TYPE_GRADE = "Grade";
    //    public static final String STANDERD_WSCALL_TYPE_DIVISION = "Division";
    //    public static final String STANDERD_WSCALL_TYPE_SUBJECT = "Subject";
    
    //aryStandard
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_gradedivisionsubject,apk_GetGradeDivisionSubject];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    // NSLog(@"dic=%@",dicCurrentUser);
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"GradeID"]] forKey:@"GradeID"];
    [param setValue:@"" forKey:@"DivisionID"];
    [param setValue:@"" forKey:@"SubjectID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"TeacherID"];
    [param setValue:@"Division" forKey:@"Type"];
    
    [ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             // NSLog(@"data=%@",dicResponce);
             
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             //NSLog(@"array=%@",arrResponce);
             
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
                     aryDivision = [[NSMutableArray alloc]initWithArray:arrResponce];
                     [_tblDivision reloadData];
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


#pragma mark - Call api get StudentGroup

-(void)apiCallFor_getStudentGroup : (NSMutableDictionary *)dicDivision : (NSMutableDictionary *)dicStandard
{
    NSLog(@"Dic=%@",dicDivision);
    
    NSLog(@"Dic1=%@",dicStandard);
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        [ProgressHUB hideenHUDAddedTo:self.view];
        return;
    }
    
    //#define apk_friends @"apk_friends.asmx"
    //#define apk_GetStudentsListNameAndMemberID @"GetStudentsListNameAndMemberID"
    
    
    //    <InstituteID>guid</InstituteID>
    //    <ClientID>guid</ClientID>
    //    <GradeID>guid</GradeID>
    //    <DivisionID>guid</DivisionID>
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_friends,apk_GetStudentsListNameAndMemberID];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    // NSLog(@"dic=%@",dicCurrentUser);
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicDivision objectForKey:@"DivisionID"]] forKey:@"DivisionID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicStandard objectForKey:@"GradeID"]] forKey:@"GradeID"];
    
    [ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             // NSLog(@"data=%@",dicResponce);
             
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             //NSLog(@"array=%@",arrResponce);
             
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
                     aryStudentList = [[NSMutableArray alloc]initWithArray:arrResponce];
                     
                     NSMutableArray *aryTempSave = [[NSMutableArray alloc]init];
                     
                     for (NSMutableDictionary *dic in aryStudentList)
                     {
                         NSMutableDictionary *d = [[NSMutableDictionary alloc]initWithDictionary:dic];
                         [d setValue:@"0" forKey:@"SetUntick"];
                         [aryTempSave addObject:d];
                     }
                     aryStudentList = [[NSMutableArray alloc]initWithArray:aryTempSave];
                     aryTempStu = [[NSMutableArray alloc]initWithArray:aryTempSave];
                     
                     [_tblStudentGroupMember reloadData];
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

#pragma mark - Call api get TeacherGroup

-(void)api_getTeacherList
{
    //  strStudentTeacher = @"Student";
    //strStudentTeacher = @"Teacher";
    //apk_GetTeacherListNameAndMemberID
    // <InstituteID>guid</InstituteID>
    // <ClientID>guid</ClientID>
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        [ProgressHUB hideenHUDAddedTo:self.view];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_friends,apk_GetTeacherListNameAndMemberID];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    // NSLog(@"dic=%@",dicCurrentUser);
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    
    [ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             // NSLog(@"data=%@",dicResponce);
             
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             //NSLog(@"array=%@",arrResponce);
             
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
                     aryStudentList = [[NSMutableArray alloc]initWithArray:arrResponce];
                     
                     NSMutableArray *aryTempSave = [[NSMutableArray alloc]init];
                     
                     for (NSMutableDictionary *dic in aryStudentList)
                     {
                         NSMutableDictionary *d = [[NSMutableDictionary alloc]initWithDictionary:dic];
                         [d setValue:@"0" forKey:@"SetUntick"];
                         [aryTempSave addObject:d];
                     }
                     aryStudentList = [[NSMutableArray alloc]initWithArray:aryTempSave];
                     
                     aryTempStu = [[NSMutableArray alloc]initWithArray:aryTempSave];
                     
                     [_tblStudentGroupMember reloadData];
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

#pragma mark - Call api Create Project

-(void)api_createProject
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    //aryTeacherStudentID
    // aryStudentMemberID
    
    NSString *strStartDate = [Utility convertDateFtrToDtaeFtr:@"dd-MM-yyyy" newDateFtr:@"MM-dd-yyyy" date:_txtStartDate.text];
    
    //[Utility convertDatetoSpecificDate:_txtStartDate.text date:@"MM-dd-yyyy"];
    
    NSString *strEndDate = [Utility convertDateFtrToDtaeFtr:@"dd-MM-yyyy" newDateFtr:@"MM-dd-yyyy" date:_txtEndDate.text];
    
    NSString *strStuID = [aryStudentMemberID componentsJoinedByString:@","];
    NSString *strTeacherID = [aryTeacherStudentID componentsJoinedByString:@","];
    
    NSString *joinStr = [NSString stringWithFormat:@"%@,%@",strStuID,strTeacherID];
    
    // NSLog(@"sddsdsd");
    
    
    //    if ([_projectvar isEqualToString:@"Edit"])
    //    {
    //
    //    }
    //    else
    //    {
    //
    //    }
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_projects,apk_saveupdateproject_action];
    
    //#define apk_projects @"apk_projects.asmx"
    
    //#define apk_saveupdateproject_action @"saveupdateproject"
    
    //    <ProjectID>guid</ProjectID>
    //    <InstituteID>guid</InstituteID>
    //    <ClientID>guid</ClientID>
    //    <WallID>guid</WallID>
    //    <UserID>guid</UserID>
    //    <MemberID>guid</MemberID>
    //    <BeachID>guid</BeachID>
    
    //    <projectstartdate>string</projectstartdate>
    //    <projectenddate>string</projectenddate>
    //    <projecttitle>string</projecttitle>
    //    <projectdefinetion>string</projectdefinetion>
    //    <projectscope>string</projectscope>
    //    <groupmembers>string</groupmembers>
    
    if ([_projectvar isEqualToString:@"Edit"])
    {
        [param setValue:[_dicCreateProject objectForKey:@"ProjectID"] forKey:@"ProjectID"];
        
        
    }
    else
    {
        [param setValue:@"" forKey:@"ProjectID"];
    }
    
    
    [param setValue:[dicCurrentUser objectForKey:@"InstituteID"] forKey:@"InstituteID"];
    [param setValue:[dicCurrentUser objectForKey:@"ClientID"] forKey:@"ClientID"];
    [param setValue:[dicCurrentUser objectForKey:@"WallID"] forKey:@"WallID"];
    [param setValue:[dicCurrentUser objectForKey:@"UserID"] forKey:@"UserID"];
    [param setValue:[dicCurrentUser objectForKey:@"MemberID"] forKey:@"MemberID"];
    [param setValue:[dicCurrentUser objectForKey:@"BatchID"] forKey:@"BeachID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",strStartDate] forKey:@"projectstartdate"];
    [param setValue:[NSString stringWithFormat:@"%@",strEndDate] forKey:@"projectenddate"];
    [param setValue:_txtProjectTitle.text forKey:@"projecttitle"];
    [param setValue:_txtProjectDefination.text forKey:@"projectdefinetion"];
    [param setValue:[dicCurrentUser objectForKey:@"InstituteID"]  forKey:@"projectscope"];
    [param setValue:joinStr  forKey:@"groupmembers"];
    
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
                 if([strStatus isEqualToString:@"Record save successfully"])
                 {
                    // UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    // [alrt show];
                     
                     for (UIViewController *controller in self.navigationController.viewControllers)
                     {
                         if ([controller isKindOfClass:[ProjectVc class]])
                         {
                             [self.navigationController popToViewController:controller animated:YES];
                             
                             break;
                         }
                     }
                     
                 }
                 else if([strStatus isEqualToString:@"Record update successfully"])
                 {
                    // UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    // [alrt show];
                     
                     for (UIViewController *controller in self.navigationController.viewControllers)
                     {
                         if ([controller isKindOfClass:[ProjectVc class]])
                         {
                             [self.navigationController popToViewController:controller animated:YES];
                             
                             break;
                         }
                     }
                     
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


#pragma mark - Call api Edit Group

-(void)api_getEditList : (NSMutableDictionary *)dic
{
    NSLog(@"Dic=%@",dic);
    
    //aryEditTableList
    // NSLog(@"Data=%@",_dicCreateProject);
    //#define apk_projects @"apk_projects.asmx"
    //
    //#define apk_GetProjectList_action  @"GetProjectList"
    //#define apk_PrjectDataByID_action  @"PrjectDataByID"
    
    //ProjectID=b8b8fa8d-3a35-4a68-9a55-0b4f64f05ab9
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        [ProgressHUB hideenHUDAddedTo:self.view];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_projects,apk_PrjectDataByID_action];
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%@",[dic objectForKey:@"ProjectID"]] forKey:@"ProjectID"];
    
    
    [ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if (!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableDictionary *dicResponce = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]mutableCopy];
             
             if([dicResponce count] != 0)
             {
                 NSString *strStatus=[[dicResponce objectForKey:@"message"]mutableCopy];
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dicResponce objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     NSMutableArray *arrTable=[[dicResponce objectForKey:@"Table"]mutableCopy];
                     
                     if([arrTable count] != 0)
                     {
                         NSMutableDictionary *dic=[arrTable objectAtIndex:0];
                         _txtProjectDefination.text=[[dic objectForKey:@"ProjectDefination"]capitalizedString];
                         
                     }
                     
                     NSMutableArray *arrTable1=[[dicResponce objectForKey:@"Table1"]mutableCopy];
                     if([arrTable1 count] != 0)
                     {
                         aryEditTableList=[[NSMutableArray alloc]init];
                         aryEditTableList = [arrTable1 mutableCopy];
                         [_tblEditProjectMemberList_Height setConstant:105*aryEditTableList.count];
                         [_tblEditProjectMemberList reloadData];
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

#pragma mark - Call api Remove Group member

-(void)api_removeGroupMember : (NSMutableDictionary *)dic
{
    
    //#define apk_projects @"apk_projects.asmx"
    //#define apk_RemoveProjectGroupMembers @"RemoveProjectGroupMembers"
    
    NSLog(@"Dic=%@",dic);
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        [ProgressHUB hideenHUDAddedTo:self.view];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_projects,apk_RemoveProjectGroupMembers];
    
    //    <GropuMemberID>guid</GropuMemberID>
    //    <MemberID>guid</MemberID>
    //    <BeachID>guid</BeachID>
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[dic objectForKey:@"GropuMemberID"] forKey:@"GropuMemberID"];
    [param setValue:[dic objectForKey:@"MemberID"] forKey:@"MemberID"];
    [param setValue:[dicCurrentUser objectForKey:@"BatchID"] forKey:@"BeachID"];
    
    [ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if (!error)
         {
             
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[dic objectForKey:@"message"];
                 if([strStatus isEqualToString:@"Record delete successfully"])
                 {
                     [self api_getEditList:_dicCreateProject];
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

@end
