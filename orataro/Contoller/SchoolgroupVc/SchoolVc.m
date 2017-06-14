//
//  SchoolVc.m
//  orataro
//
//  Created by MAC008 on 28/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "SchoolVc.h"
#import "Global.h"

@interface SchoolVc ()

@end

@implementation SchoolVc

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _lbHeaderTitle.text = [NSString stringWithFormat:@"Prayer (%@)",[Utility getCurrentUserName]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"View will appear");
    
    [self apiCallFor_getSchoolPrayer];
    // _webview
    
}
#pragma mark - button action

- (IBAction)BackBtnClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - webview delegate

-(void)webViewDidStartLoad:(UIWebView *)webView
{
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
}



#pragma mark - call API

-(void)apiCallFor_getSchoolPrayer
{
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_InstitutePage,apk_GetCmsPageDetail_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    
    NSLog(@"Prayer=%@", dicCurrentUser);
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[dicCurrentUser objectForKey:@"Prayer"] forKey:@"CMSPageID"];
    
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
                     UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:SCHOOLPRAYERLIST delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                     [alrt show];
                 }
                 else
                 {
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
