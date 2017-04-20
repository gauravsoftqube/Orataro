//
//  MessageVc.m
//  orataro
//
//  Created by MAC008 on 16/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "MessageVc.h"
#import "REFrostedViewController.h"
#import "AppDelegate.h"
#import "Global.h"

@interface MessageVc ()<UIWebViewDelegate>
{
    int c2;
     AppDelegate *app;
}
@end

@implementation MessageVc
@synthesize aWebview;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    aWebview.delegate=self;
    
    NSArray *arr=[[[Utility getCurrentUserDetail]objectForKey:@"FullName"] componentsSeparatedByString:@" "];
    if (arr.count != 0) {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Exam Timing (%@)",[arr objectAtIndex:0]];
    }
    else
    {
        self.lblHeaderTitle.text=[NSString stringWithFormat:@"Exam Timing"];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([Utility isInterNetConnectionIsActive] == false)
    {
        NSMutableArray *arrTemp=[DBOperation selectData:[NSString stringWithFormat:@"select htmlString from ExamTiming"]];
        if([arrTemp count] != 0)
        {
            NSString* htmlPath = [NSString stringWithFormat:@"%@",[[arrTemp objectAtIndex:0]objectForKey:@"htmlString"]];
            [aWebview loadHTMLString:htmlPath baseURL:nil];
        }
        if(arrTemp.count == 0)
        {
            UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:nil message:INTERNETVALIDATION delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alrt show];
            return;
        }
    }
    else
    {
        NSMutableArray *arrTemp=[DBOperation selectData:[NSString stringWithFormat:@"select htmlString from ExamTiming"]];
        
        if([arrTemp count] != 0)
        {
            NSString* htmlPath = [NSString stringWithFormat:@"%@",[[arrTemp objectAtIndex:0]objectForKey:@"htmlString"]];
            [aWebview loadHTMLString:htmlPath baseURL:nil];
        }
        
        if(arrTemp.count == 0)
        {
            [self apiCallFor_getPageDetail:@"1"];
        }
        else
        {
            [self apiCallFor_getPageDetail:@"0"];
        }
 
    }
}

#pragma mark - ApiCall

-(void)apiCallFor_getPageDetail:(NSString *)strShowHUB
{
    NSString *strURL=[NSString stringWithFormat:@"%@%@/%@",URL_Api,apk_InstitutePage,apk_GetCmsPageDetail_action];
    
    NSMutableDictionary *dicCurrentUser=[Utility getCurrentUserDetail];
    
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    
    [param setValue:[NSString stringWithFormat:@"%@",[dicCurrentUser objectForKey:@"SchoolTiming"]] forKey:@"CMSPageID"];
    if([strShowHUB isEqualToString:@"1"])
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
                     [DBOperation executeSQL:[NSString stringWithFormat:@"DELETE FROM ExamTiming"]];
                     NSString* htmlPath = [NSString stringWithFormat:@"%@",[[arrResponce objectAtIndex:0]objectForKey:@"PageDetails"]];
                     [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO ExamTiming(htmlString)values('%@')",htmlPath]];
                     
                     [aWebview loadHTMLString:[NSString stringWithFormat:@"<HTML><HEAD><LINK href=%@ type=\"text/css\" rel=\"stylesheet\"/></HEAD><body>%@</body></HTML>",URL_CSS_File,htmlPath] baseURL:nil];
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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([[[request URL] absoluteString] hasPrefix:@"ios:"]) {
        
        // Call the given selector
        [self performSelector:@selector(webToNativeCall)];
        // Cancel the location change
        return NO;
    }
    return YES;
}

- (void)webToNativeCall
{
    NSString *returnvalue =  [aWebview stringByEvaluatingJavaScriptFromString:@"OnLoad()"];
    
    NSLog(@"%@",[NSString stringWithFormat:@"From browser : %@", returnvalue ]);
}



#pragma mark - stepper value change

- (IBAction)steprChanged:(UIStepper *)sender
{
    //NSLog(@"change%f",_Steper.value);
    int myInt = (int) _Steper.value;
    //NSLog(@"data=%d",myInt);
    
    NSString *com = [NSString stringWithFormat:@"%d",myInt];
    if ([com isEqualToString:@"-1"])
    {
        aWebview.scalesPageToFit = NO;
        aWebview.scrollView.zoomScale = 0.0;
    }
    else
    {
        aWebview.scalesPageToFit = NO;
        aWebview.scrollView.zoomScale = 2.0 ;
    }
}

#pragma mark - button action

- (IBAction)MenuBtnClicked:(id)sender
{
    self.frostedViewController.direction = REFrostedViewControllerDirectionRight;
    
    
    if (app.checkview == 0)
    {
        [self.frostedViewController presentMenuViewController];
        app.checkview = 1;
        
    }
    else
    {
        [self.frostedViewController hideMenuViewController];
        app.checkview = 0;
    }
}
- (IBAction)btnHomeClicked:(id)sender
{
     [self.frostedViewController hideMenuViewController];
    
    UIViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"OrataroVc"];
    
    [self.navigationController pushViewController:wc animated:NO];
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
