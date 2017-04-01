//
//  BlogVc.m
//  orataro
//
//  Created by MAC008 on 17/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "BlogVc.h"
#import "DisplayTitleVc.h"
#import "Global.h"

@interface BlogVc ()
{
    NSMutableArray *getdata;
}
@end

@implementation BlogVc
@synthesize aBlogTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //BlogCell
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    getdata = [[NSMutableArray alloc]init];
               
    aBlogTable.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    aBlogTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // //HelveticaNeueLTStd-Roman 20.0
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    NSArray *ary = [DBOperation selectData:@"select * from BlogDetail"];
    getdata = [Utility getLocalDetail:ary columnKey:@"BlogJsonStr"];
    [aBlogTable reloadData];
    //  dispatch_group_t group = dispatch_group_create();
    
    
    if (getdata.count == 0)
    {
        if ([Utility isInterNetConnectionIsActive] == false)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
        else
        {
            [self apiCallFor_BlogetDetail:YES];
            
        }
    }
    else
    {
        [self apiCallFor_BlogetDetail:NO];
    }

}

#pragma mark - tableview delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BlogCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BlogCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row % 2 ==0)
    {
        cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    }
    
    //tag 1
    UIImageView *img1 = (UIImageView *)[cell.contentView viewWithTag:1];
    img1.image = [UIImage imageNamed:@"blogico"];
    img1.image = [img1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [img1 setTintColor:[UIColor colorWithRed:40.0/255.0 green:49.0/255.0 blue:90.0/255.0 alpha:1.0]];
    
    //tag 2
    UILabel *lb = (UILabel *)[cell.contentView viewWithTag:2];
    lb.text = [[getdata objectAtIndex:indexPath.row]objectForKey:@"BlogTitle"];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return getdata.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // as per content
    
    NSString *str = [NSString stringWithFormat:@"%@",[[getdata objectAtIndex:indexPath.row]objectForKey:@"BlogTitle"]];
        CGSize size = [str sizeWithFont:[UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:13] constrainedToSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-35, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];

        return size.height+35;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    
        DisplayTitleVc *b = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"DisplayTitleVc"];
        b.strCheckBlogPage = @"Blog";
        b.dicBlogDatail = [getdata objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:b animated:YES];
}

#pragma mark - button action

- (IBAction)BackBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ApiCall

-(void)apiCallFor_BlogetDetail : (BOOL)checkProgress
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alrt show];
        return;
    }
    //#define apk_InstitutePage @"apk_cmspage.asmx"
    //#define apk_GetCmsPages_action @"GetCmsPages"
    //InstituteID=4f4bbf0e-858a-46fa-a0a7-bf116f537653
    //ClientID=d79901a7-f9f7-4d47-8e3b-198ede7c9f58
    //UserID=30032284-31d1-4ba6-8ef4-54edb8e223aa
    //BeachID=null
    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_blogs,apk_GetBlogList_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"InstituteID"]] forKey:@"InstituteID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"ClientID"]] forKey:@"ClientID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"UserID"]] forKey:@"UserID"];
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"BatchID"]] forKey:@"BeachID"];
    
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
                     [self ManageCircularList:arrResponce];
                     
                     
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

-(void)ManageCircularList:(NSMutableArray *)arrResponce
{
    //#define apk_blogs @"apk_blogs.asmx"
    //#define apk_GetBlogList_action @"GetBlogList"
    //#define apk_GetBlogDetail_action @"GetBlogDetail"
    
    //CREATE TABLE "BlogDetail" ("id" INTEGER PRIMARY KEY  NOT NULL , "BlogJsonStr" VARCHAR)
    
    [DBOperation executeSQL:@"delete from BlogDetail"];
    
    NSLog(@"ary Response=%@",arrResponce);
    
    for (NSMutableDictionary *dic in arrResponce)
    {
        NSString *getjsonstr = [Utility Convertjsontostring:dic];
        [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO BlogDetail (BlogJsonStr) VALUES ('%@')",getjsonstr]];
    }
    
    NSArray *ary = [DBOperation selectData:@"select * from BlogDetail"];
    getdata = [Utility getLocalDetail:ary columnKey:@"BlogJsonStr"];
    
    [aBlogTable reloadData];
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
