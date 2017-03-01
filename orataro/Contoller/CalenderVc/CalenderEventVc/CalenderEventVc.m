//
//  CalenderEventVc.m
//  orataro
//
//  Created by Softqube on 22/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "CalenderEventVc.h"
#import "CalenderEventDetailVc.h"

@interface CalenderEventVc ()

@end

@implementation CalenderEventVc

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
    self.tblCalenderEventList.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self.viewPopupBorder.layer setBorderColor:[UIColor colorWithRed:34/255.0f green:49/255.0f blue:89/255.0f alpha:1.0f].CGColor];
    [self.viewPopupBorder.layer setBorderWidth:2];
    [self PopupHidden];
}

-(void)PopupHidden
{
    [self.btnPopuBack setHidden:YES];
    [self.viewPopup setHidden:YES];
}

-(void)PopupShow
{
    [self.btnPopuBack setHidden:NO];
    [self.viewPopup setHidden:NO];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *HeaderCellIdentifier = @"cellSection";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeaderCellIdentifier];
    }
    UIView *viewRound=(UIView *)[cell.contentView viewWithTag:1];
    [viewRound.layer setCornerRadius:50];
    viewRound.clipsToBounds=YES;
    [viewRound.layer setBorderColor:[UIColor colorWithRed:202/255.0f green:202/255.0f blue:202/255.0f alpha:1.0f].CGColor];
    [viewRound.layer setBorderWidth:2];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellRow"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    UIView *viewBackgroundCell=(UIView *)[cell.contentView viewWithTag:1];
    UIView *viewDateBackground=(UIView *)[cell.contentView viewWithTag:2];
    if(indexPath.row % 2)
    {
        [viewBackgroundCell setBackgroundColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f]];
        [viewDateBackground setBackgroundColor:[UIColor colorWithRed:46/255.0f green:60/255.0f blue:100/255.0f alpha:1.0f]];
    }
    else
    {
        [viewBackgroundCell setBackgroundColor:[UIColor colorWithRed:242/255.0f green:242/255.0f blue:242/255.0f alpha:1.0f]];
        [viewDateBackground setBackgroundColor:[UIColor colorWithRed:29/255.0f green:42/255.0f blue:76/255.0f alpha:1.0f]];
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"CalenderEventDetailVc"];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UIButton Action

- (IBAction)btnHeaderMenu:(id)sender {
    [self PopupShow];
}
- (IBAction)btnHome:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnPopuBack:(id)sender {
    [self PopupHidden];
}
- (IBAction)btnSyncCalender:(id)sender {
    [self PopupHidden];
}
- (IBAction)btnActivity:(id)sender {
}
- (IBAction)btnEvent:(id)sender {
}
- (IBAction)btnExam:(id)sender {
}
- (IBAction)btnHoliday:(id)sender {
}
@end
