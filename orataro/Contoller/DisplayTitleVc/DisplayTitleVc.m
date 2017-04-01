//
//  DisplayTitleVc.m
//  orataro
//
//  Created by MAC008 on 23/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "DisplayTitleVc.h"
#import "Global.h"

@interface DisplayTitleVc ()
{
    UIActivityIndicatorView *loadingIndicator;
}
@end

@implementation DisplayTitleVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    loadingIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(145, 190, 20,20)]; [loadingIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [loadingIndicator setHidesWhenStopped:YES];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"dic=%@",_dicPageDetail);
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    
   // b.strCheckBlogPage = @"Page";

    // b.strCheckBlogPage = @"Blog";
    
    if ([_strCheckBlogPage isEqualToString:@"Page"])
    {
        _lbNavTitle.text = [NSString stringWithFormat:@"%@ (%@)",[_dicPageDetail objectForKey:@"PageTitle"],[dicCurrentUser objectForKey:@"FullName"]];
        
        [self apiCallFor_getPageDetail];
    }
    else
    {
        _lbNavTitle.text = [NSString stringWithFormat:@"%@ (%@)",[_dicBlogDatail objectForKey:@"BlogTitle"],[dicCurrentUser objectForKey:@"FullName"]];

         [self apiCallFor_getBlogDetail];
    }
    
}
- (IBAction)BackBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - webview delegate

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [webView addSubview:loadingIndicator];
    [loadingIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
     [loadingIndicator stopAnimating];
}
#pragma mark - call API

-(void)apiCallFor_getPageDetail
{
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_InstitutePage,apk_GetCmsPageDetail_action];
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[_dicPageDetail objectForKey:@"CMSPagesID"]] forKey:@"CMSPageID"];
    
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
                     [loadingIndicator startAnimating];
                    NSString* htmlPath = [NSString stringWithFormat:@"%@",[[arrResponce objectAtIndex:0]objectForKey:@"PageDetails"]];
                     [_webview loadHTMLString:htmlPath baseURL:nil];
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

-(void)apiCallFor_getBlogDetail
{

    
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_blogs,apk_GetBlogDetail_action];
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[_dicBlogDatail objectForKey:@"BlogsID"]] forKey:@"BlogID"];
    
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
                     [loadingIndicator startAnimating];
                     NSString* htmlPath = [NSString stringWithFormat:@"%@",[[arrResponce objectAtIndex:0]objectForKey:@"BlogDetails"]];
                     [_webview loadHTMLString:htmlPath baseURL:nil];
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
