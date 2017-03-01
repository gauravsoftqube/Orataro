//
//  CreateScoolGroupVc.m
//  orataro
//
//  Created by Softqube on 22/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "CreateScoolGroupVc.h"
#import "Global.h"
#import "AppDelegate.h"

@interface CreateScoolGroupVc ()
{
    AppDelegate *get;
}
@end

@implementation CreateScoolGroupVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    get = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    NSLog(@"value=%d",get.scoolgroup);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tblMemberList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    // Do any additional setup after loading the view.
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    [Utility setLeftViewInTextField:self.txtGroupTitle imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtGroupSubject imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtEducationGroup imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtGroupMemberTecher imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtGroupMemberStudent imageName:@"" leftSpace:0 topSpace:0 size:5];

    if (get.scoolgroup == 1)
    {
        _aHeadreTitle.text = @"Create Group (kinjal)";
        self.tblMembrList_Height.constant=0;
    }
    else
    {
        _aHeadreTitle.text = @"Edit Group (kinjal)";
        self.tblMembrList_Height.constant=105*5;
    }
}

#pragma mark - tableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    UIImageView *img=(UIImageView *)[cell.contentView viewWithTag:2];
    
    [img.layer setBorderColor:[UIColor colorWithRed:34/255.0f green:49/255.0f blue:89/255.0f alpha:1.0f].CGColor];
    [img.layer setBorderWidth:1.0f];
    
   // UILabel *lblName=(UILabel *)[cell.contentView viewWithTag:3];
    
    
   // UILabel *lblStatus=(UILabel *)[cell.contentView viewWithTag:4];
    
    
    UIButton *btnRemove=(UIButton *)[cell.contentView viewWithTag:5];
    [btnRemove.layer setCornerRadius:4];
    btnRemove.clipsToBounds=YES;
    
    return cell;
}


#pragma mark - UIButton Action



- (IBAction)btnBackHeader:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)btnSubmitHeader:(id)sender {
}
- (IBAction)btnTackeImage:(id)sender {
}

- (IBAction)btnMemberCkeckBoxMember:(id)sender {
}
- (IBAction)btnMemberCkeckBoxPost:(id)sender {
}
- (IBAction)btnMemberCkeckBoxAlbums:(id)sender {
}
- (IBAction)btnMemberCkeckBoxAttachment:(id)sender {
}
- (IBAction)btnMemberCkeckBoxPolls:(id)sender {
}
- (IBAction)btnSelectEducationGroup:(id)sender {
}
- (IBAction)btnSelectGroupMemberStudent:(id)sender {
}
- (IBAction)btnSelectGroupMemberTecher:(id)sender {
}
@end
