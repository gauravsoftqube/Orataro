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
    NSMutableArray *circularAry,*subAry,*arrSelected_Circular;
    NSMutableArray *aryTemp;
    NSMutableArray *aryTempStore;
    
    NSMutableArray *arrSelected_StdAndDiv;
}
@end

@implementation AddCircularVc
@synthesize aViewHeight,aScrollview,aViewwidth,aDescLb,aDescTextView,aTitleTextfield,selectTypeTextfield,standardTextfield,endDateTextfield,PhotoBtn,viewCircularType,viewSubjectandDiv,tblSubject,tblCircularType;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    aryTemp = [[NSMutableArray alloc]init];
    circularAry = [[NSMutableArray alloc]init];
    subAry = [[NSMutableArray alloc]init];
    aryTempStore= [[NSMutableArray alloc]init];
    arrSelected_Circular=[[NSMutableArray alloc]init];
    arrSelected_StdAndDiv=[[NSMutableArray alloc]init];
    
    viewSubjectandDiv.hidden = YES;
    viewCircularType.hidden = YES;
    
    [tblCircularType setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tblSubject setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    //set Header Title
    NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
    if (arr.count != 0) {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Add Circular (%@)",[arr objectAtIndex:0]];
    }
    else
    {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Add Circular"];
    }
    
    
    [Utility setLeftViewInTextField:selectTypeTextfield imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:standardTextfield imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:aTitleTextfield imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:endDateTextfield imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    aDescTextView.textContainerInset = UIEdgeInsetsMake(10, 1, 0, 0);
    
    CGRect frame = CGRectMake(0, 0, 200, 200);
    datePicker = [[UIDatePicker alloc] initWithFrame:frame];
    datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    NSDate *Date=[NSDate date];
    datePicker.minimumDate=Date;
    
    alert = [[UIAlertView alloc]
             initWithTitle:@"Select Date"
             message:nil
             delegate:self
             cancelButtonTitle:@"OK"
             otherButtonTitles:@"Cancel", nil];
    alert.delegate = self;
    alert.tag = 2;
    [alert setValue:datePicker forKey:@"accessoryView"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    [self apiCallFor_getCircularType];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
   /* if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"SelectTerm"]length] == 0)
    {
        
    }
    else
    {
        selectTypeTextfield.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"SelectTerm"];
    }
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"setStandard"]length] == 0)
    {
        _lbStandard.text = @"Select Standard And Division";
    }
    else
    {
        _lbStandard.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"setStandard"];
        NSString *getLb = _lbStandard.text;
        
        CGSize size = [getLb sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:14] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-50, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        
        // CGSize size1 = [getLb sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:14] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-60, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        
        [_lbStandardHeight setConstant:size.height+15];
        //[_viewHeight setConstant:size.height];
    }*/
}

#pragma mark - tabelview delegate

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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tblCircularType)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hello"];
        
        if (!cell)
        {
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
        cell.textLabel.text = [[circularAry objectAtIndex:indexPath.row]objectForKey:@"Term"];
        
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
        
        UIButton *btnSelect = (UIButton *)[cell.contentView viewWithTag:4];
        btnSelect.tag = indexPath.row;
        
        UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:3];
        
        //NSMutableArray *arySelect = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"SelectAryData"]];
        
//        if ([arySelect containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])
        if ([arrSelected_StdAndDiv containsObject:[subAry objectAtIndex:indexPath.row]])
        {
            [img setImage:[UIImage imageNamed:@"checkboxblue"]];
        }
        else
        {
            [img setImage:[UIImage imageNamed:@"checkboxunselected"]];
        }
        
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tblCircularType)
    {
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        else
        {
            selectTypeTextfield.text = [[circularAry objectAtIndex:indexPath.row]objectForKey:@"Term"];
            
            [arrSelected_Circular removeAllObjects];
            [arrSelected_Circular addObject:[circularAry objectAtIndex:indexPath.row]];
           
            //[[NSUserDefaults standardUserDefaults]setObject:[[circularAry objectAtIndex:indexPath.row]objectForKey:@"Term"] forKey:@"SelectTerm"];
          //  [[NSUserDefaults standardUserDefaults]synchronize];
            viewCircularType.hidden = YES;
        }
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

#pragma mark - gesture reconize

-(void)TaptoHideViewCircular:(UIGestureRecognizer *)tap
{
    
}
-(void)TaptoHideViewSubject:(UIGestureRecognizer *)tap
{
    //viewSubjectandDiv.hidden = YES;
}

#pragma mark - button action

- (IBAction)SelectRowClicked:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tblSubject];
    NSIndexPath *indexPath = [tblSubject indexPathForRowAtPoint:buttonPosition];
    
    NSMutableDictionary *dic=[[subAry objectAtIndex:indexPath.row]mutableCopy];
    if([arrSelected_StdAndDiv containsObject:dic])
    {
        [arrSelected_StdAndDiv removeObject:dic];
    }
    else
    {
        [arrSelected_StdAndDiv addObject:dic];
    }
    
    /*aryTemp = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"SelectAryData"]];
    
    
    if ([aryTemp containsObject:[NSString stringWithFormat:@"%ld",indexPath.row]])
    {
        [aryTemp removeObject:[NSString stringWithFormat:@"%ld",indexPath.row]];
    }
    else
    {
        [aryTemp addObject:[NSString stringWithFormat:@"%ld",indexPath.row]];
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:aryTemp forKey:@"SelectAryData"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    */
    
    
    
    [tblSubject reloadData];
}

- (IBAction)BackBtnClicked1:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)BackBtnClicked:(id)sender
{
}

- (IBAction)addPhotoBtnClicked:(id)sender
{
    [self.view endEditing:YES];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Attach image" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* pickFromGallery = [UIAlertAction actionWithTitle:@"Take a photo"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {
                                                                if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                                                                {
                                                                    UIImagePickerController* picker = [[UIImagePickerController alloc] init];
                                                                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                                    picker.delegate = (id)self;
                                                                    [self presentViewController:picker animated:YES completion:NULL];
                                                                }
                                                                
                                                            }];
    UIAlertAction* takeAPicture = [UIAlertAction actionWithTitle:@"Choose from gallery"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             UIImagePickerController* picker = [[UIImagePickerController alloc] init];
                                                             picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                             picker.delegate = (id)self;
                                                             [self presentViewController:picker animated:YES completion:NULL];
                                                         }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * action) {
                                                   }];
    
    [alertController addAction:pickFromGallery];
    [alertController addAction:takeAPicture];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (IBAction)btnSaveClicked:(id)sender
{
    [self.view endEditing:YES];

    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    if([Utility validateBlankField:self.aTitleTextfield.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:CIRCULAR_TITLE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
   
    if ([Utility validateBlankField:self.selectTypeTextfield.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@CIRCULAR_TYPE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    if ([Utility validateBlankField:self.aDescTextView.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:CIRCULAR_DESC delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    if ([_lbStandard.text isEqualToString:@"Select Standard And Division"])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@CIRCULAR_STANDARD delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    if ([arrSelected_StdAndDiv count] == 0)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@CIRCULAR_STANDARD delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    if ([endDateTextfield.text isEqualToString:@""])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@CIRCULAR_ENDDATE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    else
    {
        [self apiCallFor_SaveCircular];
    }
}

- (IBAction)btnEndDateClicked:(id)sender
{
    [self.view endEditing:YES];
    [datePicker setDate:[NSDate date]];
    [alert show];
}

- (IBAction)btnStandardClicked:(id)sender
{
    [self.view endEditing:YES];
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    else
    {
        viewCircularType.hidden = YES;
        viewSubjectandDiv.hidden = NO;
        [self.view bringSubviewToFront:viewSubjectandDiv];
    }
}

- (IBAction)btnCircularClicked:(id)sender
{
    [self.view endEditing:YES];
    viewCircularType.hidden = NO;
    viewSubjectandDiv.hidden = YES;
    [self.view bringSubviewToFront:viewCircularType];
}

- (IBAction)btnDoneClciked:(id)sender
{
    NSMutableArray *strStandard = [[NSMutableArray alloc]init];
//    NSMutableArray *aryGet = [[NSUserDefaults standardUserDefaults]valueForKey:@"SelectAryData"];
//    for (int i=0; i<subAry.count; i++)
//    {
//        if ([aryGet containsObject:[NSString stringWithFormat:@"%d",i]])
//        {
//            [strStandard addObject:[subAry objectAtIndex:i]];
//        }
//    }
    
    NSMutableArray *arySet = [[NSMutableArray alloc]init];
    for(int i=0 ; i<arrSelected_StdAndDiv.count;i++)
    {
        [arySet addObject:[NSString stringWithFormat:@"%@-%@",[[arrSelected_StdAndDiv objectAtIndex:i]objectForKey:@"Grade"],[[arrSelected_StdAndDiv objectAtIndex:i]objectForKey:@"Division"]]];
    }
    
    NSString *strTableColumn = [arySet componentsJoinedByString:@","];
    //[[NSUserDefaults standardUserDefaults]setObject:strTableColumn forKey:@"setStandard"];
    //[[NSUserDefaults standardUserDefaults]synchronize];
    _lbStandard.text = strTableColumn;
    
    NSString *str =  _lbStandard.text;
    CGSize size = [str sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:14] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-50, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    [_lbStandardHeight setConstant:size.height+15];
    viewSubjectandDiv.hidden = YES;
}

- (IBAction)btnCancelClicked:(id)sender
{
    viewSubjectandDiv.hidden = YES;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2)
    {
        if (buttonIndex == 0)
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
            endDateTextfield.text = theDate;
            
        }
        if (buttonIndex == 1)
        {
            alert.hidden = YES;
        }
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

#pragma mark - UIImagePicker Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *selectImage = info[UIImagePickerControllerOriginalImage];
    [PhotoBtn setBackgroundImage:selectImage forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - api call

-(void)apiCallFor_SaveCircular
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        [ProgressHUB hideenHUDAddedTo:self.view];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_circular,apk_CreateCircularWithMulty_action];
    NSMutableArray *getDivId = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"SelectAryData"]];
    NSMutableArray *aryDivId = [[NSMutableArray alloc]init];
    
    for (int i=0; i<subAry.count; i++)
    {
        if ([getDivId containsObject:[NSString stringWithFormat:@"%d",i]])
        {
            [aryDivId addObject:[subAry objectAtIndex:i]];
        }
    }
    
    NSMutableArray *arySet = [[NSMutableArray alloc]init];
    for(int i=0 ; i<aryDivId.count;i++)
    {
        [arySet addObject:[NSString stringWithFormat:@"%@,%@",[[aryDivId objectAtIndex:i]objectForKey:@"GradeID"],[[aryDivId objectAtIndex:i]objectForKey:@"DivisionID"]]];
    }
    
    NSString *strTableColumn = [arySet componentsJoinedByString:@"#"];
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:@"" forKey:@"EditID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] forKey:@"WallID"];
    [param setValue:aTitleTextfield.text forKey:@"title"];
    [param setValue:strTableColumn forKey:@"GradeDivisoinID"];
    [param setValue:selectTypeTextfield.text forKey:@"CircularType"];
    [param setValue:[NSString stringWithFormat:@"%@",[Utility convertDateFtrToDtaeFtr:@"dd-MM-yyyy" newDateFtr:@"MM-dd-yyyy" date:endDateTextfield.text]] forKey:@"DateOfCircular"];
    [param setValue:aDescTextView.text forKey:@"CircularDetails"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    
    CGRect rect = CGRectMake(0,0,30,30);
    UIGraphicsBeginImageContext( rect.size );
    [PhotoBtn.currentBackgroundImage drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *data =  UIImagePNGRepresentation(picture1);
    const unsigned char *bytes = [data bytes];
    NSUInteger length = [data length];
    NSMutableArray *byteArray = [NSMutableArray array];
    for (NSUInteger i = 0; i < length; i++)
    {
        [byteArray addObject:[NSNumber numberWithUnsignedChar:bytes[i]]];
    }
    [param setValue:byteArray forKey:@"File"];
    
    NSString *getImageName = [Utility randomImageGenerator];
    [param setValue:[NSString stringWithFormat:@"%@.png",getImageName] forKey:@"FileName"];
    [param setValue:@"IMAGE" forKey:@"FileType"];
    [param setValue:@"" forKey:@"FileMineType"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstitutionWallID"]] forKey:@"InstitutionWallID"];
    
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
                 if([strStatus isEqualToString:@"Circular Created SuccessFully...!!"])
                 {
                     [self apiCallFor_SendPushNotification];
                     
                 }
                 else
                 {
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

-(void)apiCallFor_SendPushNotification
{
    if ([Utility isInterNetConnectionIsActive] == false){
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_notifications,apk_SendPushNotification_action];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    [ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error){
        [ProgressHUB hideenHUDAddedTo:self.view];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

-(void)apiCallFor_getCircularType
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_login,apk_GetProjectType_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
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
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_gradedivisionsubject,apk_GetGradeDivisionSubjectbyTeacher_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:@"Teacher" forKey:@"Role"];
    
    //[ProgressHUB showHUDAddedTo:self.view];
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
                     [self ManageSubjectList:arrResponce];
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

#pragma mark - Manage Group of Subject and Division

-(void)ManageSubjectList : (NSMutableArray *)aryResponse
{
    NSMutableArray *aryTmp = [[NSMutableArray alloc]initWithArray:aryResponse];
    for (int i=0; i< aryTmp.count; i++)
    {
        NSMutableDictionary *d = [[aryTmp objectAtIndex:i] mutableCopy];
        NSString *str = [NSString stringWithFormat:@"%@%@",[d objectForKey:@"Grade"],[d objectForKey:@"Division"]];
        [d setObject:str forKey:@"Group"];
        [aryTmp replaceObjectAtIndex:i withObject:d];
    }
    
    NSArray *temp = [aryTmp sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"Group" ascending:YES]]];
    [aryTmp removeAllObjects];
    [aryTmp addObjectsFromArray:temp];
    
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    for (NSMutableDictionary *dic in aryTmp) {
        NSString *STR=[dic objectForKey:@"Group"];
        if (![[arr valueForKey:@"Group"] containsObject:STR]) {
            [arr addObject:dic];
        }
    }
    NSSortDescriptor *sortIdClient =
    [NSSortDescriptor sortDescriptorWithKey:@"Group"
                                  ascending:YES
                                 comparator: ^(id obj1, id obj2){
                                     
                                     return [obj1 compare:obj2 options:NSOrderedAscending];
                                     
                                 }];
    
    NSArray *sortDescriptors = @[sortIdClient];
    
    NSArray *arrTemp = [arr sortedArrayUsingDescriptors:sortDescriptors];

    subAry = [[NSMutableArray alloc]initWithArray:arrTemp];
    NSLog(@"arrTemp=%@",subAry);
    [tblCircularType reloadData];
    [tblSubject reloadData];
}

@end
