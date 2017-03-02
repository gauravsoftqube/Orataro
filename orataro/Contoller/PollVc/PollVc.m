//
//  PollVc.m
//  orataro
//
//  Created by MAC008 on 08/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "PollVc.h"
#import "REFrostedViewController.h"
#import "AddPollVc.h"

@interface PollVc ()
{
int c2;
}
@end

@implementation PollVc
@synthesize aFirstImage,aBottomView1,aBottomView2,aSecondImage;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //pollico
    //voting_shoe
    //voting
    //pollico_shiw
    
   
    _lbNopoll.hidden =YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tblPoll.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    aBottomView1.hidden = NO;
    [aFirstImage setImage:[UIImage imageNamed:@"pollico_shiw"]];
    
    aBottomView2.hidden = YES;
    [aSecondImage setImage:[UIImage imageNamed:@"voting"]];
    
    
    _viewAdd.layer.cornerRadius = 30.0;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //
    //
    //
    //
    static NSString *HeaderCellIdentifier = @"PollHeaderCell";
    
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
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PollRowCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UIView *viewBackgroundCell=(UIView *)[cell.contentView viewWithTag:1];
     UIView *viewDateBackground=(UIView *)[cell.contentView viewWithTag:2];
    if(indexPath.row % 2)
    {
        [viewBackgroundCell setBackgroundColor:[UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f]];
         [viewDateBackground setBackgroundColor:[UIColor colorWithRed:29/255.0f green:42/255.0f blue:76/255.0f alpha:1.0f]];
        
    }
    else
    {
         [viewBackgroundCell setBackgroundColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f]];
        [viewDateBackground setBackgroundColor:[UIColor colorWithRed:46/255.0f green:60/255.0f blue:100/255.0f alpha:1.0f]];
       
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddPollVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"AddPollVc"];
    vc.strPoll = @"Edit";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - button action

- (IBAction)btnAddClicked:(UIButton *)sender
{
    AddPollVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"AddPollVc"];
    vc.strPoll = @"Add";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)aFirstBtnClicked:(id)sender
{
    aBottomView1.hidden = NO;
    [aFirstImage setImage:[UIImage imageNamed:@"pollico_shiw"]];
    
    aBottomView2.hidden = YES;
    [aSecondImage setImage:[UIImage imageNamed:@"voting"]];
}
- (IBAction)aSeconBtnClicked:(id)sender
{
    aBottomView1.hidden = YES;
    [aFirstImage setImage:[UIImage imageNamed:@"pollico"]];
    
    aBottomView2.hidden = NO;
    [aSecondImage setImage:[UIImage imageNamed:@"voting_shoe"]];
}

- (IBAction)MenuBtnClicked:(id)sender
{
     if (c2==0)
    {
        self.frostedViewController.direction = REFrostedViewControllerDirectionRight;
        self.frostedViewController.panGestureEnabled = NO;
        [self.frostedViewController presentMenuViewController];
        c2=1;
    }
    else
    {
        [self.frostedViewController hideMenuViewController];
        self.frostedViewController.panGestureEnabled = NO;
        c2 =0;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
