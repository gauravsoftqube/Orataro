//
//  TimeTableVc.m
//  orataro
//
//  Created by Softqube Mac IOS on 06/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "TimeTableVc.h"
#import "REFrostedViewController.h"
#import "AppDelegate.h"
#import "Global.h"

@interface TimeTableVc ()
{
    int c2;
    AppDelegate *app;
    NSMutableArray *arrTimeTable,*arrTiemTableMain;
    long totalArrCount,totalArrCountMain;
}
@end

@implementation TimeTableVc
@synthesize PreBtn,NextBtn,NextimageView,PreImageView,aTableView,aTableHeaderView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //TimetableCell
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
    if (arr.count != 0) {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Time Table (%@)",[arr objectAtIndex:0]];
    }
    else
    {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Time Table"];
    }
    
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)commonData
{
    NextimageView.image = [NextimageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [NextimageView setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    PreImageView.image = [PreImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [PreImageView setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    aTableView.tableHeaderView = aTableHeaderView;
    aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        arrTiemTableMain = [[NSMutableArray alloc]init];
        NSMutableArray *arrTiemTableMain_Temp=[DBOperation selectData:[NSString stringWithFormat:@"select * from TimeTable"]];
        for (NSMutableDictionary *dic in arrTiemTableMain_Temp) {
            NSString *json_dic=[dic objectForKey:@"dic_json"];
            NSMutableDictionary *dic_json=[[Utility ConvertStringtoJSON:json_dic]mutableCopy];
            [arrTiemTableMain addObject:dic_json];
        }
        totalArrCountMain = [arrTiemTableMain count];
        totalArrCountMain = totalArrCountMain-1;
        
        arrTimeTable =[[NSMutableArray alloc]init];
        if ([arrTiemTableMain count] != 0) {
            totalArrCount=0;
            NSMutableDictionary *dic=[arrTiemTableMain objectAtIndex:0];
            NSString *Dayofweek=[dic objectForKey:@"Dayofweek"];
            self.lblDayName.text=[Dayofweek capitalizedString];
            [arrTimeTable addObject:dic];
            [self.aTableView reloadData];
        }
        [self.aTableView reloadData];
        
        if(arrTimeTable.count == 0)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
    }
    else
    {
        arrTiemTableMain = [[NSMutableArray alloc]init];
        NSMutableArray *arrTiemTableMain_Temp=[DBOperation selectData:[NSString stringWithFormat:@"select * from TimeTable"]];
        for (NSMutableDictionary *dic in arrTiemTableMain_Temp) {
            NSString *json_dic=[dic objectForKey:@"dic_json"];
            NSMutableDictionary *dic_json=[[Utility ConvertStringtoJSON:json_dic]mutableCopy];
            [arrTiemTableMain addObject:dic_json];
        }
        totalArrCountMain = [arrTiemTableMain count];
        totalArrCountMain = totalArrCountMain-1;
        
        arrTimeTable =[[NSMutableArray alloc]init];
        if ([arrTiemTableMain count] != 0) {
            totalArrCount=0;
            NSMutableDictionary *dic=[arrTiemTableMain objectAtIndex:0];
            NSString *Dayofweek=[dic objectForKey:@"Dayofweek"];
            self.lblDayName.text=[Dayofweek capitalizedString];
            [arrTimeTable addObject:dic];
            [self.aTableView reloadData];
        }
        [self.aTableView reloadData];

        if(arrTiemTableMain.count == 0)
        {
            [self apiCallFor_getTimeTableList:@"1"];
        }
        else
        {
            [self apiCallFor_getTimeTableList:@"0"];
        }
    }
}


#pragma mark - ApiCall

-(void)apiCallFor_getTimeTableList:(NSString *)strShowHUB
{
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_timetable,apk_GetTimeTableListForTeachert_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    if([strShowHUB isEqualToString:@"1"])
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
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:TIMETABLELIST delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     
                     arrTiemTableMain = [[NSMutableArray alloc]init];
                     arrTiemTableMain = [arrResponce mutableCopy];
                     [DBOperation executeSQL:[NSString stringWithFormat:@"DELETE FROM TimeTable"]];
                     for (NSMutableDictionary *dic in arrTiemTableMain) {
                         NSString *json_dic=[Utility Convertjsontostring:dic];
                         [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO TimeTable(dic_json)values('%@')",json_dic]];
                     }
                     
                     totalArrCountMain = [arrTiemTableMain count];
                     totalArrCountMain = totalArrCountMain-1;
                     
                     arrTimeTable =[[NSMutableArray alloc]init];
                     if ([arrTiemTableMain count] != 0) {
                         totalArrCount=0;
                         NSMutableDictionary *dic=[arrTiemTableMain objectAtIndex:0];
                         NSString *Dayofweek=[dic objectForKey:@"Dayofweek"];
                         self.lblDayName.text=[Dayofweek capitalizedString];
                         [arrTimeTable addObject:dic];
                         [self.aTableView reloadData];
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


#pragma mark - UITableview Delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimetableCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TimetableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row % 2 ==0)
    {
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    }
    
    UILabel *lblTime=(UILabel *)[cell.contentView viewWithTag:11];
    [lblTime setText:[NSString stringWithFormat:@"%@ %@",[arrTimeTable[indexPath.row] objectForKey:@"StartTime"],[arrTimeTable[indexPath.row] objectForKey:@"EndTime"]]];
    
    UILabel *lblSubject=(UILabel *)[cell.contentView viewWithTag:12];
    [lblSubject setText:[NSString stringWithFormat:@"%@/%@/%@",[arrTimeTable[indexPath.row] objectForKey:@"GradeName"],[arrTimeTable[indexPath.row] objectForKey:@"DivisionName"],[arrTimeTable[indexPath.row] objectForKey:@"SubjectName"]]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrTimeTable count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // as per content
    return 50;
}


#pragma mark - UIButton Action

- (IBAction)PreBtnClicked:(id)sender {
   
}

- (IBAction)NextBtnClicked:(id)sender {
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
- (IBAction)btnNext:(id)sender
{
    if(totalArrCount <= totalArrCountMain)
    {
        arrTimeTable =[[NSMutableArray alloc]init];
        if(totalArrCount < totalArrCountMain)
        {
            totalArrCount = totalArrCount+1;
        }
        NSMutableDictionary *dic=[arrTiemTableMain objectAtIndex:totalArrCount];
        NSString *Dayofweek=[dic objectForKey:@"Dayofweek"];
        self.lblDayName.text=[Dayofweek capitalizedString];
        [arrTimeTable addObject:dic];
        [self.aTableView reloadData];
    }

}
- (IBAction)btnPre:(id)sender
{
    if(totalArrCount >= 0)
    {
        arrTimeTable =[[NSMutableArray alloc]init];
        if(totalArrCount == 0){}else{
            totalArrCount = totalArrCount-1;
        }
        NSMutableDictionary *dic=[arrTiemTableMain objectAtIndex:totalArrCount];
        NSString *Dayofweek=[dic objectForKey:@"Dayofweek"];
        self.lblDayName.text=[Dayofweek capitalizedString];
        [arrTimeTable addObject:dic];
        [self.aTableView reloadData];
    }
}
@end
