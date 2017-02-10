//
//  AboutOrataroVc.m
//  orataro
//
//  Created by MAC008 on 09/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "AboutOrataroVc.h"

@interface AboutOrataroVc ()
{
    NSArray *dispary;
}
@end

@implementation AboutOrataroVc
@synthesize AboutTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    dispary = [[NSMutableArray alloc]initWithObjects:@"Share App",@"Rate App",@"Our other Free Apps",@"Facebook",@"Twitter",@"Linkin",@"Google+",@"About Us",@"Contact US",@"Help Desk", nil];
    
    AboutTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    AboutTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //AboutCell
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AboutCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AboutCell"];
    }
    
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    UILabel *lb = [cell.contentView viewWithTag:2];
    lb.text = [dispary objectAtIndex:indexPath.row];
    
    if (indexPath.row %2 ==0)
    {
        cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    }
    //UIImageView *img = [cell.contentView viewWithTag:1];
   // img.image
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dispary.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63;
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
