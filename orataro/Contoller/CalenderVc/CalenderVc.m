//
//  CalenderVc.m
//  orataro
//
//  Created by MAC008 on 07/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "CalenderVc.h"
#import "FSCalendar.h"

@interface CalenderVc ()<FSCalendarDataSource,FSCalendarDelegate>
{
    FSCalendar *calendar1;
    UILabel *lblMonth;
    UILabel *lblYear;

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadView
{
    self.title = @"FSCalendar";
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.view = view;
    
    // 450 for iPad and 300 for iPhone
    UIView *viewCalenderback=[[UIView alloc]initWithFrame:CGRectMake(0, 84, view.frame.size.width, 300)];
    viewCalenderback.backgroundColor=[UIColor redColor];
    
    CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 300;
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, height)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.appearance.headerMinimumDissolvedAlpha = 0;
    calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase;
    calendar.calendarHeaderView.hidden=YES;
    calendar.allowsSelection=NO;
    //calendar.pagingEnabled=NO;
    calendar.scrollEnabled=NO;
    
    [viewCalenderback addSubview:calendar];
    [self.view addSubview:viewCalenderback];
    self.calendar = calendar;
    
    UIView *viewHeaderCalender=[[UIView alloc]initWithFrame:CGRectMake(0, calendar.frame.origin.y, view.frame.size.width, 40)];
    viewHeaderCalender.backgroundColor=[UIColor grayColor];
    
    UIButton *btnMonthPrev = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMonthPrev.frame = CGRectMake(0, 0, 35, 40);
    btnMonthPrev.backgroundColor = [UIColor whiteColor];
    btnMonthPrev.titleLabel.font = [UIFont systemFontOfSize:15];
    [btnMonthPrev setImage:[UIImage imageNamed:@"icon_prev"] forState:UIControlStateNormal];
    [btnMonthPrev addTarget:self action:@selector(btnMonthPrev_click:) forControlEvents:UIControlEventTouchUpInside];
    [viewHeaderCalender addSubview:btnMonthPrev];
    
    float widthMain=viewHeaderCalender.frame.size.width - 140;
    float lblWidth=widthMain/2;
    
    lblMonth = [[UILabel alloc]initWithFrame:CGRectMake(btnMonthPrev.frame.origin.x + btnMonthPrev.frame.size.width, 0, lblWidth, 40)];
    lblMonth.textAlignment=NSTextAlignmentCenter;
    lblMonth.backgroundColor = [UIColor whiteColor];
    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
    [formater setDateFormat:@"MMMM"];
    NSString *month=[formater stringFromDate:self.calendar.currentPage];
    [lblMonth setText:[NSString stringWithFormat:@"%@",month]];
    [viewHeaderCalender addSubview:lblMonth];
    
    UIButton *btnMonthNext = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMonthNext.frame = CGRectMake(lblMonth.frame.origin.x+lblMonth.frame.size.width, 0, 35, 40);
    btnMonthNext.backgroundColor = [UIColor whiteColor];
    btnMonthNext.titleLabel.font = [UIFont systemFontOfSize:15];
    [btnMonthNext setImage:[UIImage imageNamed:@"icon_next"] forState:UIControlStateNormal];
    [btnMonthNext addTarget:self action:@selector(btnMonthNext_click:) forControlEvents:UIControlEventTouchUpInside];
    [viewHeaderCalender addSubview:btnMonthNext];
    
    //Year
    UIButton *btnYearPrev = [UIButton buttonWithType:UIButtonTypeCustom];
    btnYearPrev.frame = CGRectMake(btnMonthNext.frame.origin.x+btnMonthNext.frame.size.width, 0, 35, 40);
    btnYearPrev.backgroundColor = [UIColor whiteColor];
    btnYearPrev.titleLabel.font = [UIFont systemFontOfSize:15];
    [btnYearPrev setImage:[UIImage imageNamed:@"icon_prev"] forState:UIControlStateNormal];
    [btnYearPrev addTarget:self action:@selector(btnYearPrev_click:) forControlEvents:UIControlEventTouchUpInside];
    [viewHeaderCalender addSubview:btnYearPrev];
    
    lblYear = [[UILabel alloc]initWithFrame:CGRectMake(btnYearPrev.frame.origin.x + btnYearPrev.frame.size.width, 0, lblWidth, 40)];
    lblYear.textAlignment=NSTextAlignmentCenter;
    lblYear.backgroundColor = [UIColor whiteColor];
    NSDateFormatter *formaterYear=[[NSDateFormatter alloc]init];
    [formaterYear setDateFormat:@"yyyy"];
    NSString *Year=[formaterYear stringFromDate:self.calendar.currentPage];
    [lblYear setText:[NSString stringWithFormat:@"%@",Year]];
    [viewHeaderCalender addSubview:lblYear];
    
    UIButton *btnYearNext = [UIButton buttonWithType:UIButtonTypeCustom];
    btnYearNext.frame = CGRectMake(lblYear.frame.origin.x+lblYear.frame.size.width, 0, 35, 40);
    btnYearNext.backgroundColor = [UIColor whiteColor];
    btnYearNext.titleLabel.font = [UIFont systemFontOfSize:15];
    [btnYearNext setImage:[UIImage imageNamed:@"icon_next"] forState:UIControlStateNormal];
    [btnYearNext addTarget:self action:@selector(btnYearNext_click:) forControlEvents:UIControlEventTouchUpInside];
    [viewHeaderCalender addSubview:btnYearNext];
    
    [viewCalenderback addSubview:viewHeaderCalender];
    
    
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
        return [UIImage imageNamed:@"coloredIcon"];
    }
    else
    {
        return [UIImage imageNamed:@"notify"];
    }
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

- (void)btnMonthPrev_click:(id)sender
{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *previousMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:currentMonth options:0];
    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
    [formater setDateFormat:@"MMMM"];
    NSString *month=[formater stringFromDate:previousMonth];
    [lblMonth setText:[NSString stringWithFormat:@"%@",month]];
    [self.calendar setCurrentPage:previousMonth animated:YES];
}

- (void)btnMonthNext_click:(id)sender
{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:currentMonth options:0];
    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
    [formater setDateFormat:@"MMMM"];
    NSString *month=[formater stringFromDate:nextMonth];
    [lblMonth setText:[NSString stringWithFormat:@"%@",month]];
    [self.calendar setCurrentPage:nextMonth animated:YES];
}

- (void)btnYearPrev_click:(id)sender
{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *previousMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitYear value:-1 toDate:currentMonth options:0];
    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy"];
    NSString *month=[formater stringFromDate:previousMonth];
    [lblYear setText:[NSString stringWithFormat:@"%@",month]];
    [self.calendar setCurrentPage:previousMonth animated:YES];
}

- (void)btnYearNext_click:(id)sender
{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitYear value:1 toDate:currentMonth options:0];
    NSDateFormatter *formater=[[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy"];
    NSString *month=[formater stringFromDate:nextMonth];
    [lblYear setText:[NSString stringWithFormat:@"%@",month]];
    [self.calendar setCurrentPage:nextMonth animated:YES];
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
