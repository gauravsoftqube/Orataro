//
//  AddPollVc.m
//  orataro
//
//  Created by MAC008 on 07/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "AddPollVc.h"
#import "Global.h"

@interface AddPollVc ()<UITextFieldDelegate>
{
    NSMutableArray *arrAnsOption;
    
    NSString *flagNotifyOnlyParticipaintUser;
    NSString *flagIsParcentage;
    NSString *flagIsMultiChoice;
    
    UIDatePicker *datePicker;
    UIAlertView *alert;
    
    UIDatePicker *datePickerEnd;
    UIAlertView *alertEnd;

}
@end

@implementation AddPollVc
@synthesize aAddOptionView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    aAddOptionView.layer.cornerRadius = 12.5;
    aAddOptionView.layer.masksToBounds =YES;
    
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
}

-(void)commonData
{
    //set Header Title
    if ([_strPoll isEqualToString:@"Add"])
    {
        NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
        if (arr.count != 0) {
            _lbHeaderText.text=[NSString stringWithFormat:@"Add Poll (%@)",[arr objectAtIndex:0]];
        }
        else
        {
            _lbHeaderText.text=[NSString stringWithFormat:@"Add Poll"];
        }
    }
    else
    {
        NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
        if (arr.count != 0) {
            _lbHeaderText.text=[NSString stringWithFormat:@"Edit Poll (%@)",[arr objectAtIndex:0]];
        }
        else
        {
            _lbHeaderText.text=[NSString stringWithFormat:@"Edit Poll"];
        }
    }
    
    //
    arrAnsOption = [[NSMutableArray alloc]init];
    
    //
    self.tblMoreOptionList.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //
    flagNotifyOnlyParticipaintUser=@"0";
    flagIsParcentage=@"0";
    flagIsMultiChoice=@"0";
    
    //
    [Utility setLeftViewInTextField:_txtPollName imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtStartDate imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtEndDate imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtAnswerChoices imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    
    //StartDate
    CGRect frame = CGRectMake(0, 0, 200, 200);
    datePicker = [[UIDatePicker alloc] initWithFrame:frame];
    datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    NSDate *Date=[NSDate date];
    datePicker.maximumDate=Date;
    
    alert = [[UIAlertView alloc]
             initWithTitle:@"Select Date"
             message:nil
             delegate:self
             cancelButtonTitle:@"OK"
             otherButtonTitles:@"Cancel", nil];
    alert.delegate = self;
    alert.tag=111;
    [alert setValue:datePicker forKey:@"accessoryView"];
    
    //EndDate
    
    CGRect frameEnd = CGRectMake(0, 0, 200, 200);
    datePickerEnd = [[UIDatePicker alloc] initWithFrame:frameEnd];
    datePickerEnd = [[UIDatePicker alloc] init];
    datePickerEnd.datePickerMode = UIDatePickerModeDate;
    
    NSDate *DateEnd=[NSDate date];
    datePickerEnd.minimumDate=DateEnd;
    
    alertEnd = [[UIAlertView alloc]
                initWithTitle:@"Select Date"
                message:nil
                delegate:self
                cancelButtonTitle:@"OK"
                otherButtonTitles:@"Cancel", nil];
    alertEnd.delegate = self;
    alertEnd.tag=112;
    [alertEnd setValue:datePickerEnd forKey:@"accessoryView"];
}

#pragma mark - UITextField

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField)
    {
        NSMutableDictionary *dic=[arrAnsOption objectAtIndex:textField.tag];
        [dic setValue:textField.text forKey:@"ans"];
    }
}

#pragma mark - UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrAnsOption count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellANS"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    UITextField *txt=(UITextField *)[cell.contentView viewWithTag:1];
    txt.tag=indexPath.row;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (IBAction)btnCell_DeleteMoreOption:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblMoreOptionList];
    NSIndexPath *indexPath = [self.tblMoreOptionList indexPathForRowAtPoint:buttonPosition];
    [arrAnsOption removeObjectAtIndex:indexPath.row];
    
    [self.tblMoreOptionList deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
  
    long tblHeight=[arrAnsOption count] * 51;
    self.viewMoreOption_Height.constant = tblHeight + 120;
}

#pragma mark -  Date Picker Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 111)
    {
        if (buttonIndex == 0)
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
            self.txtStartDate.text = theDate;
        }
        
    }
    if (alertView.tag == 112)
    {
        if (buttonIndex == 0)
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePickerEnd date]];
            self.txtEndDate.text = theDate;
        }
        
    }
    
}


#pragma mark - button action

- (IBAction)BackBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnStartDate:(id)sender
{
    [self.view endEditing:YES];
    [datePicker setDate:[NSDate date]];
    [alert show];
}

- (IBAction)btnEndDate:(id)sender
{
    [self.view endEditing:YES];
    [datePickerEnd setDate:[NSDate date]];
    [alertEnd show];
    
}

- (IBAction)btnNotifyOnly:(id)sender
{
    if([flagNotifyOnlyParticipaintUser integerValue] == 1)
    {
        flagNotifyOnlyParticipaintUser=@"0";
        [_btnNotifyOnly setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
    }
    else
    {
        flagNotifyOnlyParticipaintUser=@"1";
         [_btnNotifyOnly setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
        
    }
}

- (IBAction)btnIsPercentage:(id)sender
{
    if([flagIsParcentage integerValue] == 1)
    {
        flagIsParcentage=@"0";
        [_btnIsPercentage setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
    }
    else
    {
        flagIsParcentage=@"1";
        [_btnIsPercentage setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
        
    }
}

- (IBAction)btnIsMultiChoice:(id)sender
{
    if([flagIsMultiChoice integerValue] == 1)
    {
        flagIsMultiChoice=@"0";
        [_btnIsMultiChoice setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
    }
    else
    {
        flagIsMultiChoice=@"1";
        [_btnIsMultiChoice setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
        
    }
}

- (IBAction)btnAddMoreOption:(id)sender
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"" forKey:@"ans"];
    [arrAnsOption addObject:dic];
    
    long tblHeight=[arrAnsOption count] * 51;
    self.viewMoreOption_Height.constant = tblHeight + 120;
    [self.tblMoreOptionList reloadData];
}

@end
