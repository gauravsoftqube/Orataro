//
//  AttendanceVC.m
//  orataro
//
//  Created by Softqube Mac IOS on 06/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "AttendanceVC.h"
#import "AttendanceTableViewCell.h"
#import "ClassVcCell.h"
#import "SWRevealViewController.h"
#import "StudentListViewController.h"

@interface AttendanceVC ()
{
    NSMutableArray *classTableDataAry;
    UIDatePicker *datePicker;
    UIAlertView *alert;
}
@end

@implementation AttendanceVC
@synthesize AttendanceTableView,aClasstableView,aClassMAinView,workBtn,NormalBtn,aTextfield1,aTextField2,aTextfield3;

int com =0 ;
int cn =0;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    classTableDataAry = [[NSMutableArray alloc]initWithObjects:@"Class A",@"Class B",@"Class C",@"Class D",@"Class E", nil];
    
      [AttendanceTableView registerNib:[UINib nibWithNibName:@"AttendanceTableViewCell" bundle:nil] forCellReuseIdentifier:@"AttendanceCell"];
    AttendanceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [aClasstableView registerNib:[UINib nibWithNibName:@"ClassVcCell" bundle:nil] forCellReuseIdentifier:@"ClassCell"];
    aClasstableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    aClassMAinView.hidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TaptoHideView:)];
    
    [aClassMAinView addGestureRecognizer:tap];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    aTextfield1.leftView = paddingView;
    aTextfield1.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    aTextField2.leftView = paddingView1;
    aTextField2.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    aTextfield3.leftView = paddingView2;
    aTextfield3.leftViewMode = UITextFieldViewModeAlways;
    
    
    CGRect frame = CGRectMake(0, 0, 200, 200);
    datePicker = [[UIDatePicker alloc] initWithFrame:frame];
    datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
   // NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
  //  [dateFormatter setDateFormat:@"dd MMM yyyy"];
  // NSString * dateString = [dateFormatter stringFromDate:[NSDate date]];
    
  //  NSDate *dt = [dateFormatter dateFromString:dateString];
    
   // [datePicker setDate:dt];
    
    //NSLog(@"str=%@",dateString);
    //NSLog(@"dt=%@",dt);
    
    alert = [[UIAlertView alloc]
             initWithTitle:@"Select Date"
             message:nil
             delegate:self
             cancelButtonTitle:@"OK"
             otherButtonTitles:@"Cancel", nil];
    alert.delegate = self;
    [alert setValue:datePicker forKey:@"accessoryView"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tap to hide view

-(void)TaptoHideView :(UIGestureRecognizer *)tap
{
    aClassMAinView.hidden = YES;
}
#pragma mark - tabelview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == AttendanceTableView)
    {
        AttendanceTableViewCell *cell = (AttendanceTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AttendanceCell"];
        
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AttendanceTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }

        if (indexPath.row % 2 ==0)
        {
            cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
        }
        else
        {
            cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    if (tableView == aClasstableView)
    {
        ClassVcCell *cell = (ClassVcCell *)[tableView dequeueReusableCellWithIdentifier:@"ClassCell"];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ClassVcCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

//        NSString *yourText = [yourArray objectAtIndex:indexPath.row];
//
//        CGSize labelWidth = CGSizeMake(300, CGFLOAT_MAX); // 300 is fixed width of label. You can change this value
//        CGRect textRect = [visitorsPerRegion boundingRectWithSize:labelWidth options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:16.0]} context:nil];
//
//        int calculatedHeight = textRect.size.height+10;
//        return (float)calculatedHeight;

    if (tableView == AttendanceTableView)
    {
        return 59;
    }
    
    if (tableView == aClasstableView)
    {
        return 64;
    }

    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    StudentListViewController *s = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"StudentListViewController"];
//    [self.navigationController pushViewController:s animated:YES];
}
#pragma mark - button action

- (IBAction)ClassBtnClicked:(id)sender
{
    aClassMAinView.hidden = NO;
    [self.view bringSubviewToFront:aClassMAinView];
}
- (IBAction)MenuBtnClicked:(id)sender
{
    [self.revealViewController rightRevealToggle:nil];
}
- (IBAction)isWorkingClicked:(id)sender
{
    //checkboxunselected
    //checkboxblue
    if (com == 0)
    {
        [workBtn setBackgroundImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
        com =1;
       
    }
    else
    {
        [workBtn setBackgroundImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
        com =0;
      
    }
}
- (IBAction)DateSelectClicked:(id)sender
{
    [datePicker setDate:[NSDate date]];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
    }
    if (buttonIndex == 1)
    {
        alert.hidden = YES;
    }
}
- (IBAction)NormalBtnClicked:(id)sender
{
    if (cn==0)
    {
        [NormalBtn setTitle:@"Quick" forState:UIControlStateNormal];
        cn =1;
        AttendanceTableView.hidden = YES;
        aTextfield3.hidden = NO;
        aTextField2.hidden = NO;
        aTextfield1.hidden = NO;
        [self.view bringSubviewToFront:aTextfield1];
        [self.view bringSubviewToFront:aTextField2];
        [self.view bringSubviewToFront:aTextfield3];
    }
    else
    {
        [NormalBtn setTitle:@"Normal" forState:UIControlStateNormal];
        cn =0;
        AttendanceTableView.hidden = NO;
        aTextfield3.hidden = YES;
        aTextField2.hidden = YES;
        aTextfield1.hidden = YES;
        [self.view bringSubviewToFront:AttendanceTableView];
        

    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
