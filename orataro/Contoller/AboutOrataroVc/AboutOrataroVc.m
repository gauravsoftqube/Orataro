//
//  AboutOrataroVc.m
//  orataro
//
//  Created by MAC008 on 09/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "AboutOrataroVc.h"
#import "AboutUsVc.h"
#import "HelpDeskVc.h"
#import "ContactUsVc.h"
#import "REFrostedViewController.h"

@interface AboutOrataroVc ()
{
    NSArray *dispary,*imgary;
    int c2;
}
@end

@implementation AboutOrataroVc
@synthesize AboutTableView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    dispary = [[NSMutableArray alloc]initWithObjects:@"Share App",@"Rate App",@"Our other Free Apps",@"Facebook",@"Twitter",@"Linkin",@"Google+",@"About Us",@"Contact US",@"Help Desk", nil];
    
    imgary = [[NSMutableArray alloc]initWithObjects:@"share",@"star",@"more23",@"facebook",@"twitter",@"linkdin",@"googleplus",@"user",@"phone",@"customersupport", nil];
    
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
    
    UIImageView *img1 = (UIImageView *)[cell.contentView viewWithTag:1];
    
    img1.image = [UIImage imageNamed:[imgary objectAtIndex:indexPath.row]];
    
    img1.image = [img1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [img1 setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    img1.contentMode = UIViewContentModeScaleAspectFit;
    
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     AboutUsVc *a = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"AboutUsVc"];
    
     ContactUsVc *c = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ContactUsVc"];
    
    HelpDeskVc *h = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"HelpDeskVc"];
    
    switch (indexPath.row)
    {
        case 0:
            
            break;
            
        case 1:
            
            break;
            
        case 2:
            
            break;
            
        case 3:
            
            break;
            
        case 4:
            
            break;
            
        case 5:
            
            break;
            
        case 6:
            
            break;
            
        case 7:
            
           
            [self.navigationController pushViewController:a animated:YES];
            
            break;
            
        case 8:
            
            [self.navigationController pushViewController:c animated:YES];
            
            break;
            
        case 9:
            
            [self.navigationController pushViewController:h animated:YES];
            
            break;
            
            
        default:
            break;
    }
}

#pragma mark - button action

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
