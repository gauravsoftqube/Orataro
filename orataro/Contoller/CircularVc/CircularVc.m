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
}
@end

@implementation CircularVc
@synthesize aView1;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self commonData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    aView1.layer.cornerRadius =50.;
    aView1.layer.borderWidth = 2.0;
    aView1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    //CircularVc
    
    _AddBtn.layer.cornerRadius = 30;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _CircularTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    MemberType =YES;
    arrCircularList=[[NSMutableArray alloc]init];
    arrCircularList_Section=[[NSMutableArray alloc]init];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    if([[dicCurrentUser objectForKey:@"MemberType"] isEqualToString:@"Student"])
    {
        MemberType=YES;
        [self.AddBtn setHidden:YES];
    }
    else
    {
        MemberType=NO;
        [self.AddBtn setHidden:NO];
    }

    [self apiCallFor_getCircular];
}

#pragma mark - ApiCall

-(void)apiCallFor_getCircular
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
        
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_circular,apk_GetCircularList_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    /*[param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
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
    }*/
    
    [param setValue:[NSString stringWithFormat:@"f1a6d89d-37dc-499a-9476-cb83f0aba0f2"] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"30032284-31d1-4ba6-8ef4-54edb8e223aa"] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"d79901a7-f9f7-4d47-8e3b-198ede7c9f58"] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"4f4bbf0e-858a-46fa-a0a7-bf116f537653"] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@""] forKey:@"DivisionID"];
    [param setValue:[NSString stringWithFormat:@""] forKey:@"GradeID"];
    [param setValue:[NSString stringWithFormat:@""] forKey:@"BeachID"];
    
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
                     [self ManageCircularList:arrResponce];
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
//    NSLog(@"total %lu",(unsigned long)arrResponce.count);
//    NSLog(@"arra=%@",arrResponce);
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:arrResponce];
    
    for (int i=0; i< mutableArray.count; i++)
    {
        NSMutableDictionary *d = [[mutableArray objectAtIndex:i] mutableCopy];
        
        //NSLog(@"data=%@",[[mutableArray objectAtIndex:i]objectForKey:@"DateOfCircular"]);
        
        NSString *DateOfCircular=[Utility convertMiliSecondtoDate:@"MM/yyyy" date:[NSString stringWithFormat:@"%@",[[mutableArray objectAtIndex:i]objectForKey:@"DateOfCircular"]]];
        
        [d setObject:DateOfCircular forKey:@"Group"];
        
      //  NSString *filterData = [Utility convertMiliSecondtoDate:@"MM/yyyy" date:[NSString stringWithFormat:@"%@",[[mutableArray objectAtIndex:i]objectForKey:@"DateOfCircular"]]];
        
      //  [d setObject:filterData forKey:@"Filter"];

        
        [mutableArray replaceObjectAtIndex:i withObject:d];
        
        //NSLog(@"data=%@",mutableArray);
        
        
        arrResponce = mutableArray;
    }
    
    NSArray *temp = [arrResponce sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"Group" ascending:YES]]];
    
  //  NSLog(@"Temp=%@",temp);
    
    [arrResponce removeAllObjects];
    [arrResponce addObjectsFromArray:temp];
    
    NSArray *areas = [arrResponce valueForKeyPath:@"@distinctUnionOfObjects.Group"];
    
   // NSLog(@"area=%@",areas);
    
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
    
    
   // NSLog(@"sorta1=%@",sortedArray1);
    sortedArray = [[NSArray alloc]initWithArray:sortedArray1];
    
    /////////////////
    
    /////////////////
    
    for (NSString *area in sortedArray)
    {
        __autoreleasing NSMutableDictionary *entry = [NSMutableDictionary new];
        [entry setObject:area forKey:@"Groups"];
        
        __autoreleasing NSArray *temp = [arrResponce filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"Group = %@", area]];
        
        __autoreleasing NSMutableArray *items = [NSMutableArray new];
        
        NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"Group"                                                                        ascending:YES];
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
        
        items = [[NSMutableArray alloc] initWithArray:[temp sortedArrayUsingDescriptors:sortDescriptors]];
        
        [entry setObject:items forKey:@"items"];
        
        [arrCircularList addObject:entry];
    }
    
  //  NSLog(@"ary=%@",arrCircularList);
    
    [_CircularTableView reloadData];
    
   /* NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:arrResponce];
    
    for (int i=0; i< mutableArray.count; i++)
    {
        NSMutableDictionary *d = [[mutableArray objectAtIndex:i] mutableCopy];
        
        NSLog(@"data=%@",[[mutableArray objectAtIndex:i]objectForKey:@"DateOfCircular"]);
        
        NSString *DateOfCircular=[Utility convertMiliSecondtoDate:@"dd/MM/yyyy" date:[NSString stringWithFormat:@"%@",[[mutableArray objectAtIndex:i]objectForKey:@"DateOfCircular"]]];
        
        [d setObject:DateOfCircular forKey:@"Group"];
        
        
        [mutableArray replaceObjectAtIndex:i withObject:d];
        
        NSLog(@"data=%@",mutableArray);
        
        
        arrResponce = mutableArray;
    }
    
    NSArray *temp = [arrResponce sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"Group" ascending:YES]]];
    
    NSLog(@"Temp=%@",temp);
    
    [arrResponce removeAllObjects];
    [arrResponce addObjectsFromArray:temp];
    
    NSArray *areas = [arrResponce valueForKeyPath:@"@distinctUnionOfObjects.Group"];
    
    NSLog(@"area=%@",areas);
    
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES];
    
    NSArray *sorters = [[NSArray alloc] initWithObjects:sorter, nil];
    
    NSArray *sortedArray = [areas sortedArrayUsingDescriptors:sorters];
    
    NSDateFormatter *dateFormatter1 = [NSDateFormatter new];
    dateFormatter1.dateFormat = @"dd-MM-yyyy";
    
    NSArray *sortedArray1 = [sortedArray sortedArrayUsingComparator:^(NSString *string1, NSString *string2)
    {
        NSDate *date1 = [dateFormatter1 dateFromString:string1];
        NSDate *date2 = [dateFormatter1 dateFromString:string2];
        
        return [date1 compare:date2];
    }];
    
    
    NSLog(@"sorta1=%@",sortedArray1);
    sortedArray = [[NSArray alloc]initWithArray:sortedArray1];
    
    /////////////////
    
    /////////////////
    
    for (NSString *area in sortedArray)
    {
        __autoreleasing NSMutableDictionary *entry = [NSMutableDictionary new];
        [entry setObject:area forKey:@"Groups"];
        
        __autoreleasing NSArray *temp = [arrResponce filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"Group = %@", area]];
        
        __autoreleasing NSMutableArray *items = [NSMutableArray new];
        
        NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"Group"                                                                        ascending:YES];
       
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
        
        items = [[NSMutableArray alloc] initWithArray:[temp sortedArrayUsingDescriptors:sortDescriptors]];
        
        [entry setObject:items forKey:@"items"];
        
        [arrCircularList addObject:entry];
        }
    
    NSLog(@"ary=%@",arrCircularList);
    
    [_CircularTableView reloadData];*/
    
    

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
    // UIView *viewDateBackground=(UIView *)[cell.contentView viewWithTag:2];
    if(indexPath.row % 2)
    {
        [viewBackgroundCell setBackgroundColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f]];
        //    [viewDateBackground setBackgroundColor:[UIColor colorWithRed:46/255.0f green:60/255.0f blue:100/255.0f alpha:1.0f]];
    }
    else
    {
        [viewBackgroundCell setBackgroundColor:[UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f]];
        // [viewDateBackground setBackgroundColor:[UIColor colorWithRed:29/255.0f green:42/255.0f blue:76/255.0f alpha:1.0f]];
    }
    
    NSDictionary *d = [[[arrCircularList objectAtIndex:indexPath.section] objectForKey:@"items"] objectAtIndex:indexPath.row];
    
    //NSLog(@"Dic=%@",d);
    
    UILabel *lbHeaderDt = (UILabel *)[cell.contentView viewWithTag:3];
    NSString *getfrmt = [Utility convertDateFtrToDtaeFtr:@"dd/MM/yyyy" newDateFtr:@"dd EEE" date:[NSString stringWithFormat:@"%@",[d objectForKey:@"Group"]]];
    lbHeaderDt.text = getfrmt;

    UILabel *lbTitle = (UILabel *)[cell.contentView viewWithTag:4];
    lbTitle.text = [d objectForKey:@"CircularTitle"];
    
    UILabel *lbDesc = (UILabel *)[cell.contentView viewWithTag:6];
    lbDesc.text = [d objectForKey:@"CircularDetails"];
    
    if(MemberType == YES)
    {
        //student
        //hidden
    }
    else
    {
        //show
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
    
    NSLog(@"data=%@",[arrCircularList objectAtIndex:section]);
    
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
- (IBAction)AddBtnClicked:(UIButton *)sender
{
    AddCircularVc *p = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddCircularVc"];
    [self.navigationController pushViewController:p animated:YES];
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
