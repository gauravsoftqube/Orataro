//
//  ListSelectionVc.m
//  orataro
//
//  Created by Softqube Mac IOS on 31/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ListSelectionVc.h"
#import "ListCell.h"
#import "REFrostedViewController.h"
#import "StudentListViewController.h"
#import "AppDelegate.h"
#import "ProfileHappyGramListdetailListVc.h"
#import "AddClassWorkVc.h"
#import "AddHomeworkVc.h"
#import "Global.h"

@interface ListSelectionVc ()
{
    AppDelegate *ad;
    int c2;
    
    NSMutableArray *arrList;
}
@end

@implementation ListSelectionVc
@synthesize aListTableView,HomeBtn,NavigationTitle,aMenuBtn;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    ad = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [aListTableView registerNib:[UINib nibWithNibName:@"ListCell" bundle:nil] forCellReuseIdentifier:@"ListCell"];
    
    aListTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    aListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    //[[NSUserDefaults standardUserDefaults]setObject:@"FromHomeWork" forKey:@"Homework"];
    
    NSLog(@"ad=%d",ad.checkListelection);
    
    //home work - 2
    
    //pt communication 1
    
    //happy gram 3
    //_lbHeaderTitle.text = [NSString stringWithFormat:@"My Profile (%@)",[Utility getCurrentUserName]];
    
    if (ad.checkListelection == 0)
    {
        [HomeBtn setBackgroundImage:[UIImage imageNamed:@"dash_home"] forState:UIControlStateNormal];
        aMenuBtn.hidden = NO;
        [NavigationTitle setText:[NSString stringWithFormat:@"List Selection (%@)",[Utility getCurrentUserName]]];
         
    }
    if (ad.checkListelection == 1)
    {
        [HomeBtn setBackgroundImage:[UIImage imageNamed:@"dash_home"] forState:UIControlStateNormal];
        aMenuBtn.hidden = NO;
        [NavigationTitle setText:[NSString stringWithFormat:@"List Selection (%@)",[Utility getCurrentUserName]]];
    }
    if (ad.checkListelection == 2)
    {
        [HomeBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        aMenuBtn.hidden = YES;
       [NavigationTitle setText:[NSString stringWithFormat:@"List Selection (%@)",[Utility getCurrentUserName]]];
        
    }
    if (ad.checkListelection == 3)
    {
        [HomeBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        aMenuBtn.hidden = YES;
        [NavigationTitle setText:[NSString stringWithFormat:@"List Selection (%@)",[Utility getCurrentUserName]]];    }
    if (ad.checkListelection == 4)
    {
        [HomeBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        aMenuBtn.hidden = YES;
        [NavigationTitle setText:[NSString stringWithFormat:@"List Selection (%@)",[Utility getCurrentUserName]]];
    }

    if ([Utility isInterNetConnectionIsActive] == false)
    {
        arrList = [[NSMutableArray alloc]init];
        arrList=[DBOperation selectData:[NSString stringWithFormat:@"select * from SelectionList"]];
        [self.aListTableView reloadData];
    }
    else
    {
        arrList=[DBOperation selectData:[NSString stringWithFormat:@"select * from SelectionList"]];
        
        if(arrList.count == 0)
        {
            [self apiCallFor_getList:@"1"];
        }
        else
        {
            [self apiCallFor_getList:@"0"];
        }
    }
    NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
    if (arr.count != 0) {
        NavigationTitle.text=[NSString stringWithFormat:@"List Selection (%@)",[arr objectAtIndex:0]];
    }else{
        NavigationTitle.text=[NSString stringWithFormat:@"List Selection"];
    }
}

#pragma mark - apiCall

-(void)apiCallFor_getList:(NSString *)strInternet
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_gradedivisionsubject,apk_GetGradeDivisionSubjectbyTeacher_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:@"Teacher" forKey:@"Role"];
    
    if([strInternet isEqualToString:@"1"])
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
                     arrList = [[NSMutableArray alloc]init];
                     arrList = [arrResponce mutableCopy];
                     [DBOperation executeSQL:[NSString stringWithFormat:@"DELETE FROM SelectionList"]];
                     
                     for (NSMutableDictionary *dic in arrList)
                     {
                         NSString *Division=[dic objectForKey:@"Division"];
                         NSString *DivisionID=[dic objectForKey:@"DivisionID"];
                         NSString *Grade=[dic objectForKey:@"Grade"];
                         NSString *GradeID=[dic objectForKey:@"GradeID"];
                         NSString *Subject=[dic objectForKey:@"Subject"];
                         NSString *SubjectID=[dic objectForKey:@"SubjectID"];
                         
                         [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO SelectionList(Division,DivisionID,Grade,GradeID,Subject,SubjectID)values('%@','%@','%@','%@','%@','%@')",Division,DivisionID,Grade,GradeID,Subject,SubjectID]];
                     }
                     [self.aListTableView reloadData];
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


#pragma mark - tabelview delegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [arrList count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListCell *cell = (ListCell *)[tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    
    if (indexPath.row % 2 ==0)
    {
        cell.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *lblGrade = (UILabel *)[cell.contentView viewWithTag:1];
    [lblGrade setText:[NSString stringWithFormat:@"%@",[[arrList objectAtIndex:indexPath.row] objectForKey:@"Grade"]]];
    
    UILabel *lblDivision = (UILabel *)[cell.contentView viewWithTag:2];
    [lblDivision setText:[NSString stringWithFormat:@"%@",[[arrList objectAtIndex:indexPath.row] objectForKey:@"Division"]]];
    
    UILabel *lblSubject = (UILabel *)[cell.contentView viewWithTag:3];
    [lblSubject setText:[NSString stringWithFormat:@"%@",[[arrList objectAtIndex:indexPath.row] objectForKey:@"Subject"]]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //home work - 2
    
    //pt communication 1
    
    //happy gram 3
    
    if (ad.checkListelection == 0)
    {
        
    }
    if (ad.checkListelection == 1)
    {
        StudentListViewController *s = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"StudentListViewController"];
        s.dicSelectedList=[arrList objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:s animated:YES];
    }
    if (ad.checkListelection == 2)
    {
        AddHomeworkVc *s = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddHomeworkVc"];
        s.dicSelectListSelection=[arrList objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:s animated:YES];
    }
    if (ad.checkListelection == 3)
    {
        ProfileHappyGramListdetailListVc  *vc1 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ProfileHappyGramListdetailListVc"];
        vc1.dicHappyGrameList = [arrList objectAtIndex:indexPath.row];
        
        [self.navigationController pushViewController:vc1 animated:YES];
    }
    if (ad.checkListelection == 4)
    {
        AddClassWorkVc  *vc1 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddClassWorkVc"];
        vc1.dicSelectListSelection=[arrList objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc1 animated:YES];
    }
    
}

#pragma mark - button action

- (IBAction)BackBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)MenuBtnClicked:(id)sender
{
    self.frostedViewController.direction = REFrostedViewControllerDirectionRight;
    
    if (ad.checkview == 0)
    {
        [self.frostedViewController presentMenuViewController];
        ad.checkview = 1;
        
    }
    else
    {
        [self.frostedViewController hideMenuViewController];
        ad.checkview = 0;
    }
}
- (IBAction)HomeBtnClicked:(id)sender
{
    
    //    UIImage* checkImage = [UIImage imageNamed:@"back"];
    //    NSData *checkImageData = UIImagePNGRepresentation(checkImage);
    //    NSData *propertyImageData = UIImagePNGRepresentation([HomeBtn currentBackgroundImage]);
    //    if ([checkImageData isEqualToData:propertyImageData])
    //    {
    //        [self.navigationController popViewControllerAnimated:YES];
    //    }
    //    else
    //    {
    //
    //    }
}

- (IBAction)btnHomeClicked:(id)sender
{
    NSLog(@"ad=%d",ad.checkListelection);
    
    if (ad.checkListelection == 0)
    {
        [self.frostedViewController hideMenuViewController];
        UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"OrataroVc"];
        
        [self.navigationController pushViewController:wc animated:NO];
    }
    if (ad.checkListelection == 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
        //        [HomeBtn setBackgroundImage:[UIImage imageNamed:@"dash_home"] forState:UIControlStateNormal];
        //        aMenuBtn.hidden = NO;
        //        [NavigationTitle setText:@"Homework (Name)"];
    }
    if (ad.checkListelection == 2)
    {
        [self.navigationController popViewControllerAnimated:YES];
        
        
        //        [HomeBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        //        aMenuBtn.hidden = YES;
        //        [NavigationTitle setText:@"List Selection (name)"];
        
    }
    if (ad.checkListelection == 3)
    {
        [self.navigationController popViewControllerAnimated:YES];
        //        [HomeBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        //        aMenuBtn.hidden = YES;
        //        [NavigationTitle setText:@"List Selection (name)"];
    }
    if (ad.checkListelection == 4)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
@end
