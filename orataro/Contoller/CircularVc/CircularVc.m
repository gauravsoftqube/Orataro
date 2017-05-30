//
//  CircularVc.m
//  orataro
//
//  Created by MAC008 on 20/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "CircularVc.h"
#import "REFrostedViewController.h"
#import "AddCircularVc.h"
#import "CircularDetailVc.h"
#import "AppDelegate.h"
#import "OrataroVc.h"
#import "Global.h"

@interface CircularVc ()
{
    int c2;
    AppDelegate *app;
    bool MemberType;
    NSMutableArray *arrCircularList,*arrCircularList_Section;
    
    NSMutableArray *arrPopup;
    NSString *strdelete_selecteid;
}
@end

@implementation CircularVc
@synthesize aView1;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self commonData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)commonData
{
    aView1.layer.cornerRadius =20;
    aView1.layer.borderWidth = 2.0;
    aView1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    //CircularVc
    
    _AddBtn.layer.cornerRadius = 20;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _CircularTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    MemberType =YES;
    arrCircularList=[[NSMutableArray alloc]init];
    arrCircularList_Section=[[NSMutableArray alloc]init];
    
    //
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    UITableViewController *tableViewController = [[UITableViewController alloc] init];
    tableViewController.tableView = self.CircularTableView;
    tableViewController.refreshControl = refreshControl;
    
    //set Header Title
    NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
    if (arr.count != 0) {
        self.lblCircularHeaderTitle.text=[NSString stringWithFormat:@"Circular (%@)",[arr objectAtIndex:0]];
    }
    else
    {
        self.lblCircularHeaderTitle.text=[NSString stringWithFormat:@"Circular"];
    }
    
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
        MemberType=YES;
        [self.AddBtn setHidden:YES];
    }
    else
    {
        MemberType=NO;
        [self.AddBtn setHidden:NO];
    }
    
    [self apiCallMethod];
}

-(void)apiCallMethod
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        NSMutableArray *arrLoacalDb = [DBOperation selectData:@"select * from CircularList"];
        NSMutableArray *arrListTemp = [Utility getLocalDetail:arrLoacalDb columnKey:@"CircularJsonStr"];
        
        if(arrListTemp.count == 0)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        else
        {
            [self ManageCircularList:arrListTemp];
        }
    }
    else
    {
        NSMutableArray *arrLoacalDb = [DBOperation selectData:@"select * from CircularList"];
        NSMutableArray *arrListTemp = [Utility getLocalDetail:arrLoacalDb columnKey:@"CircularJsonStr"];
        [self ManageCircularList:arrListTemp];
        
        if(arrListTemp.count == 0)
        {
            [self apiCallFor_getCircular:YES];
        }
        else
        {
            [self apiCallFor_getCircular:NO];
        }
    }
}


#pragma mark - ApiCall

-(void)apiCallFor_getCircular : (BOOL)checkProgress
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_circular,apk_GetCircularList_action];
    
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
         [self.CircularTableView.refreshControl endRefreshing];
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
                     [self ManageCircularList:arrResponce];
                     [DBOperation executeSQL:@"delete from CircularList"];
                     for (NSMutableDictionary *dic in arrResponce)
                     {
                         NSString *getjsonstr = [Utility Convertjsontostring:dic];
                         [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO CircularList (CircularJsonStr) VALUES ('%@')",getjsonstr]];
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

-(void)ManageCircularList:(NSMutableArray *)arrResponce
{
    arrCircularList = [[NSMutableArray alloc]init];
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:arrResponce];
    
    for (int i=0; i< mutableArray.count; i++)
    {
        NSMutableDictionary *d = [[mutableArray objectAtIndex:i] mutableCopy];
        
        NSString *DateOfCircular=[Utility convertMiliSecondtoDate:@"MM/yyyy" date:[NSString stringWithFormat:@"%@",[[mutableArray objectAtIndex:i]objectForKey:@"DateOfCircular"]]];
        
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
        
        NSSortDescriptor * brandDescriptor = [[NSSortDescriptor alloc] initWithKey:@"DateOfCircular" ascending:NO];
        NSArray * sortedArray3 = [items sortedArrayUsingDescriptors:@[brandDescriptor]];
        
        [entry setObject:sortedArray3 forKey:@"items"];
        [arrCircularList addObject:entry];
    }
    arrCircularList =[[[arrCircularList reverseObjectEnumerator]allObjects]mutableCopy];
    
    [_CircularTableView reloadData];
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
    
    [param setValue:[NSString stringWithFormat:@"Circular"] forKey:@"AssociationType"];
    
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
         [self.CircularTableView.refreshControl endRefreshing];
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
    return [arrCircularList count];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = [[[arrCircularList objectAtIndex:section] objectForKey:@"items"] count];
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CircularRowCell"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UIView *viewBackgroundCell=(UIView *)[cell.contentView viewWithTag:1];
    if(indexPath.row % 2)
    {
        [viewBackgroundCell setBackgroundColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f]];
    }
    else
    {
        [viewBackgroundCell setBackgroundColor:[UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f]];
    }
    
    NSDictionary *d = [[[arrCircularList objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
    
    NSString *getdt = [d objectForKey:@"DateOfCircular"];
    NSString *getMilisecond = [Utility convertMiliSecondtoDate:@"dd/MM/yyyy" date:getdt];
    UILabel *lbHeaderDt = (UILabel *)[cell.contentView viewWithTag:3];
    
    
    NSString *getfrmt = [Utility convertDateFtrToDtaeFtr:@"dd/MM/yyyy" newDateFtr:@"dd EEE" date:getMilisecond];
    lbHeaderDt.text = getfrmt;
    
    NSString *IsRead = [d objectForKey:@"IsRead"];
    UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:31];
    if([IsRead integerValue] == 1)
    {
        [img setImage:[UIImage imageNamed:@"double_tick_sky_blue"]];
    }
    else
    {
        [img setImage:[UIImage imageNamed:@"tick_sky_blue"]];
    }
    
    
    UILabel *lbTitle = (UILabel *)[cell.contentView viewWithTag:4];
    lbTitle.text = [[d objectForKey:@"CircularTitle"] capitalizedString];
    
    UILabel *lbDesc = (UILabel *)[cell.contentView viewWithTag:6];
    lbDesc.text = [[d objectForKey:@"CircularDetails"]capitalizedString];
    
    UIButton *btnDelete = (UIButton *)[cell.contentView viewWithTag:5];
    if([[Utility getMemberType] isEqualToString:@"Student"])
    {
        [btnDelete setHidden:YES];
        [btnDelete setFrame:CGRectMake(btnDelete.frame.origin.x, btnDelete.frame.origin.y, 0, btnDelete.frame.size.height)];
    }
    
    return cell;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *HeaderCellIdentifier = @"CircularHeaderCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCellIdentifier];
    }
    UIView *viewRound=(UIView *)[cell.contentView viewWithTag:1];
    [viewRound.layer setCornerRadius:50];
    viewRound.clipsToBounds=YES;
    [viewRound.layer setBorderColor:[UIColor colorWithRed:202/255.0f green:202/255.0f blue:202/255.0f alpha:1.0f].CGColor];
    [viewRound.layer setBorderWidth:2];
    
    NSString *st = [[arrCircularList objectAtIndex:section] objectForKey:@"Groups"];
    
    NSString *getfrmt = [Utility convertDateFtrToDtaeFtr:@"MM/yyyy" newDateFtr:@"MMM yyyy" date:st];
    
    NSArray* getary = [getfrmt componentsSeparatedByString: @" "];
    
    UILabel *lbTitle = (UILabel *)[cell.contentView viewWithTag:2];
    lbTitle.text = [getary objectAtIndex: 0];
    
    UILabel *lbDesc = (UILabel *)[cell.contentView viewWithTag:3];
    lbDesc.text = [getary objectAtIndex: 1];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CircularDetailVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"CircularDetailVc"];
    vc.dicSelect_Circular=[[[arrCircularList objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - tbl UIButton Action

- (IBAction)btnCell_DeleteRow:(id)sender
{
    arrPopup = [[NSMutableArray alloc]init];
    
    [arrPopup addObject:[Utility addCell_PopupView:self.viewAddPage ParentView:self.view sender:sender]];
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.CircularTableView];
    NSIndexPath *indexPath = [self.CircularTableView indexPathForRowAtPoint:buttonPosition];
    NSMutableDictionary *dicAddpage = [[[arrCircularList objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
    strdelete_selecteid=[dicAddpage objectForKey:@"CircularID"];
    [self.lblDeleteConf_Detail setText:[NSString stringWithFormat:@"%@",[dicAddpage objectForKey:@"CircularTitle"]]];
    
}

- (IBAction)btnDeleteConf_Cancel:(id)sender
{
    [self.viewDelete_Conf setHidden:YES];
}

- (IBAction)btnDeleteConf_Yes:(id)sender
{
    [self.viewDelete_Conf setHidden:YES];
    NSArray *ary = [DBOperation selectData:@"select * from CircularList"];
    NSMutableArray *arrTemp = [Utility getLocalDetail:ary columnKey:@"CircularJsonStr"];
    for (int i=0;i<[arrTemp count]; i++) {
        NSMutableDictionary *dic=[arrTemp objectAtIndex:i];
        NSString *str=[[dic objectForKey:@"CircularID"]mutableCopy];
        if([str isEqualToString:strdelete_selecteid])
        {
            NSMutableDictionary *dicLocalDB=[[ary objectAtIndex:i]mutableCopy];
            NSString *strid=[dicLocalDB objectForKey:@"id"];
            [DBOperation executeSQL:[NSString stringWithFormat:@"delete from CircularList where id = '%@'",strid]];
            [arrTemp removeObject:dic];
        }
    }
    
    [self ManageCircularList:arrTemp];
    
    
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
                if([[Utility getUserRoleRightList:@"Circular" settingType:@"IsDelete"] integerValue] == 1)
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

- (IBAction)AddBtnClicked:(UIButton *)sender
{
    
    if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Teacher"])
    {
        if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Student"] )
        {
            if(![[Utility getCurrentUserType] caseInsensitiveCompare:@"Parent"] )
            {
                if([[Utility getUserRoleRightList:@"Circular" settingType:@"IsCreate"] integerValue] == 1)
                {
                    if ([Utility isInterNetConnectionIsActive] == false)
                    {
                        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alrt show];
                        return;
                    }
                    else
                    {
                        AddCircularVc *p = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddCircularVc"];
                        [self.navigationController pushViewController:p animated:YES];
                    }
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
                else
                {
                    AddCircularVc *p = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddCircularVc"];
                    [self.navigationController pushViewController:p animated:YES];
                }
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
            else
            {
                AddCircularVc *p = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddCircularVc"];
                [self.navigationController pushViewController:p animated:YES];
            }
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
        else
        {
            AddCircularVc *p = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddCircularVc"];
            [self.navigationController pushViewController:p animated:YES];
        }
    }
}

- (IBAction)CircularBtnClicked:(UIButton *)sender
{
    CircularDetailVc *c = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"CircularDetailVc"];
    
    [self.navigationController pushViewController:c animated:YES];
}

- (IBAction)btnHomeClicked:(id)sender
{
    [self.frostedViewController hideMenuViewController];
    
    UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"OrataroVc"];
    [self.navigationController pushViewController:wc animated:NO];
    
}

@end
