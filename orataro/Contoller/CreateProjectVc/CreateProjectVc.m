//
//  CreateProjectVc.m
//  orataro
//
//  Created by Softqube on 13/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "CreateProjectVc.h"
#import "Global.h"

@interface CreateProjectVc ()

@end

@implementation CreateProjectVc

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
    [Utility setLeftViewInTextField:self.txtProjectTitle imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtStartDate imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtEndDate imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtSelectProjectStudents imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtProjectMemberTeacher imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    if ([_projectvar isEqualToString:@"Edit"])
    {
        self.tblEditProjectMemberList_Height.constant=105*5;
        _aHeaderTitleLb.text =@"Edit Project (Name)";
    }
    else
    {
        self.tblEditProjectMemberList_Height.constant=0;
         _aHeaderTitleLb.text =@"Create Project (Name)";
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
    
    UILabel *lblName=(UILabel *)[cell.contentView viewWithTag:3];
    
    
    UILabel *lblStatus=(UILabel *)[cell.contentView viewWithTag:4];
    
    
    UIButton *btnRemove=(UIButton *)[cell.contentView viewWithTag:5];
    [btnRemove.layer setCornerRadius:4];
    btnRemove.clipsToBounds=YES;
    
    return cell;
}

- (IBAction)btnRemove:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblEditProjectMemberList];
    NSIndexPath *indexPath = [self.tblEditProjectMemberList indexPathForRowAtPoint:buttonPosition];
    
}


#pragma mark - button action

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnSumbit:(id)sender {
}
@end
