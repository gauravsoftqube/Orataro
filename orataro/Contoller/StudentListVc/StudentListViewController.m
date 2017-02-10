//
//  StudentListViewController.m
//  orataro
//
//  Created by Softqube Mac IOS on 06/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "StudentListViewController.h"
#import "SWRevealViewController.h"
#import "WallVc.h"
#import "RightVc.h"

@interface StudentListViewController ()
{
    NSMutableArray *stuAry;
}
@end

@implementation StudentListViewController
@synthesize aStudentTable;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    stuAry = [[NSMutableArray alloc]initWithObjects:@"Ruchita boraniya",@"patel pooja",@"patel roshni", nil];
    self.automaticallyAdjustsScrollViewInsets = NO;
    aStudentTable.separatorStyle = UITableViewCellSelectionStyleNone;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hello"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hello"];
    }
    if (indexPath.row % 2 ==0)
    {
        cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    }
    
    cell.textLabel.text = [stuAry objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return stuAry.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
#pragma mark - button action
- (IBAction)BackBtnClicked:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // here you need to create storyboard ID of perticular view where you need to navigate your app
    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"WallVc"];
    UIViewController *vc1 = [mainStoryboard instantiateViewControllerWithIdentifier:@"RightVc"];
    [self.revealViewController setFrontViewController:vc animated:YES];
    [self.revealViewController setRightViewController:vc1 animated:YES];
    [self.navigationController popToViewController:self.revealViewController animated:YES];
    
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
