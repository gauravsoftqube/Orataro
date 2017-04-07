//
//  CalenderVc.m
//  orataro
//
//  Created by MAC008 on 07/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "CalenderVc.h"
#import "FSCalendar.h"
#import "REFrostedViewController.h"
#import "AppDelegate.h"
#import "Global.h"


@interface CalenderVc ()<FSCalendarDataSource,FSCalendarDelegate>
{
    FSCalendar *calendar1;
    UILabel *lblMonth;
    UILabel *lblYear;
    int c2;
    AppDelegate *app;
    
    NSMutableArray *arrType;
    NSMutableArray *arrCalenderDetailList;
    
}
@property (weak, nonatomic) IBOutlet FSCalendar *calendar;

//@property (weak, nonatomic) FSCalendar *calendar;
@property (weak, nonatomic) UIButton *previousButton;
@property (weak, nonatomic) UIButton *nextButton;

@property (strong, nonatomic) NSCalendar *gregorian;

- (void)previousClicked:(id)sender;
- (void)nextClicked:(id)sender;


@end

@implementation CalenderVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
    [formater setDateFormat:@"MMM"];
    NSString *month=[formater stringFromDate:self.calendar.currentPage];
    [_lblMonth setText:[NSString stringWithFormat:@"%@",month]];
    
    NSDateFormatter *formaterYear=[[NSDateFormatter alloc]init];
    [formaterYear setDateFormat:@"yyyy"];
    NSString *Year=[formaterYear stringFromDate:self.calendar.currentPage];
    [_lblYear setText:[NSString stringWithFormat:@"%@",Year]];
    
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    
    NSDateFormatter *formatter1=[[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"dd/MM/yyyy"];
    NSString *strDate1=[formatter1 stringFromDate:[NSDate new]];
    
    [self apiCallFor_getGetProjectType];
    //[self apiCallFor_getCalendar:YES];
}


#pragma mark - ApiCall

-(void)apiCallFor_getGetProjectType
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_login,apk_GetProjectType_action];
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:@"eventType" forKey:@"Category"];
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
                     arrType=[[NSMutableArray alloc]init];
                     arrType = [[arrResponce valueForKey:@"Term"]mutableCopy];
                     [arrType addObject:@"Holiday"];
                     [self apiCallFor_getCalendar:YES];
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

-(void)apiCallFor_getCalendar:(BOOL)checkProgress
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_calendar,apk_GetCalendarData_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    
    [param setValue:[NSString stringWithFormat:@"%@",yearString] forKey:@"year"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"RoleName"]] forKey:@"RoleName"];
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
                     arrCalenderDetailList = [arrResponce mutableCopy];
                     [self.calendar reloadData];
                     [self setTotalEventCount];
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

-(void)setTotalEventCount
{
    NSMutableArray *arrTotalEventThisMonth=[[NSMutableArray alloc]init];
    NSDate *currentPageDate=self.calendar.currentPage;
    NSDateFormatter *formatter12=[[NSDateFormatter alloc]init];
    [formatter12 setDateFormat:@"MM"];
    NSString *strDate11=[formatter12 stringFromDate:currentPageDate];
    
    for (NSMutableDictionary *dic in arrCalenderDetailList)
    {
        
        NSString *start11=[dic objectForKey:@"start"];
        NSArray *arr=[start11 componentsSeparatedByString:@"/"];
        
        NSString *strResStartDate;
        if(arr.count != 0)
        {
            strResStartDate=[arr objectAtIndex:1];
        }
        
        if([strDate11 isEqual:strResStartDate])
        {
            [arrTotalEventThisMonth addObject:strResStartDate];
        }
    }
    long totalEvent=[arrTotalEventThisMonth count];
    if(totalEvent <= 9)
    {
        [self.lblEventCount setText:[NSString stringWithFormat:@"%ld",totalEvent]];
    }
    else
    {
        [self.lblEventCount setText:[NSString stringWithFormat:@"9+"]];
    }

    if([arrTotalEventThisMonth count] == 0)
    {
        [self.viewEventTotal setHidden:YES];
    }
    else
    {
        [self.viewEventTotal setHidden:NO];
    }
}

#pragma mark - Calender Delegate


- (nullable UIImage *)calendar:(FSCalendar *)calendar imageForDate:(NSDate *)date
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM"];
    NSString *strDate123=[formatter stringFromDate:date];
    
    NSDate *currentPageDate=self.calendar.currentPage;
    NSDateFormatter *formatter1=[[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"MM"];
    NSString *strDate1=[formatter1 stringFromDate:currentPageDate];
    
    if([strDate123 isEqual:strDate1])
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
   
    //NSMutableArray *arrTotalEventThisMonth=[[NSMutableArray alloc]init];
    for (NSMutableDictionary *dic in arrCalenderDetailList)
    {
//        NSDateFormatter *formatter12=[[NSDateFormatter alloc]init];
//        [formatter12 setDateFormat:@"MM"];
//        NSString *strDate11=[formatter12 stringFromDate:date];
//        
//        NSString *start11=[dic objectForKey:@"start"];
//        NSArray *arr=[start11 componentsSeparatedByString:@"/"];
//        
//        NSString *strResStartDate;
//        if(arr.count != 0)
//        {
//            strResStartDate=[arr objectAtIndex:1];
//        }
//        NSDateFormatter *formatter33=[[NSDateFormatter alloc]init];
//        [formatter33 setDateFormat:@"MM"];
//        NSString *strDate33=[formatter33 stringFromDate:self.calendar.currentPage];
//        
//        if([strDate123 isEqual:strDate33])
//        {
//            if([strDate11 isEqual:strResStartDate])
//            {
//                [arrTotalEventThisMonth addObject:strResStartDate];
//            }
//        }
        NSString *type=[dic objectForKey:@"type"];
        if ([@"Activity" isEqualToString:type]) {
            
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy/MM/dd"];
            NSString *strDate=[formatter stringFromDate:date];
            
            
            NSString *start=[dic objectForKey:@"start"];
            if([strDate123 isEqual:strDate1])
            {
            if([strDate isEqualToString:start])
            {
                return [UIImage imageNamed:@"notify_20"];
            }
            }
        }
        if ([@"Event" isEqualToString:type])
        {
            
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy/MM/dd"];
            NSString *strDate=[formatter stringFromDate:date];
            
            
            NSString *start=[dic objectForKey:@"start"];
            if([strDate123 isEqual:strDate1])
            {
            if([strDate isEqualToString:start])
            {
                return [UIImage imageNamed:@"notify_20"];
            }}
        }
        if ([@"Exam" isEqualToString:type])
        {
            
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy/MM/dd"];
            NSString *strDate=[formatter stringFromDate:date];
            
            
            NSString *start=[dic objectForKey:@"start"];
            
            if([strDate isEqualToString:start])
            {
                return [UIImage imageNamed:@"exam_20"];
            }
        }

        if ([@"Todos" isEqualToString:type])
        {
            
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy/MM/dd"];
            NSString *strDate=[formatter stringFromDate:date];
            
            
            NSString *start=[dic objectForKey:@"start"];
            if([strDate123 isEqual:strDate1])
            {
            if([strDate isEqualToString:start])
            {
                return [UIImage imageNamed:@"notify_20"];
            }
            }
        }

        if ([@"Holiday" isEqualToString:type])
        {
            
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy/MM/dd"];
            NSString *strDate=[formatter stringFromDate:date];
            
            
            NSString *start=[dic objectForKey:@"start"];
            
            if([strDate isEqualToString:start])
            {
                return [UIImage imageNamed:@"notify_red_20"];
            }
        }

    }
    
//    long totalEvent=[arrTotalEventThisMonth count];
//    if(totalEvent <= 9)
//    {
//        [self.lblEventCount setText:[NSString stringWithFormat:@"%ld",totalEvent]];
//    }
//    else
//    {
//        [self.lblEventCount setText:[NSString stringWithFormat:@"9+"]];
//    }

    
   
    return nil;
    //    else
    //    {
    //        return [UIImage imageNamed:@"notify"];
    //    }
}

- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
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
    }
}

- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
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
    }
}

- (IBAction)btnMonthPre:(id)sender {
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *previousMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:currentMonth options:0];
    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
    [formater setDateFormat:@"MMM"];
    NSString *month=[formater stringFromDate:previousMonth];
    [_lblMonth setText:[NSString stringWithFormat:@"%@",month]];
    [self.calendar setCurrentPage:previousMonth animated:YES];
    
    [self setTotalEventCount];
}
- (IBAction)btnMonthNext:(id)sender {
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:currentMonth options:0];
    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
    [formater setDateFormat:@"MMM"];
    NSString *month=[formater stringFromDate:nextMonth];
    [_lblMonth setText:[NSString stringWithFormat:@"%@",month]];
    [self.calendar setCurrentPage:nextMonth animated:YES];
    [self setTotalEventCount];
}
- (IBAction)btnYearPre:(id)sender {
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *previousMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitYear value:-1 toDate:currentMonth options:0];
    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy"];
    NSString *month=[formater stringFromDate:previousMonth];
    [_lblYear setText:[NSString stringWithFormat:@"%@",month]];
    [self.calendar setCurrentPage:previousMonth animated:YES];
    [self setTotalEventCount];
}
- (IBAction)btnYearNext:(id)sender {
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitYear value:1 toDate:currentMonth options:0];
    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy"];
    NSString *month=[formater stringFromDate:nextMonth];
    [_lblYear setText:[NSString stringWithFormat:@"%@",month]];
    [self.calendar setCurrentPage:nextMonth animated:YES];
    [self setTotalEventCount];
}

#pragma mark - UIButton Action

- (IBAction)btnEventDetailLIst:(id)sender {
    UIViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"CalenderEventVc"];
    [self.navigationController pushViewController:vc animated:YES];
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

- (IBAction)btnHomeClicked:(id)sender
{
    [self.frostedViewController hideMenuViewController];
    UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"OrataroVc"];
    
    [self.navigationController pushViewController:wc animated:NO];
}

@end
