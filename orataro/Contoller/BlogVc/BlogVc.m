//
//  BlogVc.m
//  orataro
//
//  Created by MAC008 on 17/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "BlogVc.h"

@interface BlogVc ()
{
    NSMutableArray *getdata;
}
@end

@implementation BlogVc
@synthesize aBlogTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //BlogCell
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    getdata = [[NSMutableArray alloc]initWithObjects:@"cdsfdfdsfdsfsdfsdfdfdfdsf cdsfdfdsfdsfsdfsdfdfdfdsf cdsfdfdsfdsfsdfsdfdfdfdsf",@"Prayer Of The Winter fgfffdgfdgfg",@"gfgfgfg Message cdsfdfdsfdsfsdfsdfdfdfdsf cdsfdfdsfdsfsdfsdfdfdfdsf cdsfdfdsfdsfsdfsdfdfdfdsf cdsfdfdsfdsfsdfsdfdfdfdsf",@"fgfdfg School Photo",@"fgfg Welcome Message", nil];
    aBlogTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    aBlogTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // //HelveticaNeueLTStd-Roman 20.0
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlogCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BlogCell"];
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
    img1.image = [UIImage imageNamed:@"blogico"];
    img1.image = [img1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [img1 setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    //tag 2
    UILabel *lb = (UILabel *)[cell.contentView viewWithTag:2];
    lb.text = [getdata objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return getdata.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // as per content
    
    NSString *str = [NSString stringWithFormat:@"%@",[getdata objectAtIndex:indexPath.row]];
        CGSize size = [str sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:20] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-48, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];

        return size.height+35;
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
