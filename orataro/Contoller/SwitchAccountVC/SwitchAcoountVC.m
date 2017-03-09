//
//  SwitchAcoountVC.m
//  orataro
//
//  Created by MAC008 on 07/03/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "SwitchAcoountVC.h"
#import "Global.h"

@interface SwitchAcoountVC ()
{
    NSMutableArray *fetchDataAry;
}
@end

@implementation SwitchAcoountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    _tblSwitchAccount.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self fetchDataofUser];

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
   }
#pragma mark - tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchAccountCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SwitchAccountCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // tag 1
     UIView *view1 = (UIView *)[cell.contentView viewWithTag:1];
    view1.layer.borderWidth = 1.0;
    view1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    //tag 2
    //UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:2];
    
    //tag 3
    //UILabel *lb1 = (UILabel *)[cell.contentView viewWithTag:3];
    
    //tag 4
    //UILabel *lb2 = (UILabel *)[cell.contentView viewWithTag:4];
    
    //tag 5
    //UILabel *lb3 = (UILabel *)[cell.contentView viewWithTag:5];
    
    //tag 6
    //UILabel *lb4 = (UILabel *)[cell.contentView viewWithTag:6];
    
    //tag 7
    
    //UIButton *btn = (UIButton *)[cell.contentView viewWithTag:7];
    
    UIView *view2 = (UIView *)[cell.contentView viewWithTag:8];
   // view2.frame = CGRectMake(view2.frame.origin.x, view2.frame.origin.y,(view2.frame.size.width)-5/3, view2.frame.size.height);
    view2.layer.borderWidth = 1.0;
    view2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    UIView *view3 = (UIView *)[cell.contentView viewWithTag:9];
   // view3.frame = CGRectMake(view3.frame.origin.x-5, view3.frame.origin.y,(view3.frame.size.width)/3, view3.frame.size.height);
    view3.layer.borderWidth = 1.0;
    view3.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    UIView *view4 = (UIView *)[cell.contentView viewWithTag:10];
    //view4.frame = CGRectMake(view4.frame.origin.x, view4.frame.origin.y,(view4.frame.size.width)-5/3, view4.frame.size.height);
    view4.layer.borderWidth = 1.0;
    view4.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    UIImageView *img1 = (UIImageView *)[cell.contentView viewWithTag:11];
    img1.image = [img1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [img1 setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    UIImageView *img2 = (UIImageView *)[cell.contentView viewWithTag:12];
    img2.image = [img2.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [img2 setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    UIImageView *img3 = (UIImageView *)[cell.contentView viewWithTag:13];
    img3.image = [img3.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [img3 setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // as per content
    return 194;
}


#pragma mark - button action

- (IBAction)HomeBtnClicked:(id)sender
{
}

- (IBAction)btnMenuClicked:(id)sender
{
}

#pragma mark - fetch data from database

-(void)fetchDataofUser
{
    //[fetchDataAry removeAllObjects];
    
    fetchDataAry =  [DBOperation selectData:[NSString stringWithFormat:@"select * from Login"]];
    
    NSLog(@"data=%@",fetchDataAry);
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
