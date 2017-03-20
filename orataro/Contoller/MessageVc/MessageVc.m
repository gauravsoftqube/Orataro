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
    //NSString *str = @"<p>Hey you. My <b>name </b> is <h1> Joe </h1></p>";
    
  //  NSString *str=@"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\"/><title>Hello World - Google  Web Search API Sample</title><script src=\"https://www.google.com/jsapi\"type=\"text/javascript\"></script><script language=\"Javascript\" type=\"text/javascript\">//<!google.load('search', '1');//]]></script></head><body><div id=\"searchcontrol\">Loading</div></body></html>";
   // aWebview.scalesPageToFit = NO;
   // aWebview.scrollView.zoomScale = 2.0;
  //  [aWebview loadHTMLString:str baseURL:nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSLog(@"change%f",_Steper.value);
    int myInt = (int) _Steper.value;
    NSLog(@"data=%d",myInt);
    
    NSString *com = [NSString stringWithFormat:@"%d",myInt];
    if ([com isEqualToString:@"-1"])
    {
        aWebview.scalesPageToFit = NO;
        aWebview.scrollView.zoomScale = 2.1;
    }
    else
    {
        aWebview.scalesPageToFit = YES;
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
