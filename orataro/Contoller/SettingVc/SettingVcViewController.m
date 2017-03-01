//
//  SettingVcViewController.m
//  orataro
//
//  Created by MAC008 on 13/02/17.
//  Copyright © 2017 Softqube. All rights reserved.
//

#import "SettingVcViewController.h"
#import "SWRevealViewController.h"

@interface SettingVcViewController ()

@end

@implementation SettingVcViewController
@synthesize aSoundBtn,aViratBtn;
int ct =0;
int ct1 =0;

- (void)viewDidLoad {
    [super viewDidLoad];
    //uncheck
    //tick_mark
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - button action

- (IBAction)MenuBtnClicked:(id)sender
{
    [self.revealViewController rightRevealToggle:nil];
}

- (IBAction)aSoundCheckClicked:(UIButton *)sender
{
    if (ct == 0)
    {
        [aSoundBtn setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        ct = 1;
    }
    else{
         [aSoundBtn setBackgroundImage:[UIImage imageNamed:@"tick_mark"] forState:UIControlStateNormal];
        ct = 0;
    }
}

- (IBAction)aVibrateClicked:(id)sender
{
    if (ct1 == 0)
    {
        [aViratBtn setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        ct1 = 1;
    }
    else{
        [aViratBtn setBackgroundImage:[UIImage imageNamed:@"tick_mark"] forState:UIControlStateNormal];
        ct1 = 0;
    }

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
