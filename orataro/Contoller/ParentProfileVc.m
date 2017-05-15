//
//  ParentProfileVc.m
//  orataro
//
//  Created by MAC008 on 05/05/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ParentProfileVc.h"
#import "Global.h"

@interface ParentProfileVc ()
{
    HMSegmentedControl *segmentedControl2;
    NSMutableArray *aryPrefix,*aryGuardianPrefix;
    UIDatePicker *datePicker;
    UIAlertView *alert;
    NSString *strCheck;
    
    NSMutableDictionary *dicTemp;
    
    NSString *strSelectedGender;
    
    NSString *strImg;
    
    NSString *strImageUpdated;
    
    NSString *strCheckImagesUpload;
    
    NSString *isPicked,*isMotherPicked;
    
    NSString *strFatherEditId,*strMotherEditId,*strGuardianName;
}
@end

@implementation ParentProfileVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    strSelectedGender = @"Mr.";
    strSelectedGender = @"Mr.";
    
    aryPrefix = [NSMutableArray arrayWithObjects:
                 
                 [NSDictionary dictionaryWithObjectsAndKeys:@"Mr.",@"Name",@"1",@"Value", nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"Mrs.",@"Name",@"0",@"Value", nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"Miss",@"Name",@"0",@"Value", nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"Dr.",@"Name",@"0",@"Value", nil], nil];
    
    [_tblPrefixHeight setConstant:44*aryPrefix.count];
    _tblPrefixProfile.scrollEnabled =NO;
    
    
    
    aryGuardianPrefix = [NSMutableArray arrayWithObjects:
                         
                         [NSDictionary dictionaryWithObjectsAndKeys:@"Mr.",@"Name",@"1",@"Value", nil],
                         [NSDictionary dictionaryWithObjectsAndKeys:@"Mrs.",@"Name",@"0",@"Value", nil],
                         [NSDictionary dictionaryWithObjectsAndKeys:@"Miss",@"Name",@"0",@"Value", nil],nil];
    
    [_tblPrefixHeight setConstant:44*aryGuardianPrefix.count];
    _tblMotherPrefix.scrollEnabled = NO;
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    
    // Segmented control with images
    NSArray<UIImage *> *images = @[[UIImage imageNamed:@"profileico.png"],
                                   [UIImage imageNamed:@"father.png"],
                                   [UIImage imageNamed:@"mother.png"],
                                   [UIImage imageNamed:@"gaurdian.png"]];
    
    NSArray<UIImage *> *selectedImages = @[[UIImage imageNamed:@"profileico_show.png"],
                                           [UIImage imageNamed:@"father_show.png"],
                                           [UIImage imageNamed:@"mother_show.png"],
                                           [UIImage imageNamed:@"gaurdian_show.png"]];
    
    segmentedControl2   = [[HMSegmentedControl alloc] initWithSectionImages:images sectionSelectedImages:selectedImages];
    segmentedControl2.frame = CGRectMake(0,64, viewWidth, 50);
    segmentedControl2.selectionIndicatorHeight = 4.0f;
    segmentedControl2.backgroundColor = [UIColor whiteColor];
    segmentedControl2.selectionIndicatorColor = [UIColor colorWithRed:65.0/255.0 green:68.0/255.0 blue:69.0/255.0 alpha:1.0];
    segmentedControl2.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl2.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    [segmentedControl2 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl2];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrAddFourView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 4, [UIScreen mainScreen].bounds.size.height-64);
    
    _btnProfileImage.layer.cornerRadius = 30.0;
    _btnProfileImage.clipsToBounds= YES;
    
    _btnFatherSelectImage.layer.cornerRadius = 30.0;
    _btnFatherSelectImage.clipsToBounds = YES;
    
    _btnMotherProfileSelect.layer.cornerRadius = 30.0;
    _btnMotherProfileSelect.clipsToBounds = YES;

    _btnGuardianSelectPhoto.layer.cornerRadius = 30.0;
    _btnGuardianSelectPhoto.clipsToBounds = YES;
    
    [self oneView];
    [self twoView];
    [self threeView];
    [self fourView];
    
    _scrAddFourView.pagingEnabled = YES;
    [self segmentData];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    if ([strImg isEqualToString:@"FromImagePicker"])
    {
        
    }
    else
    {
        [self Api_GetProfileData];
    }
}
#pragma mark - segment delegate

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl
{
    // NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    
    //  CGFloat pageWidth = _scrAddFourView.frame.size.width;
    //  NSInteger page = _scrAddFourView.contentOffset.x / pageWidth;
    
    //[segmentedControl2 setSelectedSegmentIndex:page animated:YES];
    
    if (segmentedControl.selectedSegmentIndex == 0)
    {
        CGPoint offset = CGPointMake(0,0);
        [_scrAddFourView setContentOffset:offset animated:YES];
        
    }
    if (segmentedControl.selectedSegmentIndex == 1)
    {
        CGFloat originWidth = [[UIScreen mainScreen]bounds].size.width;
        CGPoint offset = CGPointMake(originWidth, 0);
        [_scrAddFourView setContentOffset:offset animated:YES];
        
        [self Api_getFatherProfile];
        
        
    }
    if (segmentedControl.selectedSegmentIndex == 2)
    {
        CGFloat originWidth = [[UIScreen mainScreen]bounds].size.width;
        CGPoint offset = CGPointMake(originWidth*2, 0);
        [_scrAddFourView setContentOffset:offset animated:YES];
        
        [self api_getMotherProfile];
    }
    if (segmentedControl.selectedSegmentIndex == 3)
    {
        CGFloat originWidth = [[UIScreen mainScreen]bounds].size.width;
        CGPoint offset = CGPointMake(originWidth*3, 0);
        [_scrAddFourView setContentOffset:offset animated:YES];
       
    }
}



-(void)segmentData
{
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
    
    //// student profile
    
    [Utility setLeftViewInTextField:_txtFirstname imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtMiddleNameProfile imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtlastnameProfile imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtFullnameProfile imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtDisplayNameProfile imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtBirthDateProfile imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtAnnivarsaryDateProfile imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtEmailProfile imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtCityProfile imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtStateProfile imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtCountryProfile imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtPincodeProfile imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    
    //// father
    
    [Utility setLeftViewInTextField:_txtFatherFirstName imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtFatherMiddleName imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtFatherLastName imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtFatherPhoneNumber imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtFatherBirthDate imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtFatherAnniversaryDate imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtFatherEducationQualification imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtFatherOcuupation imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtFatherDesignation imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtFatherEmail imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtFatherOfficeNumber imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtFatherId imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtFatherIdType imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtFatherDateofIssue imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtFatherDateofExpiry imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    
    ///////// Mother
    
    [Utility setLeftViewInTextField:_txtMotherFullName imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtMotherFirstName imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtMotherLastName imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtMotherPhoneNumber imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtMotherBirthDate imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtMotherAnniversaryDate imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtMotherEducationQualification imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtMotherOccupation imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtMotherDesignation imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtMotherEmail imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtMotherOfficeNumber imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtMotherIDNo imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtMotherIDType imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtMotherDateofIssue imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtMotherDateofExpiry imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    
    //////////// Guardian
    
    [Utility setLeftViewInTextField:_txtGuardianFullName imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtGuradianFirstName imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtGuradianLastName imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtGuardianPhoneNumber imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    [Utility setLeftViewInTextField:_txtGuardianEducationQualification imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtMotherDateofExpiry imageName:@"" leftSpace:0 topSpace:0 size:5];
}


-(void)oneView
{
    CGFloat originWidth = [[UIScreen mainScreen]bounds].size.width;
    CGFloat originHeight = [[UIScreen mainScreen]bounds].size.height;
    _viewFirst.translatesAutoresizingMaskIntoConstraints=YES;
    _viewFirst.frame=CGRectMake(0,0,originWidth, originHeight-110);
    _scrAddFourView.delegate = self;
    [_scrAddFourView addSubview:_viewFirst];
}
-(void)twoView
{
    CGFloat originWidth = [[UIScreen mainScreen]bounds].size.width;
    CGFloat originHeight = [[UIScreen mainScreen]bounds].size.height;
    _viewSecond.translatesAutoresizingMaskIntoConstraints=YES;
    _viewSecond.frame=CGRectMake(originWidth,0,originWidth, originHeight-110);
    _scrAddFourView.delegate = self;
    [_scrAddFourView addSubview:_viewSecond];
}

-(void)threeView
{
    CGFloat originWidth = [[UIScreen mainScreen]bounds].size.width;
    CGFloat originHeight = [[UIScreen mainScreen]bounds].size.height;
    _viewThird.translatesAutoresizingMaskIntoConstraints=YES;
    _viewThird.frame=CGRectMake(originWidth*2,0,originWidth, originHeight-110);
    // NSLog(@"VIEW2%f",originWidth*2);
    _scrAddFourView.delegate = self;
    [_scrAddFourView addSubview:_viewThird];
}

-(void)fourView
{
    CGFloat originWidth = [[UIScreen mainScreen]bounds].size.width;
    CGFloat originHeight = [[UIScreen mainScreen]bounds].size.height;
    _viewFourth.translatesAutoresizingMaskIntoConstraints=YES;
    _viewFourth.frame=CGRectMake(originWidth*3,0,originWidth, originHeight-110);
    _scrAddFourView.delegate = self;
    [_scrAddFourView addSubview:_viewFourth];
}


#pragma mark - tableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView==_tblPrefixProfile)
    {
        return  aryPrefix.count;

    }
    if (tableView == _tblMotherPrefix)
    {
        return aryGuardianPrefix.count;
    }
    return 0.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tblPrefixProfile)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrefixCellProfile"];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PrefixCellProfile"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *lb = (UILabel *)[cell.contentView viewWithTag:1];
        
        lb.text = [[aryPrefix objectAtIndex:indexPath.row]objectForKey:@"Name"];
        
        UIImageView *img= (UIImageView *)[cell.contentView viewWithTag:2];
        
        if ([[[aryPrefix objectAtIndex:indexPath.row]objectForKey:@"Value"] isEqualToString:@"1"])
        {
            [img setImage:[UIImage imageNamed:@"unradiop"]];
        }
        else
        {
            [img setImage:[UIImage imageNamed:@"radiop"]];
        }
        return cell;

    }
    if (tableView == _tblMotherPrefix)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GurdianPrefixCell"];
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GurdianPrefixCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *lb = (UILabel *)[cell.contentView viewWithTag:1];
        
        lb.text = [[aryGuardianPrefix objectAtIndex:indexPath.row]objectForKey:@"Name"];
        
        UIImageView *img= (UIImageView *)[cell.contentView viewWithTag:2];
        
        if ([[[aryGuardianPrefix objectAtIndex:indexPath.row]objectForKey:@"Value"] isEqualToString:@"1"])
        {
            [img setImage:[UIImage imageNamed:@"unradiop"]];
        }
        else
        {
            [img setImage:[UIImage imageNamed:@"radiop"]];
        }
        return cell;
        
    }

    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _tblPrefixProfile)
    {
        _txtPrefixProfile.text = [NSString stringWithFormat:@" Prefix  %@",[[aryPrefix objectAtIndex:indexPath.row]objectForKey:@"Name"]];
        
        strSelectedGender = [[aryPrefix objectAtIndex:indexPath.row]objectForKey:@"Name"];
        
        NSString *s = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        
        for (int i=0; i< aryPrefix.count; i++)
        {
            NSMutableDictionary *d = [[aryPrefix objectAtIndex:i] mutableCopy];
            NSString *s1 = [NSString stringWithFormat:@"%d",i];
            
            if (s == s1)
            {
                [d setValue:@"1" forKey:@"Value"];
            }
            else
            {
                [d setValue:@"0" forKey:@"Value"];
            }
            [aryPrefix replaceObjectAtIndex:i withObject:d];
        }
        [_tblPrefixProfile reloadData];
        _viewPrefixProfile.hidden = YES;
    }
    if (tableView == _tblMotherPrefix)
    {
        //strGuardianName
        
        _txtGuradianPrefixName.text = [NSString stringWithFormat:@" Prefix  %@",[[aryPrefix objectAtIndex:indexPath.row]objectForKey:@"Name"]];
        
        strGuardianName = [[aryGuardianPrefix objectAtIndex:indexPath.row]objectForKey:@"Name"];
        
        NSString *s = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        
        for (int i=0; i< aryGuardianPrefix.count; i++)
        {
            NSMutableDictionary *d = [[aryGuardianPrefix objectAtIndex:i] mutableCopy];
            NSString *s1 = [NSString stringWithFormat:@"%d",i];
            
            if (s == s1)
            {
                [d setValue:@"1" forKey:@"Value"];
            }
            else
            {
                [d setValue:@"0" forKey:@"Value"];
            }
            [aryGuardianPrefix replaceObjectAtIndex:i withObject:d];
        }
        [_tblMotherPrefix reloadData];
        _viewGurdianPrefix.hidden = YES;
    }
    
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}
/*- (void)scrollViewDidScroll:(UIScrollView *)scrollView
 {
 CGFloat pageWidth = _scrAddFourView.frame.size.width;
 NSInteger page = _scrAddFourView.contentOffset.x / pageWidth;
 
 [segmentedControl2 setSelectedSegmentIndex:page animated:YES];
 }*/



#pragma mark - button action

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

- (IBAction)btnPrefixProfiClicked:(id)sender
{
    _viewPrefixProfile.hidden = NO;
    
    [self.view bringSubviewToFront:_viewPrefixProfile];
}

- (IBAction)btnProfileDateSelectClicked:(id)sender
{
    strCheck =@"Birth";
    
    [alert show];
}

- (IBAction)btnProfileAnniversaryClicked:(id)sender
{
    strCheck =@"Annivarsary";
    [alert show];
}

- (IBAction)btnSaveProfileClicked:(id)sender
{
    [self UploadPic];
    
}

- (IBAction)btnProfileSelectPhotoClicked:(id)sender
{
    strCheckImagesUpload = @"FromProfile";
    
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


#pragma mark  - button action for father profile

- (IBAction)btnFatherSelectPhotoClicked:(id)sender
{
    strCheckImagesUpload = @"FromFatherProfilePhoto";
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


- (IBAction)btnFatherPickupDropClicked:(id)sender
{
    if ([isPicked isEqualToString:@"0"])
    {
        [_btnFatherPickupDrop setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
        isPicked =@"1";
    }
    else
    {
        [_btnFatherPickupDrop setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
        isPicked =@"0";
    }
}
- (IBAction)btnFatherIdProofImageClicked:(id)sender
{
    strCheckImagesUpload = @"FromFatherIdProof";
    
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

- (IBAction)btnFatherSaveClicked:(id)sender
{
    
    if ([Utility validateBlankField:_txtFatherBirthDate.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please Select Date of Birth" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    if ([Utility validateBlankField:_txtFatherAnniversaryDate.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please Select Anniversary Date" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    if ([Utility validateBlankField:_txtFatherDateofIssue.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please Select Date of Issue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    if ([Utility validateBlankField:_txtFatherDateofExpiry.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please Select Date of Expiry" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    [self api_EditFatherProfile];
    
}
- (IBAction)btnFatherBirthDateClicked:(id)sender
{
    strCheck =@"FatherBirth";
    [alert show];
    
}
- (IBAction)btnFatherAnnivearsaryClicked:(id)sender
{
    strCheck =@"FatherAnnivarsary";
    [alert show];
}
- (IBAction)btnFatherDateofIssueClicked:(id)sender
{
    strCheck =@"FatherDateofIssue";
    [alert show];
}

- (IBAction)btnFatherDateofExpiryClicked:(id)sender
{
    strCheck =@"FatherExpiry";
    [alert show];
}


#pragma mark - Gurdian button action

- (IBAction)btnGurdianProofIDClicked:(id)sender
{
    strCheckImagesUpload = @"FromGurdianIdProof";
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

- (IBAction)btnGurdianIDProofClicked:(id)sender
{
   
}
- (IBAction)btnGurdianSaveClicked:(id)sender
{
}

- (IBAction)btnGuardianPrefixClicked:(id)sender
{
    _viewGurdianPrefix.hidden = NO;
    [self.view bringSubviewToFront:_viewGurdianPrefix];
}

- (IBAction)btnGurdianBirthClicked:(id)sender
{
    strCheck =@"GuardianDateofBirth";
    [alert show];
}
- (IBAction)btnGurdianAnniversaryClicked:(id)sender
{
    strCheck =@"GuardianAnnivaersary";
    [alert show];
}
- (IBAction)btnGurdianDateofIssueClicked:(id)sender
{
    strCheck =@"MotherDateofIssue";
    [alert show];
}

- (IBAction)btnGurdianDateofExpiryClicked:(id)sender
{
    strCheck =@"MotherDateofExpiry";
    [alert show];
}


- (IBAction)btnGuradianPhotoClicked:(id)sender
{
    strCheckImagesUpload = @"FromGurdianProfilePhoto";
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

- (IBAction)btnGurdianPickupDropClicked:(id)sender
{
    
}

- (IBAction)btnGurdianProofClicked:(id)sender
{
    
}



#pragma mark - Button action for Mother

- (IBAction)btnMotherProfileSelectPhoto:(id)sender
{
    strCheckImagesUpload = @"FromMotherProfilePhoto";
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
- (IBAction)btnMotherPickupDropClicked:(id)sender
{
    if ([isMotherPicked isEqualToString:@"0"])
    {
        [_btnMotherPickupDrop setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
        isMotherPicked =@"1";
    }
    else
    {
        [_btnMotherPickupDrop setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
        isMotherPicked =@"0";
    }
}
- (IBAction)btnMotherIDProofClicked:(id)sender
{
    strCheckImagesUpload = @"FromMotherIDProofPhoto";
    
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

- (IBAction)btnMotherDateofExpiryClicked:(id)sender
{
    strCheck =@"MotherDateofExpiry";
    [alert show];
}

- (IBAction)btnMotherDateofIssueClicked:(id)sender
{
    strCheck =@"MotherDateIssue";
    [alert show];

}

- (IBAction)btnMotherDateofBirthClicked:(id)sender
{
    strCheck =@"MotherDateofBirth";
    [alert show];
}
- (IBAction)btnMotherAnniversaryClicked:(id)sender
{
    strCheck =@"MotherDateofAnnivarsary";
    [alert show];
}

- (IBAction)btnMotherSaveClicked:(id)sender
{
    if ([Utility validateBlankField:_txtMotherBirthDate.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please Select Date of Birth" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    if ([Utility validateBlankField:_txtMotherAnniversaryDate.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please Select Anniversary Date" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    if ([Utility validateBlankField:_txtMotherDateofIssue.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please Select Date of Issue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    if ([Utility validateBlankField:_txtMotherDateofExpiry.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please Select Date of Expiry" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    [self api_EditMotherProfile];
}


#pragma mark -alert delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 2)
    {
        if ([strCheck isEqualToString:@"Birth"])
        {
            if (buttonIndex == 0)
            {
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"dd-MM-yyyy"];
                NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
                _txtBirthDateProfile.text = theDate;
                
            }
            if (buttonIndex == 1)
            {
                alert.hidden = YES;
            }
            
        }
        else if([strCheck isEqualToString:@"Annivarsary"])
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
            _txtAnnivarsaryDateProfile.text = theDate;
            
        }
        if (buttonIndex == 1)
        {
            alert.hidden = YES;
        }
        else if([strCheck isEqualToString:@"FatherBirth"])
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
            _txtFatherBirthDate.text = theDate;
            
        }
        if (buttonIndex == 1)
        {
            alert.hidden = YES;
        }
        
        else if([strCheck isEqualToString:@"FatherAnnivarsary"])
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
            _txtFatherAnniversaryDate.text = theDate;
            
        }
        if (buttonIndex == 1)
        {
            alert.hidden = YES;
        }
        
        else if([strCheck isEqualToString:@"FatherDateofIssue"])
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
            _txtFatherDateofIssue.text = theDate;
            
        }
        if (buttonIndex == 1)
        {
            alert.hidden = YES;
        }
        
        else if([strCheck isEqualToString:@"FatherExpiry"])
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
            _txtFatherDateofExpiry.text = theDate;
            
        }
        if (buttonIndex == 1)
        {
            alert.hidden = YES;
        }
        else if([strCheck isEqualToString:@"MotherDateofExpiry"])
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
            _txtMotherDateofExpiry.text = theDate;
            
        }
        if (buttonIndex == 1)
        {
            alert.hidden = YES;
        }
        else if([strCheck isEqualToString:@"MotherDateIssue"])
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
            _txtMotherDateofIssue.text = theDate;
            
        }
        if (buttonIndex == 1)
        {
            alert.hidden = YES;
        }
        
        else if([strCheck isEqualToString:@"MotherDateofBirth"])
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
            _txtMotherBirthDate.text = theDate;
            
        }
        if (buttonIndex == 1)
        {
            alert.hidden = YES;
        }
        
        else if([strCheck isEqualToString:@"MotherDateofAnnivarsary"])
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
            _txtMotherAnniversaryDate.text = theDate;
            
        }
        if (buttonIndex == 1)
        {
            alert.hidden = YES;
        }
        else if([strCheck isEqualToString:@"GuardianDateofBirth"])
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
            _btnGurdianBirthDate.text = theDate;
            
        }
        if (buttonIndex == 1)
        {
            alert.hidden = YES;
        }
        else if([strCheck isEqualToString:@"GuardianAnnivaersary"])
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
            _txtGurdianAnnioversary.text = theDate;
            
        }
        if (buttonIndex == 1)
        {
            alert.hidden = YES;
        }
        else if([strCheck isEqualToString:@"MotherDateofIssue"])
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
            _txtGuardianDateofIssue.text = theDate;
            
        }
        if (buttonIndex == 1)
        {
            alert.hidden = YES;
        }
        else if([strCheck isEqualToString:@"MotherDateofExpiry"])
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd-MM-yyyy"];
            NSString *theDate = [dateFormat stringFromDate:[datePicker date]];
            _txtGurdianDateofExpiry.text = theDate;
            
        }
        if (buttonIndex == 1)
        {
            alert.hidden = YES;
        }
        
        
    }
}


#pragma mark - UIImagePicker Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // NSData *imageData = UIImageJPEGRepresentation(aSelectBtn.currentBackgroundImage,1.0);
    UIImage *selectImage = info[UIImagePickerControllerOriginalImage];
    
    if ([strCheckImagesUpload isEqualToString:@"FromProfile"])
    {
        [_btnProfileImage setImage:selectImage forState:UIControlStateNormal];
        
    }
    else if ([strCheckImagesUpload isEqualToString:@"FromFatherProfilePhoto"])
    {
        [_btnFatherSelectImage setImage:selectImage forState:UIControlStateNormal];
    }
    else if ([strCheckImagesUpload isEqualToString:@"FromFatherIdProof"])
    {
        [_imgFatherIdProofImage setImage:selectImage];
    }
    else if ([strCheckImagesUpload isEqualToString:@"FromMotherProfilePhoto"])
    {
        [_btnMotherProfileSelect setImage:selectImage forState:UIControlStateNormal];
    }
    else if ([strCheckImagesUpload isEqualToString:@"FromMotherIDProofPhoto"])
    {
        [_imgMotherIDProof setImage:selectImage];
    }
    else if ([strCheckImagesUpload isEqualToString:@"FromGurdianProfilePhoto"])
    {
        [_btnGuardianSelectPhoto setImage:selectImage forState:UIControlStateNormal];
    }
    else if ([strCheckImagesUpload isEqualToString:@"FromGurdianIdProof"])
    {
        [_imgGurdianIDProof setImage:selectImage];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    strImg = @"FromImagePicker";
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark -  api call

-(void)Api_GetProfileData
{
    //#define apk_profile @"apk_profile.asmx"
    //#define GetStudentProfileData @"GetStudentProfileData"
    //#define UpdateStudentProfileData @"UpdateStudentProfileData"
    
    // <MemberID>guid</MemberID>
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_profile,GetStudentProfileData];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    //  dicTemp = [[NSMutableDictionary alloc]initWithDictionary:dicCurrentUser];
    
    //apk_ImageUrlFor_HomeworkDetail
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    
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
                   //  NSLog(@"Dic=%@",dic);
                     
                     _txtFirstname.text = [dic objectForKey:@"FirstName"];
                     _txtMiddleNameProfile.text = [dic objectForKey:@"MiddleName"];
                     _txtlastnameProfile.text = [dic objectForKey:@"LastName"];
                     _txtFullnameProfile.text = [dic objectForKey:@"FullName"];
                     _txtDisplayNameProfile.text = [dicCurrentUser objectForKey:@"DisplayName"];
                     
                     _txtPrefixProfile.text = [NSString stringWithFormat:@" Prefix  %@",[dic objectForKey:@"Initial"]];
                     
                     NSString *strDob = [NSString stringWithFormat:@"%@",[dic objectForKey:@"DOB"]];
                     
                    // NSLog(@"data=%@",strDob);
                     
                     if ([strDob isEqualToString:@"<null>"])
                     {
                         _txtBirthDateProfile.text =@"";
                     }
                     else
                     {
                         _txtBirthDateProfile.text = [Utility convertDatetoSpecificDate:@"dd-MM-yyyy"  date:[dic objectForKey:@"DOB"]];
                     }
                     
                     
                     NSString *strDoAnn = [NSString stringWithFormat:@"%@",[dic objectForKey:@"DateOfAnniversary"]];
                     
                     //NSLog(@"data=%@",strDoAnn);
                     
                     if ([strDoAnn isEqualToString:@"<null>"])
                     {
                         _txtAnnivarsaryDateProfile.text =@"";
                     }
                     else
                     {
                         _txtAnnivarsaryDateProfile.text = [Utility convertDatetoSpecificDate:@"dd-MM-yyyy"  date:[dic objectForKey:@"DateOfAnniversary"]];
                     }
                     _txtEmailProfile.text = [dic objectForKey:@"EmailID"];
                     
                     //////////////////////
                     
                     NSString *strAdd = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Address1"]];
                     
                     NSLog(@"data=%@",strAdd);
                     
                     if ([strAdd isEqualToString:@"<null>"] || strAdd.length == 0 || [strAdd isEqualToString:@" "] || [strAdd isEqualToString:@"null"])
                     {
                         //_txtOccupationProfile.text =@"";
                         [_txtOccupationProfile setPlaceholder:@"Address1"];
                     }
                     else
                     {
                         _txtOccupationProfile.text = [dic objectForKey:@"Address1"];
                     }
                     
                     //////////////////////
                     
                     NSString *strAdd1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Address2"]];
                     
                   //  NSLog(@"data=%@",strAdd1);
                     
                     if ([strAdd1 isEqualToString:@"<null>"]  || strAdd1.length == 0 || [strAdd1 isEqualToString:@""] || [strAdd1 isEqualToString:@"null"])
                     {
                         //_txtOfficeAddressProfile.text =@"";
                         [_txtOfficeAddressProfile setPlaceholder:@"Address2"];
                     }
                     else
                     {
                         _txtOfficeAddressProfile.text = [dic objectForKey:@"Address2"];
                     }
                     
                     _txtCityProfile.text = [dic objectForKey:@"City"];
                     _txtStateProfile.text = [dic objectForKey:@"State"];
                     _txtCountryProfile.text = [dic objectForKey:@"Country"];
                     _txtPincodeProfile.text = [dic objectForKey:@"ZipCode"];
                     
                     // strImageUpdated = @"Edit";
                     
                     if ([strImageUpdated isEqualToString:@"Edit"])
                     {
                         
                     }
                     else
                     {
                         UIImageView *img = [[UIImageView alloc]init];
                         [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[dicCurrentUser objectForKey:@"ProfilePicture"]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
                          {
                              [_btnProfileImage setImage:image forState:UIControlStateNormal];
                          }];
                     }
                     
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

#pragma mark - update Profile

-(void)Api_EditProfileData
{
    //#define apk_profile @"apk_profile.asmx"
    //#define GetStudentProfileData @"GetStudentProfileData"
    //#define UpdateStudentProfileData @"UpdateStudentProfileData"
    
    /* <MemberID>guid</MemberID>
     <UserID>guid</UserID>
     <ClientID>guid</ClientID>
     <InstituteID>guid</InstituteID>*/
    
    
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_profile,UpdateStudentProfileData];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    
    /* <FirstName>string</FirstName>
     <MiddleName>string</MiddleName>
     <LastName>string</LastName>
     <FullName>string</FullName>
     <Initial>string</Initial>
     <DOB>string</DOB>
     <DateOfAnniversary>string</DateOfAnniversary>
     <DisplayName>string</DisplayName>
     <Address1>string</Address1>
     <Address2>string</Address2>
     <City>string</City>
     <State>string</State>
     <Country>string</Country>
     <ZipCode>string</ZipCode>*/
    
    [param setValue:_txtFirstname.text forKey:@"FirstName"];
    [param setValue:_txtMiddleNameProfile.text forKey:@"MiddleName"];
    [param setValue:_txtlastnameProfile.text forKey:@"LastName"];
    [param setValue:_txtFullnameProfile.text forKey:@"FullName"];
    [param setValue:strSelectedGender forKey:@"Initial"];
    [param setValue:[Utility convertDateFtrToDtaeFtr:@"dd-MM-yyyy" newDateFtr:@"MM-dd-yyyy" date:_txtBirthDateProfile.text] forKey:@"DOB"];
    [param setValue:[Utility convertDateFtrToDtaeFtr:@"dd-MM-yyyy" newDateFtr:@"MM-dd-yyyy" date:_txtAnnivarsaryDateProfile.text] forKey:@"DateOfAnniversary"];
    
    [param setValue:_txtDisplayNameProfile.text forKey:@"DisplayName"];
    
    [param setValue:_txtOccupationProfile.text forKey:@"Address1"];
    [param setValue:_txtOfficeAddressProfile.text forKey:@"Address2"];
    [param setValue:_txtCityProfile.text forKey:@"City"];
    [param setValue:_txtStateProfile.text forKey:@"State"];
    [param setValue:_txtCountryProfile.text forKey:@"Country"];
    [param setValue:_txtPincodeProfile.text forKey:@"ZipCode"];
    
    
    // [ProgressHUB showHUDAddedTo:self.view];
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             
             if([strArrd isEqualToString:@"Record update successfully"])
             {
                 [self Api_GetProfileData];
             }
             else
             {
                 
                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:strArrd delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alrt show];
             }
             
             //             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             //             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             //
             //             if([arrResponce count] != 0)
             //             {
             //                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
             //                 NSString *strStatus=[dic objectForKey:@"message"];
             //                 if([strArrd isEqualToString:@"Record update successfully"])
             //                 {
             //                     [self Api_GetProfileData];
             //                 }
             //                 else
             //                 {
             //
             //                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             //                     [alrt show];
             //                 }
             //             }
             //             else
             //             {
             //                 UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             //                 [alrt show];
             //             }
         }
         else
         {
             UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:Api_Not_Response delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alrt show];
         }
     }];
    
    
}

#pragma mark - upload profile picture

-(void)UploadPic
{
    
    //#define apk_parentprofile @"apk_parentprofile.asmx"
    //#define apk_ChnageProfilePhotos @"ChnageProfilePhotos"
    
    //    <NamePhoto>string</NamePhoto>
    //    <MemberID>guid</MemberID>
    //    <ClientID>guid</ClientID>
    //    <InstituteID>guid</InstituteID>
    //    <PhotoFile>base64Binary</PhotoFile>
    
    //
    //    [param setValue:[NSString stringWithFormat:@"%@.png",[Utility randomImageGenerator]] forKey:@"FileName"];
    
    
    
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_parentprofile,apk_ChnageProfilePhotos];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@.png",[Utility randomImageGenerator]] forKey:@"NamePhoto"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    
    NSData *data = UIImagePNGRepresentation(_btnProfileImage.currentImage);
    const unsigned char *bytes = [data bytes];
    NSUInteger length = [data length];
    NSMutableArray *byteArray = [NSMutableArray array];
    for (NSUInteger i = 0; i < length; i++)
    {
        [byteArray addObject:[NSNumber numberWithUnsignedChar:bytes[i]]];
    }
    [param setValue:byteArray forKey:@"PhotoFile"];
    
    [ProgressHUB showHUDAddedTo:self.view];
    
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[dic objectForKey:@"message"];
                 
                 NSArray *ary = [strStatus componentsSeparatedByString:@","];
                 
                 
                 if([[ary objectAtIndex:1] isEqualToString:@"Image Update SuccessFully."])
                 {
                     //apk_ImageUrlFor_HomeworkDetail
                     
                     UIImageView *img = [[UIImageView alloc]init];
                     [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[ary objectAtIndex:0]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
                      {
                          [_btnProfileImage setImage:image forState:UIControlStateNormal];
                      }];
                     
                     strImageUpdated = @"Edit";
                     
                     [self Api_EditProfileData];
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

#pragma mark - Api for get Father Profile

-(void)Api_getFatherProfile
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_parentprofile,apk_GetParentProfile];
    
    //#define apk_parentprofile @"apk_parentprofile.asmx"
    //#define apk_GetParentProfile @"GetParentProfile"
    //#define apk_CreateParentProfile @"CreateParentProfile"
    
    //    <ClientID>guid</ClientID>
    //    <InstituteID>guid</InstituteID>
    //    <MemberID>guid</MemberID>
    //    <BeachID>guid</BeachID>
    
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    
    // [ProgressHUB showHUDAddedTo:self.view];
    
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
                     
                    //   NSLog(@"Dic=%@",dic);
                     
                     NSMutableArray *aryFather = [[NSMutableArray alloc]init];
                     
                     for (NSMutableDictionary *dic in arrResponce)
                     {
                         // NSLog(@"Dic=%@",dic);
                         
                         if ([[dic objectForKey:@"RelationTypeTerm"] isEqualToString:@"Father"])
                         {
                             [aryFather addObject:dic];
                         }
                     }
                     
                     NSLog(@"Father=%@",aryFather);
                     
                     
                     _txtFatherFirstName.text = [[aryFather objectAtIndex:0]objectForKey:@"FullName"];
                     
                     _txtFatherMiddleName.text = [[aryFather objectAtIndex:0]objectForKey:@"FirstName"];
                     
                     _txtFatherLastName.text = [[aryFather objectAtIndex:0]objectForKey:@"LastName"];
                     
                     
                     NSString *strDob3 = [NSString stringWithFormat:@"%@",[[aryFather objectAtIndex:0]objectForKey:@"MobileNo"]];
                     
                     if ([strDob3 isEqualToString:@"<null>"])
                     {
                         _txtFatherPhoneNumber.text =@"";
                     }
                     else
                     {
                         _txtFatherPhoneNumber.text = [[aryFather objectAtIndex:0]objectForKey:@"ContactNo"];
                     }
                     
                     NSString *strDob = [NSString stringWithFormat:@"%@",[[aryFather objectAtIndex:0]objectForKey:@"DateOfBirth"]];
                     
               //      NSLog(@"data=%@",strDob);
                     
                     if ([strDob isEqualToString:@"<null>"])
                     {
                         _txtFatherBirthDate.text =@"";
                     }
                     else
                     {
                         // NSString *strEndDate = [Utility convertDateFtrToDtaeFtnslogr:@"dd-MM-yyyy" newDateFtr:@"MM-dd-yyyy" date:_txtEndDate.text];
                         
                         _txtFatherBirthDate.text = [Utility convertDatetoSpecificDate:@"dd-MM-yyyy"  date:[[aryFather objectAtIndex:0]objectForKey:@"DateOfBirth"]];
                         
                         //[Utility convertDatetoSpecificDate:@"dd-MM-yyyy"  date:[[aryFather objectAtIndex:0]objectForKey:@"DateOfBirth"]];
                     }
                     
                     
                     NSString *strDob1 = [NSString stringWithFormat:@"%@",[[aryFather objectAtIndex:0]objectForKey:@"DateOfAnniversary"]];
                     
               //      NSLog(@"data=%@",strDob1);
                  
                     if ([strDob1 isEqualToString:@"<null>"])
                     {
                         _txtFatherAnniversaryDate.text =@"";
                     }
                     else
                     {
                         _txtFatherAnniversaryDate.text = [Utility convertDatetoSpecificDate:@"dd-MM-yyyy"  date:[[aryFather objectAtIndex:0]objectForKey:@"DateOfAnniversary"]];
                     }
                     
                     NSString *strDob4 = [NSString stringWithFormat:@"%@",[[aryFather objectAtIndex:0]objectForKey:@"HighestStudyTerm"]];
                     
                    // NSLog(@"data=%@",strDob4);
                     
                     if ([strDob4 isEqualToString:@"<null>"])
                     {
                         _txtFatherEducationQualification.text =@"";
                     }
                     else
                     {
                         _txtFatherEducationQualification.text = [[aryFather objectAtIndex:0]objectForKey:@"HighestStudyTerm"];
                     }
                     
                     NSString *strDob5 = [NSString stringWithFormat:@"%@",[[aryFather objectAtIndex:0]objectForKey:@"OccupationTerm"]];
                     
                    // NSLog(@"data=%@",strDob5);
                     
                     if ([strDob5 isEqualToString:@"<null>"])
                     {
                         _txtFatherOcuupation.text =@"";
                     }
                     else
                     {
                         _txtFatherOcuupation.text = [[aryFather objectAtIndex:0]objectForKey:@"OccupationTerm"];
                     }
                     
        
                     NSString *strDob6 = [NSString stringWithFormat:@"%@",[[aryFather objectAtIndex:0]objectForKey:@"DesignationOccupationTerm"]];
                     
                     //NSLog(@"data=%@",strDob6);
                     
                     if ([strDob6 isEqualToString:@"<null>"])
                     {
                         _txtFatherDesignation.text =@"";
                     }
                     else
                     {
                         _txtFatherDesignation.text = [[aryFather objectAtIndex:0]objectForKey:@"DesignationOccupationTerm"];
                     }
                     
                     _txtFatherEmail.text = [[aryFather objectAtIndex:0]objectForKey:@"EmailID"];
                     
                     NSString *strDob7 = [NSString stringWithFormat:@"%@",[[aryFather objectAtIndex:0]objectForKey:@"OccupationDetails"]];
                     
                    // NSLog(@"data=%@",strDob7);
                     
                     if ([strDob7 isEqualToString:@"<null>"])
                     {
                         _txtFatherOccupationDetail.text =@"";
                     }
                     else
                     {
                         _txtFatherOccupationDetail.text = [[aryFather objectAtIndex:0]objectForKey:@"OccupationDetails"];
                     }
                     
                     
                     NSString *strDob8 = [NSString stringWithFormat:@"%@",[[aryFather objectAtIndex:0]objectForKey:@"OfficeAddress"]];
                     
                     //NSLog(@"data=%@",strDob8);
                     
                     if ([strDob8 isEqualToString:@"<null>"])
                     {
                         _txtFatherOfficeName.text =@"";
                     }
                     else
                     {
                         _txtFatherOfficeName.text = [[aryFather objectAtIndex:0]objectForKey:@"OfficeAddress"];
                     }
                     
                     
                     NSString *strDob9 = [NSString stringWithFormat:@"%@",[[aryFather objectAtIndex:0]objectForKey:@"HomeAddress"]];
                     
                    // NSLog(@"data=%@",strDob9);
                     
                     if ([strDob9 isEqualToString:@"<null>"])
                     {
                         _txtFatherHomeAddres.text =@"";
                     }
                     else
                     {
                         
                         _txtFatherHomeAddres.text = [[aryFather objectAtIndex:0]objectForKey:@"HomeAddress"];
                     }
                     
                     
                     NSString *strDob10 = [NSString stringWithFormat:@"%@",[[aryFather objectAtIndex:0]objectForKey:@"ContactNo"]];
                     
                     //NSLog(@"data=%@",strDob10);
                     
                     if ([strDob10 isEqualToString:@"<null>"])
                     {
                         _txtFatherOfficeNumber.text =@"";
                     }
                     else
                     {
                         
                         _txtFatherOfficeNumber.text = [[aryFather objectAtIndex:0]objectForKey:@"ContactNo"];
                     }
                     
                     
                     
                     NSString *strDob11 = [NSString stringWithFormat:@"%@",[[aryFather objectAtIndex:0]objectForKey:@"IDNo"]];
                     
                     //NSLog(@"data=%@",strDob11);
                     
                     if ([strDob11 isEqualToString:@"<null>"])
                     {
                         _txtFatherId.text =@"";
                     }
                     else
                     {
                         
                         _txtFatherId.text = [[aryFather objectAtIndex:0]objectForKey:@"IDNo"];
                     }
                     
                     
                     
                     
                     
                     NSString *strDob12 = [NSString stringWithFormat:@"%@",[[aryFather objectAtIndex:0]objectForKey:@"IDTypeTerm"]];
                     
                    // NSLog(@"data=%@",strDob12);
                     
                     if ([strDob12 isEqualToString:@"<null>"])
                     {
                         _txtFatherIdType.text =@"";
                     }
                     else
                     {
                         
                         _txtFatherIdType.text = [[aryFather objectAtIndex:0]objectForKey:@"IDTypeTerm"];
                     }
                     
                     
                     
                     
                     NSString *strDob13 = [NSString stringWithFormat:@"%@",[[aryFather objectAtIndex:0]objectForKey:@"DateOfIssue"]];
                     
                   //  NSLog(@"data=%@",strDob13);
                     
                     if ([strDob13 isEqualToString:@"<null>"])
                     {
                         _txtFatherDateofIssue.text =@"";
                     }
                     else
                     {
                         _txtFatherDateofIssue.text = [Utility convertDatetoSpecificDate:@"dd-MM-yyyy"  date:[[aryFather objectAtIndex:0]objectForKey:@"DateOfIssue"]];
                         
                     }
                     
                     
                     NSString *strDob14 = [NSString stringWithFormat:@"%@",[[aryFather objectAtIndex:0]objectForKey:@"DateOfExpiry"]];
                     
                     //NSLog(@"data=%@",strDob14);
                     
                     if ([strDob14 isEqualToString:@"<null>"])
                     {
                         _txtFatherDateofExpiry.text =@"";
                     }
                     else
                     {
                         _txtFatherDateofExpiry.text = [Utility convertDatetoSpecificDate:@"dd-MM-yyyy"  date:[[aryFather objectAtIndex:0]objectForKey:@"DateOfExpiry"]];
                     }
                     
                     //
                     //isPicked
                     
                     NSString *strDob15 = [NSString stringWithFormat:@"%@",[[aryFather objectAtIndex:0]objectForKey:@"IsPickup"]];
                     
                    // NSLog(@"data=%@",strDob15);
                     
                     if ([strDob15 isEqualToString:@"<null>"])
                     {
                         isPicked = @"0";
                         [_btnFatherPickupDrop setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
                         
                         //checkboxunselected
                     }
                     else if ([strDob15 isEqualToString:@"1"])
                     {
                         isPicked = @"1";
                         [_btnFatherPickupDrop setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
                     }
                     else if ([strDob15 isEqualToString:@"0"])
                     {
                         isPicked = @"0";
                         [_btnFatherPickupDrop setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
                     }
                     else
                     {
                         isPicked = @"1";
                         [_btnFatherPickupDrop setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
                     }
                     
                     //    _imgFatherIdProofImage.image = //IDProofAttached
                     
                     NSString *strDob16 = [NSString stringWithFormat:@"%@",[[aryFather objectAtIndex:0]objectForKey:@"IDProofAttached"]];
                     
                    // NSLog(@"data=%@",strDob16);
                     
                     if ([strDob16 isEqualToString:@"<null>"])
                     {
                         [_imgFatherIdProofImage setImage:[UIImage imageNamed:@"no_img"]];
                     }
                     else
                     {
                         
                    [_imgFatherIdProofImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[[aryFather objectAtIndex:0]objectForKey:@"IDProofAttached"]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
                         {
                             _imgFatherIdProofImage.image  = image;
                         }];
                         
                         
                     }
                     
                     ///////////// Images
                     
                     NSString *strDob18 = [NSString stringWithFormat:@"%@",[[aryFather objectAtIndex:0]objectForKey:@"Avtar"]];
                     
                   //  NSLog(@"data=%@",strDob18);
                     
                     if ([strDob18 isEqualToString:@"<null>"])
                     {
                         
                         [_btnFatherSelectImage setImage:[UIImage imageNamed:@"no_img"] forState:UIControlStateNormal];
                     }
                     else
                     {
                         UIImageView *img1 = [[UIImageView alloc]init];
                         [img1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[[aryFather objectAtIndex:0]objectForKey:@"Avtar"]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
                          {
                              NSLog(@"URL=%@",imageURL);
                              
                              [_btnFatherSelectImage setImage:image forState:UIControlStateNormal];
                          }];
                     }
                     
                     
                     //strFatherEditId
                     
                     NSString *strDob17 = [NSString stringWithFormat:@"%@",[[aryFather objectAtIndex:0]objectForKey:@"ParentProfileID"]];
                     
                   //  NSLog(@"data=%@",strDob17);
                     
                     if ([strDob17 isEqualToString:@"<null>"])
                     {
                         strFatherEditId = @"";
                     }
                     else
                     {
                         strFatherEditId = [[aryFather objectAtIndex:0]objectForKey:@"ParentProfileID"];
                     }
                     
                     
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

#pragma mark - Edit Father Profile

-(void)api_EditFatherProfile
{
    //#define apk_parentprofile @"apk_parentprofile.asmx"
    //#define apk_GetParentProfile @"GetParentProfile"
    //#define apk_CreateParentProfile @"CreateParentProfile"
    
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        [ProgressHUB hideenHUDAddedTo:self.view];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_parentprofile,apk_CreateParentProfile];
    //http://orataro.com/Services/apk_parentprofile.asmx/CreateParentProfile
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    //    <EditID>guid</EditID>
    //    <MemberID>guid</MemberID>
    //    <ClientID>guid</ClientID>
    //    <InstituteID>guid</InstituteID>
    //    <UserID>guid</UserID>
    //    <BeachID>guid</BeachID>
    //    <InitialTerm>string</InitialTerm>
    //    <FirstName>string</FirstName>
    //    <LastName>string</LastName>
    //    <FullName>string</FullName>
    //    <DateOfBirth>string</DateOfBirth>
    //    <DateOfAnniversary>string</DateOfAnniversary>
    //    <HighestStudy>string</HighestStudy>
    //    <Relation>string</Relation>
    //    <Occupation>string</Occupation>
    //    <Designation>string</Designation>
    //    <OccupationDetails>string</OccupationDetails>
    //    <ContactNo>string</ContactNo>
    //    <MobileNo>string</MobileNo>
    //    <Email>string</Email>
    //    <ProfileURL>string</ProfileURL>
    //    <HomeAddress>string</HomeAddress>
    //    <OfficeAddress>string</OfficeAddress>
    //    <IDNo>string</IDNo>
    //    <IDType>string</IDType>
    //    <DateOfIssue>string</DateOfIssue>
    //    <DateOfExpiry>string</DateOfExpiry>
    //    <IDProofAttach>string</IDProofAttach>
    //    <ParentPhoto>string</ParentPhoto>
    //    <IsPickup>boolean</IsPickup>
    //    <ParentFile>base64Binary</ParentFile>
    //    <IDProofFile>base64Binary</IDProofFile>
    
    [param setValue:strFatherEditId forKey:@"EditID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    [param setValue:@"Mr." forKey:@"InitialTerm"];
    
    [param setValue:_txtFatherMiddleName.text forKey:@"FirstName"];
    
    [param setValue:_txtFatherLastName.text forKey:@"LastName"];
    
    [param setValue:_txtFatherFirstName.text forKey:@"FullName"];
    
  //  [param setValue:[Utility convertDatetoSpecificDate:@"MM-dd-yyyy"  date:_txtFatherBirthDate.text] forKey:@"DateOfBirth"];
    
    [param setValue:[Utility convertDateFtrToDtaeFtr:@"dd-MM-yyyy" newDateFtr:@"MM-dd-yyyy" date:_txtFatherBirthDate.text] forKey:@"DateOfBirth"];
    
   // [param setValue:[Utility convertDatetoSpecificDate:@"MM-dd-yyyy"  date:_txtFatherAnniversaryDate.text] forKey:@"DateOfAnniversary"];
    
     [param setValue:[Utility convertDateFtrToDtaeFtr:@"dd-MM-yyyy" newDateFtr:@"MM-dd-yyyy" date:_txtFatherAnniversaryDate.text] forKey:@"DateOfAnniversary"];
    
    [param setValue:_txtFatherEducationQualification.text forKey:@"HighestStudy"];
    
    [param setValue:@"Father" forKey:@"Relation"];
    
    [param setValue:_txtFatherOcuupation.text forKey:@"Occupation"];
    
    [param setValue:_txtFatherDesignation.text forKey:@"Designation"];
    
    [param setValue:_txtFatherOccupationDetail.text forKey:@"OccupationDetails"];
    
    [param setValue:_txtFatherOfficeNumber.text forKey:@"ContactNo"];
    
    [param setValue:_txtFatherPhoneNumber.text forKey:@"MobileNo"];
    
    [param setValue:_txtFatherEmail.text forKey:@"Email"];
    
    [param setValue:_txtFatherHomeAddres.text forKey:@"HomeAddress"];
    
    [param setValue:_txtFatherOfficeName.text forKey:@"OfficeAddress"];
    
    [param setValue:_txtFatherId.text forKey:@"IDNo"];
    
    [param setValue:_txtFatherIdType.text forKey:@"IDType"];
    
  //  [param setValue:[Utility convertDatetoSpecificDate:@"MM-dd-yyyy"  date:_txtFatherDateofIssue.text] forKey:@"DateOfIssue"];
    
     [param setValue:[Utility convertDateFtrToDtaeFtr:@"dd-MM-yyyy" newDateFtr:@"MM-dd-yyyy" date:_txtFatherDateofIssue.text] forKey:@"DateOfIssue"];
    
    //[param setValue:[Utility convertDatetoSpecificDate:@"MM-dd-yyyy"  date:_txtFatherDateofExpiry.text] forKey:@"DateOfExpiry"];

      [param setValue:[Utility convertDateFtrToDtaeFtr:@"dd-MM-yyyy" newDateFtr:@"MM-dd-yyyy" date:_txtFatherDateofExpiry.text] forKey:@"DateOfExpiry"];
    
    if ([isPicked isEqualToString:@"0"])
    {
        [param setValue:@"false" forKey:@"IsPickup"];
    }
    else
    {
         [param setValue:@"true" forKey:@"IsPickup"];
    }
   
     [param setValue:@"" forKey:@"ProfileURL"];
    
    //  [param setValue:_txtFatherDateofExpiry.text forKey:@"IDProofAttach"];
    
    //[param setValue:_txtFatherDateofExpiry.text forKey:@"ParentPhoto"];
    
    //  [param setValue:_txtFatherDateofExpiry.text forKey:@"ParentFile"];
    
    // [param setValue:_txtFatherDateofExpiry.text forKey:@"IDProofFile"];
    
    [param setValue:[NSString stringWithFormat:@"%@.png",[Utility randomImageGenerator]] forKey:@"IDProofAttach"];
    
    [param setValue:[NSString stringWithFormat:@"%@.png",[Utility randomImageGenerator]] forKey:@"ParentPhoto"];
    
    UIImage *org = _btnFatherSelectImage.currentImage ;
    
    UIImage *imgCompressed = [self compressImage:org];
    
 //   NSData *dataImage = UIImageJPEGRepresentation(imgCompressed, 0.0);
    
  //  NSLog(@"Size of Image(bytes):%ld",(unsigned long)[dataImage length]);
    
    NSData *data = UIImagePNGRepresentation(imgCompressed);
    const unsigned char *bytes = [data bytes];
    NSUInteger length = [data length];
    NSMutableArray *byteArray = [NSMutableArray array];
    for (NSUInteger i = 0; i < length; i++)
    {
        [byteArray addObject:[NSNumber numberWithUnsignedChar:bytes[i]]];
    }
    [param setValue:byteArray forKey:@"ParentFile"];
    
    
    UIImage *org1 = _imgFatherIdProofImage.image ;
    
    UIImage *imgCompressed1 = [self compressImage:org1];
    
    //NSData *dataImage1 = UIImageJPEGRepresentation(imgCompressed1, 0.0);
    
    //NSLog(@"Size of Image(bytes):%ld",(unsigned long)[dataImage1 length]);
    
    NSData *data1 = UIImagePNGRepresentation(imgCompressed1);
    const unsigned char *bytes1 = [data1 bytes];
    NSUInteger length1 = [data1 length];
    NSMutableArray *byteArray1 = [NSMutableArray array];
    for (NSUInteger i = 0; i < length1; i++)
    {
        [byteArray1 addObject:[NSNumber numberWithUnsignedChar:bytes1[i]]];
    }
    [param setValue:byteArray1 forKey:@"IDProofFile"];
    
    
   /* NSData *data = UIImagePNGRepresentation(_btnFatherSelectImage.currentImage);
    const unsigned char *bytes = [data bytes];
    NSUInteger length = [data length];
    NSMutableArray *byteArray = [NSMutableArray array];
    for (NSUInteger i = 0; i < length; i++)
    {
        [byteArray addObject:[NSNumber numberWithUnsignedChar:bytes[i]]];
    }
    [param setValue:byteArray forKey:@"ParentFile"];

    NSData *data1 = UIImagePNGRepresentation(_imgFatherIdProofImage.image);
    const unsigned char *bytes1 = [data1 bytes];
    NSUInteger length1 = [data1 length];
    NSMutableArray *byteArray1 = [NSMutableArray array];
    for (NSUInteger i = 0; i < length1; i++)
    {
        [byteArray1 addObject:[NSNumber numberWithUnsignedChar:bytes1[i]]];
    }
    [param setValue:byteArray1 forKey:@"IDProofFile"];*/
    
    
    [ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
       //  [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[dic objectForKey:@"message"];
                 if([strStatus isEqualToString:@"ParentProfile Updated SuccessFully."])
                 {
                     [self Api_getFatherProfile];
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

#pragma mark  - API for Get mother Profile

-(void)api_getMotherProfile
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_parentprofile,apk_GetParentProfile];
    
    //#define apk_parentprofile @"apk_parentprofile.asmx"
    //#define apk_GetParentProfile @"GetParentProfile"
    //#define apk_CreateParentProfile @"CreateParentProfile"
    
    //    <ClientID>guid</ClientID>
    //    <InstituteID>guid</InstituteID>
    //    <MemberID>guid</MemberID>
    //    <BeachID>guid</BeachID>
    
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    
    // [ProgressHUB showHUDAddedTo:self.view];
    
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
                     
                    NSLog(@"Dic=%@",dic);
                     
                     NSMutableArray *aryMother = [[NSMutableArray alloc]init];
                     
                     for (NSMutableDictionary *dic in arrResponce)
                     {
                         // NSLog(@"Dic=%@",dic);
                         
                         if ([[dic objectForKey:@"RelationTypeTerm"] isEqualToString:@"Mother"])
                         {
                             [aryMother addObject:dic];
                         }
                     }
                     
                     NSLog(@"Father=%@",aryMother);
                     
                     
                     _txtMotherFullName.text = [[aryMother objectAtIndex:0]objectForKey:@"FullName"];
                     
                     _txtMotherFirstName.text = [[aryMother objectAtIndex:0]objectForKey:@"FirstName"];
                     
                     _txtMotherLastName.text = [[aryMother objectAtIndex:0]objectForKey:@"LastName"];
                     
                     
                     NSString *strDob3 = [NSString stringWithFormat:@"%@",[[aryMother objectAtIndex:0]objectForKey:@"MobileNo"]];
                     
                     if ([strDob3 isEqualToString:@"<null>"])
                     {
                         _txtMotherPhoneNumber.text =@"";
                     }
                     else
                     {
                         _txtMotherPhoneNumber.text = [[aryMother objectAtIndex:0]objectForKey:@"ContactNo"];
                     }
                     
                     NSString *strDob = [NSString stringWithFormat:@"%@",[[aryMother objectAtIndex:0]objectForKey:@"DateOfBirth"]];
                     
                     //      NSLog(@"data=%@",strDob);
                     
                     if ([strDob isEqualToString:@"<null>"])
                     {
                         _txtMotherBirthDate.text =@"";
                     }
                     else
                     {
                         // NSString *strEndDate = [Utility convertDateFtrToDtaeFtnslogr:@"dd-MM-yyyy" newDateFtr:@"MM-dd-yyyy" date:_txtEndDate.text];
                         
                         _txtMotherBirthDate.text = [Utility convertDatetoSpecificDate:@"dd-MM-yyyy"  date:[[aryMother objectAtIndex:0]objectForKey:@"DateOfBirth"]];
                         
                         //[Utility convertDatetoSpecificDate:@"dd-MM-yyyy"  date:[[aryFather objectAtIndex:0]objectForKey:@"DateOfBirth"]];
                     }
                     
                     
                     NSString *strDob1 = [NSString stringWithFormat:@"%@",[[aryMother objectAtIndex:0]objectForKey:@"DateOfAnniversary"]];
                     
                     //      NSLog(@"data=%@",strDob1);
                     
                     if ([strDob1 isEqualToString:@"<null>"])
                     {
                         _txtMotherAnniversaryDate.text =@"";
                     }
                     else
                     {
                         _txtMotherAnniversaryDate.text = [Utility convertDatetoSpecificDate:@"dd-MM-yyyy"  date:[[aryMother objectAtIndex:0]objectForKey:@"DateOfAnniversary"]];
                     }
                     
                     NSString *strDob4 = [NSString stringWithFormat:@"%@",[[aryMother objectAtIndex:0]objectForKey:@"HighestStudyTerm"]];
                     
                     // NSLog(@"data=%@",strDob4);
                     
                     if ([strDob4 isEqualToString:@"<null>"])
                     {
                         _txtMotherEducationQualification.text =@"";
                     }
                     else
                     {
                         _txtMotherEducationQualification.text = [[aryMother objectAtIndex:0]objectForKey:@"HighestStudyTerm"];
                     }
                     
                     NSString *strDob5 = [NSString stringWithFormat:@"%@",[[aryMother objectAtIndex:0]objectForKey:@"OccupationTerm"]];
                     
                     // NSLog(@"data=%@",strDob5);
                     
                     if ([strDob5 isEqualToString:@"<null>"])
                     {
                         _txtMotherOccupation.text =@"";
                     }
                     else
                     {
                         _txtMotherOccupation.text = [[aryMother objectAtIndex:0]objectForKey:@"OccupationTerm"];
                     }
                     
                     
                     NSString *strDob6 = [NSString stringWithFormat:@"%@",[[aryMother objectAtIndex:0]objectForKey:@"DesignationOccupationTerm"]];
                     
                     //NSLog(@"data=%@",strDob6);
                     
                     if ([strDob6 isEqualToString:@"<null>"])
                     {
                         _txtMotherDesignation.text =@"";
                     }
                     else
                     {
                         _txtMotherDesignation.text = [[aryMother objectAtIndex:0]objectForKey:@"DesignationOccupationTerm"];
                     }
                     
                     _txtMotherEmail.text = [[aryMother objectAtIndex:0]objectForKey:@"EmailID"];
                     
                     NSString *strDob7 = [NSString stringWithFormat:@"%@",[[aryMother objectAtIndex:0]objectForKey:@"OccupationDetails"]];
                     
                     // NSLog(@"data=%@",strDob7);
                     
                     if ([strDob7 isEqualToString:@"<null>"])
                     {
                         _txtMotherOccupationDetail.text =@"";
                     }
                     else
                     {
                         _txtMotherOccupationDetail.text = [[aryMother objectAtIndex:0]objectForKey:@"OccupationDetails"];
                     }
                     
                     
                     NSString *strDob8 = [NSString stringWithFormat:@"%@",[[aryMother objectAtIndex:0]objectForKey:@"OfficeAddress"]];
                     
                     //NSLog(@"data=%@",strDob8);
                     
                     if ([strDob8 isEqualToString:@"<null>"])
                     {
                         _txtMotherOfficeNameAddress.text =@"";
                     }
                     else
                     {
                         _txtMotherOfficeNameAddress.text = [[aryMother objectAtIndex:0]objectForKey:@"OfficeAddress"];
                     }
                     
                     
                     NSString *strDob9 = [NSString stringWithFormat:@"%@",[[aryMother objectAtIndex:0]objectForKey:@"HomeAddress"]];
                     
                     // NSLog(@"data=%@",strDob9);
                     
                     if ([strDob9 isEqualToString:@"<null>"])
                     {
                         _txtMotherHomeAddress.text =@"";
                     }
                     else
                     {
                         
                         _txtMotherHomeAddress.text = [[aryMother objectAtIndex:0]objectForKey:@"HomeAddress"];
                     }
                     
                     
                     NSString *strDob10 = [NSString stringWithFormat:@"%@",[[aryMother objectAtIndex:0]objectForKey:@"ContactNo"]];
                     
                     //NSLog(@"data=%@",strDob10);
                     
                     if ([strDob10 isEqualToString:@"<null>"])
                     {
                        _txtMotherOfficeNumber.text =@"";
                     }
                     else
                     {
                         
                         _txtMotherOfficeNumber.text = [[aryMother objectAtIndex:0]objectForKey:@"ContactNo"];
                     }
                     
                     
                     
                     NSString *strDob11 = [NSString stringWithFormat:@"%@",[[aryMother objectAtIndex:0]objectForKey:@"IDNo"]];
                     
                     //NSLog(@"data=%@",strDob11);
                     
                     if ([strDob11 isEqualToString:@"<null>"])
                     {
                         _txtMotherIDNo.text =@"";
                     }
                     else
                     {
                         
                         _txtMotherIDNo.text = [[aryMother objectAtIndex:0]objectForKey:@"IDNo"];
                     }
                     
                     
                     
                     
                     
                     NSString *strDob12 = [NSString stringWithFormat:@"%@",[[aryMother objectAtIndex:0]objectForKey:@"IDTypeTerm"]];
                     
                     // NSLog(@"data=%@",strDob12);
                     
                     if ([strDob12 isEqualToString:@"<null>"])
                     {
                         _txtMotherIDType.text =@"";
                     }
                     else
                     {
                         
                         _txtMotherIDType.text = [[aryMother objectAtIndex:0]objectForKey:@"IDTypeTerm"];
                     }
                     
                     
                     
                     
                     NSString *strDob13 = [NSString stringWithFormat:@"%@",[[aryMother objectAtIndex:0]objectForKey:@"DateOfIssue"]];
                     
                     //  NSLog(@"data=%@",strDob13);
                     
                     if ([strDob13 isEqualToString:@"<null>"])
                     {
                         _txtMotherDateofIssue.text =@"";
                     }
                     else
                     {
                         _txtMotherDateofIssue.text = [Utility convertDatetoSpecificDate:@"dd-MM-yyyy"  date:[[aryMother objectAtIndex:0]objectForKey:@"DateOfIssue"]];
                         
                     }
                     
                     
                     NSString *strDob14 = [NSString stringWithFormat:@"%@",[[aryMother objectAtIndex:0]objectForKey:@"DateOfExpiry"]];
                     
                     //NSLog(@"data=%@",strDob14);
                     
                     if ([strDob14 isEqualToString:@"<null>"])
                     {
                         _txtMotherDateofExpiry.text =@"";
                     }
                     else
                     {
                         _txtMotherDateofExpiry.text = [Utility convertDatetoSpecificDate:@"dd-MM-yyyy"  date:[[aryMother objectAtIndex:0]objectForKey:@"DateOfExpiry"]];
                     }
                     
                     //
                     //isPicked
                     
                     NSString *strDob15 = [NSString stringWithFormat:@"%@",[[aryMother objectAtIndex:0]objectForKey:@"IsPickup"]];
                     
                     // NSLog(@"data=%@",strDob15);
                     
                     if ([strDob15 isEqualToString:@"<null>"])
                     {
                         isMotherPicked = @"0";
                         [_btnMotherPickupDrop setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
                         
                         //checkboxunselected
                     }
                     else if ([strDob15 isEqualToString:@"1"])
                     {
                         isMotherPicked = @"1";
                         [_btnMotherPickupDrop setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
                     }
                     else if ([strDob15 isEqualToString:@"0"])
                     {
                         isMotherPicked = @"0";
                         [_btnMotherPickupDrop setImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
                     }
                     else
                     {
                         isMotherPicked = @"1";
                         [_btnMotherPickupDrop setImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
                     }
                     
                     //    _imgFatherIdProofImage.image = //IDProofAttached
                     
                     NSString *strDob16 = [NSString stringWithFormat:@"%@",[[aryMother objectAtIndex:0]objectForKey:@"IDProofAttached"]];
                     
                     // NSLog(@"data=%@",strDob16);
                     
                     if ([strDob16 isEqualToString:@"<null>"])
                     {
                         [_imgMotherIDProof setImage:[UIImage imageNamed:@"no_img"]];
                     }
                     else
                     {
                         
                         [_imgMotherIDProof sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[[aryMother objectAtIndex:0]objectForKey:@"IDProofAttached"]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
                          {
                              _imgMotherIDProof.image  = image;
                          }];
                         
                         
                     }
                     
                     ///////////// Images
                     
                     NSString *strDob18 = [NSString stringWithFormat:@"%@",[[aryMother objectAtIndex:0]objectForKey:@"Avtar"]];
                     
                     //  NSLog(@"data=%@",strDob18);
                     
                     if ([strDob18 isEqualToString:@"<null>"])
                     {
                         
                         [_btnMotherProfileSelect setImage:[UIImage imageNamed:@"no_img"] forState:UIControlStateNormal];
                     }
                     else
                     {
                         UIImageView *img1 = [[UIImageView alloc]init];
                         [img1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[[aryMother objectAtIndex:0]objectForKey:@"Avtar"]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
                          {
                              NSLog(@"URL=%@",imageURL);
                              
                              [_btnMotherProfileSelect setImage:image forState:UIControlStateNormal];
                          }];
                     }
                     
                     
                     //strFatherEditId
                     
                     NSString *strDob17 = [NSString stringWithFormat:@"%@",[[aryMother objectAtIndex:0]objectForKey:@"ParentProfileID"]];
                     
                     //  NSLog(@"data=%@",strDob17);
                     
                     if ([strDob17 isEqualToString:@"<null>"])
                     {
                         strMotherEditId = @"";
                     }
                     else
                     {
                         strMotherEditId = [[aryMother objectAtIndex:0]objectForKey:@"ParentProfileID"];
                     }
                     
                     
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

#pragma mark  - API for EDIT mother Profile

-(void)api_EditMotherProfile
{
    //#define apk_parentprofile @"apk_parentprofile.asmx"
    //#define apk_GetParentProfile @"GetParentProfile"
    //#define apk_CreateParentProfile @"CreateParentProfile"
    
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        [ProgressHUB hideenHUDAddedTo:self.view];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_parentprofile,apk_CreateParentProfile];
    //http://orataro.com/Services/apk_parentprofile.asmx/CreateParentProfile
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    //    <EditID>guid</EditID>
    //    <MemberID>guid</MemberID>
    //    <ClientID>guid</ClientID>
    //    <InstituteID>guid</InstituteID>
    //    <UserID>guid</UserID>
    //    <BeachID>guid</BeachID>
    //    <InitialTerm>string</InitialTerm>
    //    <FirstName>string</FirstName>
    //    <LastName>string</LastName>
    //    <FullName>string</FullName>
    //    <DateOfBirth>string</DateOfBirth>
    //    <DateOfAnniversary>string</DateOfAnniversary>
    //    <HighestStudy>string</HighestStudy>
    //    <Relation>string</Relation>
    //    <Occupation>string</Occupation>
    //    <Designation>string</Designation>
    //    <OccupationDetails>string</OccupationDetails>
    //    <ContactNo>string</ContactNo>
    //    <MobileNo>string</MobileNo>
    //    <Email>string</Email>
    //    <ProfileURL>string</ProfileURL>
    //    <HomeAddress>string</HomeAddress>
    //    <OfficeAddress>string</OfficeAddress>
    //    <IDNo>string</IDNo>
    //    <IDType>string</IDType>
    //    <DateOfIssue>string</DateOfIssue>
    //    <DateOfExpiry>string</DateOfExpiry>
    //    <IDProofAttach>string</IDProofAttach>
    //    <ParentPhoto>string</ParentPhoto>
    //    <IsPickup>boolean</IsPickup>
    //    <ParentFile>base64Binary</ParentFile>
    //    <IDProofFile>base64Binary</IDProofFile>
    
    [param setValue:strMotherEditId forKey:@"EditID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    [param setValue:@"Mrs." forKey:@"InitialTerm"];
    
    [param setValue:_txtMotherFirstName.text forKey:@"FirstName"];
    
    [param setValue:_txtMotherLastName.text forKey:@"LastName"];
    
    [param setValue:_txtMotherFullName.text forKey:@"FullName"];
    
    //  [param setValue:[Utility convertDatetoSpecificDate:@"MM-dd-yyyy"  date:_txtFatherBirthDate.text] forKey:@"DateOfBirth"];
    
    [param setValue:[Utility convertDateFtrToDtaeFtr:@"dd-MM-yyyy" newDateFtr:@"MM-dd-yyyy" date:_txtMotherBirthDate.text] forKey:@"DateOfBirth"];
    
    // [param setValue:[Utility convertDatetoSpecificDate:@"MM-dd-yyyy"  date:_txtFatherAnniversaryDate.text] forKey:@"DateOfAnniversary"];
    
    [param setValue:[Utility convertDateFtrToDtaeFtr:@"dd-MM-yyyy" newDateFtr:@"MM-dd-yyyy" date:_txtMotherAnniversaryDate.text] forKey:@"DateOfAnniversary"];
    
    [param setValue:_txtMotherEducationQualification.text forKey:@"HighestStudy"];
    
    [param setValue:@"Mother" forKey:@"Relation"];
    
    [param setValue:_txtMotherOccupation.text forKey:@"Occupation"];
    
    [param setValue:_txtMotherDesignation.text forKey:@"Designation"];
    
    [param setValue:_txtMotherOccupationDetail.text forKey:@"OccupationDetails"];
    
    [param setValue:_txtMotherOfficeNumber.text forKey:@"ContactNo"];
    
    [param setValue:_txtMotherPhoneNumber.text forKey:@"MobileNo"];
    
    [param setValue:_txtMotherEmail.text forKey:@"Email"];
    
    [param setValue:_txtMotherHomeAddress.text forKey:@"HomeAddress"];
    
    [param setValue:_txtMotherOfficeNameAddress.text forKey:@"OfficeAddress"];
    
    [param setValue:_txtMotherIDNo.text forKey:@"IDNo"];
    
    [param setValue:_txtMotherIDType.text forKey:@"IDType"];
    
    //  [param setValue:[Utility convertDatetoSpecificDate:@"MM-dd-yyyy"  date:_txtFatherDateofIssue.text] forKey:@"DateOfIssue"];
    
    [param setValue:[Utility convertDateFtrToDtaeFtr:@"dd-MM-yyyy" newDateFtr:@"MM-dd-yyyy" date:_txtMotherDateofIssue.text] forKey:@"DateOfIssue"];
    
    //[param setValue:[Utility convertDatetoSpecificDate:@"MM-dd-yyyy"  date:_txtFatherDateofExpiry.text] forKey:@"DateOfExpiry"];
    
    [param setValue:[Utility convertDateFtrToDtaeFtr:@"dd-MM-yyyy" newDateFtr:@"MM-dd-yyyy" date:_txtMotherDateofExpiry.text] forKey:@"DateOfExpiry"];
    
    if ([isMotherPicked isEqualToString:@"0"])
    {
        [param setValue:@"false" forKey:@"IsPickup"];
    }
    else
    {
        [param setValue:@"true" forKey:@"IsPickup"];
    }
    
    [param setValue:@"" forKey:@"ProfileURL"];
    
    //  [param setValue:_txtFatherDateofExpiry.text forKey:@"IDProofAttach"];
    
    //[param setValue:_txtFatherDateofExpiry.text forKey:@"ParentPhoto"];
    
    //  [param setValue:_txtFatherDateofExpiry.text forKey:@"ParentFile"];
    
    // [param setValue:_txtFatherDateofExpiry.text forKey:@"IDProofFile"];
    
    [param setValue:[NSString stringWithFormat:@"%@.png",[Utility randomImageGenerator]] forKey:@"IDProofAttach"];
    
    [param setValue:[NSString stringWithFormat:@"%@.png",[Utility randomImageGenerator]] forKey:@"ParentPhoto"];
    
    UIImage *org = _btnMotherProfileSelect.currentImage ;
    
    UIImage *imgCompressed = [self compressImage:org];
    
    //   NSData *dataImage = UIImageJPEGRepresentation(imgCompressed, 0.0);
    
    //  NSLog(@"Size of Image(bytes):%ld",(unsigned long)[dataImage length]);
    
    NSData *data = UIImagePNGRepresentation(imgCompressed);
    const unsigned char *bytes = [data bytes];
    NSUInteger length = [data length];
    NSMutableArray *byteArray = [NSMutableArray array];
    for (NSUInteger i = 0; i < length; i++)
    {
        [byteArray addObject:[NSNumber numberWithUnsignedChar:bytes[i]]];
    }
    [param setValue:byteArray forKey:@"ParentFile"];
    
    
    UIImage *org1 = _imgMotherIDProof.image ;
    
    UIImage *imgCompressed1 = [self compressImage:org1];
    
    //NSData *dataImage1 = UIImageJPEGRepresentation(imgCompressed1, 0.0);
    
    //NSLog(@"Size of Image(bytes):%ld",(unsigned long)[dataImage1 length]);
    
    NSData *data1 = UIImagePNGRepresentation(imgCompressed1);
    const unsigned char *bytes1 = [data1 bytes];
    NSUInteger length1 = [data1 length];
    NSMutableArray *byteArray1 = [NSMutableArray array];
    for (NSUInteger i = 0; i < length1; i++)
    {
        [byteArray1 addObject:[NSNumber numberWithUnsignedChar:bytes1[i]]];
    }
    [param setValue:byteArray1 forKey:@"IDProofFile"];
    
    [ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         //  [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[dic objectForKey:@"message"];
                 if([strStatus isEqualToString:@"ParentProfile Updated SuccessFully."])
                 {
                     [self api_getMotherProfile];
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

#pragma mark - Image Compress

-(UIImage *)compressImage:(UIImage *)image{
    
    NSData *imgData = UIImagePNGRepresentation(image); //1 it represents the quality of the image.
   // NSLog(@"Size of Image(bytes):%ld",(unsigned long)[imgData length]);
    
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 600.0;
    float maxWidth = 800.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth){
        if(imgRatio < maxRatio){
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio){
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else{
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    
 //   NSLog(@"Size of Image(bytes):%ld",(unsigned long)[imageData length]);
    
    return [UIImage imageWithData:imageData];
}

























































/*- (IBAction)btnStudentProfileClicked:(id)sender
 {
 [_btnProfile setImage:[UIImage imageNamed:@"profileico_blue"] forState:UIControlStateNormal];
 [_btnFather setImage:[UIImage imageNamed:@"father_gray"] forState:UIControlStateNormal];
 [_btnMother setImage:[UIImage imageNamed:@"mother_gray"] forState:UIControlStateNormal];
 [_btnGurdian setImage:[UIImage imageNamed:@"gaurdian_gray"] forState:UIControlStateNormal];
 
 // CGRect basketTopFrame = _viewIndicator.frame;
 //  basketTopFrame.origin.x =0;
 
 //    _viewIndicator1.hidden = YES;
 //    _viewIndicator2.hidden = YES;
 //    _viewIndicator3.hidden = YES;
 
 _viewIndicator1.hidden = YES;
 _viewIndicator2.hidden = YES;
 _viewIndicator3.hidden = YES;
 
 CGPoint offset = CGPointMake(0, 0);
 [_scrAddFourView setContentOffset:offset animated:YES];
 
 // [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
 //  _viewIndicator.frame = basketTopFrame;
 //_viewIndicator.hidden = NO;
 
 _viewIndicator.hidden = NO;
 
 
 // }completion:^(BOOL finished)
 // {
 // }];
 
 
 
 //    CGRect basketTopFrame = _btnProfile.frame;
 //    basketTopFrame.size.height = 5;
 //    basketTopFrame.origin.y = _viewIndicator.frame.origin.y;
 //    basketTopFrame.origin.x = _btnProfile.frame.origin.x;
 //
 //    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
 //        _viewIndicator.frame = basketTopFrame;
 
 //        CGPoint offset = CGPointMake(0, 0);
 //        [_scrAddFourView setContentOffset:offset animated:YES];
 //
 //
 //    } completion:^(BOOL finished)
 //     {
 //     }];
 }
 
 - (IBAction)btnFatherProfileClicked:(id)sender
 {
 [_btnFather setImage:[UIImage imageNamed:@"father_blue"] forState:UIControlStateNormal];
 [_btnProfile setImage:[UIImage imageNamed:@"profileico_gray"] forState:UIControlStateNormal];
 [_btnMother setImage:[UIImage imageNamed:@"mother_gray"] forState:UIControlStateNormal];
 [_btnGurdian setImage:[UIImage imageNamed:@"gaurdian_gray"] forState:UIControlStateNormal];
 
 //CGRect basketTopFrame = _btnFather.frame;
 //basketTopFrame.size.height = 5;
 // basketTopFrame.origin.y = _viewIndicator.frame.origin.y;
 // basketTopFrame.origin.x = _btnProfile.frame.origin.x+_btnProfile.frame.size.width+5;
 
 //  CGRect basketTopFrame = _viewIndicator.frame;
 //  basketTopFrame.origin.x = [[UIScreen mainScreen]bounds].size.width/4;
 //    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
 //
 //        _viewIndicator.frame = basketTopFrame;
 //        CGPoint offset = CGPointMake(0, 0);
 //        [_scrAddFourView setContentOffset:offset animated:YES];
 //
 //    }completion:^(BOOL finished)
 //     {
 //     }];
 
 // _viewIndicator.hidden = YES;
 
 _viewIndicator.hidden = YES;
 _viewIndicator2.hidden = YES;
 _viewIndicator3.hidden = YES;
 
 
 _viewIndicator1.hidden = NO;
 
 CGFloat originWidth = [[UIScreen mainScreen]bounds].size.width;
 CGPoint offset = CGPointMake(originWidth, 0);
 [_scrAddFourView setContentOffset:offset animated:YES];
 
 // [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
 // _viewIndicator1.hidden = NO;
 // _viewIndicator.frame = basketTopFrame;
 
 //  _viewIndicator.hidden = YES;
 // _viewIndicator2.hidden = YES;
 // _viewIndicator3.hidden = YES;
 
 
 
 
 // } completion:^(BOOL finished)
 //  {
 // }];
 
 }
 
 - (IBAction)btnMotherProfileClicked:(id)sender
 {
 [_btnMother setImage:[UIImage imageNamed:@"mother_blue"] forState:UIControlStateNormal];
 
 [_btnProfile setImage:[UIImage imageNamed:@"profileico_gray"] forState:UIControlStateNormal];
 [_btnFather setImage:[UIImage imageNamed:@"father_gray"] forState:UIControlStateNormal];
 [_btnGurdian setImage:[UIImage imageNamed:@"gaurdian_gray"] forState:UIControlStateNormal];
 
 
 //    CGRect basketTopFrame = _btnMother.frame;
 //    basketTopFrame.size.height = 5;
 //    basketTopFrame.origin.y = _viewIndicator.frame.origin.y;
 //     basketTopFrame.origin.x = _btnFather.frame.origin.x+_btnFather.frame.size.width+5;
 
 //basketTopFrame.origin.x =[[UIScreen mainScreen]bounds].size.width/2;
 
 //    _viewIndicator.hidden = YES;
 //    _viewIndicator1.hidden = YES;
 //    _viewIndicator3.hidden = YES;
 
 
 CGFloat originWidth = [[UIScreen mainScreen]bounds].size.width;
 CGPoint offset = CGPointMake(originWidth*2, 0);
 [_scrAddFourView setContentOffset:offset animated:YES];
 _viewIndicator2.hidden = NO;
 
 //[UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
 //  _viewIndicator.frame = basketTopFrame;
 _viewIndicator.hidden = YES;
 _viewIndicator1.hidden = YES;
 _viewIndicator3.hidden = YES;
 
 
 
 // _viewIndicator2.hidden = NO;
 
 //       _viewIndicator.frame = CGRectMake(_btnFather.frame.origin.x
 //                                          +_btnFather.frame.size.width,_btnMother.frame.origin.y+_btnMother.frame.size.height , _viewIndicator.frame.size.width, 5);
 
 
 // } completion:^(BOOL finished)
 // {
 //}];
 }
 
 - (IBAction)btnGuardianClicked:(id)sender
 {
 [_btnGurdian setImage:[UIImage imageNamed:@"gaurdian_blue"] forState:UIControlStateNormal];
 [_btnProfile setImage:[UIImage imageNamed:@"profileico_gray"] forState:UIControlStateNormal];
 [_btnFather setImage:[UIImage imageNamed:@"father_gray"] forState:UIControlStateNormal];
 [_btnMother setImage:[UIImage imageNamed:@"mother_gray"] forState:UIControlStateNormal];
 
 //    CGRect basketTopFrame = _btnGurdian.frame;
 //    basketTopFrame.size.height = 5;
 //    basketTopFrame.origin.y =_viewIndicator.frame.origin.y;
 //    basketTopFrame.origin.x =[[UIScreen mainScreen]bounds].size.width/4 * 3;
 
 
 //    _viewIndicator.hidden = YES;
 //    _viewIndicator1.hidden = YES;
 //    _viewIndicator2.hidden = YES;
 
 _viewIndicator.hidden = YES;
 _viewIndicator1.hidden = YES;
 _viewIndicator2.hidden = YES;
 CGFloat originWidth = [[UIScreen mainScreen]bounds].size.width;
 CGPoint offset = CGPointMake(originWidth*3, 0);
 [_scrAddFourView setContentOffset:offset animated:YES];
 
 [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
 //  _viewIndicator.frame = basketTopFrame;
 
 
 //_viewIndicator3.hidden = NO;
 
 
 _viewIndicator3.hidden = NO;
 
 
 
 } completion:^(BOOL finished)
 {
 }];
 }
 - (IBAction)btnProfileSaveClicked:(id)sender
 {
 //#define apk_profile @"apk_profile.asmx"
 //#define GetStudentProfileData @"GetStudentProfileData"
 //#define UpdateStudentProfileData @"UpdateStudentProfileData"
 }
 
 - (IBAction)btnProfileSelectClicked:(id)sender
 {
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
 
 - (IBAction)btnPrefixProfileClicked:(id)sender
 {
 
 }
 
 
 #pragma mark - UIImagePicker Delegate
 
 -(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
 {
 // NSData *imageData = UIImageJPEGRepresentation(aSelectBtn.currentBackgroundImage,1.0);
 UIImage *selectImage = info[UIImagePickerControllerOriginalImage];
 [_btnProfileImage setImage:selectImage forState:UIControlStateNormal];
 [picker dismissViewControllerAnimated:YES completion:nil];
 }
 
 -(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
 {
 [picker dismissViewControllerAnimated:YES completion:nil];
 }*/



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */






@end
