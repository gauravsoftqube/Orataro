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
#import "FSCalendar.h"


#import "TestPreview.h"
#import "AMPPreviewController.h"

@interface AttendanceVC ()<FSCalendarDataSource,FSCalendarDelegate>
{
    NSMutableArray *classTableDataAry;
    UIDatePicker *datePicker;
    UIAlertView *alert;
    int c2;
    AppDelegate *app;
    NSMutableArray *subAry;
    NSString *strDivId,*strGradeId,*strMonth,*strYear;
    NSMutableArray *arySaveTag;
    NSMutableArray *aryTable,*aryTable1;
    int presentcnt,absentcnt,leavecnt;
    FSCalendar *calendar1;
    NSString *strStudentRegID;
}
@property (weak, nonatomic) IBOutlet FSCalendar *calendar;
@property (strong, nonatomic) NSCalendar *gregorian;
@end

@implementation AttendanceVC
@synthesize AttendanceTableView,aClasstableView,aClassMAinView,workBtn,NormalBtn,aTextfield1,aTextField2,aTextfield3;
int com =0;
int cn =0;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    subAry = [[NSMutableArray alloc]init];
    aryTable = [[NSMutableArray alloc]init];
    aryTable1 = [[NSMutableArray alloc]init];
    
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
    
    //set Header Title
    NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
    if (arr.count != 0) {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Attendance (%@)",[arr objectAtIndex:0]];
    }
    else
    {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Attendance"];
    }
    
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
    
    /*
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'"];
     NSDate *originalDate = [dateFormatter dateFromString:originalDateString];
     [dateFormatter setDateFormat:@"MM' 'DD','yyyy"];
     NSString *formattedDateString = [dateFormatter stringFromDate:originalDate];
     */
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MMM-yyyy"];
    NSString *theDate = [[dateFormat stringFromDate:[NSDate date]]uppercaseString];
    _lbDate.text = [theDate uppercaseString];
    
    [self hideTextfield];
    
    /*
     #define apk_attendance  @"apk_attendance.asmx"
     #define apk_AttendanceListForStudent @"AttendanceListForStudent"
     */
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    
    if ([[Utility getMemberType] containsString:@"Teacher"])
    {
        _viewCalender.hidden = YES;
        [self apiCallFor_getSubDiv];
    }
    else
    {
        _viewCalender.hidden = NO;
        [self apicallfor_StudentAttendance];
    }
    
//    if([[Utility getMemberType] isEqualToString:@"Student"])
//    {
//       
//        
//        
//    }
//    else
//    {
//       
//    }
    
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
        
        cell.btnFirst.tag = 0;
        cell.btnSecond.tag = 1;
        cell.btnThird.tag = 2;
        cell.btnFourth.tag = 3;
        
        
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
        aClassMAinView.hidden = YES;
        
        _lbSubDivision.text = [NSString stringWithFormat:@"%@ %@",[[subAry objectAtIndex:indexPath.row] objectForKey:@"Grade"],[[subAry objectAtIndex:indexPath.row] objectForKey:@"Division"]];
        
        strDivId = [[subAry objectAtIndex:indexPath.row] objectForKey:@"DivisionID"];
        strGradeId = [[subAry objectAtIndex:indexPath.row] objectForKey:@"GradeID"];
        NSArray *aryVal = [_lbDate.text componentsSeparatedByString:@"-"];
        strMonth = [aryVal objectAtIndex:1];
        strYear = [aryVal objectAtIndex:2];
        
        [self getAttendanceList:strDivId :strGradeId :strMonth :strYear];
        
        
    }
}

#pragma mark - Calender Delegate


- (nullable UIImage *)calendar:(FSCalendar *)calendar imageForDate:(NSDate *)date
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM"];
    NSString *strDate123=[formatter stringFromDate:date];
    
    NSDateFormatter *formatterYear=[[NSDateFormatter alloc]init];
    [formatterYear setDateFormat:@"yyyy"];
    NSString *strDate123Year=[formatterYear stringFromDate:date];
    
    NSDate *currentPageDate=self.calendar.currentPage;
    NSDateFormatter *formatter1=[[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"MM"];
    NSString *strDate1=[formatter1 stringFromDate:currentPageDate];
    
    
    
    /*if([strDate123 isEqual:strDate1])
     {
     NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
     [formatter setDateFormat:@"dd/MM/yyyy"];
     NSString *strDate21=[formatter stringFromDate:date];
     
     NSDateFormatter *formatter11=[[NSDateFormatter alloc]init];
     [formatter11 setDateFormat:@"dd/MM/yyyy"];
     NSString *strDate11=[formatter11 stringFromDate:[NSDate new]];
     if([strDate21 isEqual:strDate11])
     {
     return [UIImage imageNamed:@"coloricon"];
     }
     }
     
     for (NSMutableDictionary *dic in arrCalenderDetailList)
     {
     NSString *type=[dic objectForKey:@"type"];
     if ([@"Activity" isEqualToString:type]) {
     
     NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
     [formatter setDateFormat:@"yyyy/MM/dd"];
     NSString *strDate=[formatter stringFromDate:date];
     
     NSString *start=[dic objectForKey:@"start"];
     
     NSArray *arrResDate = [strDate componentsSeparatedByString:@"/"];
     NSString *strDate1Year;
     if(arrResDate.count != 0)
     {
     strDate1Year = [arrResDate objectAtIndex:0];
     }
     
     if([strDate123 isEqual:strDate1])
     {
     if([strDate123Year isEqual:strDate1Year])
     {
     if([strDate isEqualToString:start])
     {
     return [UIImage imageNamed:@"notify_20"];
     }
     }
     }
     }
     if ([@"Event" isEqualToString:type])
     {
     NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
     [formatter setDateFormat:@"yyyy/MM/dd"];
     NSString *strDate=[formatter stringFromDate:date];
     
     
     NSString *start=[dic objectForKey:@"start"];
     
     
     NSArray *arrResDate = [strDate componentsSeparatedByString:@"/"];
     NSString *strDate1Year;
     if(arrResDate.count != 0)
     {
     strDate1Year = [arrResDate objectAtIndex:0];
     }
     
     if([strDate123 isEqual:strDate1])
     {
     if([strDate123Year isEqual:strDate1Year])
     {
     if([strDate isEqualToString:start])
     {
     return [UIImage imageNamed:@"notify_20"];
     }
     }
     }
     }
     if ([@"Exam" isEqualToString:type])
     {
     NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
     [formatter setDateFormat:@"yyyy/MM/dd"];
     NSString *strDate=[formatter stringFromDate:date];
     
     
     NSString *start=[dic objectForKey:@"start"];
     
     NSArray *arrResDate = [strDate componentsSeparatedByString:@"/"];
     NSString *strDate1Year;
     if(arrResDate.count != 0)
     {
     strDate1Year = [arrResDate objectAtIndex:0];
     }
     
     
     if([strDate123 isEqual:strDate1])
     {
     if([strDate123Year isEqual:strDate1Year])
     {
     if([strDate isEqualToString:start])
     {
     return [UIImage imageNamed:@"exam_20"];
     }
     }
     }
     }
     
     if ([@"Todos" isEqualToString:type])
     {
     NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
     [formatter setDateFormat:@"yyyy/MM/dd"];
     NSString *strDate=[formatter stringFromDate:date];
     
     
     NSString *start=[dic objectForKey:@"start"];
     
     NSArray *arrResDate = [strDate componentsSeparatedByString:@"/"];
     NSString *strDate1Year;
     if(arrResDate.count != 0)
     {
     strDate1Year = [arrResDate objectAtIndex:0];
     }
     
     
     if([strDate123 isEqual:strDate1])
     {
     if([strDate123Year isEqual:strDate1Year])
     {
     if([strDate isEqualToString:start])
     {
     return [UIImage imageNamed:@"notify_20"];
     }
     }
     }
     }
     
     if ([@"Holiday" isEqualToString:type])
     {
     NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
     [formatter setDateFormat:@"yyyy/MM/dd"];
     NSString *strDate=[formatter stringFromDate:date];
     
     
     NSString *start=[dic objectForKey:@"start"];
     
     NSArray *arrResDate = [strDate componentsSeparatedByString:@"/"];
     NSString *strDate1Year;
     if(arrResDate.count != 0)
     {
     strDate1Year = [arrResDate objectAtIndex:0];
     }
     
     
     if([strDate123 isEqual:strDate1])
     {
     if([strDate123Year isEqual:strDate1Year])
     {
     if([strDate isEqualToString:start])
     {
     return [UIImage imageNamed:@"notify_red_20"];
     }
     }
     }
     }
     }*/
    
    return nil;
}

- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date
{
    /* NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
     [formatter setDateFormat:@"MM"];
     NSString *strDate=[formatter stringFromDate:date];
     
     NSDate *currentPageDate=self.calendar.currentPage;
     NSDateFormatter *formatter1=[[NSDateFormatter alloc]init];
     [formatter1 setDateFormat:@"MM"];
     NSString *strDate1=[formatter1 stringFromDate:currentPageDate];
     
     if([strDate isEqual:strDate1])
     {
     return [UIColor blackColor];
     }
     else
     {
     return [UIColor lightGrayColor];
     }*/
    
    return [UIColor lightGrayColor];
}

- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date
{
    /* NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
     [formatter setDateFormat:@"dd/MM/yyyy"];
     NSString *strDate=[formatter stringFromDate:date];
     
     NSDateFormatter *formatter1=[[NSDateFormatter alloc]init];
     [formatter1 setDateFormat:@"dd/MM/yyyy"];
     NSString *strDate1=[formatter1 stringFromDate:[NSDate new]];
     
     if([strDate  isEqual:strDate1])
     {
     return [UIColor whiteColor];
     }
     else
     {
     return [UIColor whiteColor];
     }*/
    
    return [UIColor whiteColor];
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
    
    if (btn.tag == 0)
    {
        [d setObject:@"1" forKey:@"Present"];
        [d setObject:@"0" forKey:@"Absent"];
        [d setObject:@"0" forKey:@"sick Leave"];
        [d setObject:@"0" forKey:@"Leave"];
        [arySaveTag replaceObjectAtIndex:indexPath.row withObject:d];
    }
    if (btn.tag == 1)
    {
        [d setObject:@"1" forKey:@"Absent"];
        [d setObject:@"0" forKey:@"Present"];
        [d setObject:@"0" forKey:@"sick Leave"];
        [d setObject:@"0" forKey:@"Leave"];
        [arySaveTag replaceObjectAtIndex:indexPath.row withObject:d];
    }
    if (btn.tag == 2)
    {
        
        [d setObject:@"1" forKey:@"sick Leave"];
        [d setObject:@"0" forKey:@"Absent"];
        [d setObject:@"0" forKey:@"Present"];
        [d setObject:@"0" forKey:@"Leave"];
        [arySaveTag replaceObjectAtIndex:indexPath.row withObject:d];
    }
    if (btn.tag == 3)
    {
        [d setObject:@"1" forKey:@"Leave"];
        [d setObject:@"0" forKey:@"sick Leave"];
        [d setObject:@"0" forKey:@"Absent"];
        [d setObject:@"0" forKey:@"Present"];
        [arySaveTag replaceObjectAtIndex:indexPath.row withObject:d];
    }
    
    NSLog(@"Ary data=%@",arySaveTag);
    
    [AttendanceTableView reloadData];
    
    
}

- (IBAction)btnSaveClicked:(id)sender
{
    if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"])
    {
        if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
            {
                if([[Utility getUserRoleRightList:@"Attendance" settingType:@"IsCreate"] integerValue] == 1)
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
                else
                {
                    [WToast showWithText:You_dont_have_permission];
                }
            }
            else
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
            
        }
        else
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
        
    }
    else
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
}

- (IBAction)btnGenerateReportClicked:(id)sender
{
    [self apicallfor_GenerateReport];
}

- (IBAction)btnMonthPreveiousClicked:(id)sender {
}

- (IBAction)btnYearePreviousClicked:(id)sender {
}

- (IBAction)btnMonthNextClicked:(id)sender {
}

- (IBAction)btnYearNextClicked:(id)sender {
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

#pragma mark - alert delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2)
    {
        if (buttonIndex == 0)
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MMM-yyyy"];
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
        if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"])
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
            {
                if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
                {
                    if([[Utility getUserRoleRightList:@"Attendance" settingType:@"IsCreate"] integerValue] == 1)
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
                        [WToast showWithText:You_dont_have_permission];
                    }
                }
                else
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
                
            }
            else
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
            
        }
        else
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

#pragma mark - get StudentList

-(void)apicallfor_StudentAttendance
{
    //#define apk_attendance  @"apk_attendance.asmx"
    //#define apk_AttendanceListForStudent @"AttendanceListForStudent"
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        [ProgressHUB hideenHUDAddedTo:self.view];
        return;
    }
    
    /*
     <GradeID>guid</GradeID>
     <DivisionID>guid</DivisionID>
     
     <BatchID>guid</BatchID>
     <MemberID>guid</MemberID>
     
     <YearStartDate>string</YearStartDate>
     <YearEndDate>string</YearEndDate>
     
     */
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_attendance,apk_AttendanceListForStudent];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    // NSLog(@"dic=%@",dicCurrentUser);
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"GradeID"]] forKey:@"GradeID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"DivisionID"]] forKey:@"DivisionID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BatchID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    
    [param setValue:[Utility convertMiliSecondtoDate:@"MM-dd-yyyy" date:[dicCurrentUser objectForKey:@"BatchStart"]] forKey:@"YearStartDate"];
    [param setValue:[Utility convertMiliSecondtoDate:@"MM-dd-yyyy" date:[dicCurrentUser objectForKey:@"BatchEnd"]] forKey:@"YearEndDate"];
    

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
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:STUDENTLEAVE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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

#pragma mark - generate Report

-(void)apicallfor_GenerateReport
{
    //#define apk_attendance  @"apk_attendance.asmx"
    //#define apk_AttendanceReport @"AttendanceReport"
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        [ProgressHUB hideenHUDAddedTo:self.view];
        return;
    }
    
    /*
     
     <InstituteID>guid</InstituteID>
     <ClientID>guid</ClientID>
     <BatchID>guid</BatchID>
     
     <BatchStart>string</BatchStart>
     <BatchEnd>string</BatchEnd>
     
     <Month>int</Month>
     <Year>int</Year>
     <GradeID>guid</GradeID>
     <DivisionID>guid</DivisionID>
     <STDDVIName>string</STDDVIName>
     <InstituteName>string</InstituteName>
     <IsOnlyWorkingDay>boolean</IsOnlyWorkingDay>
     
     
     <MemberID>guid</MemberID>
     
     */
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_attendance,apk_AttendanceReport];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    // NSLog(@"dic=%@",dicCurrentUser);
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BatchID"];
   
    
    [param setValue:[Utility convertMiliSecondtoDate:@"MM-dd-yyyy" date:[dicCurrentUser objectForKey:@"BatchStart"]] forKey:@"BatchStart"];
    [param setValue:[Utility convertMiliSecondtoDate:@"MM-dd-yyyy" date:[dicCurrentUser objectForKey:@"BatchEnd"]] forKey:@"BatchEnd"];
    
    NSString *str = [Utility convertDateFtrToDtaeFtr:@"dd-MMM-yyyy" newDateFtr:@"dd-MM-yyyy" date:[NSString stringWithFormat:@"%@",_lbDate.text]];
    
    NSArray *arMon = [str componentsSeparatedByString:@"-"];
    NSString *strarMon = [arMon objectAtIndex:1];
    NSString *strarYear = [arMon objectAtIndex:2];

   // int mon = [[NSString stringWithFormat:@"%@",strarMon]intValue];
   // int year = [[NSString stringWithFormat:@"%@",strarYear]intValue];

    [param setValue:strarMon  forKey:@"Month"];
    [param setValue:strarYear forKey:@"Year"];
    
    [param setValue:strGradeId forKey:@"GradeID"];
    [param setValue:strDivId forKey:@"DivisionID"];
    
    [param setValue:_lbSubDivision.text forKey:@"STDDVIName"];
    [param setValue:[dicCurrentUser objectForKey:@"InstituteName"] forKey:@"InstituteName"];
    
    if (com == 1)
    {
        [param setValue:@"true" forKey:@"IsOnlyWorkingDay"];
    }
    else
    {
        [param setValue:@"false" forKey:@"IsOnlyWorkingDay"];
    }
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    
    [ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
            
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             
             if([str length] != 0)
             {
                 AMPPreviewController *pc = [[AMPPreviewController alloc]
                                             initWithRemoteFile:[NSURL URLWithString:[NSString stringWithFormat:@"%@\%@",apk_ImageUrlFor_HomeworkDetail,strArrd]] title:@"Growth in time"];
                 [pc setStartDownloadBlock:^()
                 {
                    // NSLog(@"Start download");
                     [WToast showWithText:@"Download......"];
                 }];
                 [pc setFinishDownloadBlock:^(NSError *error)
                 {
                     //NSLog(@"Download finished %@", error);
                     
                 }];
                 [self presentViewController:pc animated:YES completion:nil];
                 
                // }
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
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:ATTENSUBDIV delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
    
    //NSLog(@"GetDate=%@",_lbDate.text);
    
    NSString *str = [Utility convertDateFtrToDtaeFtr:@"dd-MMM-yyyy" newDateFtr:@"dd-MM-yyyy" date:[NSString stringWithFormat:@"%@",_lbDate.text]];
    
    NSArray *arMon = [str componentsSeparatedByString:@"-"];
    
    NSString *strarMon = [arMon objectAtIndex:1];
    
    [param setValue:[NSString stringWithFormat:@"%@",strarMon] forKey:@"Month"];
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
                 if (data != nil)
                 {
                     arrResponce  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                     
                     aryTable = [arrResponce objectForKey:@"Table"];
                     aryTable1 = [arrResponce objectForKey:@"Table1"];
                     
                     if([aryTable count] == 0)
                     {
                         UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:ATTENDANCE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
                         [AttendanceTableView reloadData];
                     }
                 }
                 else
                 {
                   //  UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    // [alrt show];
                 }
                 
             } @catch (NSException *exception)
             {
                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
        
        NSLog(@"Data=%@",arySaveTag);
        
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
        
        NSLog(@"Temp=%@",arytmp);
        
        NSMutableArray *aryStore = [[NSMutableArray alloc]init];
        NSString *strStud;
        for (NSMutableDictionary *d in arytmp)
        {
            strStud = [NSString stringWithFormat:@"%@,%@#",[d objectForKey:@"memberId"],[d objectForKey:@"present"]];
            [aryStore addObject:strStud];
        }
        
        NSLog(@"Ary store=%@",aryStore);
        
        NSString *st = [aryStore componentsJoinedByString:@""];
        
        [param setValue:[NSString stringWithFormat:@"%@",st] forKey:@"StudentData"];
        
        //strStudentRegID
        
        if (aryTable1.count > 0)
        {
            NSString *str = [Utility convertDateFtrToDtaeFtr:@"dd-MMM-yyyy" newDateFtr:@"dd-MM-yyyy" date:_lbDate.text];
            
            for (NSMutableDictionary *dic in aryTable1)
            {
                NSString *strDate = [Utility convertMiliSecondtoDate:@"dd-MM-yyyy" date:[dic objectForKey:@"DateOfAttendence"]];
                
                if ([strDate isEqualToString:str])
                {
                    strStudentRegID = [dic objectForKey:@"StudentAttRegMasterID"];
                }
               // else
             //   {
                    //strStudentRegID = @"";
              //  }
            }
           //  [param setValue:@"" forKey:@"OldStudAtteRegiMasterID"];
        }
       
        [param setValue:strStudentRegID forKey:@"OldStudAtteRegiMasterID"];
        /*
         
         <StandardID>guid</StandardID>
         <DivisionID>guid</DivisionID>
         <ClientID>guid</ClientID>
         <InstituteID>guid</InstituteID>
         <AttendenceBy>guid</AttendenceBy>
         <DateOfAttendence>string</DateOfAttendence>
         <BatchID>guid</BatchID>
         <DayOfAttendence_Term>string</DayOfAttendence_Term>
         <TotalStudents>int</TotalStudents>
         <PresentStudents>int</PresentStudents>
         <AbsentStudents>int</AbsentStudents>
         <OnLeaveStudents>int</OnLeaveStudents>
         <IsWorkingDay>boolean</IsWorkingDay>
         <StudentData>string</StudentData>
         <OldStudAtteRegiMasterID>string</OldStudAtteRegiMasterID>
         
         */
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
    
    NSLog(@"absent=%d Leave=%d Present=%d",absentcnt,leavecnt,presentcnt);
    
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
    /*
     <StandardID>guid</StandardID>
     <DivisionID>guid</DivisionID>
     <ClientID>guid</ClientID>
     <InstituteID>guid</InstituteID>
     <AttendenceBy>guid</AttendenceBy>
     <DateOfAttendence>string</DateOfAttendence>
     <BatchID>guid</BatchID>
     <DayOfAttendence_Term>string</DayOfAttendence_Term>
     <TotalStudents>int</TotalStudents>
     <PresentStudents>int</PresentStudents>
     <AbsentStudents>int</AbsentStudents>
     <OnLeaveStudents>int</OnLeaveStudents>
     <IsWorkingDay>boolean</IsWorkingDay>
     <StudentData>string</StudentData>
     <OldStudAtteRegiMasterID>string</OldStudAtteRegiMasterID>
     
     */
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
                     [self apiCallFor_SendPushNotification];
                 }
                 else
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:ATTENNOTSAVE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
    }];
}

@end
