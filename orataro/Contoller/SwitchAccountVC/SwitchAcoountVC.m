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

    fetchDataAry = [[NSMutableArray alloc]init];
    
    _tblSwitchAccount.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self fetchDataofUser];

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
    
    //InstitutionWallImage
    
    //tag 2
    UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:2];
    //blank-user
    
   // NSLog(@"Ary=%@",fetchDataAry);
    
    [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",apk_ImageUrl,[[fetchDataAry objectAtIndex:indexPath.row]objectForKey:@"ProfilePicture"]]] placeholderImage:[UIImage imageNamed:@"blank-user"]];
    
    //tag 3
    UILabel *lb1 = (UILabel *)[cell.contentView viewWithTag:60];
    lb1.text = [[fetchDataAry objectAtIndex:indexPath.row]objectForKey:@"FullName"];
    
    //tag 4
    UILabel *lb2 = (UILabel *)[cell.contentView viewWithTag:300];
    lb2.text = [[fetchDataAry objectAtIndex:indexPath.row]objectForKey:@"InstituteName"];
    
    //tag 5
    UILabel *lb3 = (UILabel *)[cell.contentView viewWithTag:45];
    
    NSString *strGrade = [NSString stringWithFormat:@"%@",[[fetchDataAry objectAtIndex:indexPath.row]objectForKey:@"GradeName"]];
    
    if ([strGrade isEqualToString:@"<null>"])
    {
        lb3.text = @" ";
    }
    else
    {
        lb3.text = strGrade;
    }
    
    //tag 6
    UILabel *lb4 = (UILabel *)[cell.contentView viewWithTag:23];
    
    NSString *strDiv = [NSString stringWithFormat:@"%@",[[fetchDataAry objectAtIndex:indexPath.row]objectForKey:@"DivisionName"]];
    
    NSLog(@"data=%@",strDiv);
    
    //if (strDiv == (id)[NSNull null] || strDiv.length == 0 || strDiv == nil || [strDiv isKindOfClass:[NSNull class]])
    
    if ([strDiv isEqualToString:@"<null>"])
    {
        lb4.text = @"";
    }
    else
    {
        lb4.text = strDiv;
    }
    
    
    UIButton *btn = (UIButton *)[cell.contentView viewWithTag:67];
   
    [btn setTitle:[NSString stringWithFormat:@"%@",[[fetchDataAry objectAtIndex:indexPath.row]objectForKey:@"RoleName"]] forState:UIControlStateNormal];

    UIView *view2 = (UIView *)[cell.contentView viewWithTag:8];
    view2.layer.borderWidth = 1.0;
    view2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    UIView *view3 = (UIView *)[cell.contentView viewWithTag:9];
    view3.layer.borderWidth = 1.0;
    view3.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    UIView *view4 = (UIView *)[cell.contentView viewWithTag:10];
    view4.layer.borderWidth = 1.0;
    view4.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    //20
//    UIImageView *img4 = (UIImageView *)[cell.contentView viewWithTag:20];
//    img4.layer.borderWidth = 0.5;
//    img4.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    
//    
    UIImageView *img1 = (UIImageView *)[cell.contentView viewWithTag:11];
    img1.image = [img1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [img1 setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    UIImageView *img2 = (UIImageView *)[cell.contentView viewWithTag:12];
    img2.image = [img2.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [img2 setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    UIImageView *img3 = (UIImageView *)[cell.contentView viewWithTag:13];
    img3.image = [img3.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [img3 setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    UIImageView *imgActiveUser = (UIImageView *)[cell.contentView viewWithTag:20];
     imgActiveUser.tag = indexPath.row;
    
    NSString *getSelectRow = [[NSUserDefaults standardUserDefaults]valueForKey:@"SelectedRow"];
    int row = [[NSString stringWithFormat:@"%ld",(long)indexPath.row]intValue];
    
    NSLog(@"row =%@",getSelectRow);
    
    if([getSelectRow isEqual: [NSNull null]] || getSelectRow.length == 0 || getSelectRow == nil)
    {
       [imgActiveUser setImage:[UIImage imageNamed:@""]];
   }
    else if ([getSelectRow isEqualToString:[NSString stringWithFormat:@"%d",row]])
    {
        [imgActiveUser setImage:[UIImage imageNamed:@"swichusertick"]];
    }
    else
    {
        [imgActiveUser setImage:[UIImage imageNamed:@""]];
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return fetchDataAry.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // as per content
    return 194;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [DBOperation executeSQL:@"delete from CurrentActiveUser"];
    
    NSMutableDictionary *getActiveUserdata = [fetchDataAry objectAtIndex:indexPath.row];
    NSString *strJSon = [Utility Convertjsontostring:getActiveUserdata];
    
    [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO CurrentActiveUser (JsonStr) VALUES ('%@')",strJSon]];
    
    NSLog(@"fetch data%@",[DBOperation selectData:@"Select * from CurrentActiveUser"]);
    
    int row = [[NSString stringWithFormat:@"%ld",(long)indexPath.row]intValue];
    
    [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%d",row] forKey:@"SelectedRow"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    UIViewController  *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WallVc"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
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
    NSMutableArray *fetchdata =  [DBOperation selectData:[NSString stringWithFormat:@"select * from Login"]];
    if (fetchdata.count != 0)
    {
        for (NSMutableDictionary *dicFetch in fetchdata)
        {
            NSString *strJson = [dicFetch objectForKey:@"dic_json_string"];
            
            NSMutableDictionary *dic1 = [Utility ConvertStringtoJSON:strJson];
            [fetchDataAry addObject:dic1];
        }
    }
    [_tblSwitchAccount reloadData];
}

@end
