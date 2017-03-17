//
//  AddCircularVc.m
//  orataro
//
//  Created by Softqube Mac IOS on 30/01/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "AddCircularVc.h"
#import "RightVc.h"
#import "REFrostedViewController.h"
#import "SAMTextView.h"
#import "Global.h"

@interface AddCircularVc ()<UIGestureRecognizerDelegate>
{
    UIDatePicker *datePicker;
    UIAlertView *alert;
    NSMutableArray *circularAry,*subAry;
}
@end

@implementation AddCircularVc
@synthesize aViewHeight,aScrollview,aViewwidth,aDescLb,aDescTextView,aTitleTextfield,selectTypeTextfield,standardTextfield,endDateTextfield,PhotoBtn,viewCircularType,viewSubjectandDiv,tblSubject,tblCircularType;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    circularAry = [[NSMutableArray alloc]init];
    subAry = [[NSMutableArray alloc]init];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TaptoHideViewCircular:)];
    [viewCircularType addGestureRecognizer:tap];
    
    viewSubjectandDiv.hidden = YES;
    viewCircularType.hidden = YES;
    
   // [tblCircularType setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  //  [tblSubject setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //checkboxblue
    
    [aScrollview setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 2000)];
    [aViewHeight setConstant:600];
    
    [aViewwidth setConstant:[UIScreen mainScreen].bounds.size.width];
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    selectTypeTextfield.leftView = paddingView;
    selectTypeTextfield.leftViewMode = UITextFieldViewModeAlways;

    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    aTitleTextfield.leftView = paddingView1;
    aTitleTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    standardTextfield.leftView = paddingView2;
    standardTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    endDateTextfield.leftView = paddingView3;
    endDateTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    aDescTextView.textContainerInset = UIEdgeInsetsMake(10, 20, 0, 0);
    

    CGRect frame = CGRectMake(0, 0, 200, 200);
    datePicker = [[UIDatePicker alloc] initWithFrame:frame];
    datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    alert = [[UIAlertView alloc]
             initWithTitle:@"Select Date"
             message:nil
             delegate:self
             cancelButtonTitle:@"OK"
             otherButtonTitles:@"Cancel", nil];
    alert.delegate = self;
    [alert setValue:datePicker forKey:@"accessoryView"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
     [self apiCallFor_getCircularType];
      // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tabelview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tblCircularType)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hello"];
        
        if (!cell)
        {
            // if cell is empty create the cell
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hello"];
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
        NSLog(@"circular =%@",circularAry);
        
        cell.textLabel.text = [[circularAry objectAtIndex:indexPath.row]objectForKey:@"Term"];
        
      //  [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        
        return cell;
    }
    if (tableView == tblSubject)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubjectCell"];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SubjectCell" owner:self options:nil];
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
        
        UILabel *lb = (UILabel *)[cell.contentView viewWithTag:1];
        lb.text = [[subAry objectAtIndex:indexPath.row]objectForKey:@"Grade"];
        
        UILabel *lb1 = (UILabel *)[cell.contentView viewWithTag:2];
        lb1.text = [[subAry objectAtIndex:indexPath.row]objectForKey:@"Division"];
        // UIButton *btnSelect = (UIButton *)[cell.contentView viewWithTag:4];
      //  UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:3];
        
          NSLog(@"circular =%@",subAry);
        return cell;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tblCircularType)
    {
        return 44;
    }
    
    if (tableView == tblSubject)
    {
        return 59;
    }
    
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == tblCircularType)
    {
       if(circularAry.count>0)
       {
           return circularAry.count;
       }
    }
    
    if (tableView == tblSubject)
    {
        if (subAry.count > 0)
        {
            return subAry.count;
        }
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tblCircularType)
    {
        selectTypeTextfield.text = [[circularAry objectAtIndex:indexPath.row]objectForKey:@"Term"];
        
        //viewCircularType.hidden = YES;
    }
    if (tableView == tblSubject)
    {
        // lb.text = [[subAry objectAtIndex:indexPath.row]objectForKey:@"Grade"];
        
        //  UILabel *lb1 = (UILabel *)[cell.contentView viewWithTag:2];
        //  lb1.text = [[subAry objectAtIndex:indexPath.row]objectForKey:@"Division"];
        
        //NSString *getStandardDiv = [[subAry objectAtIndex:indexPath.row]objectForKey:@"Grade"];
        //standardTextfield.text =
    }
}


#pragma mark - textview delegate

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (aDescTextView.text.length == 0)
    {
        aDescTextView.text = @"";
        aDescTextView.textColor = [UIColor blackColor];
    }
    if ([aDescTextView.text isEqualToString:@"Description"])
    {
        aDescTextView.text = @"";
        aDescTextView.textColor = [UIColor blackColor];
    }

    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(aDescTextView.text.length == 0){
        aDescTextView.textColor = [UIColor lightGrayColor];
        aDescTextView.text = @"Description";
        [aDescTextView resignFirstResponder];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(aDescTextView.text.length == 0){
            aDescTextView.textColor = [UIColor lightGrayColor];
            aDescTextView.text = @"Desciption";
            [aDescTextView resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
}

#pragma mark - gesture reconize

-(void)TaptoHideViewCircular:(UIGestureRecognizer *)tap
{
    
}
-(void)TaptoHideViewSubject:(UIGestureRecognizer *)tap
{
    //viewSubjectandDiv.hidden = YES;
}

#pragma mark - button action

- (IBAction)BackBtnClicked1:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)BackBtnClicked:(id)sender
{
   // UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // here you need to create storyboard ID of perticular view where you need to navigate your app
//    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"WallVc"];
//    UIViewController *vc1 = [mainStoryboard instantiateViewControllerWithIdentifier:@"RightVc"];
//    [self.revealViewController setFrontViewController:vc animated:YES];
//    [self.revealViewController setRightViewController:vc1 animated:YES];
//    [self.navigationController popToViewController:self.revealViewController animated:YES];
}

- (IBAction)addPhotoBtnClicked:(id)sender
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Add Photo!" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose from Liabrary", nil];
    
    [action showInView:self.view];
}


- (IBAction)btnSaveClicked:(id)sender
{
    
}

- (IBAction)btnEndDateClicked:(id)sender
{
    [datePicker setDate:[NSDate date]];
    [alert show];
}

- (IBAction)btnStandardClicked:(id)sender
{
    viewCircularType.hidden = YES;
    viewSubjectandDiv.hidden = NO;
    [self.view bringSubviewToFront:viewSubjectandDiv];

}

- (IBAction)btnCircularClicked:(id)sender
{
    viewCircularType.hidden = NO;
    viewSubjectandDiv.hidden = YES;
    [self.view bringSubviewToFront:viewCircularType];
}

- (IBAction)btnDoneClciked:(id)sender
{
    
}

- (IBAction)btnCancelClicked:(id)sender
{
    viewSubjectandDiv.hidden = YES;
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

#pragma mark - ActionSheet delegates

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( buttonIndex == 0 )
    {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *pickerView =[[UIImagePickerController alloc]init];
            pickerView.allowsEditing = YES;
            pickerView.delegate = self;
            pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentModalViewController:pickerView animated:true];
        }
        
    }
    else if( buttonIndex == 1)
    {
        
        UIImagePickerController *pickerView = [[UIImagePickerController alloc] init];
        pickerView.allowsEditing = YES;
        pickerView.delegate = self;
        [pickerView setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentModalViewController:pickerView animated:YES];
        
    }
}

#pragma mark - PickerDelegates

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    //  [self dismissModalViewControllerAnimated:true];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage * img = [info valueForKey:UIImagePickerControllerEditedImage];
    
    [PhotoBtn setBackgroundImage:img forState:UIControlStateNormal];
    
   // PostImageView.image = img;
}

#pragma mark - api call

-(void)apiCallFor_getCircularType
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_login,apk_GetCircularType];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSLog(@"dic=%@",dicCurrentUser);
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:@"CircularType" forKey:@"Category"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
  
    
    [ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
        // [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[dic objectForKey:@"message"];
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     circularAry = arrResponce;
                   //  NSLog(@"arra=%@",circularAry);
                     [self apiCallFor_getSubDiv];

                 }
             }
             else
             {
                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alrt show];
             }
         }
         else
         {
             UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alrt show];
         }
     }];
}

-(void)apiCallFor_getSubDiv
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        [ProgressHUB hideenHUDAddedTo:self.view];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_gradedivisionsubject,apk_GetGradeDivisionSubjectbyTeacher];
    
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
   // NSLog(@"dic=%@",dicCurrentUser);
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:@"Teacher" forKey:@"Role"];
   
   // NSLog(@"data=%@",param);

    //[ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
            // NSLog(@"data=%@",dicResponce);
             
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             //NSLog(@"array=%@",arrResponce);
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[dic objectForKey:@"message"];
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     subAry = arrResponce;
                     [tblSubject reloadData];
                     [tblCircularType reloadData];
                    // NSLog(@"arra=%@",subAry);
                 }
             }
             else
             {
                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alrt show];
             }
         }
         else
         {
             UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alrt show];
         }
     }];
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
