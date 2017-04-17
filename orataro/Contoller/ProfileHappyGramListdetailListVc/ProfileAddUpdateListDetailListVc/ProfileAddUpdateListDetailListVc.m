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
}
@end

@implementation ProfileAddUpdateListDetailListVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    aryEmogination = [[NSArray alloc]initWithObjects:@"emotion1",@"emotion2",@"emotion3",@"emotion4",@"emotion5",@"emotion6",@"emotion7",@"emotion8",@"emotion9",@"emotion10",@"emotion11",@"emotion12",@"emotion13",@"emotion14",@"emotion15",@"emotion16",@"emotion17",@"emotion18",@"emotion19",@"emotion20",@"emotion21",@"emotion22",@"emotion23",@"emotion24",@"emotion25",nil];
    
    _viewEmogination.hidden = YES;
    

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
    NSLog(@"Dic=%@",_dicHappygramDetails);
    
    _lbNavigationTitle.text = [NSString stringWithFormat:@"%@ %@ %@",[_dicHappygramDetails objectForKey:@"Grade"],[_dicHappygramDetails objectForKey:@"Division"],[_dicHappygramDetails objectForKey:@"Subject"]];
    
    if([self.strVctoNavigate isEqualToString:@"Add"])
    {
        [self.viewUpdate setHidden:YES];
        [self.tblAddUpdateList setHidden:NO];
        
        [self apiCallFor_createHappygramList: YES];
        
        //add
    }
    else
    {
        [self.tblAddUpdateList setHidden:YES];
        [self.viewUpdate setHidden:NO];
        
        
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
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    //UIView *viewBackgroundCell=(UIView *)[cell.contentView viewWithTag:3];
    
    UILabel *lb = (UILabel *)[cell.contentView viewWithTag:11];
    lb.text = [[aryStoreHappyGrameData objectAtIndex:indexPath.row]objectForKey:@"RegistrationNo"];
    
    UILabel *lb1 = (UILabel *)[cell.contentView viewWithTag:12];
    lb1.text = [[aryStoreHappyGrameData objectAtIndex:indexPath.row]objectForKey:@"FullName"];
    
    
    UIButton *btn = (UIButton *)[cell.contentView viewWithTag:13];
    btn.tag = indexPath.row;
    
    //  UILabel *lb2 = (UILabel *)[cell.contentView viewWithTag:14];
    // lb2
    
    UITextView *txt = (UITextView *)[cell.contentView viewWithTag:15];
    txt.tag = indexPath.row;
    
    UIButton *btn1 = (UIButton *)[cell.contentView viewWithTag:16];
    btn1.tag = indexPath.row;
    
    UIImageView *img = (UIImageView *)[cell.contentView viewWithTag:17];
    img.tag = indexPath.row;
    
    UIButton *btn2 = (UIButton *)[cell.contentView viewWithTag:18];
    btn2.tag = indexPath.row;
    
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
    UICollectionViewCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileUpdateCell" forIndexPath:indexPath];
    
    UIButton *btn=(UIButton *)[cell2.contentView viewWithTag:92];
    [btn setImage:[UIImage imageNamed:[aryEmogination objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    
    return cell2;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionVie
{
    return 1;
}



- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(-10, 10, -10, 10); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float f = (([UIScreen mainScreen].bounds.size.width/5)-16);
    [_collViewHeight setConstant:50*5];
    return CGSizeMake(f, 50);
}
//
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}


#pragma mark - tbl Add UIButton Action

- (IBAction)btnAddCheckBox:(id)sender
{
    NSLog(@"ary data=%@",aryStoreHappyGrameData);
    
}
- (IBAction)btnAddSmileImg:(id)sender
{
     _viewEmogination.hidden = NO;
    [self.view bringSubviewToFront:_viewEmogination];
    
    
}
- (IBAction)btnAddRemoveSmileImg:(id)sender
{
}

#pragma mark - Update UIButton Action

- (IBAction)btnUpdateSmileRemove:(id)sender
{
}
- (IBAction)btnUpdateSmileAdd:(id)sender
{
}


#pragma mark - UIButton Action

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnSubmit:(id)sender
{
    if([self.strVctoNavigate isEqualToString:@"Add"])
    {
        
    }
    else
    {
        
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


@end
