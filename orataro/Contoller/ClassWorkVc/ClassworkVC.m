//
//  ClassworkVC.m
//  orataro
//
//  Created by MAC008 on 21/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ClassworkVC.h"
#import "REFrostedViewController.h"
#import "AppDelegate.h"
#import "ListSelectionVc.h"
#import "SubjectVc.h"
#import "Global.h"

@interface ClassworkVC ()
{
    AppDelegate *gh;
    int c2;
    NSMutableArray *arrClassWorkList;
}
@end

@implementation ClassworkVC
@synthesize aCalenderView,aView1;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    gh =(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    aCalenderView.layer.cornerRadius = 50.0;
    aCalenderView.layer.borderWidth =2.0;
    aCalenderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    aView1.layer.cornerRadius = 30.0;
    
     [self commonData];
    
    // Do any additional setup after loading the view.
}
-(void)commonData
{
    self.tblClassworkList.separatorStyle=UITableViewCellSeparatorStyleNone;
    arrClassWorkList =[[NSMutableArray alloc]init];
}

-(void)viewWillAppear:(BOOL)animated
{
    if([[Utility getMemberType] isEqualToString:@"Student"])
    {
        [self.aView1 setHidden:YES];
    }
    else
    {
        [self.aView1 setHidden:NO];
    }

    NSArray *ary = [DBOperation selectData:@"select * from ClassWorkList"];
    //NSLog(@"ary=%@",ary);
    
    arrClassWorkList = [Utility getLocalDetail:ary columnKey:@"classworkJsonStr"];
    [_tblClassworkList reloadData];
    
    if (arrClassWorkList.count == 0)
    {
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        else
        {
            [self apiCallFor_getClasswork:YES];
            
        }
    }
    else
    {
        arrClassWorkList = [Utility getLocalDetail:ary columnKey:@"classworkJsonStr"];
        [_tblClassworkList reloadData];
        
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            
        }
        else
        {
            [self apiCallFor_getClasswork:NO];
        }
    }

}

#pragma mark - ApiCall

-(void)apiCallFor_getClasswork : (BOOL)checkProgress
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_classwork,apk_GetClassWorkList_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@""] forKey:@"BeachID"];
    
    if([[dicCurrentUser objectForKey:@"MemberType"] isEqualToString:@"Student"])
    {
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"DivisionID"]] forKey:@"DivisionID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"GradeID"]] forKey:@"GradeID"];
    }
    else
    {
        [param setValue:[NSString stringWithFormat:@""] forKey:@"DivisionID"];
        [param setValue:[NSString stringWithFormat:@""] forKey:@"GradeID"];
    }
    
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
                     [self ManageHomeworkList:arrResponce];
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

-(void)ManageHomeworkList:(NSMutableArray *)arrResponce
{
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:arrResponce];
    
    for (int i=0; i< mutableArray.count; i++)
    {
        NSMutableDictionary *d = [[mutableArray objectAtIndex:i] mutableCopy];
        
        NSString *DateOfCircular=[Utility convertMiliSecondtoDate:@"MM/yyyy" date:[NSString stringWithFormat:@"%@",[[mutableArray objectAtIndex:i]objectForKey:@"DateOfClassWork"]]];
        
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
        
        
        NSSortDescriptor * brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"DateOfClassWork" ascending:YES];
        NSArray * sortedArray3 = [items sortedArrayUsingDescriptors:@[brandDescriptor]];
        
        
        [entry setObject:sortedArray3 forKey:@"items"];
        [arrClassWorkList addObject:entry];
    }
    
    [DBOperation executeSQL:@"delete from ClassWorkList"];
    for (NSMutableDictionary *dic in arrClassWorkList)
    {
        NSString *getjsonstr = [Utility Convertjsontostring:dic];
        [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO ClassWorkList (classworkJsonStr) VALUES ('%@')",getjsonstr]];
        
    }
    NSArray *ary = [DBOperation selectData:@"select * from ClassWorkList"];
    arrClassWorkList = [Utility getLocalDetail:ary columnKey:@"classworkJsonStr"];
    [_tblClassworkList reloadData];
    
}
#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [arrClassWorkList count];
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
    
    NSString *st = [[arrClassWorkList objectAtIndex:section] objectForKey:@"Groups"];
    
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
    NSInteger rows = [[[arrClassWorkList objectAtIndex:section] objectForKey:@"items"] count];
    
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
    
    NSDictionary *d = [[[arrClassWorkList objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
    
  //  NSLog(@"Dic=%@",d);
    
    
    NSString *getdt = [d objectForKey:@"DateOfClassWork"];
    NSString *getMilisecond = [Utility convertMiliSecondtoDate:@"dd/MM/yyyy" date:getdt];
    UILabel *lbHeaderDt = (UILabel *)[cell.contentView viewWithTag:3];
    
    
    NSString *getfrmt = [Utility convertDateFtrToDtaeFtr:@"dd/MM/yyyy" newDateFtr:@"dd EEE" date:getMilisecond];
    lbHeaderDt.text = getfrmt;
    
    NSString *SubjectName = [d objectForKey:@"SubjectName"];
    NSString *DateOfFinish = [d objectForKey:@"EndTime"];
    NSString *Title = [d objectForKey:@"Title"];
    NSString *GradeName = [d objectForKey:@"GradeName"];
    NSString *DivisionName = [d objectForKey:@"DivisionName"];
    NSString *ClassWorkDetails = [d objectForKey:@"ClassWorkDetails"];
    
    UILabel *lblSubjectName = (UILabel *)[cell.contentView viewWithTag:4];
    
    if([SubjectName isEqual:@"<null>"] || [SubjectName isKindOfClass:[NSNull class]])
    {
        [lblSubjectName setText:[NSString stringWithFormat:@""]];
    }
    else
    {
        [lblSubjectName setText:[NSString stringWithFormat:@"%@",SubjectName]];
    }
    
    UILabel *lblDateOfFinish = (UILabel *)[cell.contentView viewWithTag:5];
    [lblDateOfFinish setText:[NSString stringWithFormat:@"End Date: %@",[Utility convertMiliSecondtoDate:@"dd/MM/yyyy" date:DateOfFinish]]];
    
    //UILabel *lblTitle = (UILabel *)[cell.contentView viewWithTag:6];
   // [lblTitle setText:[NSString stringWithFormat:@"%@",Title]];
    
    UILabel *lblGradeNameDivision = (UILabel *)[cell.contentView viewWithTag:6];
    [lblGradeNameDivision setText:[NSString stringWithFormat:@"%@ %@",GradeName,DivisionName]];
    
    UILabel *lblHomeWorksDetails = (UILabel *)[cell.contentView viewWithTag:7];
    [lblHomeWorksDetails setText:[NSString stringWithFormat:@"%@",ClassWorkDetails]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubjectVc *b = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SubjectVc"];
    b.passVal = @"Classwork";
    b.classworkDic = [[[arrClassWorkList objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:b animated:YES];
}


#pragma mark - tbl UIButton Action

- (IBAction)btnTblDeleteClasswork:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action

- (IBAction)MenuBtnClicked:(UIButton *)sender
{
    self.frostedViewController.direction = REFrostedViewControllerDirectionRight;
    
    
    if (gh.checkview == 0)
    {
        [self.frostedViewController presentMenuViewController];
        gh.checkview = 1;
        
    }
    else
    {
        [self.frostedViewController hideMenuViewController];
        gh.checkview = 0;
    }
}

- (IBAction)btnAddClicked:(id)sender
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    else
    {
        gh.checkListelection = 4;
        ListSelectionVc *l = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ListSelectionVc"];
        [self.navigationController pushViewController:l animated:YES];
    }

   
}

- (IBAction)btnHomeClicked:(id)sender
{
     [self.frostedViewController hideMenuViewController];
    
    UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"OrataroVc"];
    
    [self.navigationController pushViewController:wc animated: NO];
}

@end
