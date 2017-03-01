//
//  ProjectVc.m
//  orataro
//
//  Created by Softqube on 13/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ProjectVc.h"
#import "ORGDetailViewController.h"
#import "ORGContainerCell.h"
#import "ORGContainerCellView.h"
#import "CreateProjectVc.h"

@interface ProjectVc ()

@end

@implementation ProjectVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _AddBtn.layer.cornerRadius = 30.0;
    
    _tblProjectList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    // Do any additional setup after loading the view.
    NSMutableArray *arrTemp=[[NSMutableArray alloc]init];
    NSMutableArray *arrsecDetail=[[NSMutableArray alloc]init];
    [arrsecDetail addObject:@"a"];
    [arrsecDetail addObject:@"a"];
    [arrsecDetail addObject:@"a"];
    [arrsecDetail addObject:@"a"];
    [arrsecDetail addObject:@"a"];
    [arrsecDetail addObject:@"a"];
    [arrsecDetail addObject:@"a"];
    [arrsecDetail addObject:@"a"];
    [arrsecDetail addObject:@"a"];
    [arrsecDetail addObject:@"a"];

    NSMutableDictionary *dicSection=[[NSMutableDictionary alloc]init];
    [dicSection setObject:@"asa" forKey:@"FloorID"];
    [dicSection setObject:arrsecDetail forKey:@"Floor"];
    [arrTemp addObject:dicSection];
    
    self.sampleData=[arrTemp mutableCopy];
    
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    // Register the table cell
    [self.tblProjectList registerClass:[ORGContainerCell class] forCellReuseIdentifier:@"ORGContainerCell"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectItemFromCollectionView:) name:@"didSelectItemFromCollectionView" object:nil];
}

#pragma mark - Table View

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 67;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sampleData count];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *HeaderCellIdentifier = @"cellSection";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCellIdentifier];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ORGContainerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ORGContainerCell"];
    
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cellSection"];
    
    UIImageView *img1 = (UIImageView *)[cell1.contentView viewWithTag:50];
    img1.image = [img1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [img1 setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    img1.contentMode = UIViewContentModeScaleAspectFit;

    
    NSDictionary *cellData = [self.sampleData objectAtIndex:[indexPath section]];
    NSArray *articleData = [cellData objectForKey:@"Floor"];
    [cell setCollectionData:articleData];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - NSNotification to select table cell
- (void) didSelectItemFromCollectionView:(NSNotification *)notification
{
    NSDictionary *cellData = [notification object];
    if (cellData)
    {
    }
    CreateProjectVc *s = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"CreateProjectVc"];
    s.projectvar =@"Edit";
    [self.navigationController pushViewController:s animated:YES];
    
}   

#pragma mark - button action

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addBtnClicked:(id)sender
{
    CreateProjectVc *s = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"CreateProjectVc"];
    s.projectvar = @"Create";
    
    [self.navigationController pushViewController:s animated:YES];
}

@end
