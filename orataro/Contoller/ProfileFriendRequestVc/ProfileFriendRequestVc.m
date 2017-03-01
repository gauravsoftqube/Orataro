//
//  ProfileFriendRequestVc.m
//  orataro
//
//  Created by Softqube on 24/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ProfileFriendRequestVc.h"

@interface ProfileFriendRequestVc ()

@end

@implementation ProfileFriendRequestVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    self.tblFriendList.separatorStyle=UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellRow"];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    UIView *viewBackgroundCell=(UIView *)[cell.contentView viewWithTag:1];
    
    UIButton *btnAccept=(UIButton *)[cell.contentView viewWithTag:6];
    [btnAccept.layer setCornerRadius:4];
    btnAccept.clipsToBounds=YES;
    
    UIButton *btnDecline=(UIButton *)[cell.contentView viewWithTag:7];
    [btnDecline.layer setCornerRadius:4];
    btnDecline.clipsToBounds=YES;
    
    [btnDecline.layer setBorderColor:[UIColor colorWithRed:34/255.0f green:49/255.0f blue:89/255.0f alpha:1.0f].CGColor];
    [btnDecline.layer setBorderWidth:1];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UIButton Action

- (IBAction)btntblAccept:(id)sender {
}

- (IBAction)btntblDecline:(id)sender {
}

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
