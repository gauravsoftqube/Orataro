//
//  ProfileAddUpdateListDetailListVc.m
//  orataro
//
//  Created by Softqube on 27/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ProfileAddUpdateListDetailListVc.h"
#import "Global.h"

@interface ProfileAddUpdateListDetailListVc ()
{
    NSMutableArray *aryStoreHappyGrameData;
    NSArray *aryEmogination;
    int getRow;
    NSString *strEmogiesName;
    NSString *strEmogies;
}
@end

@implementation ProfileAddUpdateListDetailListVc


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    aryEmogination = [[NSArray alloc]initWithObjects:@"emotion1",@"emotion2",@"emotion3",@"emotion4",@"emotion5",@"emotion6",@"emotion7",@"emotion8",@"emotion9",@"emotion10",@"emotion11",@"emotion12",@"emotion13",@"emotion14",@"emotion15",@"emotion16",@"emotion17",@"emotion18",@"emotion19",@"emotion20",@"emotion21",@"emotion22",@"emotion23",@"emotion24",@"emotion25",nil];
    
    _viewEmogination.hidden = YES;
    
    
    _collEmogination.delegate = self;
    _collEmogination.dataSource = self;
    
    
    // Do any additional setup after loading the view.
    [self commonData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    self.tblAddUpdateList.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tblAddUpdateList.allowsSelection=NO;
    
    _tblAddUpdateList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    _lbNavigationTitle.text = [NSString stringWithFormat:@"%@ %@ %@",[_dicHappygramDetails objectForKey:@"Grade"],[_dicHappygramDetails objectForKey:@"Division"],[_dicHappygramDetails objectForKey:@"Subject"]];
    
    if([self.strVctoNavigate isEqualToString:@"Add"])
    {
        [self.viewUpdate setHidden:YES];
        [self.tblAddUpdateList setHidden:NO];
        [self.view bringSubviewToFront:_tblAddUpdateList];
        // [self apiCallFor_createHappygramList: YES];
        //add
    }
    else
    {
        [self.tblAddUpdateList setHidden:YES];
        [self.viewUpdate setHidden:NO];
        [self.view bringSubviewToFront:_viewUpdate];
        
        NSLog(@"Dic=%@",_dicUpdateList);
        
        NSLog(@"Dic=%@",_dicHappygramDetails);
        
        _txtUpdateAppreciation.text = [_dicUpdateList objectForKey:@"Appreciation"];
        _txtViewNote.text= [_dicUpdateList objectForKey:@"Note"];
        [_btnUpdateSmileRemove setImage:[UIImage imageNamed:[_dicUpdateList objectForKey:@"Emotion"]] forState:UIControlStateNormal];
        _imgUpdateCancel.hidden = NO;
        //update
    }
    
}
#pragma mark - UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 231;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return aryStoreHappyGrameData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellAddNew"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellAddNew"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    UILabel *lb = (UILabel *)[cell.contentView viewWithTag:11];
    lb.text = [[aryStoreHappyGrameData objectAtIndex:indexPath.row]objectForKey:@"RegistrationNo"];
    
    UILabel *lb1 = (UILabel *)[cell.contentView viewWithTag:12];
    lb1.text = [[aryStoreHappyGrameData objectAtIndex:indexPath.row]objectForKey:@"FullName"];
    
    UIButton *btn = (UIButton *)[cell.contentView viewWithTag:13];
    
    if ([[[aryStoreHappyGrameData objectAtIndex:indexPath.row]objectForKey:@"CheckBoxVal"] isEqualToString:@"1"])
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"checkboxblue"] forState:UIControlStateNormal];
    }
    else
    {
        [btn setBackgroundImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
    }
    
    UIButton *btn1 = (UIButton *)[cell.contentView viewWithTag:16];
    //btn1.tag = indexPath.row;
    
    UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:17];
    //img.tag = indexPath.row;
    
    // [dic setObject:@"" forKey:@"EmogiesName"];
    
    if ([[[aryStoreHappyGrameData objectAtIndex:indexPath.row]objectForKey:@"SmileVal"] isEqualToString:@"1"])
    {
        NSLog(@"Emogie=%@",strEmogiesName);
        
        [btn1 setImage:[UIImage imageNamed:[[aryStoreHappyGrameData objectAtIndex:indexPath.row]objectForKey:@"EmogiesName"]] forState:UIControlStateNormal];
        btn1.hidden = NO;
        img.hidden = NO;
    }
    else
    {
        [btn1 setImage:[UIImage new] forState:UIControlStateNormal];
        NSLog(@"Emogie=%@",strEmogiesName);
        btn1.hidden = YES;
        img.hidden = YES;
        // [btn setBackgroundImage:[UIImage imageNamed:@"checkboxunselected"] forState:UIControlStateNormal];
    }
    
    UITextField *txtField = (UITextField *)[cell.contentView viewWithTag:14];
    
    
    UITextView *txt = (UITextView *)[cell.contentView viewWithTag:15];
    // txt.tag = indexPath.row;
    
    UIButton *btn2 = (UIButton *)[cell.contentView viewWithTag:18];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - collectionview delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return aryEmogination.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //ProfileUpdateCell
    
    UICollectionViewCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileUpdateCell" forIndexPath:indexPath];
    
    UIButton *btn=(UIButton *)[cell2.contentView viewWithTag:92];
    [btn setImage:[UIImage imageNamed:[aryEmogination objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    
    return cell2;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionVie
{
    return 1;
}
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(3, 5, -8, 5); // top, left, bottom, right
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float f = (([UIScreen mainScreen].bounds.size.width/5)-16);
    [_collViewHeight setConstant:50*5];
    return CGSizeMake(f, 50);
}

#pragma mark - tbl Add UIButton Action

- (IBAction)btnAddCheckBox:(id)sender
{
    //  UIButton *btn = (UIButton *)sender;
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_tblAddUpdateList];
    NSIndexPath *indexPath = [_tblAddUpdateList indexPathForRowAtPoint:buttonPosition];
    
    NSMutableDictionary *dic= [aryStoreHappyGrameData objectAtIndex:indexPath.row];
    
    if ([[dic objectForKey:@"CheckBoxVal"] isEqualToString:@"1"])
    {
        [dic setObject:@"0" forKey:@"CheckBoxVal"];
    }
    else
    {
        [dic setObject:@"1" forKey:@"CheckBoxVal"];
    }
    [aryStoreHappyGrameData replaceObjectAtIndex:indexPath.row withObject:dic];
    
    
    NSLog(@"ary store =%@",aryStoreHappyGrameData);
    [_tblAddUpdateList reloadData];
    
}
- (IBAction)btnAddSmileImg:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_tblAddUpdateList];
    NSIndexPath *indexPath = [_tblAddUpdateList indexPathForRowAtPoint:buttonPosition];
    
    _viewEmogination.hidden = NO;
    [self.view bringSubviewToFront:_viewEmogination];
    getRow = [[NSString stringWithFormat:@"%ld",(long)indexPath.row]intValue];
}

- (IBAction)btnAddRemoveSmileImg:(id)sender
{
    NSLog(@"aryHappyGrame=%@",aryStoreHappyGrameData);
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_tblAddUpdateList];
    NSIndexPath *indexPath = [_tblAddUpdateList indexPathForRowAtPoint:buttonPosition];
    NSMutableDictionary *dic = [aryStoreHappyGrameData objectAtIndex:indexPath.row];
    [dic setObject:@"0" forKey:@"SmileVal"];
    [aryStoreHappyGrameData replaceObjectAtIndex:indexPath.row withObject:dic];
    [_tblAddUpdateList reloadData];
}

#pragma mark - Update UIButton Action

- (IBAction)btnUpdateSmileRemove:(id)sender
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:_dicUpdateList];
    
    [dic removeObjectForKey:@"Emotion"];
    _dicUpdateList = [[NSMutableDictionary alloc]initWithDictionary:dic];
    
    _btnUpdateSmileRemove.hidden = YES;
    _imgUpdateCancel.hidden = YES;
    
    if([self.strVctoNavigate isEqualToString:@"Add"])
    {
        
    }
    else
    {
        
    }
}
- (IBAction)btnUpdateSmileAdd:(id)sender
{
    NSLog(@"Dic=%@",_dicUpdateList);
    
    if([self.strVctoNavigate isEqualToString:@"Add"])
    {
    }
    else
    {
        _viewEmogination.hidden = NO;
        [self.view bringSubviewToFront:_viewEmogination];
    }
}


#pragma mark - UIButton Action

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnEmogiesClicked:(id)sender
{
    if([self.strVctoNavigate isEqualToString:@"Add"])
    {
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_collEmogination];
        NSIndexPath *indexPath = [_collEmogination indexPathForItemAtPoint:buttonPosition];
        NSString *strEmogies1 = [aryEmogination objectAtIndex:indexPath.row];
        
        NSLog(@"Str=%@",strEmogies1);
        NSLog(@"Row=%d",getRow);
        
        strEmogiesName = strEmogies1;
        
        _viewEmogination.hidden = YES;
        
        NSMutableDictionary *dic = [aryStoreHappyGrameData objectAtIndex:getRow];
        [dic setObject:@"1" forKey:@"SmileVal"];
        [dic setObject:strEmogies1 forKey:@"EmogiesName"];
        
        
        
        [aryStoreHappyGrameData replaceObjectAtIndex:getRow withObject:dic];
        // NSLog(@"aryHappyGrame=%@",aryStoreHappyGrameData);
        
        [_tblAddUpdateList reloadData];
        
        
    }
    else
    {
        //  NSLog(@"Dic=%@",_dicUpdateList);
        
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_collEmogination];
        NSIndexPath *indexPath = [_collEmogination indexPathForItemAtPoint:buttonPosition];
        strEmogies  = [aryEmogination objectAtIndex:indexPath.row];
        NSLog(@"Dic=%@",_dicUpdateList);
        
        _btnUpdateSmileRemove.hidden =NO;
        _imgUpdateCancel.hidden = NO;
        
        NSMutableDictionary *dic= [[NSMutableDictionary alloc]initWithDictionary:_dicUpdateList];
        
        [dic setObject:strEmogies forKey:@"Emotion"];
        
        _dicUpdateList = [[NSMutableDictionary alloc]initWithDictionary:dic];
        
        [_btnUpdateSmileRemove setImage:[UIImage imageNamed:strEmogies] forState:UIControlStateNormal];
        
        _viewEmogination.hidden = YES;
    }
    
}

- (IBAction)btnSubmit:(id)sender
{
    if([self.strVctoNavigate isEqualToString:@"Add"])
    {
        for(int i=0;i<aryStoreHappyGrameData.count;i++)
        {
            NSMutableDictionary *dic = [[aryStoreHappyGrameData objectAtIndex:i]mutableCopy];
            
            UITableViewCell *cell = [_tblAddUpdateList cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            
            UITextField *txtField = (UITextField *)[cell.contentView viewWithTag:14];
            
            NSString *newString1 = [txtField.text stringByReplacingOccurrencesOfString:@"_" withString:@" "];
            
            UITextView *txt = (UITextView *)[cell.contentView viewWithTag:15];
            
            NSString *newString2 = [txt.text stringByReplacingOccurrencesOfString:@"_" withString:@" "];
            
            [dic setObject:newString1 forKey:@"SetAppreciation"];
            [dic setObject:newString2 forKey:@"SetDetails"];
            
            [aryStoreHappyGrameData replaceObjectAtIndex:i withObject:dic];
            
        }
        [self apiCallFor_addHappygramList:YES :aryStoreHappyGrameData];
    }
    else
    {
        [self apiCallFor_updateHappygramList:YES];
    }
}

#pragma mark - alert delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 500)
    {
        if (buttonIndex == 0)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    if (alertView.tag == 600)
    {
        if (buttonIndex == 0)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark - Create HappyGram API

-(void)apiCallFor_createHappygramList: (BOOL)strCheckVal
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    //#define apk_happygram @"apk_happygram.asmx"
    //#define apk_GetStudentListForAddNewHappyGram_action @"GetStudentListForAddNewHappyGram"
    
    //    <GetStudentListForAddNewHappyGram xmlns="http://tempuri.org/">
    //    <ClientID>guid</ClientID>
    //    <InstituteID>guid</InstituteID>
    //    <GradeID>guid</GradeID>
    //    <DivisionID>guid</DivisionID>
    //    </GetStudentListForAddNewHappyGram>
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_happygram,apk_GetStudentListForAddNewHappyGram_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    
    [param setValue:[NSString stringWithFormat:@"%@",[_dicHappygramDetails objectForKey:@"GradeID"]] forKey:@"GradeID"];
    [param setValue:[NSString stringWithFormat:@"%@",[_dicHappygramDetails objectForKey:@"DivisionID"]] forKey:@"DivisionID"];
    
    if (strCheckVal == YES)
    {
        [ProgressHUB showHUDAddedTo:self.view];
    }
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
                     NSLog(@"reponse=%@",arrResponce);
                     
                     aryStoreHappyGrameData = [[NSMutableArray alloc]initWithArray:arrResponce];
                     
                     for (int i=0; i<aryStoreHappyGrameData.count; i++)
                     {
                         NSMutableDictionary *dic= [[NSMutableDictionary alloc]init];
                         dic = [[aryStoreHappyGrameData objectAtIndex:i]mutableCopy];
                         [dic setObject:@"0" forKey:@"CheckBoxVal"];
                         [dic setObject:@"0" forKey:@"SmileVal"];
                         [dic setObject:@"" forKey:@"EmogiesName"];
                         [aryStoreHappyGrameData replaceObjectAtIndex:i withObject:dic];
                     }
                     [_tblAddUpdateList reloadData];
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

#pragma mark - add HappygrameList

-(void)apiCallFor_addHappygramList: (BOOL)strCheckVal :(NSMutableArray *)dic
{
    
    NSLog(@"Dic Happygramlist=%@",_dicHappygramDetails);
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    //#define apk_happygram @"apk_happygram.asmx"
    //#define apk_AddHappyGramData @"AddHappyGramData"
    
    //ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
    //InstituteID=4f4bbf0e-858a-46fa-a0a7-bf116f537653
    //TeacherMemberID=f1a6d89d-37dc-499a-9476-cb83f0aba0f2
    //SubjectID=d1a5e590-c9fb-452b-a942-5c9675066fb1
    //HappyGramDataList=135a696d-f856-4280-a623-75c9256d7fbf_ggggf_emotion10_dfghhg#
    
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_happygram,apk_AddHappyGramData];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"TeacherMemberID"];
    [param setValue:[_dicHappygramDetails objectForKey:@"SubjectID"] forKey:@"SubjectID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BatchID"];
    
    NSMutableArray *arySetStr = [[NSMutableArray alloc]init];
    
    for (int i=0; i<aryStoreHappyGrameData.count;i++)
    {
        NSString *str = [NSString stringWithFormat:@"%@_%@_%@_%@",[[aryStoreHappyGrameData objectAtIndex:i]objectForKey:@"MemberID"],[[aryStoreHappyGrameData objectAtIndex:i]objectForKey:@"SetAppreciation"],[[aryStoreHappyGrameData objectAtIndex:i]objectForKey:@"EmogiesName"],[[aryStoreHappyGrameData objectAtIndex:i]objectForKey:@"SetDetails"]];
        
        [arySetStr addObject:str];
    }
    NSLog(@"Data=%@",arySetStr);
    
    NSString *strGet = [arySetStr componentsJoinedByString:@"#"];
    
    [param setValue:strGet forKey:@"HappyGramDataList"];
    
    if (strCheckVal == YES)
    {
        [ProgressHUB showHUDAddedTo:self.view];
    }
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
                 
                 if([strStatus isEqualToString:@"Record save successfully"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     alrt.tag =500;
                     [alrt show];
                 }
                 else
                 {
                     
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

#pragma mark - update HappygrameList

-(void)apiCallFor_updateHappygramList: (BOOL)strCheckVal
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_happygram,apk_UpdateSingleStudentHappyGram];
    
    NSLog(@"Dic=%@",_dicUpdateList);
    
    /*
     
     Appreciation = good;
     DateOfHappyGram = "25 Nov 2016";
     Emotion = emotion1;
     FullName = "Harsh Kapoor";
     Group = "11/2016";
     HappyGramID = "a416eeaf-9982-4f4f-b5d8-b024096fbf75";
     MemberID = "135a696d-f856-4280-a623-75c9256d7fbf";
     Note = work;
     RegistrationNo = 1002;
     SubjectID = "97df9817-1701-450e-9400-11158a657947";
     SubjectName = "";
     TeacherName = "Kinjal Mishara";
     
     */
    
    //_dicUpdateList
    
    /* //<HappyGramID>guid</HappyGramID>
     //<TeacherMemberID>guid</TeacherMemberID>
     //<Appreciation>string</Appreciation>
     //<Emotion>string</Emotion>
     //<Note>string</Note>*/
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    
    
    NSLog(@"Dic=%@",_dicUpdateList);
    
    NSLog(@"Dic=%@",_dicHappygramDetails);
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[_dicUpdateList objectForKey:@"HappyGramID"] forKey:@"HappyGramID"];
    
    [param setValue:[dicCurrentUser objectForKey:@"MemberID"] forKey:@"TeacherMemberID"];
    
    [param setValue:_txtUpdateAppreciation.text forKey:@"Appreciation"];
    
    [param setValue:strEmogies forKey:@"Emotion"];
    
    [param setValue:_txtViewNote.text forKey:@"Note"];
    
    if (strCheckVal == YES)
    {
        [ProgressHUB showHUDAddedTo:self.view];
    }
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
                 
                 if([strStatus isEqualToString:@"Record update successfully"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     alrt.tag =600;
                     [alrt show];
                 }
                 else
                 {
                     
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
