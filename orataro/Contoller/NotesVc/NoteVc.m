//
//  NoteVc.m
//  orataro
//
//  Created by MAC008 on 21/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "NoteVc.h"
#import "REFrostedViewController.h"
#import "NoteDecsVc.h"
#import "AddNoteVc.h"
#import "AppDelegate.h"
#import "Global.h"

@interface NoteVc ()
{
    int c2;
    AppDelegate *app;
    NSMutableArray *arrNotesList;
}
@end

@implementation NoteVc
@synthesize aView1,aCalenderView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    aCalenderView.layer.cornerRadius = 50.0;
    aCalenderView.layer.borderWidth = 2.0;
    aCalenderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    aView1.layer.cornerRadius = 30.0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tblNote.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
    if (arr.count != 0) {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Notes (%@)",[arr objectAtIndex:0]];
    }
    else
    {
         self.lblHeaderTitle.text=[NSString stringWithFormat:@"Notes"];
    }
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        arrNotesList = [[NSMutableArray alloc]init];
        NSArray *ary = [DBOperation selectData:@"select * from NotList"];
        arrNotesList = [Utility getLocalDetail:ary columnKey:@"dic_json"];
        [self.tblNote reloadData];
        
        if(arrNotesList.count == 0)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
    }
    else
    {
        arrNotesList = [[NSMutableArray alloc]init];
        NSArray *ary = [DBOperation selectData:@"select * from NotList"];
        arrNotesList = [Utility getLocalDetail:ary columnKey:@"dic_json"];
        [self.tblNote reloadData];
        
        if(arrNotesList.count == 0)
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
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_notes,apk_GetNotesList_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    
    if([[Utility getMemberType] isEqualToString:@"Teacher"])
    {
        [param setValue:[NSString stringWithFormat:@""] forKey:@"BeachID"];
        [param setValue:[NSString stringWithFormat:@"Teacher"] forKey:@"RoleName"];
        [param setValue:[NSString stringWithFormat:@""] forKey:@"GradeID"];
        [param setValue:[NSString stringWithFormat:@""] forKey:@"DivisionID"];
    }
    else
    {
        [param setValue:@"" forKey:@"BeachID"];
        [param setValue:[NSString stringWithFormat:@"Student"] forKey:@"RoleName"];
        [param setValue:[NSString stringWithFormat:@"GradeID"] forKey:@"GradeID"];
        [param setValue:[NSString stringWithFormat:@"DivisionID"] forKey:@"DivisionID"];
    }
    
    
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
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     [self ManageNotesList:arrResponce];
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

-(void)ManageNotesList:(NSMutableArray *)arrResponce
{
    arrNotesList = [[NSMutableArray alloc]init];
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:arrResponce];
    
    for (int i=0; i< mutableArray.count; i++)
    {
        NSString *strDate=[NSString stringWithFormat:@"%@",[[mutableArray objectAtIndex:i]objectForKey:@"ActionStartDate"]];
        strDate =[Utility convertMiliSecondtoDate:@"MM/dd/yyyy" date:strDate];
        NSMutableDictionary *d = [[mutableArray objectAtIndex:i] mutableCopy];
        NSString *DateOfCircular=[Utility convertDateFtrToDtaeFtr:@"MM/dd/yyyy" newDateFtr:@"MM/yyyy" date:strDate];
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
        
        
        NSSortDescriptor * brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"ActionStartDate" ascending:YES];
        NSArray * sortedArray3 = [items sortedArrayUsingDescriptors:@[brandDescriptor]];
        
        
        [entry setObject:sortedArray3 forKey:@"items"];
        [arrNotesList addObject:entry];
    }
    
    [DBOperation executeSQL:@"delete from NotList"];
    for (NSMutableDictionary *dic in arrNotesList)
    {
        NSString *getjsonstr = [Utility Convertjsontostring:dic];
        [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO NotList (dic_json) VALUES ('%@')",getjsonstr]];
    }
    
    //NSArray *ary = [DBOperation selectData:@"select * from NotList"];
   // arrNotesList = [Utility getLocalDetail:ary columnKey:@"dic_json"];
    [self.tblNote reloadData];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [arrNotesList count];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *HeaderCellIdentifier = @"NoteHeaderCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCellIdentifier];
    }
    UIView *viewRound=(UIView *)[cell.contentView viewWithTag:1];
    [viewRound.layer setCornerRadius:50];
    viewRound.clipsToBounds=YES;
    [viewRound.layer setBorderColor:[UIColor colorWithRed:202/255.0f green:202/255.0f blue:202/255.0f alpha:1.0f].CGColor];
    [viewRound.layer setBorderWidth:2];
    
    NSString *st = [[arrNotesList objectAtIndex:section] objectForKey:@"Groups"];
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
    NSInteger rows = [[[arrNotesList objectAtIndex:section] objectForKey:@"items"] count];
    
    return rows;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"NoteRowCell"];
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
    
    NSDictionary *d = [[[arrNotesList objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
    NSString *getdt = [d objectForKey:@"ActionStartDate"];
    getdt =[Utility convertMiliSecondtoDate:@"MM/dd/yyyy" date:getdt];
    
    UILabel *lbHeaderDt = (UILabel *)[cell.contentView viewWithTag:3];
    NSString *getfrmt = [Utility convertDateFtrToDtaeFtr:@"MM/dd/yyyy" newDateFtr:@"dd EEE" date:getdt];
    lbHeaderDt.text = getfrmt;
    
    NSString *NoteTitle = [d objectForKey:@"NoteTitle"];
    NSString *NoteDetails = [d objectForKey:@"NoteDetails"];
    
    
    UILabel *lblTitle = (UILabel *)[cell.contentView viewWithTag:4];
    [lblTitle setText:[[NSString stringWithFormat:@"%@",NoteTitle] capitalizedString]];
    
    UILabel *lblDetail = (UILabel *)[cell.contentView viewWithTag:6];
    [lblDetail setText:@""];
    if(![NoteDetails isKindOfClass:[NSNull class]])
    {
        [lblDetail setText:[[NSString stringWithFormat:@"%@",NoteDetails] capitalizedString]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NoteDecsVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"NoteDecsVc"];
    vc.dicSelectNotes=[[[arrNotesList objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - button action

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


- (IBAction)CreateNoteBtnClicked:(id)sender
{
    AddNoteVc *a = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddNoteVc"];
    [self.navigationController pushViewController:a animated:YES];
}

- (IBAction)btnHomeClicked:(id)sender
{
     [self.frostedViewController hideMenuViewController];
    UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"OrataroVc"];
    
    [self.navigationController pushViewController:wc animated:NO];
}
@end
