//
//  PageVc.m
//  orataro
//
//  Created by MAC008 on 16/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "PageVc.h"
#import "DisplayTitleVc.h"

@interface PageVc ()
{
    NSArray *titleary;
}
@end

@implementation PageVc
@synthesize aPageTableview;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    titleary = [[NSArray alloc]initWithObjects:@"About Institute",@"Prayer Of The Winter",@"Message",@"School Photo",@"Welcome Message", nil];
    aPageTableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    aPageTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
   
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PageCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PageCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row % 2 ==0)
    {
        cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    }
    
    //tag 1
    UIImageView *img1 = (UIImageView *)[cell.contentView viewWithTag:1];
    
    //tag 2
    UILabel *lb = (UILabel *)[cell.contentView viewWithTag:2];
    lb.text = [titleary objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleary.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // as per content
    
    return 65;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DisplayTitleVc *b = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"DisplayTitleVc"];
    [self.navigationController pushViewController:b animated:YES];

}

#pragma mark - button action

- (IBAction)BAckBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
