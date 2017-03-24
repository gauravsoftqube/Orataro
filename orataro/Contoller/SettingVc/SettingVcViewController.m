//
//  SettingVcViewController.m
//  orataro
//
//  Created by MAC008 on 13/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "SettingVcViewController.h"
#import "REFrostedViewController.h"
#import "AppDelegate.h"
#import "Global.h"

@interface SettingVcViewController ()
{
    int c2;
    AppDelegate *app;
}
@end

@implementation SettingVcViewController
@synthesize aSoundBtn,aViratBtn;
int ct =0;
int ct1 =0;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    //uncheck
    //tick_mark
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    NSArray *arrSetting=[DBOperation selectData:[NSString stringWithFormat:@"Select * from Setting"]];

    if([arrSetting count] != 0)
    {
        NSDictionary *dic=[arrSetting objectAtIndex:0];
        if([[dic objectForKey:@"Notif_Sound"] integerValue] == 1)
        {
            [aSoundBtn setBackgroundImage:[UIImage imageNamed:@"tick_mark"] forState:UIControlStateNormal];
            ct = 1;
        }
        else
        {
            [aSoundBtn setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
            ct = 0;
        }
        
        if([[dic objectForKey:@"Notif_Vibration"] integerValue] == 1)
        {
            [aViratBtn setBackgroundImage:[UIImage imageNamed:@"tick_mark"] forState:UIControlStateNormal];
            ct1 = 1;
        }
        else
        {
            [aViratBtn setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
            ct1 = 0;
        }
    }
    else
    {
        
        [aSoundBtn setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        ct = 0;
        
        [aViratBtn setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        ct1 = 0;
        
        
        [DBOperation executeSQL:[NSString stringWithFormat:@"INSERT INTO Setting(Notif_Sound,Notif_Vibration) values (0,0)"]];
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

- (IBAction)aSoundCheckClicked:(UIButton *)sender
{
    if (ct == 0)
    {
        [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE Setting SET Notif_Sound = 1  WHERE id = 1"]];
        [aSoundBtn setBackgroundImage:[UIImage imageNamed:@"tick_mark"] forState:UIControlStateNormal];
        ct = 1;
    }
    else
    {
        [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE Setting SET Notif_Sound = 0  WHERE id = 1"]];
        [aSoundBtn setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        ct = 0;
    }
}

- (IBAction)aVibrateClicked:(id)sender
{
    if (ct1 == 0)
    {
        [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE Setting SET Notif_Vibration = 1  WHERE id = 1"]];
        [aViratBtn setBackgroundImage:[UIImage imageNamed:@"tick_mark"] forState:UIControlStateNormal];
        ct1 = 1;
    }
    else
    {
        [DBOperation executeSQL:[NSString stringWithFormat:@"UPDATE Setting SET Notif_Vibration = 0  WHERE id = 1"]];
        [aViratBtn setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        ct1 = 0;
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
