//
//  MyProfileVc.m
//  orataro
//
//  Created by MAC008 on 15/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "MyProfileVc.h"
#import "GlobalVc.h"
#import "SWRevealViewController.h"

@interface MyProfileVc ()
{
    GlobalVc *vc;
    NSMutableArray *imgary,*textary;
    

}
@end

@implementation MyProfileVc
@synthesize aProfileTable,aHeaderView,aProfileNameLb,aProfileimageview;

- (void)viewDidLoad
{
    [super viewDidLoad];

    vc = [[GlobalVc alloc]init];
    
    
    imgary = [[NSMutableArray alloc]initWithObjects:@"dash_pages",@"blogico",@"friends",@"photo_blue",@"video",@"photo",@"dash_school_group",@"dash_happygram",@"dash_school_prayer",@"dash_institute",@"standard",@"dash_division",@"dash_subject",@"project",@"leave",@"password", nil];
    
    textary = [[NSMutableArray alloc]initWithObjects:@"Institute Pages",@"Blogs",@"Friends",@"All Photo",@"Video",@"Photo",@"School Groups",@"My Happygram",@"School Prayer",@"Institute",@"Standard",@"Division",@"Subject",@"Project",@"Leave",@"Password", nil];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    aProfileTable.tableHeaderView = aHeaderView;
    
    aProfileTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //next
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyProfileCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyProfileCell"];
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
    
    //tag 3
    UIImageView *img1 = (UIImageView *)[cell.contentView viewWithTag:3];
    
    img1.image = [UIImage imageNamed:[imgary objectAtIndex:indexPath.row]];
    
    img1.image = [img1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [img1 setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    img1.contentMode = UIViewContentModeScaleAspectFit;
    
    //tag 2
    UILabel *lb = (UILabel *)[cell.contentView viewWithTag:2];
    lb.text = [textary objectAtIndex:indexPath.row];
    
    UIImageView *imageView;
   
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 6)
    {
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next"]];
    }
    cell.accessoryView = imageView;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return textary.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // as per content
    return 60;
}

#pragma mark - button action

- (IBAction)MenuBtnClicked:(id)sender
{
    [self.revealViewController rightRevealToggle:nil];
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
