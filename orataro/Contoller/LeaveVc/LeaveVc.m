//
//  LeaveVc.m
//  orataro
//
//  Created by Softqube on 13/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "LeaveVc.h"
#import "Global.h"

@interface LeaveVc ()
{
    NSMutableArray *aryStatusAry;
    NSString *strSetPreApplication;
}
@end

@implementation LeaveVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    aryStatusAry = [[NSMutableArray alloc]initWithObjects:@"Approved",@"Reject",@"Pending", nil];
    
    _viewLeaveStatus.hidden = YES;
    [self commonData];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tblLeaveStatus.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    strSetPreApplication =@"0";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"Data=%@",_dicAddLeave);
    
    NSLog(@"Dat=%@",_dicLeaveDetails);
    
    _lblFullName.text = [_dicAddLeave objectForKey:@"ApplicationBY"];
    _lblSubTitleName.text = [_dicAddLeave objectForKey:@"ReasonForLeave"];
    
    NSString *str = [_dicAddLeave objectForKey:@"ApplicationBY"];
    
    NSArray *ary = [str componentsSeparatedByString:@""];
    
    _lblApplicationBy.text = [ary objectAtIndex:0] ;
    
    // NSString *StartDate=[Utility convertMiliSecondtoDate:@"MM-dd-yyyy" date:[dicPoll objectForKey:@"StartDate"]];
    
    _lblApprovedOn.text = [Utility convertMiliSecondtoDate:@"dd-MM-yyyy" date:[_dicAddLeave objectForKey:@"ApprovedOn"]];
    
    _lblStartDate.text = [Utility convertMiliSecondtoDate:@"dd-MM-yyyy" date:[_dicAddLeave objectForKey:@"StartDate"]];
    
    _lblEndDate.text = [Utility convertMiliSecondtoDate:@"dd-MM-yyyy" date:[_dicAddLeave objectForKey:@"EndDate"]];
    
    _lblTeacherName.text = [_dicAddLeave objectForKey:@"TeacherName"];
    
    _lblApplicationDate.text = [Utility convertMiliSecondtoDate:@"dd-MM-yyyy" date:[_dicAddLeave objectForKey:@"DateOfApplication"]];
    
    BOOL checkPerApplication = [_dicAddLeave objectForKey:@"IsPerApplication"];
    
    if (checkPerApplication == YES)
    {
        [_btnPreApplication setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
        checkPerApplication = NO;
    }
    else
    {
        [_btnPreApplication setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
        checkPerApplication = YES;
    }
    
    NSDate *date1 = [NSDate date];
    
    NSString *dateStr = [Utility convertMiliSecondtoDate:@"dd-MM-yyyy" date:[_dicAddLeave objectForKey:@"StartDate"]];
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSDate *date2 = [dateFormat dateFromString:dateStr];
    
    if ([date1 compare:date2] == NSOrderedDescending)
    {
        NSLog(@"date1 is later than date2");
        // _btnSubmit.hidden = YES;
    }
    else if ([date1 compare:date2] == NSOrderedAscending)
    {
        NSLog(@"date1 is earlier than date2");
        // _btnSubmit.hidden = NO;
    }
    else
    {
        NSLog(@"dates are the same");
        // _btnSubmit.hidden = NO;
    }
    
}

- (void)viewDidLayoutSubviews
{
    [_txtViewNote setContentOffset:CGPointZero animated:NO];
}

-(void)commonData
{
    
}

#pragma mark - tableview delegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return aryStatusAry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeaveCell"];
    
    if (cell ==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LeaveCell"];
    }
    
    UILabel *lb= (UILabel *)[cell.contentView viewWithTag:2];
    lb.text = [aryStatusAry objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _lblLeaveStatus.text = [aryStatusAry objectAtIndex:indexPath.row];
    _viewLeaveStatus.hidden =YES;
}
#pragma mark - button action

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnPreApplication:(id)sender
{
    //checkboxblue
    //checkboxunselected
    UIImage* checkImage = _btnPreApplication.currentImage;
    UIImage* checkImage1 = [UIImage imageNamed:@"checkboxblue"];
    NSData *checkImageData = UIImagePNGRepresentation(checkImage);
    NSData *propertyImageData = UIImagePNGRepresentation(checkImage1);
    
    if ([checkImageData isEqualToData:propertyImageData])
    {
        strSetPreApplication =@"0";
        [_btnPreApplication setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
    }
    else
    {
        strSetPreApplication =@"1";
        [_btnPreApplication setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
    }
}
- (IBAction)btnSubmit:(id)sender
{
    [self apk_saveLeave:YES];
}
- (IBAction)btnpendClicked:(id)sender
{
    _viewLeaveStatus.hidden = NO;
    [self.view bringSubviewToFront:_viewLeaveStatus];
}

#pragma mark - call API

-(void)apk_saveLeave : (BOOL)checkProgress
{
    
    
    //#define apk_SaveUpdateTodos_action  @"SaveUpdateTodos"
    //#define apk_leave @"apk_leave.asmx"
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:                            nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_leave,apk_SaveUpdateTodos_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
   // 8733884646 
    //qwerty/123456
    
    //    <UserID>guid</UserID>
    //    <ClientID>guid</ClientID>
    //    <InstituteID>guid</InstituteID>
    //    <MemberID>guid</MemberID>
    //    <GradeID>guid</GradeID>
    //    <DivisionID>guid</DivisionID>
    //    <StartDate>string</StartDate>
    //    <EndDate>string</EndDate>
    //    <SchoolLeaveNoteID>guid</SchoolLeaveNoteID>
    //    <PostByType>string</PostByType>
    //    <TeacherID>guid</TeacherID>
    //    <IsPreApplication>boolean</IsPreApplication>
    //    <ReasonForLeave>string</ReasonForLeave>
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];

    if([[dicCurrentUser objectForKey:@"MemberType"] isEqualToString:@"Student"])
    {
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"DivisionID"]] forKey:@"DivisionID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"GradeID"]] forKey:@"GradeID"];
    }
    else
    {
        
        [param setValue:[NSString stringWithFormat:@"%@",[_dicLeaveDetails objectForKey:@"DivisionID"]] forKey:@"DivisionID"];
        
        [param setValue:[NSString stringWithFormat:@"%@",[_dicLeaveDetails objectForKey:@"GradeID"]] forKey:@"GradeID"];
        
        
    }
    [param setValue:_lblStartDate.text forKey:@"StartDate"];
    
    [param setValue:_lblEndDate.text forKey:@"EndDate"];

    [param setValue:[_dicAddLeave objectForKey:@"SchoolLeaveNoteID"] forKey:@"SchoolLeaveNoteID"];
    
    [param setValue:[dicCurrentUser objectForKey:@"PostByType"] forKey:@"PostByType"];

     [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"TeacherID"];
    
    [param setValue:[NSNumber numberWithBool:strSetPreApplication] forKey:@"IsPreApplication"];
    
    [param setValue:[_dicAddLeave objectForKey:@"ReasonForLeave"] forKey:@"ReasonForLeave"];
    
    
    // <PostByType>string</PostByType>
    
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
