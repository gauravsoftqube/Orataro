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

@interface CalenderVc ()<FSCalendarDataSource,FSCalendarDelegate>
{
    FSCalendar *calendar1;
    UILabel *lblMonth;
    UILabel *lblYear;
    int c2;
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
    
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
    [formater setDateFormat:@"MMMM"];
    NSString *month=[formater stringFromDate:self.calendar.currentPage];
    [_lblMonth setText:[NSString stringWithFormat:@"%@",month]];
    
    NSDateFormatter *formaterYear=[[NSDateFormatter alloc]init];
    [formaterYear setDateFormat:@"yyyy"];
    NSString *Year=[formaterYear stringFromDate:self.calendar.currentPage];
    [_lblYear setText:[NSString stringWithFormat:@"%@",Year]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nullable UIImage *)calendar:(FSCalendar *)calendar imageForDate:(NSDate *)date
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *strDate=[formatter stringFromDate:date];
    
    NSDateFormatter *formatter1=[[NSDateFormatter alloc]init];
    [formatter1 setDateFormat:@"dd/MM/yyyy"];
    NSString *strDate1=[formatter1 stringFromDate:[NSDate new]];
    
    if([strDate  isEqual:strDate1])
    {
        return [UIImage imageNamed:@"coloricon"];
    }
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
    [formater setDateFormat:@"MMMM"];
    NSString *month=[formater stringFromDate:previousMonth];
    [_lblMonth setText:[NSString stringWithFormat:@"%@",month]];
    [self.calendar setCurrentPage:previousMonth animated:YES];
}
- (IBAction)btnMonthNext:(id)sender {
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:currentMonth options:0];
    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
    [formater setDateFormat:@"MMMM"];
    NSString *month=[formater stringFromDate:nextMonth];
    [_lblMonth setText:[NSString stringWithFormat:@"%@",month]];
    [self.calendar setCurrentPage:nextMonth animated:YES];
}
- (IBAction)btnYearPre:(id)sender {
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *previousMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitYear value:-1 toDate:currentMonth options:0];
    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy"];
    NSString *month=[formater stringFromDate:previousMonth];
    [_lblYear setText:[NSString stringWithFormat:@"%@",month]];
    [self.calendar setCurrentPage:previousMonth animated:YES];
}
- (IBAction)btnYearNext:(id)sender {
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitYear value:1 toDate:currentMonth options:0];
    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy"];
    NSString *month=[formater stringFromDate:nextMonth];
    [_lblYear setText:[NSString stringWithFormat:@"%@",month]];
    [self.calendar setCurrentPage:nextMonth animated:YES];
}
- (IBAction)btnEventDetailLIst:(id)sender {
    UIViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"CalenderEventVc"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)MenuBtnClicked:(id)sender
{
     if (c2==0)
    {
        self.frostedViewController.direction = REFrostedViewControllerDirectionRight;
        self.frostedViewController.panGestureEnabled = NO;
        [self.frostedViewController presentMenuViewController];
        c2=1;
    }
    else
    {
        [self.frostedViewController hideMenuViewController];
        self.frostedViewController.panGestureEnabled = NO;
        c2 =0;
    }
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
