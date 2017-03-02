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

@interface ClassworkVC ()
{
    AppDelegate *gh;
    int c2;
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
}


#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubjectVc *b = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"SubjectVc"];
    b.passVal = @"Classwork";
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

- (IBAction)btnAddClicked:(id)sender
{
    gh.checkListelection = 4;

    ListSelectionVc *l = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ListSelectionVc"];
    [self.navigationController pushViewController:l animated:YES];
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
