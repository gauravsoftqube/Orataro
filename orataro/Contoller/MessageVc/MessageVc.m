//
//  MessageVc.m
//  orataro
//
//  Created by MAC008 on 16/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "MessageVc.h"
#import "SWRevealViewController.h"

@interface MessageVc ()

@end

@implementation MessageVc
@synthesize aWebview;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str = @"<p>Hey you. My <b>name </b> is <h1> Joe </h1></p>";
   // aWebview.scalesPageToFit = NO;
   // aWebview.scrollView.zoomScale = 2.0;
    [aWebview loadHTMLString:str baseURL:nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self.revealViewController rightRevealToggle:nil];
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
