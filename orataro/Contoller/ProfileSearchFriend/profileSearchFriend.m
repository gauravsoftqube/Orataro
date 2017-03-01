//
//  profileSearchFriend.m
//  orataro
//
//  Created by MAC008 on 27/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "profileSearchFriend.h"

@interface profileSearchFriend ()

@end

@implementation profileSearchFriend
@synthesize aSerchview,aTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    aTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    aTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //Bottom border
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.aSerchview.frame.size.height - 1, self.view.frame.size.width-20, 1.0f);
    bottomBorder.shadowColor = [UIColor grayColor].CGColor;
    bottomBorder.shadowOffset = CGSizeMake(1, 1);
    bottomBorder.shadowOpacity = 1;
    bottomBorder.shadowRadius = 1.0;
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.aSerchview.layer addSublayer:bottomBorder];
    
    //left border
    CALayer *leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(0.0f, 30.0f, 1.0f, self.aSerchview.frame.size.height-30);
    leftBorder.shadowColor = [UIColor grayColor].CGColor;
    leftBorder.shadowOffset = CGSizeMake(1, 1);
    leftBorder.shadowOpacity = 1;
    leftBorder.shadowRadius = 1.0;
    leftBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.aSerchview.layer addSublayer:leftBorder];
    
    //right border
    CALayer *rightBorder = [CALayer layer];
    rightBorder.frame = CGRectMake(self.view.frame.size.width-20, 30.0f, 1.0f, self.aSerchview.frame.size.height-30);
    rightBorder.shadowColor = [UIColor grayColor].CGColor;
    rightBorder.shadowOffset = CGSizeMake(1, 1);
    rightBorder.shadowOpacity = 1;
    rightBorder.shadowRadius = 1.0;
    rightBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.aSerchview.layer addSublayer:rightBorder];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchFriendCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchFriendCell"];
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
    // UIImageView *img = (UILabel *)[cell.contentView viewWithTag:1];
    //  lb.text = [getdata objectAtIndex:indexPath.row];
    
    //tag 2
   // UILabel *lb = (UILabel *)[cell.contentView viewWithTag:2];
    //lb.text = [nameary objectAtIndex:indexPath.row];
    
    //tag 3
    //UILabel *lb = (UILabel *)[cell.contentView viewWithTag:3];
    // lb.text = [getdata objectAtIndex:indexPath.row];
    
    //tag 4
    //UILabel *lb = (UILabel *)[cell.contentView viewWithTag:4];
    //lb.text = [getdata objectAtIndex:indexPath.row];
    
    //tag 5
    UIView *view1 = (UIView *)[cell.contentView viewWithTag:6];
    view1.layer.cornerRadius =3.0;
    
    view1.layer.borderColor = [UIColor colorWithRed:65.0/255.0 green:68.0/255.0 blue:69.0/255.0 alpha:1.0].CGColor;
    view1.layer.borderWidth = 1.0;
    
    //(__bridge CGColorRef _Nullable)([UIColor colorWithRed:65.0/255.0 green:68.0/255.0 blue:69.0/255.0 alpha:1.0]);
    //view1.layer.masksToBounds = YES;
    
    //  lb.text = [getdata objectAtIndex:indexPath.row];
    
    //tag 10
    
    UIImageView *img1 = (UIImageView *)[cell.contentView viewWithTag:10];
    img1.image = [UIImage imageNamed:@"fb_req_frnd_white"];
    img1.image = [img1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [img1 setTintColor:[UIColor colorWithRed:65.0/255.0 green:68.0/255.0 blue:69.0/255.0 alpha:1.0]];

    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // as per content
    return 124;
}


- (IBAction)BackBtnClicked:(UIButton *)sender
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
