//
//  HealthRecordVc.m
//  orataro
//
//  Created by MAC008 on 04/05/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "HealthRecordVc.h"
#import "Utility.h"

@interface HealthRecordVc ()
{
    __weak IBOutlet NSLayoutConstraint *txtheightConstant;
    NSMutableArray *aryQuestion;
    NSMutableDictionary *dicEditHelthRecordData;
}
@end

@implementation HealthRecordVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    aryQuestion = [[NSMutableArray alloc]initWithObjects:@"1. Allergies if any (including Medicine Allergies) :",@"2. Specific diseases suffered:",@"3. Operation undergone, if any :",@"4. Any Other diseases for which the child is on regular medication :",@"5. Colour fear if any :",@"6. Height (cm):",@"7. Weight (kg):",@"8. Blood Group :",@"9. Family Doctor",@"10. ContactNo :",@"11. Case",nil];
    
    [self Commondata];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self api_getHealthRecord];
}

-(void)Commondata
{
    _txtfirst.layer.cornerRadius = 5.0;
    _txtfirst.layer.borderColor = [UIColor colorWithRed:39.0/255.0 green:48.0/255.0 blue:91.0/255.0 alpha:1.0].CGColor;
    _txtfirst.layer.borderWidth = 1.0;
    
    _txtsecond.layer.cornerRadius = 5.0;
    _txtsecond.layer.borderColor = [UIColor colorWithRed:39.0/255.0 green:48.0/255.0 blue:91.0/255.0 alpha:1.0].CGColor;
    _txtsecond.layer.borderWidth = 1.0;

    
    _txtthird.layer.cornerRadius = 5.0;
    _txtthird.layer.borderColor = [UIColor colorWithRed:39.0/255.0 green:48.0/255.0 blue:91.0/255.0 alpha:1.0].CGColor;
    _txtthird.layer.borderWidth = 1.0;

    
    _txtforth.layer.cornerRadius = 5.0;
    _txtforth.layer.borderColor = [UIColor colorWithRed:39.0/255.0 green:48.0/255.0 blue:91.0/255.0 alpha:1.0].CGColor;
    _txtforth.layer.borderWidth = 1.0;

    
    _txtsix.layer.cornerRadius = 5.0;
    _txtsix.layer.borderColor = [UIColor colorWithRed:39.0/255.0 green:48.0/255.0 blue:91.0/255.0 alpha:1.0].CGColor;
    _txtsix.layer.borderWidth = 1.0;

    
    _txtseven.layer.cornerRadius = 5.0;
    _txtseven.layer.borderColor = [UIColor colorWithRed:39.0/255.0 green:48.0/255.0 blue:91.0/255.0 alpha:1.0].CGColor;
    _txtseven.layer.borderWidth = 1.0;

    
    _txteight.layer.cornerRadius = 5.0;
    _txteight.layer.borderColor = [UIColor colorWithRed:39.0/255.0 green:48.0/255.0 blue:91.0/255.0 alpha:1.0].CGColor;
    _txteight.layer.borderWidth = 1.0;

    
    _txtnine.layer.cornerRadius = 5.0;
    _txtnine.layer.borderColor = [UIColor colorWithRed:39.0/255.0 green:48.0/255.0 blue:91.0/255.0 alpha:1.0].CGColor;
    _txtnine.layer.borderWidth = 1.0;

    
    _txtten.layer.cornerRadius = 5.0;
    _txtten.layer.borderColor = [UIColor colorWithRed:39.0/255.0 green:48.0/255.0 blue:91.0/255.0 alpha:1.0].CGColor;
    _txtten.layer.borderWidth = 1.0;

    
    _txteleven.layer.cornerRadius = 5.0;
    _txteleven.layer.borderColor = [UIColor colorWithRed:39.0/255.0 green:48.0/255.0 blue:91.0/255.0 alpha:1.0].CGColor;
    _txteleven.layer.borderWidth = 1.0;

    
    _txtFifth.layer.cornerRadius = 5.0;
    _txtFifth.layer.borderColor = [UIColor colorWithRed:39.0/255.0 green:48.0/255.0 blue:91.0/255.0 alpha:1.0].CGColor;
    _txtFifth.layer.borderWidth = 1.0;
    
     [Utility setLeftViewInTextField:_txtsix imageName:@"" leftSpace:0 topSpace:0 size:5];
    
     [Utility setLeftViewInTextField:_txtseven imageName:@"" leftSpace:0 topSpace:0 size:5];
    
     [Utility setLeftViewInTextField:_txtten imageName:@"" leftSpace:0 topSpace:0 size:5];
    
}


#pragma mark - tableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return aryQuestion.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HealthCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HealthCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *lb = (UILabel *)[cell.contentView viewWithTag:1];
    lb.text = [aryQuestion objectAtIndex:indexPath.row];
    
    UITextView *txt = (UITextView *)[cell.contentView viewWithTag:2];
    txt.layer.cornerRadius = 5.0;
    txt.layer.borderWidth = 1.0;
    txt.layer.borderColor = [UIColor colorWithRed:39.0/255.0 green:48.0/255.0 blue:91.0/255.0 alpha:1.0].CGColor;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        NSString *str = [aryQuestion objectAtIndex:indexPath.row];
    
        CGSize size = [str sizeWithFont:[UIFont fontWithName:@"System" size:14] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-20, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];

    
    UITableViewCell *cell = [_tblHealthView dequeueReusableCellWithIdentifier:@"HealthCell"];
    
    UILabel *lb = (UILabel *)[cell.contentView viewWithTag:1];
    
    UITextView *txtView = (UITextView *)[cell.contentView viewWithTag:2];
    
//    frame = tempTxtView.frame;
//    frame.size.height = tempTxtView.contentSize.height;
//    tempTxtView.frame = frame;
       // return size.height + 44 + 60;
    if (indexPath.row == 5)
    {
        [lb setFrame:CGRectMake(lb.frame.origin.x, lb.frame.origin.y, lb.frame.size.width, lb.frame.size.height)];
        
        [txtView setFrame:CGRectMake(txtView.frame.origin.x,30,txtView.frame.size.width-20,30)];
        
        return size.height+txtView.frame.size.height;
    }
    if (indexPath.row == 6)
    {
        [lb setFrame:CGRectMake(lb.frame.origin.x, lb.frame.origin.y, lb.frame.size.width, size.height)];
        
        [txtView setFrame:CGRectMake(txtView.frame.origin.x,size.height+60,txtView.frame.size.width,30)];
        
        return lb.frame.size.height+txtView.frame.size.height;
    }
   if (indexPath.row == 9)
   {
       [lb setFrame:CGRectMake(lb.frame.origin.x, lb.frame.origin.y, lb.frame.size.width, size.height)];
       
       [txtView setFrame:CGRectMake(txtView.frame.origin.x,size.height+60,txtView.frame.size.width,30)];
       
       return lb.frame.size.height+txtView.frame.size.height;
   }
    [lb setFrame:CGRectMake(lb.frame.origin.x, lb.frame.origin.y, lb.frame.size.width, size.height)];
    [txtView setFrame:CGRectMake(txtView.frame.origin.x,lb.frame.size.height,txtView.frame.size.width,100)];
    return size.height+lb.frame.size.height+txtView.frame.size.height;
    
}

#pragma mark - button action
- (IBAction)btnSaveClicked:(id)sender
{
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    if ([Utility validateBlankField:_txtsix.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please add height" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    if ([Utility validateBlankField:_txtseven.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please add weight" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }

    [self api_createRecord];
}
- (IBAction)btnBackClicked:(id)sender
{
    for (UIViewController *controller in self.navigationController.viewControllers)
    {
        if ([controller isKindOfClass:[MyProfileVc class]])
        {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
    }
    
}

#pragma mark - create health record

-(void)api_createRecord
{
    //  <EditID>guid</EditID>
    //    <ClientID>guid</ClientID>
    //    <InstituteID>guid</InstituteID>
    //    <UserID>guid</UserID>
    //    <MemberID>guid</MemberID>
    //    <BeachID>guid</BeachID>
    //    <BloodGroup>string</BloodGroup>
    //    <Height>string</Height>
    //    <Weight>string</Weight>
    //    <Allergies>string</Allergies>
    //    <SpecificDiseases>string</SpecificDiseases>
    //    <OperationUndergone>string</OperationUndergone>
    //    <AnyOtherDisease>string</AnyOtherDisease>
    //    <Medication>string</Medication>
    //    <ColoutFear>string</ColoutFear>
    //    <FamilyDoctorName>string</FamilyDoctorName>
    //    <ContactNo>string</ContactNo>
    //    <PatientID>string</PatientID>
    //    <DateOfLastUpdate>string</DateOfLastUpdate>
    
    //#define apk_healthrecord @"apk_healthrecord.asmx"
    //#define apk_CreateHealthRecord @"CreateHealthRecord"
    //#define apk_GetHealthRecord @"GetHealthRecord"
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_healthrecord,apk_CreateHealthRecord];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:@"" forKey:@"EditID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    [param setValue:_txteight.text forKey:@"BloodGroup"];
    [param setValue:_txtsix.text forKey:@"Height"];
    [param setValue:_txtseven.text forKey:@"Weight"];
    [param setValue:_txtfirst.text forKey:@"Allergies"];
    [param setValue:_txtsecond.text forKey:@"SpecificDiseases"];
    [param setValue:_txtthird.text forKey:@"OperationUndergone"];
    [param setValue:_txtforth.text forKey:@"AnyOtherDisease"];
    
    [param setValue:_txtforth.text forKey:@"Medication"];
    
    [param setValue:_txtFifth.text forKey:@"ColoutFear"];
    [param setValue:_txtnine.text forKey:@"FamilyDoctorName"];
    
    [param setValue:_txtten.text forKey:@"ContactNo"];
    
    [param setValue:[dicEditHelthRecordData objectForKey:@"PatientID"] forKey:@"PatientID"];
    
    [param setValue:[Utility convertDatetoSpecificDate:@"dd-MM-yyyy" date:[dicEditHelthRecordData objectForKey:@"DateOfLastUpdate"]] forKey:@"DateOfLastUpdate"];
    
    [ProgressHUB showHUDAddedTo:self.view];
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[dic objectForKey:@"message"];
                 if([strStatus isEqualToString:@"HealthRecord Created SuccessFully."])
                 {
                     [self api_getHealthRecord];
                 }
                 else
                 {
                     //   _viewDelete.hidden = NO;
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
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


#pragma mark - Get HelthRecord

-(void)api_getHealthRecord
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    /*<MemberID>guid</MemberID>
    <ClientID>guid</ClientID>
    <InstituteID>guid</InstituteID>
    <BeachID>guid</BeachID>*/
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_healthrecord,apk_GetHealthRecord];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
     [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
     [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
     [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    
    [ProgressHUB showHUDAddedTo:self.view];
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
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
                    dicEditHelthRecordData = [[NSMutableDictionary alloc]initWithDictionary:dic];
                     
                     _txtfirst.text = [dicEditHelthRecordData objectForKey:@"AllergiesIfAny"];
                     
                     _txtsecond.text = [dicEditHelthRecordData objectForKey:@"SpecificDiseasSuffered"];
                     
                     _txtthird.text = [dicEditHelthRecordData objectForKey:@"OperationUndergone"];
                     
                     _txtforth.text = [dicEditHelthRecordData objectForKey:@"Medicatoin"];
                     
                     _txtFifth.text = [dicEditHelthRecordData objectForKey:@"ColourFearIfAny"];
                     
                     _txtsix.text = [NSString stringWithFormat:@"%@", [dicEditHelthRecordData objectForKey:@"Height"]];
                     
                     _txtseven.text = [NSString stringWithFormat:@"%@",[dicEditHelthRecordData objectForKey:@"Weight"]];

                     _txteight.text = [dicEditHelthRecordData objectForKey:@"BloodGroup"];
                     
                     _txtnine.text = [dicEditHelthRecordData objectForKey:@"FamilyDoctorName"];
                     
                     _txtten.text = [dicEditHelthRecordData objectForKey:@"ContactNo"];
                     
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
