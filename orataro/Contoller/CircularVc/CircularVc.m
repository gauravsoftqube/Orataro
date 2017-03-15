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
    
    
    arrCircularList=[[NSMutableArray alloc]init];
    arrCircularList_Section=[[NSMutableArray alloc]init];
}

-(void)viewWillAppear:(BOOL)animated
{
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
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
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
    NSLog(@"%@",arrResponce);
    for (NSMutableDictionary *dicResponce in arrResponce) {
        NSString *DateOfCircular=[Utility convertMiliSecondtoDate:@"dd/MM/yyyy" date:[NSString stringWithFormat:@"%@",[dicResponce objectForKey:@"DateOfCircular"]]];
        if(![arrCircularList_Section containsObject:DateOfCircular])
        {
            [arrCircularList_Section addObject:DateOfCircular];
        }
    }
}


#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
