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
    
    NSMutableArray *arrPopup;
    NSString *strdelete_selecteid;
}
@end

@implementation ClassworkVC
@synthesize aCalenderView,aView1;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    gh =(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    aCalenderView.layer.cornerRadius = 50.0;
    aCalenderView.layer.borderWidth =2.0;
    aCalenderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    aView1.layer.cornerRadius = 20;
    
    
    [self commonData];
}

-(void)commonData
{
    self.tblClassworkList.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    //set Header Title
    NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
    if (arr.count != 0) {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Classwork (%@)",[arr objectAtIndex:0]];
    }
    else
    {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Classwork"];
    }
    
    //
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    UITableViewController *tableViewController = [[UITableViewController alloc] init];
    tableViewController.tableView = self.tblClassworkList;
    tableViewController.refreshControl = refreshControl;
    
    //
    [self.viewDelete_Conf setHidden:YES];
    _viewSave.layer.cornerRadius = 30.0;
    _viewInnerSave.layer.cornerRadius = 25.0;
    _imgCancel.image = [_imgCancel.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_imgCancel setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
}

-(void)refreshData
{
    [self apiCallMethod];
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
    
    [self apiCallMethod];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)apiCallMethod
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        NSMutableArray *arrLoacalDb = [DBOperation selectData:@"select * from ClassWorkList"];
        NSMutableArray *arrListTemp = [Utility getLocalDetail:arrLoacalDb columnKey:@"classworkJsonStr"];
        
        if(arrListTemp.count == 0)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        else
        {
            [self ManageClassWorkList:arrListTemp];
        }
    }
    else
    {
        NSMutableArray *arrLoacalDb = [DBOperation selectData:@"select * from ClassWorkList"];
        NSMutableArray *arrListTemp = [Utility getLocalDetail:arrLoacalDb columnKey:@"classworkJsonStr"];
        [self ManageClassWorkList:arrListTemp];
        
        if(arrListTemp.count == 0)
        {
            [self apiCallFor_getClasswork:YES];
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
         [self.tblClassworkList.refreshControl endRefreshing];
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
                     [self ManageClassWorkList:arrResponce];
                     [DBOperation executeSQL:@"delete from ClassWorkList"];
                     for (NSMutableDictionary *dic in arrResponce)
                     {
                         NSString *getjsonstr = [Utility Convertjsontostring:dic];
                         [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO ClassWorkList (classworkJsonStr) VALUES ('%@')",getjsonstr]];
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

-(void)ManageClassWorkList:(NSMutableArray *)arrResponce
{
    arrClassWorkList=[[NSMutableArray alloc]init];
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
        
        NSSortDescriptor * brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"DateOfClassWork" ascending:NO];
        NSArray * sortedArray3 = [items sortedArrayUsingDescriptors:@[brandDescriptor]];
        
        [entry setObject:sortedArray3 forKey:@"items"];
        [arrClassWorkList addObject:entry];
    }
    
    arrClassWorkList = [[[arrClassWorkList reverseObjectEnumerator]allObjects]mutableCopy];
    [_tblClassworkList reloadData];
    
}

-(void)apiCallFor_Delete : (BOOL)checkProgress  deleteId:(NSString *)deleteID
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_notes,apk_AssociationDelete_action];
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",deleteID] forKey:@"PrimaryID"];
    
    [param setValue:[NSString stringWithFormat:@"ClassWork"] forKey:@"AssociationType"];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    
    
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
             NSMutableArray *arrResponce = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]mutableCopy];
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dicResponce=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[[dicResponce objectForKey:@"message"]mutableCopy];
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dicResponce objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     //                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dicResponce objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     //                     [alrt show];
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
    
    NSString *getdt = [d objectForKey:@"DateOfClassWork"];
    NSString *IsRead = [d objectForKey:@"IsRead"];
    
    NSString *getMilisecond = [Utility convertMiliSecondtoDate:@"dd/MM/yyyy" date:getdt];
    UILabel *lbHeaderDt = (UILabel *)[cell.contentView viewWithTag:3];
    
    NSString *getfrmt = [Utility convertDateFtrToDtaeFtr:@"dd/MM/yyyy" newDateFtr:@"dd EEE" date:getMilisecond];
    lbHeaderDt.text = getfrmt;
    
    UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:31];
    if([IsRead integerValue] == 1)
    {
        [img setImage:[UIImage imageNamed:@"double_tick_sky_blue"]];
    }
    else
    {
        [img setImage:[UIImage imageNamed:@"tick_sky_blue"]];
    }
    
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
    
    UIButton *btnDelete = (UIButton *)[cell.contentView viewWithTag:5];
    if([[Utility getMemberType] isEqualToString:@"Student"])
    {
        [btnDelete setHidden:YES];
        [btnDelete setFrame:CGRectMake(btnDelete.frame.origin.x, btnDelete.frame.origin.y, 0, btnDelete.frame.size.height)];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubjectVc *b = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SubjectVc"];
    b.passVal = @"Classwork";
    b.dicSelect_detail = [[[arrClassWorkList objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:b animated:YES];
}


#pragma mark - tbl UIButton Action

- (IBAction)btnTblDeleteClasswork:(id)sender
{
    arrPopup = [[NSMutableArray alloc]init];
    [arrPopup addObject:[Utility addCell_PopupView:self.viewAddPage ParentView:self.view sender:sender]];
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblClassworkList];
    NSIndexPath *indexPath = [self.tblClassworkList indexPathForRowAtPoint:buttonPosition];
    NSMutableDictionary *dicAddpage = [[[arrClassWorkList objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
    strdelete_selecteid=[dicAddpage objectForKey:@"ClassWorkID"];
    [self.lblDeleteConf_Detail setText:[NSString stringWithFormat:@"%@",[dicAddpage objectForKey:@"SubjectName"]]];
}

- (IBAction)btnDeleteConf_Cancel:(id)sender
{
    [self.viewDelete_Conf setHidden:YES];
}

- (IBAction)btnDeleteConf_Yes:(id)sender
{
    [self.viewDelete_Conf setHidden:YES];
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSArray *ary = [DBOperation selectData:@"select * from ClassWorkList"];
    NSMutableArray *arrTemp = [Utility getLocalDetail:ary columnKey:@"classworkJsonStr"];
    for (int i=0;i<[arrTemp count]; i++) {
        NSMutableDictionary *dic=[arrTemp objectAtIndex:i];
        NSString *str=[[dic objectForKey:@"ClassWorkID"]mutableCopy];
        if([str isEqualToString:strdelete_selecteid])
        {
            NSMutableDictionary *dicLocalDB=[[ary objectAtIndex:i]mutableCopy];
            NSString *strid=[dicLocalDB objectForKey:@"id"];
            [DBOperation executeSQL:[NSString stringWithFormat:@"delete from ClassWorkList where id = '%@'",strid]];
            [arrTemp removeObject:dic];
        }
    }
    
    [self ManageClassWorkList:arrTemp];
    
    if([strdelete_selecteid length] != 0)
    {
        [self apiCallFor_Delete:NO deleteId:strdelete_selecteid];
    }
    
}

#pragma mark - CMPopTipViewDelegate methods

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
    [arrPopup removeObject:popTipView];
}

- (IBAction)btnDelete_popup:(id)sender
{
    [Utility dismissAllPopTipViews:arrPopup];
    
    if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"])
    {
        if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
            {
                if([[Utility getUserRoleRightList:@"Class Work" settingType:@"IsDelete"] integerValue] == 1)
                {
                    if ([Utility isInterNetConnectionIsActive] == false)
                    {
                        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alrt show];
                        return;
                    }
                    [self.viewDelete_Conf setHidden:NO];
                }
                else
                {
                    [WToast showWithText:You_dont_have_permission];
                }
            }
            else
            {
                if ([Utility isInterNetConnectionIsActive] == false)
                {
                    UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alrt show];
                    return;
                }
                [self.viewDelete_Conf setHidden:NO];
            }
            
        }
        else
        {
            if ([Utility isInterNetConnectionIsActive] == false)
            {
                UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alrt show];
                return;
            }
            [self.viewDelete_Conf setHidden:NO];
        }
    }
    else
    {
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        [self.viewDelete_Conf setHidden:NO];
    }
}

#pragma mark - UIButton Action

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
    if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"])
    {
        if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
            {
                if([[Utility getUserRoleRightList:@"Class Work" settingType:@"IsCreate"] integerValue] == 1)
                {
                    if ([Utility isInterNetConnectionIsActive] == false)
                    {
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
                else
                {
                    [WToast showWithText:You_dont_have_permission];
                }
            }
            else
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
        }
        else
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
    }
    else
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
}

- (IBAction)btnHomeClicked:(id)sender
{
    [self.frostedViewController hideMenuViewController];
    
    UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"OrataroVc"];
    
    [self.navigationController pushViewController:wc animated: NO];
}

@end
