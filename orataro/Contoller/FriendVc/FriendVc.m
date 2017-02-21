//
//  FriendVc.m
//  orataro
//
//  Created by MAC008 on 17/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "FriendVc.h"

@interface FriendVc ()
{
    NSMutableArray *nameary;
}
@end

@implementation FriendVc
@synthesize aNoFriendLabel,friendTableView,aPopupAddFriendImg,aPopupFriendRequestImg,aAddFriendView,aFriendRequestView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    nameary = [[NSMutableArray alloc]initWithObjects:@"sdddfjdjf dfbefbef dnfndfdf dnfndfbdnbff fjefjf dfejendn f ejfdfdf fjfef",@"sdddfjdjf dfbefbef dnfndfdf dnfndfbdnbff sdddfjdjf dfbefbef dnfndfdf sdddfjdjf dfbefbef dnfndfdf dnfndfbdnbff fjefjf dfejendn f ejfdfdf fjfef sdddfjdjf dfbefbef dnfndfdf dnfndfbdnbff fjefjf dfejendn f ejfdfdf fjfef diya",@"sdddfjdjf dfbefbef dnfndfdf sdddfjdjf dfbefbef dnfndfdf dnfndfbdnbff fjefjf dfejendn f ejfdfdf fjfef sdddfjdjf dfbefbef dnfndfdf dnfndfbdnbff fjefjf dfejendn f ejfdfdf fjfef nilam" ,nil];
    friendTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    aAddFriendView.layer.cornerRadius = 17.5;
    aFriendRequestView.layer.cornerRadius = 17.5;
    
    //FriendCell
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FriendCell"];
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
    UILabel *lb = (UILabel *)[cell.contentView viewWithTag:2];
    lb.text = [nameary objectAtIndex:indexPath.row];
    
    //tag 3
    //UILabel *lb = (UILabel *)[cell.contentView viewWithTag:3];
   // lb.text = [getdata objectAtIndex:indexPath.row];
    
    //tag 4
    //UILabel *lb = (UILabel *)[cell.contentView viewWithTag:4];
    //lb.text = [getdata objectAtIndex:indexPath.row];
    
    //tag 5
    UIView *view1 = (UIView *)[cell.contentView viewWithTag:5];
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
    
    
    //////////////////////////////////////////////////////////
    
    //FriendRequestCell
    
    
    //tag 1
    // UIImageView *img = (UILabel *)[cell.contentView viewWithTag:1];
    //  lb.text = [getdata objectAtIndex:indexPath.row];
    
    //tag 2
   // UILabel *lb = (UILabel *)[cell.contentView viewWithTag:2];
   // lb.text = [nameary objectAtIndex:indexPath.row];
    
    //tag 3
    //UILabel *lb = (UILabel *)[cell.contentView viewWithTag:3];
    // lb.text = [getdata objectAtIndex:indexPath.row];
    
    //tag 4
    //UILabel *lb = (UILabel *)[cell.contentView viewWithTag:4];
    //lb.text = [getdata objectAtIndex:indexPath.row];
    
    //tag 5
    //UILabel *lb = (UILabel *)[cell.contentView viewWithTag:5];
    //lb.text = [getdata objectAtIndex:indexPath.row];

    //tag 6
//    UIView *view1 = (UIView *)[cell.contentView viewWithTag:5];
//    view1.layer.cornerRadius =3.0;
//    
//    view1.layer.borderColor = [UIColor colorWithRed:65.0/255.0 green:68.0/255.0 blue:69.0/255.0 alpha:1.0].CGColor;
//    view1.layer.borderWidth = 1.0;
    
    //tag 10
    
//    UIImageView *img1 = (UIImageView *)[cell.contentView viewWithTag:10];
//    img1.image = [UIImage imageNamed:@"fb_req_frnd_white"];
//    img1.image = [img1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    [img1 setTintColor:[UIColor colorWithRed:65.0/255.0 green:68.0/255.0 blue:69.0/255.0 alpha:1.0]];

    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return nameary.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // as per content
    
    NSString *str = [NSString stringWithFormat:@"%@",[nameary objectAtIndex:indexPath.row]];
    CGSize size = [str sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:25] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-252, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    return size.height+105;
    
    //FriendRequestCell
    
    
//    NSString *str = [NSString stringWithFormat:@"%@",[nameary objectAtIndex:indexPath.row]];
//    CGSize size = [str sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:25] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-203, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
//    
//    return size.height+83;
    
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
