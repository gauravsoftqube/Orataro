//
//  LeaveVc.m
//  orataro
//
//  Created by Softqube on 13/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "LeaveVc.h"
#import "Global.h"

@interface LeaveVc ()
{
    NSMutableArray *aryStatusAry;
    NSString *strSetPreApplication;
}
@end

@implementation LeaveVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    aryStatusAry = [[NSMutableArray alloc]initWithObjects:@"Approved",@"Reject",@"Pending", nil];
    
    _viewLeaveStatus.hidden = YES;
    [self commonData];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"Data=%@",_dicAddLeave);
    
    
    _lblFullName.text = [_dicAddLeave objectForKey:@"ApplicationBY"];
    _lblSubTitleName.text = [_dicAddLeave objectForKey:@"ReasonForLeave"];
    
    NSString *str = [_dicAddLeave objectForKey:@"ApplicationBY"];
    
    NSArray *ary = [str componentsSeparatedByString:@""];
    
    _lblApplicationBy.text = [ary objectAtIndex:0];
    
   // NSString *StartDate=[Utility convertMiliSecondtoDate:@"MM-dd-yyyy" date:[dicPoll objectForKey:@"StartDate"]];
    
    _lblApprovedOn.text = [Utility convertMiliSecondtoDate:@"dd-MM-yyyy" date:[_dicAddLeave objectForKey:@"ApprovedOn"]];
    
    _lblStartDate.text = [Utility convertMiliSecondtoDate:@"dd-MM-yyyy" date:[_dicAddLeave objectForKey:@"StartDate"]];
    
    _lblEndDate.text = [Utility convertMiliSecondtoDate:@"dd-MM-yyyy" date:[_dicAddLeave objectForKey:@"EndDate"]];
    
    _lblTeacherName.text = [_dicAddLeave objectForKey:@"TeacherName"];
    
    _lblApplicationDate.text = [Utility convertMiliSecondtoDate:@"dd-MM-yyyy" date:[_dicAddLeave objectForKey:@"DateOfApplication"]];
    
    BOOL checkPerApplication = [_dicAddLeave objectForKey:@"IsPerApplication"];
    
    if (checkPerApplication == YES)
    {
        [_btnPreApplication setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
    }
    else
    {
        [_btnPreApplication setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
    }
    //checkboxblue
    //checkboxunselected
    
    /*
     
     @property (weak, nonatomic) IBOutlet UIView *viewLeaveStatus;
     @property (weak, nonatomic) IBOutlet UILabel *lblFullName;
     @property (weak, nonatomic) IBOutlet UILabel *lblSubTitleName;
     @property (weak, nonatomic) IBOutlet UILabel *lblApplicationBy;
     @property (weak, nonatomic) IBOutlet UILabel *lblApprovedOn;
     @property (weak, nonatomic) IBOutlet UILabel *lblStartDate;
     @property (weak, nonatomic) IBOutlet UILabel *lblEndDate;
     @property (weak, nonatomic) IBOutlet UILabel *lblTeacherName;
     @property (weak, nonatomic) IBOutlet UILabel *lblApplicationDate;
     @property (weak, nonatomic) IBOutlet UIButton *btnPreApplication;
     - (IBAction)btnPreApplication:(id)sender;
     @property (weak, nonatomic) IBOutlet UILabel *lblLeaveStatus;
     @property (weak, nonatomic) IBOutlet UITextView *txtViewNote;
     @property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
     */
    
}

- (void)viewDidLayoutSubviews
{
    [_txtViewNote setContentOffset:CGPointZero animated:NO];
}

-(void)commonData
{
    
}

#pragma mark - tableview delegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return aryStatusAry.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hrllll"];
    
    if (cell ==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hrllll"];
    }
    
    cell.textLabel.text = [aryStatusAry objectAtIndex:indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - button action

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnPreApplication:(id)sender
{
    //checkboxblue
    //checkboxunselected
    UIImage* checkImage = _btnPreApplication.currentImage;
    UIImage* checkImage1 = [UIImage imageNamed:@"checkboxblue"];
    NSData *checkImageData = UIImagePNGRepresentation(checkImage);
    NSData *propertyImageData = UIImagePNGRepresentation(checkImage1);
    
    if ([checkImageData isEqualToData:propertyImageData])
    {
        strSetPreApplication =@"0";
    }
    else
    {
        strSetPreApplication =@"1";
    }
}
- (IBAction)btnSubmit:(id)sender
{
}
- (IBAction)btnpendClicked:(id)sender
{
    _viewLeaveStatus.hidden = NO;
    [self.view bringSubviewToFront:_viewLeaveStatus];
}
@end
