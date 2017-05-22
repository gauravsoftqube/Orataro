//
//  CreateScoolGroupVc.m
//  orataro
//
//  Created by Softqube on 22/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "CreateScoolGroupVc.h"
#import "Global.h"
#import "AppDelegate.h"

@interface CreateScoolGroupVc ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    AppDelegate *get;
    NSMutableArray *aryGetStudentGroup;
    NSMutableArray *aryGetStudentGradeDivision;
    NSMutableArray *aryStudentListName;
    NSMutableArray *aryStudentNameTemp;
    NSMutableArray *aryTemp;
    NSMutableArray *aryStudentEdit;
    
    int  btnMember,btnPost,btnAlbum,btnAttachment,btnPoll;
    
    NSString *strCheckStudentTeacher;
    
    NSString *strGroupTypeID;
    
    NSString *strGroupStduentID,*strGroupTeacherID;
}
@end

@implementation CreateScoolGroupVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    aryStudentEdit = [[NSMutableArray alloc]init];
    aryStudentNameTemp = [[NSMutableArray alloc]init];
    
    get = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSLog(@"value=%d",get.scoolgroup);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tblMemberList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    _btnTackeImage.layer.cornerRadius = 30.0;
    _btnTackeImage.layer.masksToBounds = YES;
    
    _viewStandard.hidden = YES;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:_txtSearchStudenrMember];
    
    
    
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self commonData];
}
-(void)commonData
{
    [self apiCallFor_getCircularType];
    
    [Utility setLeftViewInTextField:self.txtGroupTitle imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtGroupSubject imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtEducationGroup imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtGroupMemberTecher imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:self.txtGroupMemberStudent imageName:@"" leftSpace:0 topSpace:0 size:5];
    [Utility setLeftViewInTextField:_txtSearchStudenrMember imageName:@"" leftSpace:0 topSpace:0 size:5];
    
    if (get.scoolgroup == 1)
    {
        _aHeadreTitle.text = [NSString stringWithFormat:@"Create Group (%@)",[Utility getCurrentUserName]];
        self.tblMembrList_Height.constant=0;
    }
    else
    {
        _aHeadreTitle.text = [NSString stringWithFormat:@"Edit Group (%@)",[Utility getCurrentUserName]]; 
        // NSLog(@"Data=%@",_dicCreateSchoolGroup);
        
        
        _txtGroupTitle.text = [_dicCreateSchoolGroup objectForKey:@"GroupTitle"];
        _txtGroupSubject.text = [_dicCreateSchoolGroup objectForKey:@"GroupSubject"];
        _txtViewAbout.text = [_dicCreateSchoolGroup objectForKey:@"AboutGroup"];
        
        UIImageView *img = [[UIImageView alloc]init];
        img.frame = _btnTackeImage.frame;
        
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[_dicCreateSchoolGroup objectForKey:@"GroupImage"]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
         {
             [_btnTackeImage setBackgroundImage:image forState:UIControlStateNormal];
         }];
        // [param setValue:_txtViewAbout.text forKey:@"AboutGroup"];
        // [param setValue:_txtGroupSubject.text forKey:@"GroupSubject"];
        // [param setValue:_txtGroupTitle.text forKey:@"GroupTitle"];
        
        [self apiCallFor_EditMemberTableGroup];
    }
}

#pragma mark - tableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tblGroupType)
    {
        return aryGetStudentGroup.count;
    }
    if (tableView == _tblStandard)
    {
        return aryGetStudentGradeDivision.count;
    }
    if (tableView == _tblStudentList)
    {
        return aryStudentListName.count;
    }
    if (tableView == _tblMemberList)
    {
        return aryStudentEdit.count;
    }
    return 0.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tblGroupType)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Hello"];
        
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Hello"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [[aryGetStudentGroup objectAtIndex:indexPath.row]objectForKey:@"Term"];
        
        
        return cell;
    }
    if (tableView ==_tblStandard )
    {
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"standardDivisionCell"];
        
        if (cell2 == nil)
        {
            cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"standardDivisionCell"];
        }
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *lb =(UILabel *)[cell2.contentView viewWithTag:1];
        
        lb.text = [NSString stringWithFormat:@"%@   %@",[[aryGetStudentGradeDivision objectAtIndex:indexPath.row]objectForKey:@"Grade"],[[aryGetStudentGradeDivision objectAtIndex:indexPath.row]objectForKey:@"Division"]];
        
        return cell2;
    }
    if (tableView == _tblStudentList)
    {
        //cellStudentListName
        //cellMember
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellStudentListName"];
        
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellStudentListName"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSLog(@"Data=%@",aryStudentListName);
        
        UILabel *lb = (UILabel *)[cell.contentView viewWithTag:1];
        lb.text = [[aryStudentListName objectAtIndex:indexPath.row]objectForKey:@"FullName"];
        
        UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:2];
        
        NSMutableArray *arySelect = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"aryStudentName"]];
        
        if ([arySelect containsObject:[aryStudentListName objectAtIndex:indexPath.row]])
        {
            [img setImage:[UIImage imageNamed:@"tick_sky_blue"]];
        }
        else
        {
            [img setImage:[UIImage new]];
        }
        
        
        return cell;
        
    }
    
    if (tableView == _tblMemberList)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellMember"];
        
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellMember"];
        }
        
        UIImageView *img=(UIImageView *)[cell.contentView viewWithTag:2];
        
        [img.layer setBorderColor:[UIColor colorWithRed:34/255.0f green:49/255.0f blue:89/255.0f alpha:1.0f].CGColor];
        [img.layer setBorderWidth:1.0f];
        
        UIButton *btnRemove=(UIButton *)[cell.contentView viewWithTag:5];
        [btnRemove.layer setCornerRadius:4];
        btnRemove.clipsToBounds=YES;
        btnRemove.tag  = indexPath.row;
        
        NSLog(@"Indexpath=%@",[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[[aryStudentEdit objectAtIndex:indexPath.row]objectForKey:@"ProfilePicture"]]);
        
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",apk_ImageUrlFor_HomeworkDetail,[[aryStudentEdit objectAtIndex:indexPath.row]objectForKey:@"ProfilePicture"]]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
         {
             NSLog(@"ERROR");
         }];
        
        UILabel *lb = (UILabel *)[cell.contentView viewWithTag:3];
        lb.text = [[aryStudentEdit objectAtIndex:indexPath.row]objectForKey:@"MemberFullName"];
        
        UILabel *lb1 = (UILabel *)[cell.contentView viewWithTag:4];
        lb1.text = [[aryStudentEdit objectAtIndex:indexPath.row]objectForKey:@"MemberRole"];
        
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tblGroupType)
    {
        //  NSLog(@"%@",aryGetStudentGroup);
        
        _viewGroupType.hidden = YES;
        _txtEducationGroup.text = [[aryGetStudentGroup objectAtIndex:indexPath.row]objectForKey:@"Term"];
        strGroupTypeID = [[aryGetStudentGroup objectAtIndex:indexPath.row]objectForKey:@"TermID"];
    }
    if (tableView == _tblStandard)
    {
        strCheckStudentTeacher = @"StudentName";
        
        _viewStandard.hidden = YES;
        
        _viewStudentNameList.hidden = NO;
        [self.view bringSubviewToFront:_viewStudentNameList];
        
        NSLog(@"get data=%@",[aryGetStudentGradeDivision objectAtIndex:indexPath.row]);
        
        [self apiCallFor_GetStudentNameList:[aryGetStudentGradeDivision objectAtIndex:indexPath.row] strStudentTeacher:strCheckStudentTeacher];
        
    }
    
    if (tableView == _tblStudentList)
    {
        aryStudentNameTemp = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"aryStudentName"]];
        
        if ([aryStudentNameTemp containsObject:[aryStudentListName objectAtIndex:indexPath.row]])
        {
            [aryStudentNameTemp removeObject:[aryStudentListName objectAtIndex:indexPath.row]];
        }
        else
        {
            [aryStudentNameTemp addObject:[aryStudentListName objectAtIndex:indexPath.row]];
        }
        
        [[NSUserDefaults standardUserDefaults]setObject:aryStudentNameTemp forKey:@"aryStudentName"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [_tblStudentList reloadData];
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tblGroupType)
    {
        return 50.0;
    }
    if (tableView == _tblStandard)
    {
        return 50.0;
    }
    if (tableView == _tblStudentList)
    {
        return 40.0;
    }
    if (tableView == _tblMemberList)
    {
        return 105.0;
    }
    return 0.0;
    
}

#pragma mark - textfield delegate

- (void)textFieldDidChange:(NSNotification *)notification
{
    // Do whatever you like to respond to text changes here.
    
    if (_txtSearchStudenrMember.text.length == 0)
    {
        aryStudentListName = [[NSMutableArray alloc]initWithArray:aryTemp];
        
        [_tblStudentList reloadData];
    }
    else
    {
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.FullName contains[cd] %@",_txtSearchStudenrMember.text];
        NSArray *filteredArray = [aryStudentListName filteredArrayUsingPredicate:bPredicate];
        
        aryStudentListName = [[NSMutableArray alloc]initWithArray:filteredArray];
        [_tblStudentList reloadData];
    }
    
    
}
#pragma mark - UIImagePicker Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *selectImage = info[UIImagePickerControllerOriginalImage];
    [_btnTackeImage setBackgroundImage:selectImage forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UIButton Action

- (IBAction)btnBackHeader:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)btnSubmitHeader:(id)sender
{
    // NSLog(@"value=%@ and id =%@",_txtGroupSubject.text,strGroupTypeID);
    
    if ([Utility validateBlankField:_txtGroupTitle.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:CIRCULAR_TITLE delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
        
    }
    if ([Utility validateBlankField:_txtGroupSubject.text])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:SUBJECT delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
        
    }
    if ([_lbStudentMember.text isEqualToString:@"Group Member Student"])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please select at least one group member of student!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    if ([_lbTeacherMemebr.text isEqualToString:@"Group Member Teacher"])
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:@"Please select at least one group member of teacher!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    [self apiCallFor_createSchoolGroup];
    
}
- (IBAction)btnTackeImage:(id)sender
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

- (IBAction)btnMemberCkeckBoxMember:(id)sender
{
    
    // btnMember,btnPost,btnAlbum,btnAttachment,btnPoll
    
    if (btnMember == 0)
    {
        [_btnMemberCkeckBoxMember setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        btnMember = 1;
    }
    else
    {
        [_btnMemberCkeckBoxMember setImage:[UIImage imageNamed:@"tick_mark"] forState:UIControlStateNormal];
        btnMember = 0;
        
    }
}

- (IBAction)btnMemberCkeckBoxPost:(id)sender
{
    if (btnPost == 0)
    {
        [_btnMemberCkeckBoxPost setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        btnPost = 1;
    }
    else
    {
        [_btnMemberCkeckBoxPost setImage:[UIImage imageNamed:@"tick_mark"] forState:UIControlStateNormal];
        btnPost = 0;
        
    }
    
}
- (IBAction)btnMemberCkeckBoxAlbums:(id)sender
{
    if (btnAlbum == 0)
    {
        [_btnMemberCkeckBoxAlbums setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        btnAlbum = 1;
    }
    else
    {
        [_btnMemberCkeckBoxAlbums setImage:[UIImage imageNamed:@"tick_mark"] forState:UIControlStateNormal];
        btnAlbum = 0;
        
    }
    
}
- (IBAction)btnMemberCkeckBoxAttachment:(id)sender
{
    if (btnAttachment == 0)
    {
        [_btnMemberCkeckBoxAttachment setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        btnAttachment = 1;
    }
    else
    {
        [_btnMemberCkeckBoxAttachment setImage:[UIImage imageNamed:@"tick_mark"] forState:UIControlStateNormal];
        btnAttachment = 0;
        
    }
    
}
- (IBAction)btnMemberCkeckBoxPolls:(id)sender
{
    if (btnPoll == 0)
    {
        [_btnMemberCkeckBoxPolls setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        btnPoll = 1;
    }
    else
    {
        [_btnMemberCkeckBoxPolls setImage:[UIImage imageNamed:@"tick_mark"] forState:UIControlStateNormal];
        btnPoll = 0;
        
    }
    
}

- (IBAction)btnSelectEducationGroup:(id)sender
{
    _viewGroupType.hidden = NO;
    [self.view bringSubviewToFront:_viewGroupType];
    
    // _viewGroupSelect.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    // [self.view addSubview:_viewGroupSelect];
    // [self.view bringSubviewToFront:_viewGroupSelect];
    
}
- (IBAction)btnSelectGroupMemberStudent:(id)sender
{
    _viewStandard.hidden = NO;
    [self.view bringSubviewToFront:_viewStandard];
    
    [self apiCallFor_getGradeDivision];
}

- (IBAction)btnSelectGroupMemberTecher:(id)sender
{
    //strCheckStudentTeacher = @"StudentName";
    strCheckStudentTeacher = @"TeacherName";
    _viewStudentNameList.hidden = NO;
    [self.view bringSubviewToFront:_viewStudentNameList];
    
    NSMutableDictionary *dic;
    [self apiCallFor_GetStudentNameList:dic strStudentTeacher:strCheckStudentTeacher];
    
}
- (IBAction)btnDoneClicked:(id)sender
{
    aryStudentNameTemp = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"aryStudentName"]];
    
    NSString *strJoinStrUsingComma;
    
    //strCheckStudentTeacher = @"StudentName";
    // strCheckStudentTeacher = @"TeacherName";
    
    
    NSLog(@"data=%@",strCheckStudentTeacher);
    
    if ([strCheckStudentTeacher isEqualToString:@"StudentName"])
    {
        NSMutableArray *arySet = [[NSMutableArray alloc]init];
        NSMutableArray *aryID = [[NSMutableArray alloc]init];
        
        for (NSMutableDictionary *dic in aryStudentNameTemp)
        {
            strJoinStrUsingComma = [NSString stringWithFormat:@"%@",[dic objectForKey:@"FullName"]];
            
            [arySet addObject:[NSString stringWithFormat:@"%@",strJoinStrUsingComma]];
            [aryID addObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]]];
        }
        
        NSString *strTableColumn = [arySet componentsJoinedByString:@","];
        strGroupStduentID = [aryID componentsJoinedByString:@","];
        
        if(aryStudentNameTemp.count == 0)
        {
            _lbStudentMember.text = @"Group Member Student";
        }
        else
        {
            _lbStudentMember.text = strTableColumn;
            
            CGSize size = [strTableColumn sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:14] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-30, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
            
            [_lbStudentHeight setConstant:size.height+20];
        }
        
    }
    else
    {
        NSMutableArray *arySet = [[NSMutableArray alloc]init];
        NSMutableArray *aryTeacherID = [[NSMutableArray alloc]init];
        for (NSMutableDictionary *dic in aryStudentNameTemp)
        {
            strJoinStrUsingComma = [NSString stringWithFormat:@"%@",[dic objectForKey:@"FullName"]];
            
            [arySet addObject:[NSString stringWithFormat:@"%@",strJoinStrUsingComma]];
            [aryTeacherID addObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]]];
        }
        
        strGroupTeacherID = [aryTeacherID componentsJoinedByString:@","];
        
        NSString *strTableColumn = [arySet componentsJoinedByString:@","];
        
        if(aryStudentNameTemp.count == 0)
        {
            _lbTeacherMemebr.text = @"Group Member Teacher";
        }
        else
        {
            _lbTeacherMemebr.text = strTableColumn;
            
            CGSize size = [strTableColumn sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:14] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-30, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
            
            [_lbTeacherHeight setConstant:size.height+20];
        }
        
    }
    _viewStudentNameList.hidden = YES;
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"aryStudentName"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
- (IBAction)btnCancClicked:(id)sender
{
    _txtGroupMemberStudent.text = @"";
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"aryStudentName"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    _viewStudentNameList.hidden = YES;
}
- (IBAction)btnRemoveClicked:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_tblMemberList];
    NSIndexPath *indexPath = [_tblMemberList indexPathForRowAtPoint:buttonPosition];
    
    [self apiCallFor_DeleteMember:[aryStudentEdit objectAtIndex:indexPath.row]];
}


#pragma mark - alert delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100)
    {
        if (buttonIndex == 0)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    if (alertView.tag == 91)
    {
        if (buttonIndex ==0)
        {
            [self apiCallFor_EditMemberTableGroup];
        }
    }
}
#pragma mark - API Call getCircularType

-(void)apiCallFor_getCircularType
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_login,apk_GetProjectType_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSLog(@"dic=%@",dicCurrentUser);
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    //ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
    //Category=GroupType
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:@"GroupType" forKey:@"Category"];
    
    
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
                     aryGetStudentGroup = [[NSMutableArray alloc]initWithArray:arrResponce];
                     
                     strGroupTypeID = [[aryGetStudentGroup objectAtIndex:0]objectForKey:@"TermID"];
                     
                     [_tblGroupType reloadData];
                     
                     
                     
                     
                     
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

#pragma mark - API Call GetGradeDivision

-(void)apiCallFor_getGradeDivision
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
    
    [ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             // NSLog(@"data=%@",dicResponce);
             
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             
             NSLog(@"array=%@",arrResponce);
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[dic objectForKey:@"message"];
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                     _viewStandard.hidden =YES;

                 }
                 else
                 {
                     aryGetStudentGradeDivision = [[NSMutableArray alloc]initWithArray:arrResponce];
                     NSLog(@"data=%@",aryGetStudentGradeDivision);
                     
                     
                     
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
    
    
    
    aryGetStudentGradeDivision = [[NSMutableArray alloc]initWithArray:arrTemp];
    NSLog(@"arrTemp=%@",aryGetStudentGradeDivision);
    
    
    
    [_tblStandard reloadData];
    
    // NSLog(@"arra=%@",subAry);
}

#pragma mark - API get Name of student

-(void)apiCallFor_GetStudentNameList :(NSMutableDictionary *)dic strStudentTeacher:(NSString *)strStudentTeacher
{
    // //aryStudentListName
    
    //    <GetStudentsListNameAndMemberID xmlns="http://tempuri.org/">
    //    <InstituteID>guid</InstituteID>
    //    <ClientID>guid</ClientID>
    //    <GradeID>guid</GradeID>
    //    <DivisionID>guid</DivisionID>
    
    //#define apk_friends @"apk_friends.asmx"
    //#define apk_GetStudentsListNameAndMemberID @"GetStudentsListNameAndMemberID"
    
    
    NSLog(@"dic=%@",dic);
    
    
    //strCheckStudentTeacher = @"StudentName";
    //  strCheckStudentTeacher = @"TeacherName";
    
    
    if ([strStudentTeacher isEqualToString:@"StudentName"])
    {
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        
        NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_friends,apk_GetStudentsListNameAndMemberID];
        
        NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
        NSLog(@"dic=%@",dicCurrentUser);
        
        NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
        
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
        [param setValue:[dic objectForKey:@"GradeID"] forKey:@"GradeID"];
        [param setObject:[dic objectForKey:@"DivisionID"] forKey:@"DivisionID"];
        
        
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
                         [aryStudentListName removeAllObjects];
                         [_tblStudentList reloadData];
                         
                         UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [alrt show];
                     }
                     else
                     {
                         
                         
                         aryStudentListName = [[NSMutableArray alloc]initWithArray:arrResponce];
                         aryTemp = [[NSMutableArray alloc]initWithArray:aryStudentListName];
                         [_tblStudentList reloadData];
                         
                         
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
    else
    {
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        
        NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_friends,apk_GetTeacherListNameAndMemberID];
        
        NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
        //  NSLog(@"dic=%@",dicCurrentUser);
        
        NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
        
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
        [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
        
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
                         [aryStudentListName removeAllObjects];
                         [_tblStudentList reloadData];
                         
                         UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [alrt show];
                     }
                     else
                     {
                         
                         
                         aryStudentListName = [[NSMutableArray alloc]initWithArray:arrResponce];
                         aryTemp = [[NSMutableArray alloc]initWithArray:aryStudentListName];
                         [_tblStudentList reloadData];
                         
                         
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
    
}

#pragma mark - Call Api



-(void)apiCallFor_createSchoolGroup
{
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        [ProgressHUB hideenHUDAddedTo:self.view];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_group,apk_SaveUpdate_Group];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSLog(@"dic=%@",dicCurrentUser);
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    
    
    if (get.scoolgroup == 1)
    {
        
         [param setValue:[NSString stringWithFormat:@""] forKey:@"GroupID"];
    }
    else
    {
       //  NSLog(@"Data=%@",_dicCreateSchoolGroup);
         [param setValue:[_dicCreateSchoolGroup objectForKey:@"GropuID"] forKey:@"GroupID"];
    }
   
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] forKey:@"WallID"];
    
    [param setValue:_txtViewAbout.text forKey:@"AboutGroup"];
    [param setValue:_txtGroupSubject.text forKey:@"GroupSubject"];
    [param setValue:_txtGroupTitle.text forKey:@"GroupTitle"];
    
    [param setValue:strGroupTypeID forKey:@"GroupTypeID"];
    
    if (btnMember == 0)
    {
        [param setValue:@"true" forKey:@"IsAutoApprovePendingMember"];
        
    }
    else
    {
        [param setValue:@"false" forKey:@"IsAutoApprovePendingMember"];
        
    }
    
    if (btnPost == 0)
    {
        [param setValue:@"true" forKey:@"IsAutoApprovePendingPost"];
        
    }
    else
    {
        [param setValue:@"false" forKey:@"IsAutoApprovePendingPost"];
        
    }
    
    
    if (btnAlbum == 0)
    {
        [param setValue:@"true" forKey:@"IsAutoApprovePendingAlbums"];
        
    }
    else
    {
        [param setValue:@"false" forKey:@"IsAutoApprovePendingAlbums"];
        
    }
    
    
    if (btnAttachment == 0)
    {
        [param setValue:@"true" forKey:@"IsAutoApprovePendingAttachment"];
        
    }
    else
    {
        [param setValue:@"false" forKey:@"IsAutoApprovePendingAttachment"];
        
    }
    
    
    if (btnPoll == 0)
    {
        [param setValue:@"true" forKey:@"IsAutoApprovePendingPolls"];
        
    }
    else
    {
        [param setValue:@"false" forKey:@"IsAutoApprovePendingPolls"];
        
    }
    
    NSArray *myStrings = [[NSArray alloc] initWithObjects:strGroupStduentID, strGroupTeacherID, nil];
    NSString *strJoinStudentTeacherGroupId = [myStrings componentsJoinedByString:@","];
    
    [param setValue:strJoinStudentTeacherGroupId forKey:@"AllGroupMembers"];
    
    NSData *data =  UIImagePNGRepresentation(_btnTackeImage.currentBackgroundImage);
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
             // NSLog(@"array=%@",arrResponce);
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[dic objectForKey:@"message"];
                 
                 if (get.scoolgroup == 1)
                 {
                     if([strStatus isEqualToString:@"Record save successfully"])
                     {
                         UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         alrt.tag = 100;
                         
                         [alrt show];
                         
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
                     if([strStatus isEqualToString:@"Record update successfully"])
                     {
                         UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         alrt.tag = 100;
                         
                         [alrt show];
                         
                     }
                     else
                     {
                         UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                         [alrt show];
                         // NSLog(@"arra=%@",subAry);
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

#pragma mark - Edit Group Record

-(void)apiCallFor_EditMemberTableGroup
{
    
    //#define apk_group @"apk_group.asmx"
    //#define apk_StuGroup @"StuGroup"
    
    //aryStudentEdit
    
    //<StuGroup xmlns="http://tempuri.org/">
    //<GroupID>guid</GroupID>
    
    
    // NSLog(@"dic")
    
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        [ProgressHUB hideenHUDAddedTo:self.view];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_group,apk_StuGroup];
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    NSLog(@"data=%@",_dicCreateSchoolGroup);
    
    [param setValue:[_dicCreateSchoolGroup objectForKey:@"GropuID"] forKey:@"GroupID"];
    
    [ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             //NSLog(@"data=%@",dicResponce);
             
             NSMutableDictionary *dic= [Utility ConvertStringtoJSON:[NSString stringWithFormat:@"%@",[dicResponce objectForKey:@"d"]]];
             
             NSMutableArray *arrResponce = [dic objectForKey:@"Table1"];
             
             NSLog(@"ary=%@",arrResponce);
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 
                 
                 NSString *strStatus=[dic objectForKey:@"message"];
                 
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 } else
                 {
                     
                     aryStudentEdit = [[NSMutableArray alloc]initWithArray:arrResponce];
                     self.tblMembrList_Height.constant=105*aryStudentEdit.count;
                     
                     [_tblMemberList reloadData];
                     
                     
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

#pragma mark - Remove member

-(void)apiCallFor_DeleteMember : (NSMutableDictionary *)dic
{
    
    // <Remove_GroupMembers xmlns="http://tempuri.org/">
    // <MemberID>guid</MemberID>
    // <GroupMemberID>guid</GroupMemberID>
    
    //#define apk_group @"apk_group.asmx"
    //#define apk_Remove_GroupMembers @"Remove_GroupMembers"
    
    
    NSLog(@"Dic=%@",dic);
    
    if ([Utility isInterNetConnectionIsActive] == false) {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        [ProgressHUB hideenHUDAddedTo:self.view];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_group,apk_Remove_GroupMembers];
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    NSLog(@"data=%@",_dicCreateSchoolGroup);
    
    [param setValue:[dic objectForKey:@"MemberID"] forKey:@"MemberID"];
    [param setValue:[dic objectForKey:@"GropuMemberID"] forKey:@"GroupMemberID"];
    
    [ProgressHUB showHUDAddedTo:self.view];
    [Utility PostApiCall:strURL params:param block:^(NSMutableDictionary *dicResponce, NSError *error)
     {
         [ProgressHUB hideenHUDAddedTo:self.view];
         if(!error)
         {
             NSLog(@"data=%@",dicResponce);
             //  NSLog(@"data=%@",dicResponce);
             
             NSString *strArrd=[dicResponce objectForKey:@"d"];
             NSData *data = [strArrd dataUsingEncoding:NSUTF8StringEncoding];
             NSMutableArray *arrResponce = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             // NSLog(@"array=%@",arrResponce);
             
             if([arrResponce count] != 0)
             {
                 NSMutableDictionary *dic=[arrResponce objectAtIndex:0];
                 NSString *strStatus=[dic objectForKey:@"message"];
                 
                 if([strStatus isEqualToString:@"Members Removed"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     alrt.tag = 91;
                     
                     [alrt show];
                     
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
@end
