//
//  ScoolGroupVc.m
//  orataro
//
//  Created by Softqube on 22/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ScoolGroupVc.h"
#import "CreateScoolGroupVc.h"
#import "AppDelegate.h"

@interface ScoolGroupVc ()
{
    AppDelegate *p;
}
@end

@implementation ScoolGroupVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    p = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    _AddBtn.layer.cornerRadius = 30.0;
    
    _DeleteImageview.image = [_DeleteImageview.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [_DeleteImageview setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    _DeleteImageview.contentMode = UIViewContentModeScaleAspectFit;

    _tblScoolGroupList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    _tblScoolGroupList.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Do any additional setup after loading the view.
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    
}

#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellRow"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UIView *viewBackgroundCell=(UIView *)[cell.contentView viewWithTag:1];
    if(indexPath.row % 2)
    {
        [viewBackgroundCell setBackgroundColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f]];
        
    }
    else
    {
        [viewBackgroundCell setBackgroundColor:[UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f]];
    }
    
    UIImageView *img1 = (UIImageView *)[cell.contentView viewWithTag:11];
    img1.image = [img1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [img1 setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    img1.contentMode = UIViewContentModeScaleAspectFit;

    UIImageView *img2 = (UIImageView *)[cell.contentView viewWithTag:5];
    img2.layer.cornerRadius = 40.0;
    img2.layer.masksToBounds = YES;
    
    //11
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    p.scoolgroup = 2;
    
    CreateScoolGroupVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateScoolGroupVc"];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)btnDeleteGroup:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblScoolGroupList];
    NSIndexPath *indexPath = [self.tblScoolGroupList indexPathForRowAtPoint:buttonPosition];
}


#pragma mark - UIButton Action

- (IBAction)btnBackHeader:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnCreateGroup:(id)sender {
}

- (IBAction)AddBtnClicked:(UIButton *)sender
{
    p.scoolgroup = 1;
    
    CreateScoolGroupVc *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"CreateScoolGroupVc"];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
