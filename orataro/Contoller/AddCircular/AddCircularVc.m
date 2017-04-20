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
    NSMutableArray *aryTemp;
    NSMutableArray *aryTempStore;
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
    
    viewSubjectandDiv.hidden = YES;
    viewCircularType.hidden = YES;
    
    [tblCircularType setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tblSubject setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //checkboxblue
    
    [aScrollview setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 2000)];
    [aViewHeight setConstant:600];
    
    [aViewwidth setConstant:[UIScreen mainScreen].bounds.size.width];

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"SelectTerm"]length] == 0)
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
    }
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
        //   NSLog(@"circular =%@",circularAry);
        
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
        
        UIButton *btnSelect = (UIButton *)[cell.contentView viewWithTag:4];
        btnSelect.tag = indexPath.row;
        
        UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:3];
        
        NSMutableArray *arySelect = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"SelectAryData"]];
        
        if ([arySelect containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]])
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
        
        if ([Utility isInterNetConnectionIsActive] == false) {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        else
        {
            selectTypeTextfield.text = [[circularAry objectAtIndex:indexPath.row]objectForKey:@"Term"];
            [[NSUserDefaults standardUserDefaults]setObject:[[circularAry objectAtIndex:indexPath.row]objectForKey:@"Term"] forKey:@"SelectTerm"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
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
    
    NSLog(@"button=%ld",indexPath.row);
    
    aryTemp = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"SelectAryData"]];
    
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
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Add Photo!" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose from Liabrary", nil];
    
    [action showInView:self.view];
}


- (IBAction)btnSaveClicked:(id)sender
{
    NSLog(@"data=%@",_lbStandard.text);
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    else if ([aTitleTextfield.text isEqualToString:@""])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:CIRCULAR_TITLE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    else if ([selectTypeTextfield.text isEqualToString:@""])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@CIRCULAR_TYPE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    else if ([Utility validateBlankField:self.aDescTextView.text] || [self.aDescTextView.text isEqualToString:@"Description"])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:CIRCULAR_DESC delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    else if ([_lbStandard.text isEqualToString:@"Select Standard And Division"])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@CIRCULAR_STANDARD delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    else if ([endDateTextfield.text isEqualToString:@""])
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
    [datePicker setDate:[NSDate date]];
    [alert show];
}

- (IBAction)btnStandardClicked:(id)sender
{
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
    viewCircularType.hidden = NO;
    viewSubjectandDiv.hidden = YES;
    [self.view bringSubviewToFront:viewCircularType];
}

- (IBAction)btnDoneClciked:(id)sender
{
    NSMutableArray *strStandard = [[NSMutableArray alloc]init];
    
    NSMutableArray *aryGet = [[NSUserDefaults standardUserDefaults]valueForKey:@"SelectAryData"];
    
    for (int i=0; i<subAry.count; i++)
    {
        if ([aryGet containsObject:[NSString stringWithFormat:@"%d",i]])
        {
            [strStandard addObject:[subAry objectAtIndex:i]];
        }
    }
    
    NSMutableArray *arySet = [[NSMutableArray alloc]init];
    
    for(int i=0 ; i<strStandard.count;i++)
    {
        [arySet addObject:[NSString stringWithFormat:@"%@-%@",[[strStandard objectAtIndex:i]objectForKey:@"Grade"],[[strStandard objectAtIndex:i]objectForKey:@"Division"]]];
    }
    
    NSString *strTableColumn = [arySet componentsJoinedByString:@","];
    [[NSUserDefaults standardUserDefaults]setObject:strTableColumn forKey:@"setStandard"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
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

#pragma mark - PickerDelegates

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage * img = [info valueForKey:UIImagePickerControllerEditedImage];
    
    [PhotoBtn setBackgroundImage:img forState:UIControlStateNormal];
}

#pragma mark - api call

-(void)apiCallFor_SaveCircular
{
    // EditID=null
    // WallID=3f553bdf-a302-410f-ab2f-a82bd5aca7b5
    // title=title
    // GradeDivisoinID=9162ef41-f1cb-4f73-8155-366b894f34f4,44de9eed-96af-43cf-a5ee-7cc63d9753ed#9162ef41-f1cb-4f73-8155-366b894f34f4,9884a49f-dad0-44c0-827e-0633f3c120e1#
    // CircularType=Assignment
    // DateOfCircular=03-07-2017
    // CircularDetails=desc
    // MemberID=f1a6d89d-37dc-499a-9476-cb83f0aba0f2
    // ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
    // InstituteID=4f4bbf0e-858a-46fa-a0a7-bf116f537653
    // UserID=30032284-31d1-4ba6-8ef4-54edb8e223aa
    // BeachID=null
    // File=[B@a983d3a
    // FileName=IMG-20170307-WA0001.jpg
    // FileType=IMAGE
    // FileMineType=
    //InstitutionWallID=11fd37ef-189b-49fb-82e7-dba9b1cf4b53
    
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        [ProgressHUB hideenHUDAddedTo:self.view];
        return;
    }
    
    //NSLog(@"sub=%@",subAry);
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_circular,apk_CreateCircularWithMulty_action];
    
    
    NSMutableArray *getDivId = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"SelectAryData"]];
    NSMutableArray *aryDivId = [[NSMutableArray alloc]init];
    
    NSLog(@"getdata=%@",getDivId);
    
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
     NSLog(@"dic=%@",dicCurrentUser);
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
    
    NSData *data =  UIImagePNGRepresentation(PhotoBtn.currentBackgroundImage);
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
             NSLog(@"data=%@",dicResponce);
             
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             NSLog(@"array=%@",arrResponce);
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[dic objectForKey:@"message"];
                 if([strStatus isEqualToString:@"Circular Created SuccessFully...!!"])
                 {
                     [self.navigationController popViewControllerAnimated:YES];
                 }
                 else
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
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

-(void)apiCallFor_getCircularType
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_login,apk_GetProjectType_action];
    
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
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_gradedivisionsubject,apk_GetGradeDivisionSubjectbyTeacher_action];

    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    // NSLog(@"dic=%@",dicCurrentUser);
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
    NSLog(@"ary=%@",aryResponse);
    NSMutableArray *aryTmp = [[NSMutableArray alloc]initWithArray:aryResponse];
    for (int i=0; i< aryTmp.count; i++)
    {
        NSMutableDictionary *d = [[aryTmp objectAtIndex:i] mutableCopy];
        NSString *str = [NSString stringWithFormat:@"%@%@",[d objectForKey:@"Grade"],[d objectForKey:@"Division"]];
        [d setObject:str forKey:@"Group"];
        NSLog(@"d=%@",d);
        [aryTmp replaceObjectAtIndex:i withObject:d];
    }
    
    NSArray *temp = [aryTmp sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"Group" ascending:YES]]];
    [aryTmp removeAllObjects];
    [aryTmp addObjectsFromArray:temp];
    NSLog(@"Ary=%@",aryTmp);
    
    
    
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
   
    // NSLog(@"arra=%@",subAry);
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
