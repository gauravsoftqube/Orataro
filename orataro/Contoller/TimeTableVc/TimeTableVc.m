//
//  TimeTableVc.m
//  orataro
//
//  Created by Softqube Mac IOS on 06/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "TimeTableVc.h"
#import "SWRevealViewController.h"

@interface TimeTableVc ()

@end

@implementation TimeTableVc
@synthesize PreBtn,NextBtn,NextimageView,PreImageView,aTableView,aTableHeaderView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //TimetableCell
    
    NextimageView.image = [NextimageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
     [NextimageView setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    PreImageView.image = [PreImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [PreImageView setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    aTableView.tableHeaderView = aTableHeaderView;
    
    aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Do any additional setup after loading the view.
}

#pragma mark - tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimetableCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TimetableCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row % 2 ==0)
    {
         cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // as per content
    return 50;
}


#pragma mark - button action


- (IBAction)PreBtnClicked:(id)sender {
}
- (IBAction)NextBtnClicked:(id)sender {
}

- (IBAction)MenuBtnClicked:(id)sender
{
    [self.revealViewController rightRevealToggle:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
