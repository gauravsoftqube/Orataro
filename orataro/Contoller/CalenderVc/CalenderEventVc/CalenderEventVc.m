//
//  CalenderEventVc.m
//  orataro
//
//  Created by Softqube on 22/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "CalenderEventVc.h"
#import "CalenderEventDetailVc.h"
#import "Global.h"

@interface CalenderEventVc ()
{
    NSMutableArray *arrCalenderEventListMain;
    NSMutableArray *arrCalenderEventList;
    NSString *flagActivity;
    NSString *flagEvent;
    NSString *flagExam;
    NSString *flagHoliday;
}
@end

@implementation CalenderEventVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    flagActivity=@"0";
    flagEvent=@"0";
    flagExam=@"0";
    flagHoliday=@"0";

    [self.viewFilterImage.layer setCornerRadius:10];
    self.viewFilterImage.clipsToBounds=YES;
    
    self.tblCalenderEventList.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self.viewPopupBorder.layer setBorderColor:[UIColor colorWithRed:34/255.0f green:49/255.0f blue:89/255.0f alpha:1.0f].CGColor];
    [self.viewPopupBorder.layer setBorderWidth:2];
    [self PopupHidden];
    
    arrCalenderEventListMain = [[NSMutableArray alloc]init];
    [arrCalenderEventListMain addObjectsFromArray:self.arrCalenderDetail];
    [self ManageCalenderEventList:self.arrCalenderDetail];
}

-(void)PopupHidden
{
    [self.btnPopuBack setHidden:YES];
    [self.viewPopup setHidden:YES];
}

-(void)PopupShow
{
    [self.btnPopuBack setHidden:NO];
    [self.viewPopup setHidden:NO];
}

-(void)ManageCalenderEventList:(NSMutableArray *)arrResponce
{
    arrCalenderEventList = [[NSMutableArray alloc]init];
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:arrResponce];
    
    for (int i=0; i< mutableArray.count; i++)
    {
        NSMutableDictionary *d = [[mutableArray objectAtIndex:i] mutableCopy];
        NSString *DateOfCircular=[Utility convertDateFtrToDtaeFtr:@"yyyy/MM/dd" newDateFtr:@"MM/yyyy" date:[NSString stringWithFormat:@"%@",[[mutableArray objectAtIndex:i]objectForKey:@"start"]]];
        
        [d setObject:DateOfCircular forKey:@"Group"];
        [mutableArray replaceObjectAtIndex:i withObject:d];
        
        arrResponce = mutableArray;
    }
    
    NSArray *temp = [arrResponce sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"Group" ascending:YES]]];
    
    
    [arrResponce removeAllObjects];
    [arrResponce addObjectsFromArray:temp];
    
    NSArray *areas = [arrResponce valueForKeyPath:@"@distinctUnionOfObjects.Group"];
    
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES];
    
    NSArray *sorters = [[NSArray alloc] initWithObjects:sorter, nil];
    NSArray *sortedArray = [areas sortedArrayUsingDescriptors:sorters];
    NSDateFormatter *dateFormatter1 = [NSDateFormatter new];
    dateFormatter1.dateFormat = @"MM-yyyy";
    NSArray *sortedArray1 = [sortedArray sortedArrayUsingComparator:^(NSString *string1, NSString *string2)
                             {
                                 NSDate *date1 = [dateFormatter1 dateFromString:string1];
                                 NSDate *date2 = [dateFormatter1 dateFromString:string2];
                                 
                                 return [date1 compare:date2];
                             }];
    
    
    sortedArray = [[NSArray alloc]initWithArray:sortedArray1];
    
    for (NSString *area in sortedArray)
    {
        __autoreleasing NSMutableDictionary *entry = [NSMutableDictionary new];
        [entry setObject:area forKey:@"Groups"];
        
        __autoreleasing NSArray *temp = [arrResponce filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"Group = %@", area]];
        
        __autoreleasing NSMutableArray *items = [NSMutableArray new];
        
        NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"Group"                                                                        ascending:YES];
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
        items = [[NSMutableArray alloc] initWithArray:[temp sortedArrayUsingDescriptors:sortDescriptors]];
        
        
        NSSortDescriptor * brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"start" ascending:NO];
        NSArray * sortedArray3 = [items sortedArrayUsingDescriptors:@[brandDescriptor]];
        
        
        [entry setObject:sortedArray3 forKey:@"items"];
        [arrCalenderEventList addObject:entry];
    }
    
    NSArray *temp12 = [arrCalenderEventList sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"Groups" ascending:NO]]];
    [arrCalenderEventList removeAllObjects];
    arrCalenderEventList =[temp12 mutableCopy];

    [_tblCalenderEventList reloadData];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [arrCalenderEventList count];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *HeaderCellIdentifier = @"cellSection";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCellIdentifier];
    }
    UIView *viewRound=(UIView *)[cell.contentView viewWithTag:1];
    [viewRound.layer setCornerRadius:50];
    viewRound.clipsToBounds=YES;
    [viewRound.layer setBorderColor:[UIColor colorWithRed:202/255.0f green:202/255.0f blue:202/255.0f alpha:1.0f].CGColor];
    [viewRound.layer setBorderWidth:2];
    
    NSString *st = [[arrCalenderEventList objectAtIndex:section] objectForKey:@"Groups"];
    NSString *getfrmt = [Utility convertDateFtrToDtaeFtr:@"MM/yyyy" newDateFtr:@"MMM yyyy" date:st];
    NSArray* getary = [getfrmt componentsSeparatedByString: @" "];
    
    UILabel *lbTitle = (UILabel *)[cell.contentView viewWithTag:2];
    lbTitle.text = [getary objectAtIndex: 0];
    
    UILabel *lbDesc = (UILabel *)[cell.contentView viewWithTag:3];
    lbDesc.text = [getary objectAtIndex: 1];

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = [[[arrCalenderEventList objectAtIndex:section] objectForKey:@"items"] count];
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellRow"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UIView *viewBackgroundCell=(UIView *)[cell.contentView viewWithTag:1];
    UIView *viewDateBackground=(UIView *)[cell.contentView viewWithTag:2];
    if(indexPath.row % 2)
    {
        [viewBackgroundCell setBackgroundColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f]];
        [viewDateBackground setBackgroundColor:[UIColor colorWithRed:46/255.0f green:60/255.0f blue:100/255.0f alpha:1.0f]];
    }
    else
    {
        [viewBackgroundCell setBackgroundColor:[UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f]];
        [viewDateBackground setBackgroundColor:[UIColor colorWithRed:29/255.0f green:42/255.0f blue:76/255.0f alpha:1.0f]];
    }
    
    NSDictionary *d = [[[arrCalenderEventList objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
   
    NSString *getdt = [d objectForKey:@"start"];
    getdt =[Utility convertDateFtrToDtaeFtr:@"yyyy/MM/dd" newDateFtr:@"dd EEE" date:getdt];
    
    UILabel *lbHeaderDt = (UILabel *)[cell.contentView viewWithTag:3];
    lbHeaderDt.text = getdt;
    
    NSString *Title = [d objectForKey:@"title"];
    NSString *activitydetails = [d objectForKey:@"activitydetails"];
    
    
    UILabel *lblTitle = (UILabel *)[cell.contentView viewWithTag:4];
    [lblTitle setText:[[NSString stringWithFormat:@"%@",Title] capitalizedString]];
    
    NSString *type = [d objectForKey:@"type"];
    UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:5];
    if ([@"Activity" isEqualToString:type])
    {
        [img setImage:[UIImage imageNamed:@"notify"]];
    }
    if ([@"Event" isEqualToString:type])
    {
        [img setImage:[UIImage imageNamed:@"notify"]];
    }
    if ([@"Exam" isEqualToString:type])
    {
        [img setImage:[UIImage imageNamed:@"exam"]];
    }
    if ([@"Todos" isEqualToString:type])
    {
        [img setImage:[UIImage imageNamed:@"notify"]];
    }
    if ([@"Holiday" isEqualToString:type])
    {
        [img setImage:[UIImage imageNamed:@"notify_red"]];
    }
    
    UILabel *lblDetail = (UILabel *)[cell.contentView viewWithTag:6];
    [lblDetail setText:@""];
    if(![activitydetails isKindOfClass:[NSNull class]])
    {
        [lblDetail setText:[[NSString stringWithFormat:@"%@",activitydetails] capitalizedString]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CalenderEventDetailVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"CalenderEventDetailVc"];
    vc.dicSelectedEventdDetail = [[[[arrCalenderEventList objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row]mutableCopy];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UIButton Action

- (IBAction)btnHeaderMenu:(id)sender {
    [self PopupShow];
}
- (IBAction)btnHome:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnPopuBack:(id)sender {
    [self PopupHidden];
}
- (IBAction)btnSyncCalender:(id)sender {
    [self PopupHidden];
}

#pragma mark - Filter UIButton Action

-(void)filterCalenderEventList
{
    NSMutableArray *arrTemp=[[NSMutableArray alloc]init];
    for (NSMutableDictionary *dic in arrCalenderEventListMain) {
        NSString *type = [dic objectForKey:@"type"];
        
        if ([@"Activity" isEqualToString:type] &&
            [flagActivity isEqualToString:@"1"])
        {
            [arrTemp addObject:dic];
        }
        if ([@"Event" isEqualToString:type] &&
            [flagEvent isEqualToString:@"1"])
        {
            [arrTemp addObject:dic];
        }
        if ([@"Exam" isEqualToString:type] &&
            [flagExam isEqualToString:@"1"])
        {
            [arrTemp addObject:dic];
        }
        if ([@"Holiday" isEqualToString:type] &&
            [flagHoliday isEqualToString:@"1"])
        {
            [arrTemp addObject:dic];
        }
    }
    
    if (arrTemp.count == 0)
    {
        if ([flagActivity isEqualToString:@"0"] &&
            [flagEvent isEqualToString:@"0"] &&
            [flagExam isEqualToString:@"0"] &&
            [flagHoliday isEqualToString:@"0"])
        {
            [self ManageCalenderEventList:arrCalenderEventListMain];
        }
        else
        {
            [self ManageCalenderEventList:arrTemp];
        }
    }
    else
    {
        [self ManageCalenderEventList:arrTemp];
    }
    
}

- (IBAction)btnActivity:(id)sender {
    if([flagActivity isEqualToString:@"0"])
    {

        [_btnActivity setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
        flagActivity=@"1";
        [self filterCalenderEventList];
    }
    else
    {
        [_btnActivity setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
        flagActivity=@"0";
        [self filterCalenderEventList];
    }
}

- (IBAction)btnEvent:(id)sender {
    if([flagEvent isEqualToString:@"0"])
    {
        [_btnEvent setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
        flagEvent=@"1";
        [self filterCalenderEventList];
    }
    else
    {
        [_btnEvent setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
        flagEvent=@"0";
        [self filterCalenderEventList];
    }
}

- (IBAction)btnExam:(id)sender {
    if([flagExam isEqualToString:@"0"])
    {
        [_btnExam setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
        flagExam=@"1";
        [self filterCalenderEventList];
    }
    else
    {
        [_btnExam setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
        flagExam=@"0";
        [self filterCalenderEventList];
    }
}

- (IBAction)btnHoliday:(id)sender {
    if([flagHoliday isEqualToString:@"0"])
    {
        [_btnHoliday setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
        flagHoliday=@"1";
        [self filterCalenderEventList];
    }
    else
    {
        [_btnHoliday setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
        flagHoliday=@"0";
        [self filterCalenderEventList];
    }
}

@end
