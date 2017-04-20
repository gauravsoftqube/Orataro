//
//  WallVc.m
//  orataro
//
//  Created by harikrishna patel on 27/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "WallVc.h"
#import "WallCustomeCell.h"
#import "AddpostVc.h"
#import "OrataroVc.h"
#import "AppDelegate.h"
#import "Global.h"

@interface WallVc ()
{
    AppDelegate *app;
}
@end

@implementation WallVc
@synthesize aWallTableView,aTableHeaderView;
int c2= 0;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set vertical effect
    UIInterpolatingMotionEffect *verticalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.y"
     type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-10);
    verticalMotionEffect.maximumRelativeValue = @(10);
    
    // Set horizontal effect
    UIInterpolatingMotionEffect *horizontalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.x"
     type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-10);
    horizontalMotionEffect.maximumRelativeValue = @(10);
    
    // Create group to combine both
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[verticalMotionEffect];
    
    // Add both effects to your view
    [aWallTableView addMotionEffect:group];
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [aWallTableView registerNib:[UINib nibWithNibName:@"WallCustomeCell" bundle:nil] forCellReuseIdentifier:@"WallCustomeCell"];
    aWallTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    aWallTableView.tableHeaderView = aTableHeaderView;
    aWallTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    //ShowWall
    
    //RememberMe
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    // downarrow
    if ([_checkscreen isEqualToString:@"Institute"])
    {
        [_MenuBtn setBackgroundImage:[UIImage imageNamed:@"downarrow"] forState:UIControlStateNormal];
        [_HomeBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        _DisplayPopupView.hidden =YES;
    }
    else if([_checkscreen isEqualToString:@"Standard"])
    {
        [_MenuBtn setBackgroundImage:[UIImage imageNamed:@"downarrow"] forState:UIControlStateNormal];
        [_HomeBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        _DisplayPopupView.hidden =YES;
    }
    else if ([_checkscreen isEqualToString:@"Division"])
    {
        [_MenuBtn setBackgroundImage:[UIImage imageNamed:@"downarrow"] forState:UIControlStateNormal];
        [_HomeBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        _DisplayPopupView.hidden =YES;
    }
    else if ([_checkscreen isEqualToString:@"Subject"])
    {
        [_MenuBtn setBackgroundImage:[UIImage imageNamed:@"downarrow"] forState:UIControlStateNormal];
        [_HomeBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        _DisplayPopupView.hidden =YES;
    }
    else
    {
        [_MenuBtn setBackgroundImage:[UIImage imageNamed:@"ic_sort_white"] forState:UIControlStateNormal];
        [_HomeBtn setBackgroundImage:[UIImage imageNamed:@"dash_home"] forState:UIControlStateNormal];
        _DisplayPopupView.hidden =NO;
    }
    
    
    [self apiCallMethod];
}

-(void)apiCallMethod
{
    [self apiCallFor_GetGeneralWallData:@"1"];
}

#pragma mark - apiCall

-(void)apiCallFor_GetGeneralWallData:(NSString *)strInternet
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_generalwall,apk_GetGeneralWallData_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%d",1] forKey:@"rowno"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] forKey:@"WallID"];
    
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WallCustomeCell *cell = (WallCustomeCell *)[tableView dequeueReusableCellWithIdentifier:@"WallCustomeCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell.aLikeViewWidth setConstant:self.view.frame.size.width/4];
    [cell.aCommentViewWidth setConstant:self.view.frame.size.width/4];
    [cell.aShareViewWidth setConstant:self.view.frame.size.width/4];
    [cell.aUnlikeViewWidth setConstant:self.view.frame.size.width/4];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSIndexPath * indexPath1=[NSIndexPath indexPathForRow:indexPath.row inSection:0];
    
    //  WallCustomeCell *cell1 = (WallCustomeCell *)[self.aWallTableView dequeueReusableCellWithIdentifier:@"WallCustomeCell"];
    
    //  WallCustomeCell *cell = (WallCustomeCell *)[aWallTableView cellForRowAtIndexPath:indexPath];
    
    //NSLog(@"height=%f",(float)cell1.aFirstViewheight);
    
    
    //cell1.aFirstView.frame.size.height
    
    // CGRect frame = view.frame;
    
    
    //     MyCustomCell *cell1 = (MyCustomCell *) [[self.aWallTableView cellForRowAtIndexPath:indexPath1];
    //
    //    MyCustomCell *cell1 = (MyCustomCell *)[[aWallTableView dequeueReusableCellWithIdentifier:@"WallCustomeCell"];
    
    //NSIndexPath *path in [tableView indexPathsForVisibleRows]
    
    // MyCustomCell *cell = (MyCustomCell *)[self.tableView cellForRowAtIndexPath:path];
    
    return 288;
}

#pragma mark - UIButton Action

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

- (IBAction)WhatsyourmindBtnClicked:(id)sender
{
    if ([_checkscreen isEqualToString:@"Institute"])
    {
    }
    else if([_checkscreen isEqualToString:@"Standard"])
    {
    }
    else if ([_checkscreen isEqualToString:@"Division"])
    {
    }
    else if ([_checkscreen isEqualToString:@"Subject"])
    {
    }
    else
    {
        AddpostVc *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AddpostVc"];
        [self.navigationController pushViewController:wc animated:YES];
    }
}

- (IBAction)HomeBtnClicked:(id)sender
{
    if ([_checkscreen isEqualToString:@"Institute"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if([_checkscreen isEqualToString:@"Standard"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ([_checkscreen isEqualToString:@"Division"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ([_checkscreen isEqualToString:@"Subject"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.frostedViewController hideMenuViewController];
        OrataroVc *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"OrataroVc"];
        [self.navigationController pushViewController:wc animated:NO];
    }
}
@end
