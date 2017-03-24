//
//  AttendanceVC.m
//  orataro
//
//  Created by Softqube Mac IOS on 06/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "AttendanceVC.h"
#import "AttendanceTableViewCell.h"
#import "ClassVcCell.h"
#import "REFrostedViewController.h"
#import "StudentListViewController.h"
#import "AppDelegate.h"
#import "Global.h"

@interface AttendanceVC ()
{
    NSMutableArray *classTableDataAry;
    UIDatePicker *datePicker;
    UIAlertView *alert;
    int c2;
    AppDelegate *app;
    NSMutableArray *subAry;
    NSString *strDivId,*strGradeId,*strMonth,*strYear;
    NSMutableArray *arySaveTag;
    NSMutableArray *aryTable;
    int presentcnt,absentcnt,leavecnt;
}
@end

@implementation AttendanceVC
@synthesize AttendanceTableView,aClasstableView,aClassMAinView,workBtn,NormalBtn,aTextfield1,aTextField2,aTextfield3;
int com =0;
int cn =0;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    subAry = [[NSMutableArray alloc]init];
    aryTable = [[NSMutableArray alloc]init];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    app =(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [AttendanceTableView registerNib:[UINib nibWithNibName:@"AttendanceTableViewCell" bundle:nil] forCellReuseIdentifier:@"AttendanceCell"];
    AttendanceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [aClasstableView registerNib:[UINib nibWithNibName:@"ClassVcCell" bundle:nil] forCellReuseIdentifier:@"ClassCell"];
    aClasstableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    aClassMAinView.hidden = YES;
    
    
    [Utility setLeftViewInTextField:aTextfield1 imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:aTextField2 imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:aTextfield3 imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    CGRect frame = CGRectMake(0, 0, 200, 200);
    datePicker = [[UIDatePicker alloc] initWithFrame:frame];
    datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    // NSDate *Date=[NSDate date];
    // datePicker.minimumDate=Date;
    
    alert = [[UIAlertView alloc]
             initWithTitle:@"Select Date"
             message:nil
             delegate:self
             cancelButtonTitle:@"OK"
             otherButtonTitles:@"Cancel", nil];
    alert.delegate = self;
    alert.tag = 2;
    [alert setValue:datePicker forKey:@"accessoryView"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSString *theDate = [dateFormat stringFromDate:[NSDate date]];
    _lbDate.text = theDate;
    
    [self hideTextfield];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self apiCallFor_getSubDiv];
}

#pragma mark - tabelview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == AttendanceTableView)
    {
        AttendanceTableViewCell *cell = (AttendanceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AttendanceCell"];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AttendanceTableViewCell" owner:self options:nil];
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
        
        cell.btnFirst.tag = 1;
        cell.btnSecond.tag = 2;
        cell.btnThird.tag = 3;
        cell.btnFourth.tag = 4;
        
        
        cell.lbName.text = [[arySaveTag objectAtIndex:indexPath.row]objectForKey:@"Name"];
        
        if ([[[arySaveTag objectAtIndex:indexPath.row]objectForKey:@"Present"] isEqualToString:@"1"])
        {
            [cell.btnFirst setImage:[UIImage imageNamed:@"unradiop"] forState:UIControlStateNormal];
        }
        else
        {
            [cell.btnFirst setImage:[UIImage imageNamed:@"radiop"] forState:UIControlStateNormal];
        }
        
        if ([[[arySaveTag objectAtIndex:indexPath.row]objectForKey:@"Absent"] isEqualToString:@"1"])
        {
            [cell.btnSecond setImage:[UIImage imageNamed:@"unradioa"] forState:UIControlStateNormal];
        }
        else
        {
            [cell.btnSecond setImage:[UIImage imageNamed:@"radioa"] forState:UIControlStateNormal];
        }
        
        if ([[[arySaveTag objectAtIndex:indexPath.row]objectForKey:@"sick Leave"] isEqualToString:@"1"])
        {
            [cell.btnThird setImage:[UIImage imageNamed:@"unradios"] forState:UIControlStateNormal];
        }
        else
        {
            [cell.btnThird setImage:[UIImage imageNamed:@"radios"] forState:UIControlStateNormal];
        }
        
        if ([[[arySaveTag objectAtIndex:indexPath.row]objectForKey:@"Leave"] isEqualToString:@"1"])
        {
            [cell.btnFourth setImage:[UIImage imageNamed:@"unradiol"] forState:UIControlStateNormal];
        }
        else
        {
            [cell.btnFourth setImage:[UIImage imageNamed:@"radiol"] forState:UIControlStateNormal];
        }
        
        
        [cell.btnFirst addTarget:self action:@selector(changeRadioState:) forControlEvents: UIControlEventTouchUpInside];
        [cell.btnSecond addTarget:self action:@selector(changeRadioState:) forControlEvents: UIControlEventTouchUpInside];
        [cell.btnThird addTarget:self action:@selector(changeRadioState:) forControlEvents: UIControlEventTouchUpInside];
        [cell.btnFourth addTarget:self action:@selector(changeRadioState:) forControlEvents: UIControlEventTouchUpInside];
        
        return cell;
    }
    if (tableView == aClasstableView)
    {
        ClassVcCell *cell = (ClassVcCell *)[tableView dequeueReusableCellWithIdentifier:@"ClassCell"];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ClassVcCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lbSubDiv.text = [NSString stringWithFormat:@"%@  %@",[[subAry objectAtIndex:indexPath.row] objectForKey:@"Grade"],[[subAry objectAtIndex:indexPath.row] objectForKey:@"Division"]];
        
        return cell;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //        NSString *yourText = [yourArray objectAtIndex:indexPath.row];
    //
    //        CGSize labelWidth = CGSizeMake(300, CGFLOAT_MAX); // 300 is fixed width of label. You can change this value
    //        CGRect textRect = [visitorsPerRegion boundingRectWithSize:labelWidth options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:16.0]} context:nil];
    //
    //        int calculatedHeight = textRect.size.height+10;
    //        return (float)calculatedHeight;
    
    if (tableView == AttendanceTableView)
    {
        return 59;
    }
    
    if (tableView == aClasstableView)
    {
        return 44;
    }
    
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == AttendanceTableView)
    {
        if (arySaveTag.count > 0)
        {
            return arySaveTag.count;
        }
        
    }
    
    if (tableView == aClasstableView)
    {
        return subAry.count;
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == AttendanceTableView)
    {
        
    }
    if (tableView == aClasstableView)
    {
        _lbSubDivision.text = [NSString stringWithFormat:@"%@ %@",[[subAry objectAtIndex:indexPath.row] objectForKey:@"Grade"],[[subAry objectAtIndex:indexPath.row] objectForKey:@"Division"]];
        
        strDivId = [[subAry objectAtIndex:indexPath.row] objectForKey:@"DivisionID"];
        strGradeId = [[subAry objectAtIndex:indexPath.row] objectForKey:@"GradeID"];
        NSArray *aryVal = [_lbDate.text componentsSeparatedByString:@"-"];
        strMonth = [aryVal objectAtIndex:1];
        strYear = [aryVal objectAtIndex:2];
        
        [self getAttendanceList:strDivId :strGradeId :strMonth :strYear];
        
        aClassMAinView.hidden = YES;
    }
}

#pragma mark - button action

-(void)changeRadioState :(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:AttendanceTableView];
    NSIndexPath *indexPath = [AttendanceTableView indexPathForRowAtPoint:buttonPosition];
    
    UIButton *btn = (UIButton *)sender;
    NSLog(@"sender tag=%ld",(long)btn.tag);
    
    NSMutableDictionary *d = [arySaveTag objectAtIndex:indexPath.row];
    
    NSLog(@"dic=%@",d);
    
    if (btn.tag == 1)
    {
        [d setObject:@"1" forKey:@"Present"];
        [d setObject:@"0" forKey:@"Absent"];
        [d setObject:@"0" forKey:@"sick Leave"];
        [d setObject:@"0" forKey:@"Leave"];
        [arySaveTag replaceObjectAtIndex:indexPath.row withObject:d];
    }
    if (btn.tag == 2)
    {
        [d setObject:@"1" forKey:@"Absent"];
        [d setObject:@"0" forKey:@"Present"];
        [d setObject:@"0" forKey:@"sick Leave"];
        [d setObject:@"0" forKey:@"Leave"];
        [arySaveTag replaceObjectAtIndex:indexPath.row withObject:d];
    }
    if (btn.tag == 3)
    {
        
        [d setObject:@"1" forKey:@"sick Leave"];
        [d setObject:@"0" forKey:@"Absent"];
        [d setObject:@"0" forKey:@"Present"];
        [d setObject:@"0" forKey:@"Leave"];
        [arySaveTag replaceObjectAtIndex:indexPath.row withObject:d];
    }
    if (btn.tag == 4)
    {
        [d setObject:@"1" forKey:@"Leave"];
        [d setObject:@"0" forKey:@"sick Leave"];
        [d setObject:@"0" forKey:@"Absent"];
        [d setObject:@"0" forKey:@"Present"];
        [arySaveTag replaceObjectAtIndex:indexPath.row withObject:d];
    }
    [AttendanceTableView reloadData];
    
    
}

- (IBAction)btnSaveClicked:(id)sender
{
    if (cn == 0)
    {
        [self SaveAttendance:YES];
    }
    else
    {
        [self SaveAttendance:NO];
    }
}

- (IBAction)btnGenerateReportClicked:(id)sender
{
    
}

- (IBAction)ClassBtnClicked:(id)sender
{
    aClassMAinView.hidden = NO;
    [self.view bringSubviewToFront:aClassMAinView];
}
- (IBAction)MenuBtnClicked:(id)sender
{
    self.frostedViewController.direction = REFrostedViewControllerDirectionRight;
    
    if (app.checkview == 0)
    {
        [self.frostedViewController presentMenuViewController];
        app.checkview = 1;
    }
    else
    {
        [self.frostedViewController hideMenuViewController];
        app.checkview = 0;
    }
}
- (IBAction)isWorkingClicked:(id)sender
{
    //checkboxunselected
    //checkboxblue
    if (com == 0)
    {
        [workBtn setBackgroundImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
        com =1;
        
    }
    else
    {
        [workBtn setBackgroundImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
        com =0;
        
    }
}
- (IBAction)DateSelectClicked:(id)sender
{
    [datePicker setDate:[NSDate date]];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2)
    {
        if (buttonIndex == 0)
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
            _lbDate.text = theDate;
            
        }
        if (buttonIndex == 1)
        {
            alert.hidden = YES;
        }
        
    }
    
}
- (IBAction)NormalBtnClicked:(id)sender
{
    if (cn==0)
    {
        [NormalBtn setTitle:@"Quick" forState:UIControlStateNormal];
        cn =1;
        AttendanceTableView.hidden = YES;
        aTextfield3.hidden = NO;
        aTextField2.hidden = NO;
        aTextfield1.hidden = NO;
        [self.view bringSubviewToFront:aTextfield1];
        [self.view bringSubviewToFront:aTextField2];
        [self.view bringSubviewToFront:aTextfield3];
    }
    else
    {
        [NormalBtn setTitle:@"Normal" forState:UIControlStateNormal];
        cn =0;
        AttendanceTableView.hidden = NO;
        aTextfield3.hidden = YES;
        aTextField2.hidden = YES;
        aTextfield1.hidden = YES;
        [self.view bringSubviewToFront:AttendanceTableView];
        
        
    }
}

- (IBAction)btnHomeClicked:(id)sender
{
    [self.frostedViewController hideMenuViewController];
    
    UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"OrataroVc"];
    
    [self.navigationController pushViewController:wc animated:NO];
}

#pragma mark - API Call

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
    // NSLog(@"dic=%@",dicCurrentUser);
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
                     [self ManageSubjectList:arrResponce];
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
    //NSLog(@"ary=%@",aryResponse);
    NSMutableArray *aryTmp = [[NSMutableArray alloc]initWithArray:aryResponse];
    for (int i=0; i< aryTmp.count; i++)
    {
        NSMutableDictionary *d = [[aryTmp objectAtIndex:i] mutableCopy];
        NSString *str = [NSString stringWithFormat:@"%@%@",[d objectForKey:@"Grade"],[d objectForKey:@"Division"]];
        [d setObject:str forKey:@"Group"];
        //NSLog(@"d=%@",d);
        [aryTmp replaceObjectAtIndex:i withObject:d];
    }
    
    NSArray *temp = [aryTmp sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"Group" ascending:YES]]];
    [aryTmp removeAllObjects];
    [aryTmp addObjectsFromArray:temp];
    //NSLog(@"Ary=%@",aryTmp);
    
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
    subAry = [[NSMutableArray alloc]initWithArray:arrTemp];
    
    _lbSubDivision.text = [NSString stringWithFormat:@"%@ %@",[[subAry objectAtIndex:0] objectForKey:@"Grade"],[[subAry objectAtIndex:0] objectForKey:@"Division"]];
    
    strDivId = [[subAry objectAtIndex:0] objectForKey:@"DivisionID"];
    strGradeId = [[subAry objectAtIndex:0] objectForKey:@"GradeID"];
    NSArray *aryVal = [_lbDate.text componentsSeparatedByString:@"-"];
    strMonth = [aryVal objectAtIndex:1];
    strYear = [aryVal objectAtIndex:2];
    [aClasstableView reloadData];
    
    [self getAttendanceList:strDivId :strGradeId :strMonth :strYear];
}

#pragma mark - hide textfield

-(void)hideTextfield
{
    aTextfield3.hidden = YES;
    aTextField2.hidden = YES;
    aTextfield1.hidden = YES;
}

#pragma mark - getListofAttendance API

-(void)getAttendanceList : (NSString *)divid :(NSString *)gradeId :(NSString *)strMonth1 :(NSString *)strYear1
{
    arySaveTag = [[NSMutableArray alloc]init];
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        [ProgressHUB hideenHUDAddedTo:self.view];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_attendance,apk_AttendanceListForTeacher_action];
    
    NSLog(@"url=%@",strURL);
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BatchID"];
    [param setValue:[NSString stringWithFormat:@"%@",gradeId] forKey:@"GradeID"];
    [param setValue:[NSString stringWithFormat:@"%@",strYear1] forKey:@"Year"];
    [param setValue:[NSString stringWithFormat:@"%@",strMonth1] forKey:@"Month"];
    [param setValue:[NSString stringWithFormat:@"%@",divid] forKey:@"DivisionID"];
    
    [ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSMutableDictionary *arrResponce;
             
             @try
             {
                 NSString *strArrd=[dicResponce objectForKey:@"d"];
                 NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
                arrResponce  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                 
             } @catch (NSException *exception)
             {
                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alrt show];
                 
             } @finally {
                 
                
                 
             }
           
             
             aryTable = [arrResponce objectForKey:@"Table"];
             
             if([aryTable count] == 0)
             {
                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"No Data Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alrt show];
                 
                 [arySaveTag removeAllObjects];
                 [AttendanceTableView reloadData];

             }
             else
             {
                 for (int i=0; i<aryTable.count; i++)
                 {
                     NSMutableDictionary *d = [[NSMutableDictionary alloc]init];
                     
                     [d setObject:[[aryTable objectAtIndex:i]objectForKey:@"MemberID"] forKey:@"MemberId"];
                     [d setObject:[[aryTable objectAtIndex:i]objectForKey:@"FullName"]  forKey:@"Name"];
                     [d setObject:@"1" forKey:@"Present"];
                     [d setObject:@"0" forKey:@"Absent"];
                     [d setObject:@"0" forKey:@"sick Leave"];
                     [d setObject:@"0" forKey:@"Leave"];
                     [d setObject:[[aryTable objectAtIndex:i]objectForKey:@"RollNo"] forKey:@"RollNo"];
                     
                     [arySaveTag addObject:d];
                 }
                 
                 NSLog(@"Data=%@",arySaveTag);
                 
                 [AttendanceTableView reloadData];
             }
        }
         else
         {
             UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alrt show];
         }
     }];
    
    
}

#pragma mark - Save Attendance List

-(void)SaveAttendance : (BOOL)val
{
    NSMutableArray *aryStudentData = [[NSMutableArray alloc]init];
    // NSMutableArray *aryTempData = [[NSMutableArray alloc]init];
    NSMutableArray *tmpary = [[NSMutableArray alloc]init];
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        [ProgressHUB hideenHUDAddedTo:self.view];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_attendance,apk_SaveAttendance];
    
    if (val == YES)
    {
        NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
        NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
        
        [param setValue:strGradeId forKey:@"StandardID"];
        [param setValue:strDivId forKey:@"DivisionID"];
        
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"AttendenceBy"];
        [param setValue:[NSString stringWithFormat:@"%@",[Utility convertDateFtrToDtaeFtr:@"dd-MM-yyyy" newDateFtr:@"MM-dd-yyyy" date:_lbDate.text]] forKey:@"DateOfAttendence"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BatchID"];
        [param setValue:[NSString stringWithFormat:@"%@",[Utility convertDateFtrToDtaeFtr:@"dd-MM-yyyy" newDateFtr:@"EEEE" date:_lbDate.text]] forKey:@"DayOfAttendence_Term"];
        [param setValue:[NSString stringWithFormat:@"%lu",(unsigned long)aryTable.count] forKey:@"TotalStudents"];
        
        for (int i=0 ;i<arySaveTag.count; i++)
        {
            NSMutableDictionary *d = [arySaveTag objectAtIndex:i];
            
            if ([[d objectForKey:@"Present"] isEqualToString:@"1"])
            {
                presentcnt++;
            }
            if ([[d objectForKey:@"Absent"] isEqualToString:@"1"])
            {
                absentcnt++;
            }
            if ([[d objectForKey:@"Leave"] isEqualToString:@"1"] || [[d objectForKey:@"sick Leave"] isEqualToString:@"1"])
            {
                leavecnt++;
            }
        }
        
        [param setValue:[NSString stringWithFormat:@"%d",presentcnt] forKey:@"PresentStudents"];
        [param setValue:[NSString stringWithFormat:@"%d",absentcnt] forKey:@"AbsentStudents"];
        [param setValue:[NSString stringWithFormat:@"%d",leavecnt] forKey:@"OnLeaveStudents"];
        
        if (com == 0)
        {
            [param setValue:@"false" forKey:@"IsWorkingDay"];
        }
        else
        {
            [param setValue:@"true" forKey:@"IsWorkingDay"];
        }
        
        NSMutableArray *arytmp = [[NSMutableArray alloc]init];
        
        for (int i=0 ;i<arySaveTag.count; i++)
        {
            NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc]init];
            
            NSMutableDictionary *d = [arySaveTag objectAtIndex:i];
            
            if ([[d objectForKey:@"Present"] isEqualToString:@"1"])
            {
                [tmpDic setObject:@"Present" forKey:@"present"];
                [tmpDic setObject:[d objectForKey:@"MemberId"] forKey:@"memberId"];
                [arytmp addObject:tmpDic];
            }
            if ([[d objectForKey:@"Absent"] isEqualToString:@"1"])
            {
                [tmpDic setObject:@"Absent" forKey:@"present"];
                [tmpDic setObject:[d objectForKey:@"MemberId"] forKey:@"memberId"];
                [arytmp addObject:tmpDic];
            }
            if ([[d objectForKey:@"Leave"] isEqualToString:@"1"])
            {
                [tmpDic setObject:@"Leave" forKey:@"present"];
                [tmpDic setObject:[d objectForKey:@"MemberId"] forKey:@"memberId"];
                [arytmp addObject:tmpDic];
            }
            if ([[d objectForKey:@"sick Leave"] isEqualToString:@"1"])
            {
                [tmpDic setObject:@"Sick Leave" forKey:@"present"];
                [tmpDic setObject:[d objectForKey:@"MemberId"] forKey:@"memberId"];
                [arytmp addObject:tmpDic];
            }
        }
        NSMutableArray *aryStore = [[NSMutableArray alloc]init];
        NSString *strStud;
        for (NSMutableDictionary *d in arytmp)
        {
            strStud = [NSString stringWithFormat:@"%@,%@#",[d objectForKey:@"memberId"],[d objectForKey:@"present"]];
            [aryStore addObject:strStud];
        }
        NSString *st = [aryStore componentsJoinedByString:@""];
        
        [param setValue:[NSString stringWithFormat:@"%@",st] forKey:@"StudentData"];
        [param setValue:@"" forKey:@"OldStudAtteRegiMasterID"];
        
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
                     NSString *strMsg = [[arrResponce objectAtIndex:0]objectForKey:@"message"];
                     NSArray *ary = [strMsg componentsSeparatedByString:@"#"];
                     NSString *strStatus=[ary objectAtIndex:0];
                     
                     if([strStatus isEqualToString:@"Attendence save successfully,"])
                     {
                         UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:strStatus delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [alrt show];
                     }
                     else
                     {
                         UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:strStatus delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [alrt show];
                     }
                 }
                 else
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"No Data Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
    else
    {
        NSMutableArray *aryabsent; //= [[NSMutableArray alloc]init];
        NSMutableArray *aryleave; //= [[NSMutableArray alloc]init];
        NSMutableArray *aryseakleave;// = [[NSMutableArray alloc]init];
       
        

        if ([Utility validateBlankField:aTextfield1.text])
        {
            
        }
        else
        {
            NSString *strAbsent = [NSString stringWithFormat:@"%@",aTextfield1.text];
            NSArray *aryget = [strAbsent componentsSeparatedByString:@","];
            
            aryabsent = [[NSMutableArray alloc]initWithArray:aryget];
            NSLog(@"count= ary=%@ %lu",aryabsent,(unsigned long)aryabsent.count);
        }
        
        if ([Utility validateBlankField:aTextField2.text])
        {
            
        }
        else
        {
            NSString *strAbsent = [NSString stringWithFormat:@"%@",aTextField2.text];
            NSArray *aryget = [strAbsent componentsSeparatedByString:@","];
            aryleave = [[NSMutableArray alloc]initWithArray:aryget];
            
        }
        
        if ([Utility validateBlankField:aTextfield3.text])
        {
            
        }
        else
        {
            NSString *strAbsent = [NSString stringWithFormat:@"%@",aTextfield3.text];
            NSArray *aryget = [strAbsent componentsSeparatedByString:@","];
            aryseakleave = [[NSMutableArray alloc]initWithArray:aryget];
        }
        
        if (aryabsent.count > 0)
        {
            
            for (int i=0; i<arySaveTag.count; i++)
            {
                NSString *getval = [[arySaveTag objectAtIndex:i]objectForKey:@"RollNo"];
                
                for (int j=0; j<aryabsent.count;j++)
                {
                    if ([[aryabsent objectAtIndex:j] isEqualToString:getval])
                    {
                        NSLog(@"data");
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                        [dic setObject:[[arySaveTag objectAtIndex:i]objectForKey:@"MemberId"] forKey:@"memberId"];
                        [dic setObject:@"Absent" forKey:@"absent"];
                        [dic setObject:[[arySaveTag objectAtIndex:i]objectForKey:@"RollNo"] forKey:@"rollnum"];
                        [aryStudentData addObject:dic];
                    }
                }
            }
        }
       if(aryleave.count > 0)
        {
            for (int i=0; i<arySaveTag.count; i++)
            {
                NSString *getval = [[arySaveTag objectAtIndex:i]objectForKey:@"RollNo"];
                
                for (int j=0; j<aryleave.count;j++)
                {
                    if ([[aryleave objectAtIndex:j] isEqualToString:getval])
                    {
                        NSLog(@"data");
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                        [dic setObject:[[arySaveTag objectAtIndex:i]objectForKey:@"MemberId"] forKey:@"memberId"];
                        [dic setObject:@"Leave" forKey:@"absent"];
                        [dic setObject:[[arySaveTag objectAtIndex:i]objectForKey:@"RollNo"] forKey:@"rollnum"];
                        [aryStudentData addObject:dic];
                    }
                }
            }
        }
        if(aryseakleave.count > 0)
        {
            for (int i=0; i<arySaveTag.count; i++)
            {
                NSString *getval = [[arySaveTag objectAtIndex:i]objectForKey:@"RollNo"];
                
                for (int j=0; j<aryseakleave.count;j++)
                {
                    if ([[aryseakleave objectAtIndex:j] isEqualToString:getval])
                    {
                        NSLog(@"data");
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                        [dic setObject:[[arySaveTag objectAtIndex:i]objectForKey:@"MemberId"] forKey:@"memberId"];
                        [dic setObject:@"Leave" forKey:@"absent"];
                        [dic setObject:[[arySaveTag objectAtIndex:i]objectForKey:@"RollNo"] forKey:@"rollnum"];
                        [aryStudentData addObject:dic];
                    }
                }
            }
        }

        for (int i=0; i<arySaveTag.count; i++)
        {
            NSString *getval = [NSString stringWithFormat:@"%@",[[arySaveTag objectAtIndex:i]objectForKey:@"RollNo"]];
            
            for (int j=0; j<aryStudentData.count; j++)
            {
                if ([[aryStudentData valueForKey:@"rollnum"] containsObject:getval])
                {
                }
                else
                {
                    if (![[tmpary valueForKey:@"rollnum"] containsObject:getval])
                    {
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                        [dic setObject:[[arySaveTag objectAtIndex:i]objectForKey:@"MemberId"] forKey:@"memberId"];
                        [dic setObject:@"Present" forKey:@"absent"];
                        [dic setObject:[[arySaveTag objectAtIndex:i]objectForKey:@"RollNo"] forKey:@"rollnum"];
                        [tmpary addObject:dic];
                    }
                }
            }
        }
        
    }

    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:aryStudentData];
    [array addObjectsFromArray:tmpary];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:strGradeId forKey:@"StandardID"];
    [param setValue:strDivId forKey:@"DivisionID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"AttendenceBy"];
    [param setValue:[NSString stringWithFormat:@"%@",[Utility convertDateFtrToDtaeFtr:@"dd-MM-yyyy" newDateFtr:@"MM-dd-yyyy" date:_lbDate.text]] forKey:@"DateOfAttendence"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BatchID"];
    [param setValue:[NSString stringWithFormat:@"%@",[Utility convertDateFtrToDtaeFtr:@"dd-MM-yyyy" newDateFtr:@"EEEE" date:_lbDate.text]] forKey:@"DayOfAttendence_Term"];
    [param setValue:[NSString stringWithFormat:@"%lu",(unsigned long)aryTable.count] forKey:@"TotalStudents"];
    
    NSLog(@"array=%@",array);
    
    for (int i=0 ;i<array.count; i++)
    {
        NSMutableDictionary *d = [array objectAtIndex:i];
        
        if ([[d objectForKey:@"absent"] isEqualToString:@"Absent"])
        {
            absentcnt++;
        }
        if ([[d objectForKey:@"absent"] isEqualToString:@"Leave"])
        {
            leavecnt++;
        }
        if ([[d objectForKey:@"absent"] isEqualToString:@"Present"])
        {
            presentcnt++;
        }
    }
    
    [param setValue:[NSString stringWithFormat:@"%d",presentcnt] forKey:@"PresentStudents"];
    [param setValue:[NSString stringWithFormat:@"%d",absentcnt] forKey:@"AbsentStudents"];
    [param setValue:[NSString stringWithFormat:@"%d",leavecnt] forKey:@"OnLeaveStudents"];
    
    if (com == 0)
    {
        [param setValue:@"false" forKey:@"IsWorkingDay"];
    }
    else
    {
        [param setValue:@"true" forKey:@"IsWorkingDay"];
    }
    
    NSMutableArray *arytmp = [[NSMutableArray alloc]init];
    
    for (int i=0 ;i<array.count; i++)
    {
        NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc]init];
        
        NSMutableDictionary *d = [array objectAtIndex:i];
        
        if ([[d objectForKey:@"absent"] isEqualToString:@"Absent"])
        {
            [tmpDic setObject:@"Absent" forKey:@"present"];
            [tmpDic setObject:[d objectForKey:@"memberId"] forKey:@"memberId"];
            [arytmp addObject:tmpDic];
        }
        if ([[d objectForKey:@"absent"] isEqualToString:@"Leave"])
        {
            [tmpDic setObject:@"Leave" forKey:@"present"];
            [tmpDic setObject:[d objectForKey:@"memberId"] forKey:@"memberId"];
            [arytmp addObject:tmpDic];
        }
        if ([[d objectForKey:@"absent"] isEqualToString:@"Present"])
        {
            [tmpDic setObject:@"Present" forKey:@"present"];
            [tmpDic setObject:[d objectForKey:@"memberId"] forKey:@"memberId"];
            [arytmp addObject:tmpDic];
        }
    }
    NSMutableArray *aryStore = [[NSMutableArray alloc]init];
    NSString *strStud;
    for (NSMutableDictionary *d in arytmp)
    {
        strStud = [NSString stringWithFormat:@"%@,%@#",[d objectForKey:@"memberId"],[d objectForKey:@"present"]];
        [aryStore addObject:strStud];
    }
    NSString *st = [aryStore componentsJoinedByString:@""];
    
    [param setValue:[NSString stringWithFormat:@"%@",st] forKey:@"StudentData"];
    [param setValue:@"" forKey:@"OldStudAtteRegiMasterID"];
    
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
                 NSString *strMsg = [[arrResponce objectAtIndex:0]objectForKey:@"message"];
                 NSArray *ary = [strMsg componentsSeparatedByString:@"#"];
                 NSString *strStatus=[ary objectAtIndex:0];
                 
                 if([strStatus isEqualToString:@"Attendence save successfully,"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:strStatus delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:strStatus delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
             }
             else
             {
                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"No Data Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
