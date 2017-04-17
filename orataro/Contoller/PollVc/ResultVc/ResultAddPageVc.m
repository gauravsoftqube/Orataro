//
//  ResultAddPageVc.m
//  orataro
//
//  Created by Softqube on 14/04/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "ResultAddPageVc.h"
#import "Global.h"

@interface ResultAddPageVc ()
{
    NSMutableArray *arrOptionList;
    NSString *IsPercentege;
    NSString *IsNotifyAll;
}
@end

@implementation ResultAddPageVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self commonData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)commonData
{
    //set HeaderTitle
    NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
    if (arr.count != 0) {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Result (%@)",[arr objectAtIndex:0]];
    }
    else
    {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Result"];
    }
    
    //
    self.tblOptionAnsList.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    //
    [self.viewMemu setHidden:YES];
    
    //
    self.viewMenuBorder.layer.borderWidth=1;
    self.viewMenuBorder.layer.borderColor=[UIColor colorWithRed:34/255.0f green:49/255.0f blue:89/255.0f alpha:1.0f].CGColor;
    
    [self apiCallFor_GetPollResult:YES];
}

#pragma mark - ApiCall

-(void)apiCallFor_GetPollResult : (BOOL)checkProgress
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_poll,apk_GetPollResult_action];
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    [param setValue:[NSString stringWithFormat:@"%@",_strSelectPollID] forKey:@"PollID"];
    
    if (checkProgress == YES)
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
             NSMutableDictionary *dicResponce = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]mutableCopy];
             
             if([dicResponce count] != 0)
             {
                 NSString *strStatus=[[dicResponce objectForKey:@"message"]mutableCopy];
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:[dicResponce objectForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
                     NSMutableArray *arrTable=[[dicResponce objectForKey:@"Table"]mutableCopy];
                     if([arrTable count] != 0)
                     {
                         NSMutableDictionary *dic=[arrTable objectAtIndex:0];
                         self.lblTitle.text=[[dic objectForKey:@"Title"]capitalizedString];
                         
                         NSString *strDetail=[dic objectForKey:@"Details"];
                         if (strDetail)
                         {
                             self.lblDetail.text=[strDetail capitalizedString];
                         }
                         IsPercentege=[dic objectForKey:@"IsPercentege"];
                         IsNotifyAll=[dic objectForKey:@"IsNotifyAll"];
                     }
                     
                     NSMutableArray *arrTable1=[[dicResponce objectForKey:@"Table1"]mutableCopy];
                     if([arrTable1 count] != 0)
                     {
                         arrOptionList=[[NSMutableArray alloc]init];
                         arrOptionList = [arrTable1 mutableCopy];
                         [self.tblOptionAnsList reloadData];
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

-(void)apiCallFor_ShareResult : (BOOL)checkProgress imageShare:(UIImage *)imgaeShare
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_poll,apk_ShareResult_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",_strSelectPollID] forKey:@"PollID"];
    if([IsNotifyAll integerValue] == 1)
    {
        [param setValue:[NSString stringWithFormat:@"true"] forKey:@"IsNotifiyToAll"];
    }
    else
    {
        [param setValue:[NSString stringWithFormat:@"false"] forKey:@"IsNotifiyToAll"];
    }
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"WallID"]] forKey:@"WallID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"MemberID"]] forKey:@"MemberID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    
    NSData *data = UIImagePNGRepresentation(imgaeShare);
    const unsigned char *bytes = [data bytes];
    NSUInteger length = [data length];
    NSMutableArray *byteArray = [NSMutableArray array];
    for (NSUInteger i = 0; i < length; i++) {
        [byteArray addObject:[NSNumber numberWithUnsignedChar:bytes[i]]];
    }
    
    [param setValue:byteArray forKey:@"File"];
    [param setValue:[NSString stringWithFormat:@"%@.png",[Utility randomImageGenerator]] forKey:@"FileName"];
    
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"PostByType"]] forKey:@"PostByType"];
    
    
    if (checkProgress == YES)
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
             NSMutableArray *arrResponce = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]mutableCopy];
             
             if([arrResponce count] != 0)
             {
                 NSString *strStatus=[[[arrResponce objectAtIndex:0] objectForKey:@"message"]mutableCopy];
                 if([strStatus isEqualToString:@"No Data Found"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:strStatus delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else if([strStatus isEqualToString:@"Result Share successfully...!!!"])
                 {
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:strStatus delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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

#pragma mark - tableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrOptionList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResultAddPageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOption"];
    
    if (cell == nil)
    {
        cell = [[ResultAddPageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOption"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *strOption=[[arrOptionList objectAtIndex:indexPath.row]objectForKey:@"Option"];
    cell.lblTitle.text=[NSString stringWithFormat:@"%ld) %@",indexPath.row+1,strOption];
    
    
    if([IsPercentege integerValue] == 1)
    {
        NSString *TotalVotes=[[arrOptionList objectAtIndex:indexPath.row]objectForKey:@"TotalVotes"];
        UILabel *lblTotalVotes = (UILabel *)[cell.contentView viewWithTag:3];
        if(TotalVotes)
        {
            lblTotalVotes.text=[NSString stringWithFormat:@"%@%%",TotalVotes];
            cell.viewProgress.progress=[TotalVotes floatValue]/100;
            cell.viewProgress.lineWidth=0;
            cell.viewProgress.backgroundColor=[UIColor lightGrayColor];
            
        }
        else
        {
            lblTotalVotes.text=[NSString stringWithFormat:@"NaN%%"];
            cell.viewProgress.progress=0;
            cell.viewProgress.lineWidth=0;
            cell.viewProgress.backgroundColor=[UIColor lightGrayColor];
            
        }
    }
    else
    {
        NSString *TotalVotes=[[arrOptionList objectAtIndex:indexPath.row]objectForKey:@"TotalVotes"];
        if(TotalVotes)
        {
            cell.lblPerVote.text=[NSString stringWithFormat:@"%@ votes",TotalVotes];
            cell.lblPerVote.textColor=[UIColor redColor];
            
            cell.viewProgress.progress=[TotalVotes floatValue]/100;
            cell.viewProgress.lineWidth=0;
            cell.viewProgress.backgroundColor=[UIColor lightGrayColor];
        }
        else
        {
            cell.lblPerVote.text=[NSString stringWithFormat:@"0 votes"];
            cell.lblPerVote.textColor=[UIColor redColor];
            
            cell.viewProgress.progress=0;
            cell.viewProgress.lineWidth=0;
            cell.viewProgress.backgroundColor=[UIColor lightGrayColor];
        }
    }
    return cell;
}


#pragma mark - UIButton Action

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnMenu:(id)sender
{
    [self.viewMemu setHidden:NO];
}

- (IBAction)btnMenu_Cancel:(id)sender
{
    [self.viewMemu setHidden:YES];
}

- (IBAction)btnShare:(id)sender
{
    [self.viewMemu setHidden:YES];
    
    [self apiCallFor_ShareResult:YES imageShare:[self createSnapShotImagesFromUIview]];
}

-(UIImage *)createSnapShotImagesFromUIview
{
    UIGraphicsBeginImageContext(CGSizeMake(self.viewShare.frame.size.width,self.viewShare.frame.size.height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.viewShare.layer renderInContext:context];
    UIImage *img_screenShot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img_screenShot;
}
@end
