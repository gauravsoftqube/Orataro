//
//  ProfileAddUpdateListDetailListVc.m
//  orataro
//
//  Created by Softqube on 27/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ProfileAddUpdateListDetailListVc.h"

@interface ProfileAddUpdateListDetailListVc ()

@end

@implementation ProfileAddUpdateListDetailListVc

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
    self.tblAddUpdateList.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tblAddUpdateList.allowsSelection=NO;
    
    if([self.strVctoNavigate isEqualToString:@"Add"])
    {
        [self.viewUpdate setHidden:YES];
        [self.tblAddUpdateList setHidden:NO];
    }
    else
    {
        [self.tblAddUpdateList setHidden:YES];
        [self.viewUpdate setHidden:NO];
    }

}

#pragma mark - UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 231;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellAddNew"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    //UIView *viewBackgroundCell=(UIView *)[cell.contentView viewWithTag:3];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - tbl Add UIButton Action

- (IBAction)btnAddCheckBox:(id)sender {
}
- (IBAction)btnAddSmileImg:(id)sender {
}
- (IBAction)btnAddRemoveSmileImg:(id)sender {
}

#pragma mark - Update UIButton Action

- (IBAction)btnUpdateSmileRemove:(id)sender {
}
- (IBAction)btnUpdateSmileAdd:(id)sender {
}


#pragma mark - UIButton Action

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnSubmit:(id)sender {
}
@end
